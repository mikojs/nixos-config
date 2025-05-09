use std::{
    env,
    fs::{self, File},
    io::{Error as IoError, Write},
    path::PathBuf,
};

use clap::{error::ErrorKind, ArgMatches, Command, Error as ClapError};
use git2::{Error as RepositoryError, Repository};
use serde::{Deserialize, Serialize};
use serde_json::Error as SerdeJsonError;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] SerdeJsonError),
    #[error("RepositoryError: {0}")]
    Repository(#[from] RepositoryError),
    #[error("Repo already exists")]
    RepoExists,
    #[error("Repo not found")]
    RepoNotFound,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct RepoConfig {
    name: String,
    repo_path: PathBuf,
}

impl PartialEq for RepoConfig {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name || self.repo_path == other.repo_path
    }
}

#[derive(Serialize, Deserialize, Debug, Default)]
pub struct Config {
    #[serde(skip)]
    folder_path: PathBuf,
    repos: Vec<RepoConfig>,
}

static CONFIG_FILE: &str = "config.json";

impl Config {
    pub fn new() -> Result<Self, ConfigError> {
        let home_dir = dirs::home_dir().unwrap_or("./".into());
        let folder_path = PathBuf::from(
            env::var("CODER").unwrap_or(home_dir.join(".config/coder").display().to_string()),
        );
        let config_str =
            fs::read_to_string(folder_path.clone().join(CONFIG_FILE)).unwrap_or_default();
        let mut config = serde_json::from_str(&config_str).unwrap_or(Config::default());

        config.folder_path = folder_path;

        Ok(config)
    }

    pub fn add(&mut self, repo_name: String, path: PathBuf) -> Result<(), ConfigError> {
        let repo = Repository::discover(path.clone())?;
        let repo_config = RepoConfig {
            name: repo_name,
            repo_path: repo.path().to_path_buf(),
        };

        if self.repos.contains(&repo_config) {
            return Err(ConfigError::RepoExists);
        }

        self.repos.push(repo_config);

        Ok(())
    }

    pub fn remove(&mut self, repo_name: String) -> Result<(), ConfigError> {
        let amount = self.repos.len();

        self.repos.retain(|repo| repo.name != repo_name);

        if amount == self.repos.len() {
            return Err(ConfigError::RepoNotFound);
        }

        Ok(())
    }

    pub fn sync(&self) -> Result<(), ConfigError> {
        // TODO: map repos, create bare git repo, remove untracked git repo
        // TODO: add history(version + branches) and sync all branches
        Ok(())
    }

    pub fn save(&self) -> Result<(), ConfigError> {
        let mut file = File::create(self.folder_path.join(CONFIG_FILE))?;

        self.sync()?;
        file.write_all(serde_json::to_string(&self)?.as_bytes())?;

        Ok(())
    }
}

// for clap
impl Config {
    fn list(&self) -> Vec<RepoConfig> {
        self.repos.clone()
    }

    pub fn from_arg_matches_mut(matches: &mut ArgMatches) -> Result<String, ClapError> {
        let db_config_result = if let Some((name, _)) = matches.subcommand() {
            Config::new()
                .unwrap_or_default()
                .list()
                .into_iter()
                .find(|db_config| db_config.name == name)
        } else {
            None
        };
        let db_config = db_config_result
            .ok_or(ClapError::new(ErrorKind::ValueValidation))?
            .clone();

        Ok(db_config.name)
    }

    pub fn augment_args(cmd: Command) -> Command {
        let config = Config::new().unwrap_or_default();
        let mut new_cmd = cmd.subcommand_required(true);

        for db_config in config.list() {
            new_cmd = new_cmd.subcommand(Command::new(db_config.name).about("Repo"));
        }

        new_cmd
    }
}

#[cfg(test)]
mod config_tests {
    use super::*;
    use std::{fs::File, path::Path};

    use git2::IndexAddOption;

    #[derive(Error, Debug)]
    enum ConfigTestsError {
        #[error("ConfigError: {0}")]
        Config(#[from] ConfigError),
        #[error("RepositoryError: {0}")]
        Repository(#[from] RepositoryError),
        #[error("IoError: {0}")]
        Io(#[from] IoError),
    }

    fn create_test_repo(
        test_folder_path: &Path,
        repo_name: &str,
    ) -> Result<Repository, ConfigTestsError> {
        let repo_path = test_folder_path.join(repo_name);
        let repo = Repository::init(repo_path.clone())?;
        let mut file = File::create(repo_path.join("foo"))?;

        file.write_all(b"test")?;
        repo.index()?
            .add_all(["."], IndexAddOption::DEFAULT, None)?;
        repo.index()?.write()?;

        let oid = repo.index()?.write_tree()?;
        let tree = repo.find_tree(oid)?;
        let parent_commit = repo.head()?.peel_to_commit()?;

        repo.commit(
            Some("HEAD"),
            &repo.signature()?,
            &repo.signature()?,
            "init",
            &tree,
            &[&parent_commit],
        )?;

        Ok(Repository::open(repo_path)?)
    }

    fn test(
        tests_fn: fn(test_folder_path: &Path, config: &Config) -> Result<(), ConfigTestsError>,
    ) -> Result<(), ConfigTestsError> {
        let test_folder_path = dirs::home_dir()
            .unwrap_or("./".into())
            .join(".cache/coder-tests");
        let mut config = Config::new()?;

        config.folder_path = test_folder_path.clone().join("coder");

        if let Err(e) = tests_fn(&test_folder_path, &config) {
            fs::remove_dir_all(test_folder_path)?;
            assert_eq!(e.to_string(), "");
        }

        Ok(())
    }

    #[test]
    fn sync_the_repos() -> Result<(), ConfigTestsError> {
        test(|test_folder_path, _| {
            create_test_repo(test_folder_path, "repo1")?;

            Ok(())
        })
    }
}

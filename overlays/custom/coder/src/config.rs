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

        if !fs::exists(folder_path.clone())? {
            fs::create_dir_all(folder_path.clone())?;
        }

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

    pub fn save(&mut self) -> Result<(), ConfigError> {
        let mut file = File::create(self.folder_path.join(CONFIG_FILE))?;

        file.write_all(serde_json::to_string(&self)?.as_bytes())?;

        Ok(())
    }
}

// for clap
impl Config {
    pub fn from_arg_matches_mut(matches: &mut ArgMatches) -> Result<String, ClapError> {
        let db_config_result = if let Some((name, _)) = matches.subcommand() {
            Config::new()
                .unwrap_or_default()
                .repos
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

        for db_config in config.repos {
            new_cmd = new_cmd.subcommand(Command::new(db_config.name).about("Repo"));
        }

        new_cmd
    }
}

#[cfg(test)]
mod config_tests {
    use std::path::Path;

    use super::*;

    #[derive(Error, Debug)]
    enum ConfigTestsError {
        #[error("ConfigError: {0}")]
        Config(#[from] ConfigError),
        #[error("RepositoryError: {0}")]
        Repository(#[from] RepositoryError),
        #[error("IoError: {0}")]
        Io(#[from] IoError),
        #[error("Not Equal: {0}")]
        NotEqual(String),
    }

    fn create_test_repo(
        test_folder_path: &Path,
        repo_name: &str,
    ) -> Result<Repository, ConfigTestsError> {
        let repo_path = test_folder_path.join(repo_name);
        let repo = Repository::init(repo_path.clone())?;
        let signature = repo.signature()?;
        let oid = repo.index()?.write_tree()?;
        let tree = repo.find_tree(oid)?;

        repo.commit(Some("HEAD"), &signature, &signature, "init", &tree, &[])?;

        let head = repo.head()?;
        let commit = head.peel_to_commit()?;

        repo.branch("foo", &commit, false)?;

        Ok(Repository::open(repo_path)?)
    }

    fn test(
        name: &str,
        tests_fn: fn(test_folder_path: &Path, config: &mut Config) -> Result<(), ConfigTestsError>,
    ) -> Result<(), ConfigTestsError> {
        let test_folder_path = dirs::home_dir()
            .unwrap_or("./".into())
            .join(".cache/coder-tests")
            .join(name);
        let mut config = Config::new()?;

        config.folder_path = test_folder_path.join("coder");

        let result = if let Err(e) = tests_fn(&test_folder_path, &mut config) {
            e.to_string()
        } else {
            "".to_string()
        };

        fs::remove_dir_all(test_folder_path)?;
        assert_eq!(result, "");

        Ok(())
    }

    fn test_assert_eq<T: Eq + std::fmt::Debug>(
        description: &str,
        a: T,
        b: T,
    ) -> Result<(), ConfigTestsError> {
        if a != b {
            return Err(ConfigTestsError::NotEqual(format!(
                "{description}: {a:?} != {b:?}"
            )));
        }

        Ok(())
    }

    #[test]
    fn add_repos() -> Result<(), ConfigTestsError> {
        test("add_a_repo", |test_folder_path, config| {
            create_test_repo(test_folder_path, "repo1")?;
            config.add("repo1".to_string(), test_folder_path.join("repo1"))?;
            test_assert_eq(
                "Repo already exists",
                matches!(
                    config.add("repo1".to_string(), test_folder_path.join("repo1")),
                    Err(ConfigError::RepoExists)
                ),
                true,
            )?;

            Ok(())
        })
    }

    #[test]
    fn remove_a_repo() -> Result<(), ConfigTestsError> {
        test("remove_a_repo", |test_folder_path, config| {
            create_test_repo(test_folder_path, "repo1")?;
            config.add("repo1".to_string(), test_folder_path.join("repo1"))?;
            test_assert_eq(
                "Repo not found",
                matches!(
                    config.remove("repo_not_exist".to_string()),
                    Err(ConfigError::RepoNotFound),
                ),
                true,
            )?;
            config.remove("repo1".to_string())?;

            Ok(())
        })
    }
}

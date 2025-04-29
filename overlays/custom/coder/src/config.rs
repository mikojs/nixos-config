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
    file_path: PathBuf,
    repos: Vec<RepoConfig>,
}

impl Config {
    pub fn new() -> Result<Self, ConfigError> {
        let home_dir = dirs::home_dir().unwrap_or("./".into());
        let file_path = PathBuf::from(
            env::var("CODER_CONFIG")
                .unwrap_or(home_dir.join(".config/coder.json").display().to_string()),
        );
        let config_str = fs::read_to_string(file_path.clone()).unwrap_or_default();
        let mut config = serde_json::from_str(&config_str).unwrap_or(Config::default());

        config.file_path = file_path;

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

    pub fn save(&self) -> Result<(), ConfigError> {
        let mut file = File::create(&self.file_path)?;

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

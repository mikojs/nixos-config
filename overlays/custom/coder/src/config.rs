use std::{
    env,
    fs::{self, File},
    io::{Error as IoError, Write},
    path::PathBuf,
};

use pathdiff::diff_paths;
use serde::{Deserialize, Serialize};
use serde_json::Error as SerdeJsonError;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] SerdeJsonError),
    #[error("Repo already exists")]
    RepoExists,
    #[error("Repo not found")]
    RepoNotFound,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Repo {
    name: String,
    relative_path: PathBuf,
}

impl PartialEq for Repo {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name || self.relative_path == other.relative_path
    }
}

#[derive(Serialize, Deserialize, Debug, Default)]
pub struct Config {
    #[serde(skip)]
    file_path: PathBuf,
    repos: Vec<Repo>,
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

    pub fn add(&mut self, repo_name: String, repo_file_path: PathBuf) -> Result<(), ConfigError> {
        let relative_path = diff_paths(repo_file_path, self.file_path.clone())
            .ok_or_else(|| ConfigError::RepoNotFound)?;
        let repo = Repo {
            name: repo_name,
            relative_path,
        };

        if self.repos.contains(&repo) {
            return Err(ConfigError::RepoExists);
        }

        self.repos.push(repo);

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

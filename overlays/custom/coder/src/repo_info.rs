use std::path::PathBuf;

use serde::{Deserialize, Serialize};
use thiserror::Error;

use crate::config::{Config, ConfigError, RepoConfig};

#[derive(Error, Debug)]
pub enum RepoInfoError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Serialize, Deserialize)]
pub struct RepoInfo {
    pub repo_path: PathBuf,
    pub branches: Vec<String>,
}

impl TryFrom<RepoConfig> for RepoInfo {
    type Error = RepoInfoError;

    fn try_from(repo_config: RepoConfig) -> Result<Self, Self::Error> {
        let (repo_path, branches) = repo_config.info()?;

        Ok(RepoInfo {
            repo_path,
            branches,
        })
    }
}

#[derive(Serialize, Deserialize)]
pub struct RepoInfos(Vec<RepoInfo>);

impl TryFrom<Config> for RepoInfos {
    type Error = RepoInfoError;

    fn try_from(config: Config) -> Result<Self, Self::Error> {
        let mut repo_infos = Vec::new();

        for repo_config in config.list() {
            repo_infos.push(RepoInfo::try_from(repo_config)?);
        }

        Ok(Self(repo_infos))
    }
}

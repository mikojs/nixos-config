use clap::Args;
use serde_json::Error as SerdeJsonError;
use thiserror::Error;

use crate::{
    config::{Config, ConfigError},
    repo_info::{RepoInfoError, RepoInfos},
};

#[derive(Error, Debug)]
pub enum InfoError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
    #[error("RepoInfoError: {0}")]
    RepoInfo(#[from] RepoInfoError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] SerdeJsonError),
}

#[derive(Args)]
pub struct Info {}

impl Info {
    pub fn run(&self) -> Result<(), InfoError> {
        let repo_infos: RepoInfos = Config::new()?.try_into()?;

        println!("{}", serde_json::to_string_pretty(&repo_infos)?);
        Ok(())
    }
}

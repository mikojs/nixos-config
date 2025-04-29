use std::path::PathBuf;

use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum AddError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Add {
    /// The name of the repository
    repo_name: String,
    /// The path to find out the repository
    path: PathBuf,
}

impl Add {
    pub fn run(&self) -> Result<(), AddError> {
        let mut config = Config::new()?;

        config.add(self.repo_name.clone(), self.path.clone())?;
        config.save()?;

        // TODO: initialize the repository

        Ok(())
    }
}

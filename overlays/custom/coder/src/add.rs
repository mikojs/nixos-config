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
    /// The file path of the repository
    repo_file_path: PathBuf,
}

impl Add {
    pub fn run(&self) -> Result<(), AddError> {
        let mut config = Config::new()?;

        config.add(self.repo_name.clone(), self.repo_file_path.clone())?;
        config.save()?;

        Ok(())
    }
}

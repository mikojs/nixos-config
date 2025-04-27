use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum RemoveError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Remove {
    /// The name of the repository
    repo_name: String,
}

impl Remove {
    pub fn run(&self) -> Result<(), RemoveError> {
        let mut config = Config::new()?;

        config.remove(self.repo_name.clone())?;
        config.save()?;

        Ok(())
    }
}

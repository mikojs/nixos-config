use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum PullError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Pull {}

impl Pull {
    pub fn run(&self) -> Result<(), PullError> {
        let config = Config::new()?;

        // TODO: local and remote coder sync
        // TODO: git pull from remote

        Ok(())
    }
}

use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum PushError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Push {}

impl Push {
    pub fn run(&self) -> Result<(), PushError> {
        let config = Config::new()?;

        // TODO: local and remote coder sync
        // TODO: remote git pull from local

        Ok(())
    }
}

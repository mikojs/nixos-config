use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum DeployError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Deploy {}

impl Deploy {
    pub fn run(&self) -> Result<(), DeployError> {
        let config = Config::new()?;

        // TODO: local coder sync
        // TODO: run deploy script on local server or remote server

        Ok(())
    }
}

use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum SyncError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Sync {}

impl Sync {
    pub fn run(&self) -> Result<(), SyncError> {
        Config::new().save()?;

        Ok(())
    }
}

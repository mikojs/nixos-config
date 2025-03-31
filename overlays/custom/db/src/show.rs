use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum ShowError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Show {}

impl Show {
    pub fn run(&self) -> Result<(), ShowError> {
        // TODO: add show command

        Ok(())
    }
}

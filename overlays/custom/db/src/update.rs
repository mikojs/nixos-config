use clap::Args;
use thiserror::Error;

use crate::config::{Config, ConfigError, DbConfig};

#[derive(Error, Debug)]
pub enum UpdateError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

#[derive(Args)]
pub struct Update {
    name: String,
    url: String,
}

impl Update {
    pub fn run(&self) -> Result<(), UpdateError> {
        let mut config = Config::new();

        config.update(DbConfig {
            name: self.name.clone(),
            url: self.url.clone(),
        });
        config.save()?;

        Ok(())
    }
}

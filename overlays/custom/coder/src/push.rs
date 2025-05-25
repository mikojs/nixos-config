use clap::Args;
use thiserror::Error;

use crate::{
    config::{Config, ConfigError},
    remote::{exec, RemoteError},
};

#[derive(Error, Debug)]
pub enum PushError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
    #[error("RemoteError: {0}")]
    Remote(#[from] RemoteError),
}

#[derive(Args)]
pub struct Push {
    /// Tailscale host
    host: String,
    /// Tailscale username
    #[arg(short, long)]
    username: Option<String>,
}

impl Push {
    pub fn run(&self) -> Result<(), PushError> {
        let mut config = Config::new()?;

        exec(self.host.as_str(), self.username.as_deref(), "coder sync")?;
        config.sync()?;
        // TODO: remote git pull from local

        Ok(())
    }
}

use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum UpdateError {}

#[derive(Args)]
pub struct Update {
    name: String,
    url: String,
}

impl Update {
    pub fn run(&self) -> Result<(), UpdateError> {
        Ok(())
    }
}

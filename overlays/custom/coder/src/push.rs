use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum PushError {}

#[derive(Args)]
pub struct Push {}

impl Push {
    pub fn run(&self) -> Result<(), PushError> {
        Ok(())
    }
}

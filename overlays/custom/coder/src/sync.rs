use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum SyncError {}

#[derive(Args)]
pub struct Sync {}

impl Sync {
    pub fn run(&self) -> Result<(), SyncError> {
        Ok(())
    }
}

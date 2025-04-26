use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum AddError {}

#[derive(Args)]
pub struct Add {}

impl Add {
    pub fn run(&self) -> Result<(), AddError> {
        Ok(())
    }
}

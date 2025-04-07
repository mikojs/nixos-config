use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum SqlsError {}

#[derive(Args)]
pub struct Sqls {}

impl Sqls {
    pub fn run(&self) -> Result<(), SqlsError> {
        Ok(())
    }
}

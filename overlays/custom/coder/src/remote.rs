use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum RemoteError {}

#[derive(Args)]
pub struct Remote {
    #[arg(short, long)]
    verbose: bool,
}

impl Remote {
    pub fn run(&self) -> Result<(), RemoteError> {
        Ok(())
    }
}

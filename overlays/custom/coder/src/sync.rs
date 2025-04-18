use std::path::PathBuf;

use clap::Args;
use thiserror::Error;
use url::Url;

#[derive(Error, Debug)]
pub enum SyncError {}

#[derive(Args)]
pub struct Sync {
    #[clap(skip)]
    file_path: PathBuf,
    /// Source repo path
    source: Url,
    /// Target repo path
    target: Url,
}

impl Sync {
    pub fn run(&self) -> Result<(), SyncError> {
        println!("{:?}, {:?}", self.source, self.target);
        Ok(())
    }
}

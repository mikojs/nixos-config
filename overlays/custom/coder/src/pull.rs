use std::{fs::remove_file, io::Error as IoError, path::PathBuf};

use clap::Args;
use thiserror::Error;
use url::Url;

use crate::{
    process::{exec, ProcessError},
    sync::{Sync, SyncError},
};

#[derive(Error, Debug)]
pub enum PullError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("ProcessError: {0}")]
    Process(#[from] ProcessError),
    #[error("SyncError: {0}")]
    Sync(#[from] SyncError),
}

#[derive(Args)]
pub struct Pull {
    /// The ssh URL of the remote server
    ssh_url: Url,
    /// The directory to push
    directory: PathBuf,
}

impl Pull {
    pub fn run(&self) -> Result<(), PullError> {
        let ssh_url = self.ssh_url.as_str().replace("ssh://", "");

        println!("Creating bundle file");
        exec(
            "ssh",
            vec![
                &ssh_url,
                &format!(
                    "cd {} && git bundle create temp.bundle --all",
                    self.directory.display()
                ),
            ],
        )?;

        println!("Pulling bundle file");
        exec(
            "scp",
            vec![
                &format!(
                    "{}:{}",
                    ssh_url,
                    self.directory.join("temp.bundle").display()
                ),
                ".",
            ],
        )?;
        exec(
            "ssh",
            vec![
                &ssh_url,
                &format!("cd {} && rm temp.bundle", self.directory.display()),
            ],
        )?;

        println!("Syncing the repository");

        let file_path = PathBuf::from("temp.bundle");
        let mut sync = Sync::new(file_path.clone());

        sync.run()?;
        remove_file(file_path)?;

        Ok(())
    }
}

use std::{fs::remove_file, io::Error as IoError, path::PathBuf};

use clap::Args;
use thiserror::Error;
use url::Url;

use crate::process::{exec, ProcessError};

#[derive(Error, Debug)]
pub enum PushError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("ProcessError: {0}")]
    Process(#[from] ProcessError),
}

#[derive(Args)]
pub struct Push {
    /// The ssh URL of the remote server
    ssh_url: Url,
    /// The directory to push
    directory: PathBuf,
}

impl Push {
    pub fn run(&self) -> Result<(), PushError> {
        let ssh_url = self.ssh_url.as_str().replace("ssh://", "");

        println!("Creating bundle file");
        exec("git", vec!["bundle", "create", "temp.bundle", "--all"])?;

        println!("Pushing bundle file");
        exec(
            "scp",
            vec![
                "temp.bundle",
                &format!("{}:{}", ssh_url, self.directory.display()),
            ],
        )?;

        println!("Syncing the repository");
        exec(
            "ssh",
            vec![
                &ssh_url,
                &format!(
                    "cd {} && coder sync temp.bundle && rm temp.bundle",
                    self.directory.display()
                ),
            ],
        )?;
        remove_file(self.directory.join("temp.bundle"))?;

        Ok(())
    }
}

use std::{io::Error as IoError, process::Command, string::FromUtf8Error};

use thiserror::Error;

#[derive(Error, Debug)]
pub enum RemoteError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("FromUtf8Error: {0}")]
    FromUtf8(#[from] FromUtf8Error),
    #[error("Tailscale Not Found")]
    TailscaleNotFound,
}

fn check_tailscale() -> Result<(), RemoteError> {
    match Command::new("tailscale").output() {
        Ok(_) => Ok(()),
        Err(_) => Err(RemoteError::TailscaleNotFound),
    }
}

pub fn exec(host: &str, username: Option<&str>, args: &str) -> Result<(), RemoteError> {
    check_tailscale()?;
    Command::new("tailscale")
        .args([
            "ssh",
            &format!("{}@{}", username.unwrap_or("root"), host),
            args,
        ])
        .status()?;

    Ok(())
}

pub fn exec_output(host: &str, username: Option<&str>, args: &str) -> Result<String, RemoteError> {
    check_tailscale()?;

    Ok(String::from_utf8(
        Command::new("tailscale")
            .args([
                "ssh",
                &format!("{}@{}", username.unwrap_or("root"), host),
                args,
            ])
            .output()?
            .stdout,
    )?)
}

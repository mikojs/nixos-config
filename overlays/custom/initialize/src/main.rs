use ansi_term::Colour::Red;
use config::{Config, ConfigError};
use inquire::{InquireError, Select};
use std::{io::Error as IoError, process::Command};
use thiserror::Error;

mod config;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("InquireError: {0}")]
    Inquire(#[from] InquireError),
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

static TIDE_ITMES: &[&str] = &["Yes", "No", "Skip"];

fn main() -> Result<(), MainError> {
    let mut config = Config::new();

    if !config.tide_is_initialized {
        let result = Select::new(
            "Do you want to initialize a new Tide configure?",
            TIDE_ITMES.to_vec(),
        )
        .prompt()?;

        match result {
            "Yes" => {
                if Command::new("fish")
                    .args(["-c", "tide configure"])
                    .status()?
                    .success()
                {
                    config.tide_is_initialized = true;
                    println!(
                        "Tide is initialized. If you want to reinitialize, please remove the {} file.",
                        Red.paint(config.file_path.display().to_string())
                    );
                }
            }
            "No" => config.tide_is_initialized = true,
            _ => {}
        }
    }

    config.save()?;
    Ok(())
}

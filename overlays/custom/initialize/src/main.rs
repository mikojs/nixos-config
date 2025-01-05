use config::{Config, ConfigError, ConfigType};
use inquire::{InquireError, Select};
use std::{io::Error as IoError, process::Command};
use strum::IntoEnumIterator;
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

static OPTIONS: &[&str] = &["Yes", "No", "Skip"];

fn main() -> Result<(), MainError> {
    let mut config = Config::new();

    for config_type in ConfigType::iter() {
        if !config.is_initialized(config_type.clone()) {
            let result = Select::new(
                "Do you want to initialize a new Tide configure?",
                OPTIONS.to_vec(),
            )
            .prompt()?;

            match result {
                "Yes" => {
                    if Command::new("fish")
                        .args(["-c", "tide configure"])
                        .status()?
                        .success()
                    {
                        config.initialize(config_type);
                    }
                }
                "No" => config.initialize(config_type),
                _ => {}
            }
        }
    }

    config.save()?;
    Ok(())
}

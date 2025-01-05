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
                match config_type {
                    ConfigType::Tide => "Do you want to initialize a new Tide configure?",
                    ConfigType::Gh => "Do you want to login Github CLI?",
                },
                OPTIONS.to_vec(),
            )
            .prompt()?;

            match result {
                "Yes" => {
                    let command_name = match config_type {
                        ConfigType::Tide => "fish",
                        ConfigType::Gh => "gh",
                    };
                    let command_args = match config_type {
                        ConfigType::Tide => ["-c", "tide configure"],
                        ConfigType::Gh => ["auth", "login"],
                    };

                    if Command::new(command_name)
                        .args(command_args)
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

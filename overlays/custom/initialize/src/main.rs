use config::{Config, ConfigError};
use inquire::{InquireError, Select};
use std::env;
use thiserror::Error;

mod config;

#[derive(Error, Debug)]
enum MainError {
    #[error("InquireError: {0}")]
    InquireError(#[from] InquireError),
    #[error("ConfigError: {0}")]
    ConfigError(#[from] ConfigError),
}

static TIDE_ITMES: &[&str] = &["Yes", "No", "Skip"];

fn main() -> Result<(), MainError> {
    let mut config = Config::new();

    if env::var("TIDE_INIT").is_err() {
        let result = Select::new(
            "Do you want to initialize a new Tide configure?",
            TIDE_ITMES.to_vec(),
        )
        .prompt()?;

        match result {
            "Yes" => {
                // TODO: Initialize Tide
                config.tide_is_updated();
            }
            "No" => config.tide_is_updated(),
            _ => {}
        }
    }

    config.save()?;
    Ok(())
}

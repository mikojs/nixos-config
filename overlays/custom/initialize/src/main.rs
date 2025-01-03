use inquire::{InquireError, Select};
use std::env;
use thiserror::Error;

#[derive(Error, Debug)]
enum MainError {
    #[error("InquireError: {0}")]
    InquireError(#[from] InquireError),
}

struct Config {
    tide: bool,
}

static TIDE_ITMES: &[&str] = &["Yes", "No", "Skip"];

fn main() -> Result<(), MainError> {
    let mut config = Config { tide: false };

    if env::var("TIDE_INIT").is_err() {
        let result = Select::new(
            "Do you want to initialize a new Tide configure?",
            TIDE_ITMES.to_vec(),
        )
        .prompt()?;

        match result {
            "Yes" => {
                // TODO: Initialize Tide
                config.tide = true;
            }
            "No" => {
                config.tide = true;
            }
            _ => {}
        }
    }

    Ok(())
}

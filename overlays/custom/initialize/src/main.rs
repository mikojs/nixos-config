use dialoguer::{Error as DialoguerError, FuzzySelect};
use std::env;
use thiserror::Error;

#[derive(Error, Debug)]
enum MainError {
    #[error("Dialoguer error: {0}")]
    Dialoguer(#[from] DialoguerError),
}

struct Config {
    tide: bool,
}

static TIDE_ITMES: &[&str] = &["Yes", "No", "Skip"];

fn main() -> Result<(), MainError> {
    let mut config = Config { tide: true };

    if env::var("TIDE_INIT").is_err() {
        let result = FuzzySelect::new()
            .with_prompt("Do you want to initialize a new Tide configure?")
            .items(TIDE_ITMES)
            .interact()?;

        match TIDE_ITMES[result] {
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

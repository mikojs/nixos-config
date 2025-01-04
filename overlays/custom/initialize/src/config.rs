use serde::{Deserialize, Serialize};
use serde_json::Error as SerdeJsonError;
use std::{
    env,
    fs::{read_to_string, File},
    io::{Error as IoError, Write},
    path::PathBuf,
};
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] SerdeJsonError),
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Config {
    #[serde(skip)]
    file_path: PathBuf,
    tide_is_initialized: bool,
}

impl Config {
    pub fn new() -> Self {
        let file_path = PathBuf::from(
            env::var("INITIALIZE_CONFIG").unwrap_or("~/.config/initialize.json".to_string()),
        );
        let config_str = read_to_string(file_path.clone()).unwrap_or_default();
        let mut config = serde_json::from_str(&config_str).unwrap_or(Config {
            file_path: file_path.clone(),
            tide_is_initialized: false,
        });

        config.file_path = file_path;
        config
    }

    pub fn tide_is_initialized(&mut self) {
        self.tide_is_initialized = true;
    }

    pub fn is_tide_initialized(&self) -> bool {
        self.tide_is_initialized
    }

    pub fn save(&self) -> Result<(), ConfigError> {
        let mut file = File::create(&self.file_path)?;

        file.write_all(serde_json::to_string(&self)?.as_bytes())?;

        Ok(())
    }
}

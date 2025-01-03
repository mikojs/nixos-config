use std::{
    env,
    fs::File,
    io::{Error as IoError, Write},
    path::PathBuf,
};
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
}

pub struct Config {
    tide: bool,
    file_path: PathBuf,
}

impl Config {
    pub fn new() -> Self {
        let file_path =
            env::var("INITIALIZE_CONFIG").unwrap_or("~/.config/nvim/initialize.sh".to_string());

        Self {
            tide: false,
            file_path: PathBuf::from(file_path),
        }
    }

    pub fn tide_is_updated(&mut self) {
        self.tide = true;
    }

    pub fn save(&self) -> Result<(), ConfigError> {
        let mut file = File::create(&self.file_path)?;

        file.write_all("set -x -g tide_is_initialized = true".as_bytes())?;

        Ok(())
    }
}

use serde::{Deserialize, Serialize};
use serde_json::Error as SerdeJsonError;
use std::{
    env,
    fs::{read_to_string, File},
    io::{Error as IoError, Write},
    path::PathBuf,
    process::Command,
};
use strum_macros::EnumIter;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] SerdeJsonError),
}

#[derive(EnumIter, Debug, Clone)]
pub enum ConfigType {
    Tide,
    Gh,
}

#[derive(Serialize, Deserialize, Debug, Default)]
pub struct Config {
    #[serde(skip)]
    file_path: PathBuf,
    tide_is_initialized: bool,
    gh_is_initialized: bool,
}

impl Config {
    pub fn new() -> Result<Self, ConfigError> {
        let home_dir = dirs::home_dir().unwrap_or("./".into());
        let file_path = PathBuf::from(
            env::var("INITIALIZE_CONFIG").unwrap_or(
                home_dir
                    .join(".config/initialize.json")
                    .display()
                    .to_string(),
            ),
        );
        let config_str = read_to_string(file_path.clone()).unwrap_or_default();
        let mut config = serde_json::from_str(&config_str).unwrap_or(Config::default());

        config.file_path = file_path;
        config.gh_is_initialized =
            config.gh_is_initialized || Command::new("gh").arg("status").output().is_ok();

        Ok(config)
    }

    pub fn is_initialized(&self, config_type: ConfigType) -> bool {
        match config_type {
            ConfigType::Tide => self.tide_is_initialized,
            ConfigType::Gh => self.gh_is_initialized,
        }
    }

    pub fn initialize(&mut self, config_type: ConfigType) {
        match config_type {
            ConfigType::Tide => self.tide_is_initialized = true,
            ConfigType::Gh => self.gh_is_initialized = true,
        }
    }

    pub fn save(&self) -> Result<(), ConfigError> {
        let mut file = File::create(&self.file_path)?;

        file.write_all(serde_json::to_string(&self)?.as_bytes())?;

        Ok(())
    }
}

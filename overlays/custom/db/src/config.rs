use serde::{Deserialize, Serialize};
use serde_json::Error as SerdeJsonError;
use thiserror::Error;

use std::{
    env,
    fs::{self, File},
    io::{Error as IoError, Write},
    path::PathBuf,
    string::FromUtf8Error,
};

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] SerdeJsonError),
    #[error("FromUtf8Error: {0}")]
    FromUtf8(#[from] FromUtf8Error),
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct DbConfig {
    pub name: String,
    pub url: String,
}

pub struct Config {
    file_path: PathBuf,
    config: Vec<DbConfig>,
}

impl Config {
    pub fn new() -> Config {
        let home_dir = dirs::home_dir().unwrap_or("./".into());
        let file_path = PathBuf::from(
            env::var("DB_CONFIG").unwrap_or(home_dir.join(".config/db.json").display().to_string()),
        );
        let config_str = fs::read_to_string(file_path.clone()).unwrap_or_default();
        let config = serde_json::from_str(&config_str).unwrap_or(Vec::new());

        Config { file_path, config }
    }

    pub fn update(&mut self, new_db_config: DbConfig) {
        let db_config_result = self
            .config
            .iter_mut()
            .find(|db| db.name == new_db_config.name);

        if let Some(db_config) = db_config_result {
            db_config.url = new_db_config.url;
            return;
        }

        self.config.push(new_db_config);
    }

    pub fn list(&self) -> Vec<DbConfig> {
        self.config.clone()
    }

    pub fn save(&self) -> Result<(), ConfigError> {
        let mut file = File::create(&self.file_path)?;

        file.write_all(serde_json::to_string(&self.config)?.as_bytes())?;

        // TODO: update sqls config

        Ok(())
    }
}

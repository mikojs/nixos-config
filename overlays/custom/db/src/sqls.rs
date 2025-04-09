use clap::Args;
use serde::Serialize;
use serde_json::Error as serdeJsonError;
use thiserror::Error;

use crate::config::{Config, ConfigError, DbConfig, DbType};

#[derive(Error, Debug)]
pub enum SqlsError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] serdeJsonError),
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SqlsDbConfig {
    driver: DbType,
    data_source_name: String,
}

impl From<DbConfig> for SqlsDbConfig {
    fn from(value: DbConfig) -> Self {
        Self {
            driver: value.r#type.unwrap_or(DbType::Postgresql),
            data_source_name: value.url.map(|url| url.to_string()).unwrap_or_default(),
        }
    }
}

#[derive(Serialize)]
pub struct SqlsConfig(Vec<SqlsDbConfig>);

impl From<Config> for SqlsConfig {
    fn from(value: Config) -> Self {
        Self(value.list().into_iter().map(Into::into).collect())
    }
}

#[derive(Args)]
pub struct Sqls {}

impl Sqls {
    pub fn run(&self) -> Result<(), SqlsError> {
        let config = Config::new()?;
        let sqls_config: SqlsConfig = config.into();

        println!("{}", serde_json::to_string_pretty(&sqls_config)?);
        Ok(())
    }
}

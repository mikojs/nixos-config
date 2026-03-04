use clap::Args;
use serde::Serialize;
use serde_json::Error as serdeJsonError;
use thiserror::Error;

use crate::config::{Config, ConfigError, DbConfig, DbType};

#[derive(Error, Debug)]
pub enum SqllsError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
    #[error("SerdeJsonError: {0}")]
    SerdeJson(#[from] serdeJsonError),
    #[error("Url Not Found")]
    UrlNotFound,
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SqllsDbConfig {
    driver: DbType,
    data_source_name: String,
}

impl TryFrom<DbConfig> for SqllsDbConfig {
    type Error = SqllsError;

    fn try_from(value: DbConfig) -> Result<Self, Self::Error> {
        Ok(Self {
            driver: value.r#type.unwrap_or(DbType::Postgresql),
            data_source_name: value
                .url
                .map(|url| url.to_string())
                .ok_or(SqllsError::UrlNotFound)?,
        })
    }
}

#[derive(Serialize)]
pub struct SqllsConfig(Vec<SqllsDbConfig>);

impl TryFrom<Config> for SqllsConfig {
    type Error = SqllsError;

    fn try_from(value: Config) -> Result<Self, Self::Error> {
        let mut sqlls_config: Vec<SqllsDbConfig> = Vec::new();

        for db_config in value.list() {
            if db_config.url.is_some() {
                sqlls_config.push(db_config.try_into()?);
            }
        }

        Ok(Self(sqlls_config))
    }
}

#[derive(Args)]
pub struct Sqlls {}

impl Sqlls {
    pub fn run(&self) -> Result<(), SqllsError> {
        let config = Config::new()?;
        let sqlls_config: SqllsConfig = config.try_into()?;

        println!("{}", serde_json::to_string_pretty(&sqlls_config)?);
        Ok(())
    }
}

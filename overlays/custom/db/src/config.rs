use std::{env, str::FromStr};

use regex::{Error as RegexError, Regex};
use strum::ParseError as StrumParseError;
use strum_macros::EnumString;
use thiserror::Error;
use url::{ParseError as UrlParseError, Url};

#[derive(Error, Debug)]
pub enum ConfigError {
    #[error("RegexError: {0}")]
    Regex(#[from] RegexError),
    #[error("ParseError: {0}")]
    StrumParse(#[from] StrumParseError),
    #[error("UrlParseError: {0}")]
    UrlParse(#[from] UrlParseError),
}

#[derive(EnumString, Debug, PartialEq, Clone)]
pub enum DbType {
    #[strum(serialize = "postgres")]
    Postgres,
}

#[derive(Default, Clone)]
pub struct DbConfig {
    pub name: String,
    pub url: Option<Url>,
    pub r#type: Option<DbType>,
}

#[derive(Default)]
pub struct Config(Vec<DbConfig>);

impl Config {
    pub fn new() -> Result<Self, ConfigError> {
        let mut db_configs: Vec<DbConfig> = Vec::new();
        let db_parttern = Regex::new(r"^DB_(?<name>\w+)_(?<type>URL|TYPE)$")?;

        for (key, value) in env::vars() {
            if let Some(caps) = db_parttern.captures(&key) {
                let name = caps["name"].replace("_", "-").to_lowercase();
                let r#type = caps["type"].to_string();

                if let Some(index) = db_configs.iter().position(|c| c.name == name) {
                    Config::update_db_config_with_type(&mut db_configs[index], r#type, value)?;
                } else {
                    let mut db_config = DbConfig {
                        name,
                        ..Default::default()
                    };

                    Config::update_db_config_with_type(&mut db_config, r#type, value)?;
                    db_configs.push(db_config);
                }
            };
        }

        Ok(Self(db_configs))
    }

    fn update_db_config_with_type(
        db_config: &mut DbConfig,
        r#type: String,
        value: String,
    ) -> Result<(), ConfigError> {
        match r#type.as_ref() {
            "URL" => db_config.url = Some(Url::parse(&value)?),
            "TYPE" => db_config.r#type = Some(DbType::from_str(&value)?),
            _ => unreachable!("unknown type {}", r#type),
        }
        Ok(())
    }

    pub fn list(&self) -> Vec<DbConfig> {
        self.0.clone()
    }
}

#[cfg(test)]
const DB_DEFAULT_URL: &str = "postgresql://postgres:postgres@localhost/postgres";

#[test]
fn get_config() -> Result<(), ConfigError> {
    env::set_var("DB_DEFAULT_URL", DB_DEFAULT_URL);
    env::set_var("DB_TEST_TEST_URL", DB_DEFAULT_URL);
    env::set_var("DB_TEST_TEST_TYPE", "postgres");

    let config = Config::new()?;

    if let Some(default_config) = config.list().first() {
        assert_eq!(default_config.name, "default");
        assert_eq!(default_config.url, Some(Url::parse(DB_DEFAULT_URL)?));
    } else {
        unreachable!("not found default config");
    };

    if let Some(test_test_config) = config.list().get(1) {
        assert_eq!(test_test_config.name, "test-test");
        assert_eq!(test_test_config.url, Some(Url::parse(DB_DEFAULT_URL)?));
        assert_eq!(test_test_config.r#type, Some(DbType::Postgres));
    } else {
        unreachable!("not found test-test config");
    };

    Ok(())
}

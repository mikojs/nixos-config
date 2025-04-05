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

#[derive(EnumString, Debug, PartialEq)]
pub enum DbType {
    #[strum(serialize = "postgres")]
    Postgres,
}

#[derive(Default)]
pub struct DbConfig {
    name: String,
    url: Option<Url>,
    r#type: Option<DbType>,
}

pub struct Config(Vec<DbConfig>);

impl Config {
    pub fn new() -> Result<Config, ConfigError> {
        let mut db_configs = Vec::new();
        let db_parttern = Regex::new(r"^DB_(?<name>\w+)_(?<type>URL|TYPE)$")?;

        for (key, value) in env::vars() {
            if let Some(caps) = db_parttern.captures(&key) {
                let mut db_config = DbConfig {
                    name: caps["name"].replace("_", "-").to_lowercase(),
                    ..Default::default()
                };

                match caps["type"].as_ref() {
                    "URL" => db_config.url = Some(Url::parse(&value)?),
                    "TYPE" => db_config.r#type = Some(DbType::from_str(&value)?),
                    _ => unreachable!("unknown type {}", &caps["type"]),
                }

                db_configs.push(db_config);
            };
        }

        Ok(Config(db_configs))
    }
}

#[cfg(test)]
const DB_DEFAULT_URL: &str = "poastgres:://postgres@localhost/postgres";

#[test]
fn get_config() -> Result<(), ConfigError> {
    env::set_var("DB_DEFAULT_URL", DB_DEFAULT_URL);
    env::set_var("DB_TEST_TEST_URL", DB_DEFAULT_URL);
    env::set_var("DB_TEST_TEST_TYPE", "postgres");

    let config = Config::new()?;

    if let Some(default_config) = config.0.first() {
        assert_eq!(default_config.name, "default");
        assert_eq!(default_config.url, Some(Url::parse(DB_DEFAULT_URL)?));
    } else {
        unreachable!("not found default config");
    };

    if let Some(test_test_config) = config.0.get(1) {
        assert_eq!(test_test_config.name, "test-test");
        assert_eq!(test_test_config.url, Some(Url::parse(DB_DEFAULT_URL)?));
        assert_eq!(test_test_config.r#type, Some(DbType::Postgres));
    } else {
        unreachable!("not found test-test config");
    };

    Ok(())
}

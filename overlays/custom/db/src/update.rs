use std::env::{self};

use clap::Args;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum UpdateError {
    #[error("not found DB_URL")]
    NotFoundDbUrl,
}

#[derive(Args)]
pub struct Update {
    url: Option<String>,
}

fn get_url(url: Option<String>) -> Result<String, UpdateError> {
    Ok(url.unwrap_or(env::var("DB_URL").map_err(|_| UpdateError::NotFoundDbUrl)?))
}

impl Update {
    pub fn run(&self) -> Result<(), UpdateError> {
        println!("{}", get_url(self.url.clone())?);
        Ok(())
    }
}

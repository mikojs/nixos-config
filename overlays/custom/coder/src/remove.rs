use clap::{ArgMatches, Args, Command, Error as ClapError, FromArgMatches};
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum RemoveError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

pub struct Remove {
    repo_name: String,
}

impl FromArgMatches for Remove {
    fn from_arg_matches(matches: &ArgMatches) -> Result<Self, ClapError> {
        let mut matches = matches.clone();

        Self::from_arg_matches_mut(&mut matches)
    }

    fn from_arg_matches_mut(matches: &mut ArgMatches) -> Result<Self, ClapError> {
        Ok(Self {
            repo_name: Config::from_arg_matches_mut(matches)?,
        })
    }

    fn update_from_arg_matches(&mut self, matches: &ArgMatches) -> Result<(), ClapError> {
        let mut matches = matches.clone();

        self.update_from_arg_matches_mut(&mut matches)
    }
}

impl Args for Remove {
    fn augment_args(cmd: Command) -> Command {
        Config::augment_args(cmd)
    }

    fn augment_args_for_update(cmd: Command) -> Command {
        Remove::augment_args(cmd)
    }
}

impl Remove {
    pub fn run(&self) -> Result<(), RemoveError> {
        let mut config = Config::new()?;

        config.remove(self.repo_name.clone())?;
        config.save()?;

        Ok(())
    }
}

use clap::{ArgMatches, Args, Command, Error as ClapError, FromArgMatches};
use thiserror::Error;

use crate::config::{Config, ConfigError};

#[derive(Error, Debug)]
pub enum ShowError {
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

pub struct Show {
    all: bool,
}

impl FromArgMatches for Show {
    fn from_arg_matches(matches: &ArgMatches) -> Result<Self, ClapError> {
        let mut matches = matches.clone();

        Self::from_arg_matches_mut(&mut matches)
    }

    fn from_arg_matches_mut(matches: &mut ArgMatches) -> Result<Self, ClapError> {
        Ok(Self {
            all: matches.get_flag("all"),
        })
    }

    fn update_from_arg_matches(&mut self, matches: &ArgMatches) -> Result<(), ClapError> {
        let mut matches = matches.clone();

        self.update_from_arg_matches_mut(&mut matches)
    }

    fn update_from_arg_matches_mut(&mut self, matches: &mut ArgMatches) -> Result<(), ClapError> {
        // TODO: add logic

        Ok(())
    }
}

impl Args for Show {
    fn augment_args(cmd: Command) -> Command {
        let config = Config::new();
        let mut new_cmd = cmd;

        for db_config in config.list() {
            new_cmd = new_cmd.subcommand(Command::new(db_config.name));
        }

        new_cmd
    }

    fn augment_args_for_update(cmd: Command) -> Command {
        Show::augment_args(cmd)
    }
}

impl Show {
    pub fn run(&self) -> Result<(), ShowError> {
        // TODO: add show command

        Ok(())
    }
}

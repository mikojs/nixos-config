use clap::{ArgMatches, Args, Command, Error as ClapError, FromArgMatches};
use thiserror::Error;

use crate::config::Config;

#[derive(Error, Debug)]
pub enum ShowError {}

pub struct Show {}

impl FromArgMatches for Show {
    fn from_arg_matches(matches: &ArgMatches) -> Result<Self, ClapError> {
        let mut matches = matches.clone();

        Self::from_arg_matches_mut(&mut matches)
    }

    fn from_arg_matches_mut(matches: &mut ArgMatches) -> Result<Self, ClapError> {
        Ok(Self {})
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
        let config = Config::new().unwrap_or_default();
        let mut new_cmd = cmd;

        for db_config in config.list() {
            new_cmd = new_cmd.subcommand(Command::new(db_config.name).about("Datebase"));
        }

        new_cmd
    }

    fn augment_args_for_update(cmd: Command) -> Command {
        Show::augment_args(cmd)
    }
}

impl Show {
    pub fn run(&self) -> Result<(), ShowError> {
        // TODO: add logic

        Ok(())
    }
}

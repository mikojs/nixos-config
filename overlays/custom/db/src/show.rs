use clap::{ArgMatches, Args, Command, Error as ClapError, FromArgMatches};

use crate::config::{Config, DbConfig};

pub struct Show {
    db_config: Option<DbConfig>,
}

impl FromArgMatches for Show {
    fn from_arg_matches(matches: &ArgMatches) -> Result<Self, ClapError> {
        let mut matches = matches.clone();

        Self::from_arg_matches_mut(&mut matches)
    }

    fn from_arg_matches_mut(matches: &mut ArgMatches) -> Result<Self, ClapError> {
        let db_config = if let Some((name, _)) = matches.subcommand() {
            Config::new()
                .unwrap_or_default()
                .list()
                .into_iter()
                .find(|db_config| db_config.name == name)
        } else {
            None
        };

        Ok(Self { db_config })
    }

    fn update_from_arg_matches(&mut self, matches: &ArgMatches) -> Result<(), ClapError> {
        let mut matches = matches.clone();

        self.update_from_arg_matches_mut(&mut matches)
    }
}

impl Args for Show {
    fn augment_args(cmd: Command) -> Command {
        let config = Config::new().unwrap_or_default();
        let mut new_cmd = cmd.subcommand_required(true);

        for db_config in config.list() {
            new_cmd = new_cmd.subcommand(Command::new(db_config.name).about("Datebase"))
        }

        new_cmd
    }

    fn augment_args_for_update(cmd: Command) -> Command {
        Show::augment_args(cmd)
    }
}

impl Show {
    pub fn run(&self) {
        if let Some(Some(url)) = self.db_config.clone().map(|db_config| db_config.url) {
            println!("{}", url);
        }
    }
}

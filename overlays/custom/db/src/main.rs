use std::io::{self, Error as IoError};

use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use show::Show;
use sqls::{Sqls, SqlsError};
use thiserror::Error;

mod config;
mod show;
mod sqls;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SqlsError: {0}")]
    Sqls(#[from] SqlsError),
}

#[derive(Subcommand)]
enum Commands {
    /// Show database url
    Show(Show),
    /// Generate sqls config
    Sqls(Sqls),
}

#[derive(Parser)]
struct Cli {
    /// Generate shell completion
    #[arg(long, value_enum)]
    generate: Option<Shell>,
    #[command(subcommand)]
    commands: Option<Commands>,
}

fn main() -> Result<(), MainError> {
    let cli = Cli::parse();

    if let Some(generator) = cli.generate {
        let cmd = &mut Cli::command();

        generate(
            generator,
            cmd,
            cmd.get_name().to_string(),
            &mut io::stdout(),
        );
    } else {
        match cli.commands {
            Some(Commands::Show(show)) => show.run(),
            Some(Commands::Sqls(sqls)) => sqls.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

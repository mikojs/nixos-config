use std::io::{self, Error as IoError};

use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use show::{Show, ShowError};
use thiserror::Error;

mod config;
mod show;

#[derive(Error, Debug)]
enum MainError {
    #[error("ShowError: {0}")]
    Show(#[from] ShowError),
    #[error("IoError: {0}")]
    Io(#[from] IoError),
}

#[derive(Subcommand)]
enum Commands {
    /// Show databases
    Show(Show),
}

#[derive(Parser)]
struct Cli {
    #[arg(long, value_enum, hide = true)]
    generate: Option<Shell>,
    #[command(subcommand)]
    commands: Option<Commands>,
}

fn main() -> Result<(), MainError> {
    let cli = Cli::parse();

    if let Some(generator) = cli.generate {
        let cmd = &mut Cli::command();

        // TODO: auto load and update when the env update or update command
        generate(
            generator,
            cmd,
            cmd.get_name().to_string(),
            &mut io::stdout(),
        );
    } else {
        match cli.commands {
            Some(Commands::Show(show)) => show.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

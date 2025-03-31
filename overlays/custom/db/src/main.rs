use std::io::{self, Error as IoError};

use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use show::{Show, ShowError};
use sync::{Sync, SyncError};
use thiserror::Error;
use update::{Update, UpdateError};

mod config;
mod show;
mod sync;
mod update;

#[derive(Error, Debug)]
enum MainError {
    #[error("UpdateError: {0}")]
    Update(#[from] UpdateError),
    #[error("SyncError: {0}")]
    Sync(#[from] SyncError),
    #[error("ShowError: {0}")]
    Show(#[from] ShowError),
    #[error("IoError: {0}")]
    Io(#[from] IoError),
}

#[derive(Subcommand)]
enum Commands {
    Update(Update),
    Sync(Sync),
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

        generate(
            generator,
            cmd,
            cmd.get_name().to_string(),
            &mut io::stdout(),
        );
    } else {
        match cli.commands {
            Some(Commands::Update(update)) => update.run()?,
            Some(Commands::Sync(sync)) => sync.run()?,
            Some(Commands::Show(show)) => show.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

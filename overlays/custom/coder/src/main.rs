use std::io::{self, Error as IoError};

use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use sync::{Sync, SyncError};
use thiserror::Error;

mod process;
mod sync;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("SyncError: {0}")]
    Sync(#[from] SyncError),
}

#[derive(Subcommand)]
enum Commands {
    /// Sync code with git bundle file
    Sync(Sync),
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
            Some(Commands::Sync(push)) => push.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

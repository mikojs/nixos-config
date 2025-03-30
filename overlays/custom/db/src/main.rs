use clap::{Parser, Subcommand};
use sync::{Sync, SyncError};
use thiserror::Error;
use update::{Update, UpdateError};

mod config;
mod sync;
mod update;

#[derive(Error, Debug)]
enum MainError {
    #[error("UpdateError: {0}")]
    UpdateError(#[from] UpdateError),
    #[error("SyncError: {0}")]
    SyncError(#[from] SyncError),
}

#[derive(Subcommand)]
enum Commands {
    Update(Update),
    Sync(Sync),
}

#[derive(Parser)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

fn main() -> Result<(), MainError> {
    let cli = Cli::parse();

    match cli.command {
        Commands::Update(update) => update.run()?,
        Commands::Sync(sync) => sync.run()?,
    }

    Ok(())
}

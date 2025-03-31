use clap::{Parser, Subcommand};
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
}

#[derive(Subcommand)]
enum Commands {
    Update(Update),
    Sync(Sync),
    Show(Show),
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
        Commands::Show(show) => show.run()?,
    }

    Ok(())
}

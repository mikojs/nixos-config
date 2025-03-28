use clap::{Parser, Subcommand};
use thiserror::Error;
use update::Update;

mod update;

#[derive(Error, Debug)]
enum MainError {
    #[error("UpdateError: {0}")]
    UpdateError(#[from] update::UpdateError),
}

#[derive(Subcommand)]
enum Commands {
    Update(Update),
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
    }

    Ok(())
}

use std::io::{self, Error as IoError};

use add::{Add, AddError};
use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use remove::{Remove, RemoveError};
use thiserror::Error;

mod add;
mod config;
mod remove;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("AddError: {0}")]
    Add(#[from] AddError),
    #[error("RemoveError: {0}")]
    Remove(#[from] RemoveError),
}

#[derive(Subcommand)]
enum Commands {
    /// Add a new repository to the coder
    Add(Add),
    /// Remove a repository from the coder
    Remove(Remove),
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
            Some(Commands::Add(add)) => add.run()?,
            Some(Commands::Remove(remove)) => remove.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

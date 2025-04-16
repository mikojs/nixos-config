use std::io::{self, Error as IoError};

use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use thiserror::Error;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
}

#[derive(Subcommand)]
enum Commands {}

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
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

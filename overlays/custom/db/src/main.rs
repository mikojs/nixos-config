use std::io::{self, Error as IoError};

use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use show::{Show, ShowError};
use sqlls::{Sqlls, SqllsError};
use thiserror::Error;

mod config;
mod show;
mod sqlls;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("ShowError: {0}")]
    Show(#[from] ShowError),
    #[error("SqllsError: {0}")]
    Sqlls(#[from] SqllsError),
}

#[derive(Subcommand)]
enum Commands {
    /// Show database url
    Show(Show),
    /// Generate sqlls config
    Sqlls(Sqlls),
}

/// Parse database information from environment variables
///
/// Environment variable:
///
/// - DB_<DB_NAME>_URL: The database url
/// - DB_<DB_NAME>_TYPE: The database type (postgres|sqlite3)
/// - DB_<DB_NAME>_DESCRIPTION: The database description
#[derive(Parser)]
#[command(verbatim_doc_comment)]
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
            Some(Commands::Show(show)) => show.run()?,
            Some(Commands::Sqlls(sqlls)) => sqlls.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

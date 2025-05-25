use std::io::{self, Error as IoError};

use add::{Add, AddError};
use clap::{CommandFactory, Parser, Subcommand};
use clap_complete::{generate, Shell};
use deploy::{Deploy, DeployError};
use info::{Info, InfoError};
use pull::{Pull, PullError};
use push::{Push, PushError};
use remove::{Remove, RemoveError};
use sync::{Sync, SyncError};
use thiserror::Error;

mod add;
mod config;
mod deploy;
mod info;
mod pull;
mod push;
mod remote;
mod remove;
mod sync;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("AddError: {0}")]
    Add(#[from] AddError),
    #[error("RemoveError: {0}")]
    Remove(#[from] RemoveError),
    #[error("SyncError: {0}")]
    Sync(#[from] SyncError),
    #[error("PushError: {0}")]
    Push(#[from] PushError),
    #[error("PullError: {0}")]
    Pull(#[from] PullError),
    #[error("DeployError: {0}")]
    Deploy(#[from] DeployError),
    #[error("InfoError: {0}")]
    Info(#[from] InfoError),
}

#[derive(Subcommand)]
enum Commands {
    /// Add a new repository to Coder
    Add(Add),
    /// Remove a repository from Coder
    Remove(Remove),
    /// Sync all repositories in Coder
    Sync(Sync),
    /// Push all repositories in Coder to the target service with Tailscale
    Push(Push),
    /// Pull all repositories in Coder from the target service with Tailscale
    Pull(Pull),
    /// Deploy a repository deploy script in coder
    Deploy(Deploy),
    /// Get information about Coder
    Info(Info),
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
            Some(Commands::Sync(sync)) => sync.run()?,
            Some(Commands::Push(push)) => push.run()?,
            Some(Commands::Pull(pull)) => pull.run()?,
            Some(Commands::Deploy(deploy)) => deploy.run()?,
            Some(Commands::Info(info)) => info.run()?,
            _ => Cli::command().print_help()?,
        }
    }

    Ok(())
}

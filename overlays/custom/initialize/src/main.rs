use config::{Config, ConfigError, ConfigType};
use inquire::{Confirm, InquireError, Select, Text};
use std::{io::Error as IoError, process::Command};
use strum::IntoEnumIterator;
use thiserror::Error;

mod config;

#[derive(Error, Debug)]
enum MainError {
    #[error("IoError: {0}")]
    Io(#[from] IoError),
    #[error("InquireError: {0}")]
    Inquire(#[from] InquireError),
    #[error("ConfigError: {0}")]
    Config(#[from] ConfigError),
}

static OPTIONS: &[&str] = &["Yes", "No", "Skip"];

fn main() -> Result<(), MainError> {
    let mut config = Config::new()?;

    for config_type in ConfigType::iter() {
        if !config.is_initialized(config_type.clone()) {
            let result = Select::new(
                match config_type {
                    ConfigType::Tide => "Do you want to initialize a new Tide configure?",
                    ConfigType::Gh => "Do you want to login Github CLI?",
                    ConfigType::Tailscale => "Do you want to login Tailscale with the root user?",
                },
                OPTIONS.to_vec(),
            )
            .prompt()?;

            match result {
                "Yes" => {
                    let command_name = match config_type {
                        ConfigType::Tide => "fish",
                        ConfigType::Gh => "gh",
                        ConfigType::Tailscale => "sudo",
                    };
                    let command_args = match config_type {
                        ConfigType::Tide => vec!["-c", "tide configure"]
                            .into_iter()
                            .map(|v| v.to_string())
                            .collect(),
                        ConfigType::Gh => vec!["auth", "login"]
                            .into_iter()
                            .map(|v| v.to_string())
                            .collect(),
                        ConfigType::Tailscale => {
                            let mut command_args: Vec<String> = vec!["tailscale", "login"]
                                .into_iter()
                                .map(|v| v.to_string())
                                .collect();

                            let hostname = Text::new("Hostname:")
                                .with_help_message(
                                    "Leave it empty if you want to auto-generate the hostname by Tailscale",
                                )
                                .prompt()?;

                            if !hostname.is_empty() {
                                let new_args = format!("--hostname={}", hostname);

                                command_args.push(new_args);
                            }

                            let use_ssh = Confirm::new("Use ssh?").with_default(false)
                                .with_help_message("Run an SSH server, permitting access per tailnet admin's declared policy")
                                .prompt()?;

                            if use_ssh {
                                command_args.push("--ssh".to_string());
                            }

                            let use_advertise_exit_node = Confirm::new("Use advertise exit node?")
                                .with_default(false)
                                .with_help_message(
                                    "Offer to be an exit node for internet traffic for the tailnet",
                                )
                                .prompt()?;

                            if use_advertise_exit_node {
                                command_args.push("--advertise-exit-node".to_string());
                            }

                            command_args
                        }
                    };

                    if Command::new(command_name)
                        .args(command_args)
                        .status()?
                        .success()
                    {
                        config.initialize(config_type);
                    }
                }
                "No" => config.initialize(config_type),
                _ => {}
            }
        }
    }

    config.save()?;
    Ok(())
}

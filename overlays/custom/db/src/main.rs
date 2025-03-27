use clap::Parser;
use thiserror::Error;

#[derive(Error, Debug)]
enum MainError {}

#[derive(Parser)]
struct Cli {
    url: String,
}

fn main() -> Result<(), MainError> {
    let cli = Cli::parse();

    println!("{}", cli.url);
    Ok(())
}

use thiserror::Error;

mod config;

#[derive(Error, Debug)]
enum MainError {}

fn main() -> Result<(), MainError> {
    Ok(())
}

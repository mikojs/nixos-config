use thiserror::Error;

#[derive(Error, Debug)]
enum MainError {}

fn main() -> Result<(), MainError> {
    Ok(())
}

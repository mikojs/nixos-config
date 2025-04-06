use thiserror::Error;

#[derive(Error, Debug)]
pub enum ShowError {}

pub struct Show {}

impl Show {
    pub fn run(&self) -> Result<(), ShowError> {
        Ok(())
    }
}

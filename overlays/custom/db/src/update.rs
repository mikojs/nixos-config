use clap::Args;

#[derive(Args)]
pub struct Update {
    url: Option<String>,
}

impl Update {
    pub fn run(&self) {
        println!("{}", self.url.as_ref().unwrap());
    }
}

use std::path::PathBuf;

use clap::Args;
use thiserror::Error;

use crate::process::{exec, exec_result, ProcessError};

#[derive(Error, Debug)]
pub enum SyncError {
    #[error("ProcessError: {0}")]
    Process(#[from] ProcessError),
}

#[derive(Args)]
pub struct Sync {
    /// Path to the bundle file
    bundle: PathBuf,

    #[clap(skip)]
    bundle_branches: Vec<String>,
    #[clap(skip)]
    current_branches: Vec<String>,
}

impl Sync {
    fn get_bundle_branches(&mut self) -> Result<(), SyncError> {
        let bundle_branches_str = exec_result(
            "git",
            vec!["bundle", "list-heads", &self.bundle.display().to_string()],
        )?;

        self.bundle_branches = bundle_branches_str
            .split("\n")
            .filter(|s| !s.is_empty() && s.contains("refs/heads/"))
            .map(|s| s.split(" ").collect::<Vec<&str>>()[1].replace("refs/heads/", ""))
            .collect();
        Ok(())
    }

    fn get_current_branches(&mut self) -> Result<(), SyncError> {
        let current_branches_str = exec_result("git", vec!["branch"])?;

        self.current_branches = current_branches_str
            .split("\n")
            .filter(|s| !s.is_empty())
            .map(|s| s.replace("*", "").replace(" ", ""))
            .collect();
        Ok(())
    }

    fn checkout_to_main_branch(&self) -> Result<(), SyncError> {
        let main_branch = self
            .current_branches
            .iter()
            .find(|b| *b == "develop" || *b == "master")
            .map_or("main", |b| b);

        exec("git", vec!["checkout", main_branch])?;
        Ok(())
    }

    fn remove_old_branches(&self) -> Result<(), SyncError> {
        let removed_branches = self
            .current_branches
            .iter()
            .filter(|b| !self.bundle_branches.contains(b))
            .collect::<Vec<&String>>();

        for branch in removed_branches {
            exec("git", vec!["branch", "-D", branch])?;
        }

        Ok(())
    }

    fn add_new_branches(&self) -> Result<(), SyncError> {
        let added_branches = self
            .bundle_branches
            .iter()
            .filter(|b| !self.current_branches.contains(b))
            .collect::<Vec<&String>>();

        for branch in added_branches {
            exec("git", vec!["branch", branch])?;
        }

        Ok(())
    }

    fn update_branches(&self) -> Result<(), SyncError> {
        for branch in self.bundle_branches.clone() {
            exec("git", vec!["checkout", &branch])?;
            exec(
                "git",
                vec!["pull", &self.bundle.display().to_string(), &branch],
            )?;
        }

        Ok(())
    }

    pub fn run(&mut self) -> Result<(), SyncError> {
        self.get_bundle_branches()?;
        self.get_current_branches()?;

        let current_branch =
            exec_result("git", vec!["rev-parse", "--abbrev-ref", "HEAD"])?.replace("\n", "");

        self.checkout_to_main_branch()?;
        self.remove_old_branches()?;
        self.add_new_branches()?;
        self.update_branches()?;

        if self.bundle_branches.contains(&current_branch) {
            exec("git", vec!["checkout", &current_branch])?;
        }

        Ok(())
    }
}

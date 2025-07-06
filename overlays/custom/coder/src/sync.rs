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
}

impl Sync {
    pub fn run(&self) -> Result<(), SyncError> {
        let bundle_path_str = self.bundle.display().to_string();
        let bundle_branches_str =
            exec_result("git", vec!["bundle", "list-heads", &bundle_path_str])?;
        let bundle_branches = bundle_branches_str
            .split("\n")
            .filter(|s| !s.is_empty() && s.contains("refs/heads/"))
            .map(|s| s.split(" ").collect::<Vec<&str>>()[1].replace("refs/heads/", ""))
            .collect::<Vec<String>>();

        let current_branch = exec_result("git", vec!["rev-parse", "--abbrev-ref", "HEAD"])?;
        let current_branches_str = exec_result("git", vec!["branch"])?;
        let current_branches = current_branches_str
            .split("\n")
            .filter(|s| !s.is_empty())
            .map(|s| s.replace("*", "").replace(" ", ""))
            .collect::<Vec<String>>();

        let main_branch = current_branches
            .iter()
            .find(|b| *b == "develop" || *b == "master")
            .map_or("main", |b| b);

        exec("git", vec!["checkout", main_branch])?;

        let removed_branches = current_branches
            .iter()
            .filter(|b| !bundle_branches.contains(b))
            .collect::<Vec<&String>>();

        for branch in removed_branches {
            exec("git", vec!["branch", "-D", branch])?;
        }

        let added_branches = bundle_branches
            .iter()
            .filter(|b| !current_branches.contains(b))
            .collect::<Vec<&String>>();

        for branch in added_branches {
            exec("git", vec!["branch", branch])?;
        }

        for branch in bundle_branches.clone() {
            exec("git", vec!["checkout", &branch])?;
            exec("git", vec!["pull", &bundle_path_str, &branch])?;
        }

        if bundle_branches.contains(&current_branch) {
            exec("git", vec!["checkout", &current_branch])?;
        } else {
            exec("git", vec!["checkout", &main_branch])?;
        }

        Ok(())
    }
}

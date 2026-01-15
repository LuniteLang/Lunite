use std::fs;
use std::path::{Path, PathBuf};
use serde::{Deserialize, Serialize};
use std::process::Command;

#[derive(Debug, Deserialize, Serialize)]
pub struct Manifest {
    pub package: PackageInfo,
    pub dependencies: Option<std::collections::HashMap<String, Dependency>>,
}

#[derive(Debug, Deserialize, Serialize)]
#[serde(untagged)]
pub enum Dependency {
    Simple(String),
    Detailed { git: String, branch: Option<String> },
}

#[derive(Debug, Deserialize, Serialize)]
pub struct PackageInfo {
    pub name: String,
    pub version: String,
    pub authors: Option<Vec<String>>,
}

impl Manifest {
    pub fn fetch_all(&self) -> Result<Vec<PathBuf>, String> {
        let mut paths = Vec::new();
        let deps_dir = Path::new(".lunite/deps");
        if !deps_dir.exists() {
            fs::create_dir_all(deps_dir).map_err(|e| e.to_string())?;
        }

        if let Some(deps) = &self.dependencies {
            for (name, dep) in deps {
                let url = match dep {
                    Dependency::Simple(s) => s,
                    Dependency::Detailed { git, .. } => git,
                };
                println!("[LPM] Fetching dependency: {} from {}", name, url);
                let dep_path = deps_dir.join(name);
                
                if !dep_path.exists() {
                    let status = Command::new("git")
                        .arg("clone")
                        .arg(url)
                        .arg(&dep_path)
                        .status()
                        .map_err(|e| format!("Failed to execute git: {}", e))?;
                    
                    if !status.success() {
                        return Err(format!("Failed to clone {}", name));
                    }
                }
                
                paths.push(dep_path.join("src"));
            }
        }
        Ok(paths)
    }
}

pub fn parse_manifest(path: &Path) -> Result<Manifest, String> {
    let content = fs::read_to_string(path).map_err(|e| e.to_string())?;
    toml::from_str(&content).map_err(|e| e.to_string())
}

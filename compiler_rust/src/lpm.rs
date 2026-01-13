use serde::Deserialize;
use std::collections::HashMap;
use std::fs;
use std::path::Path;

#[derive(Debug, Deserialize)]
pub struct Manifest {
    pub package: Package,
    pub dependencies: Option<HashMap<String, Dependency>>,
}

#[derive(Debug, Deserialize)]
pub struct Package {
    pub name: String,
    pub version: String,
}

#[derive(Debug, Deserialize)]
#[serde(untagged)]
pub enum Dependency {
    // Case: lib = "1.0.0"
    Version(String),
    // Case: lib = { git = "url", tag = "v1" }
    Git {
        git: String,
        branch: Option<String>,
        tag: Option<String>,
        rev: Option<String>,
    },
    // Case: lib = { path = "../local/lib" }
    Path {
        path: String,
    }
}

pub fn parse_manifest(path: &Path) -> Result<Manifest, String> {
    if !path.exists() {
        return Err(format!("Manifest file not found at: {}", path.display()));
    }
    let content = fs::read_to_string(path)
        .map_err(|e| format!("Failed to read manifest: {}", e))?;
    
    let manifest: Manifest = toml::from_str(&content)
        .map_err(|e| format!("Failed to parse TOML: {}", e))?;
        
    Ok(manifest)
}

impl Manifest {
    pub fn fetch_all(&self) -> Result<Vec<std::path::PathBuf>, String> {
        let mut lib_paths = Vec::new();
        let deps_dir = std::path::Path::new(".lunite").join("deps");
        
        if !deps_dir.exists() {
            fs::create_dir_all(&deps_dir).map_err(|e| format!("Failed to create deps dir: {}", e))?;
        }

        if let Some(deps) = &self.dependencies {
            for (name, dep) in deps {
                println!("[LPM] Fetching dependency: {}", name);
                match dep {
                    Dependency::Git { git, branch, tag, rev } => {
                        let target_dir = deps_dir.join(name);
                        if target_dir.exists() {
                            println!("  - Updating existing repo: {}", git);
                            let status = std::process::Command::new("git")
                                .arg("-C").arg(&target_dir)
                                .arg("pull")
                                .status()
                                .map_err(|e| format!("Git pull failed: {}", e))?;
                        } else {
                            println!("  - Cloning repo: {}", git);
                            let mut cmd = std::process::Command::new("git");
                            cmd.arg("clone").arg(git).arg(&target_dir);
                            
                            if let Some(t) = tag {
                                cmd.arg("--branch").arg(t);
                            } else if let Some(b) = branch {
                                cmd.arg("--branch").arg(b);
                            }
                            
                            let status = cmd.status()
                                .map_err(|e| format!("Git clone failed: {}", e))?;
                            
                            if !status.success() {
                                return Err(format!("Failed to clone dependency: {}", name));
                            }
                        }
                        lib_paths.push(target_dir);
                    }
                    Dependency::Path { path } => {
                        let p = std::path::PathBuf::from(path);
                        if !p.exists() {
                            return Err(format!("Dependency path not found: {}", path));
                        }
                        println!("  - Using local path: {}", path);
                        lib_paths.push(p);
                    }
                    Dependency::Version(v) => {
                        return Err(format!("Version-based dependencies are not supported yet. Use Git or Path for: {}", name));
                    }
                }
            }
        }
        Ok(lib_paths)
    }
}

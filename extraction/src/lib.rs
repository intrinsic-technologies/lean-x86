pub mod config;
pub mod elf;
mod emit;
mod stack;

use anyhow::{ensure, Context, Result};
use std::{fs, path::Path};

pub fn run(config_path: &Path, decoder: &Path) -> Result<()> {
    let config = config::Config::load(config_path)?;
    let input = fs::read(&config.elf).context("reading input ELF")?;
    let image = elf::read(&input, &config)?;
    ensure!(
        config.output.symlink_metadata().is_err(),
        "output already exists: {}",
        config.output.display()
    );
    let parent = config
        .output
        .parent()
        .context("output needs a parent directory")?;
    fs::create_dir_all(parent)?;
    let temporary = tempfile::tempdir_in(parent)?;
    emit::generate(&config, &image, decoder, temporary.path())?;
    if config.include_file {
        fs::write(temporary.path().join("file.bin"), &input)?;
    }
    // Reserve the destination without replacing existing files or directories.
    fs::create_dir(&config.output)?;
    for entry in fs::read_dir(temporary.path())? {
        let entry = entry?;
        fs::rename(entry.path(), config.output.join(entry.file_name()))?;
    }
    println!("Wrote {}", config.output.display());
    Ok(())
}

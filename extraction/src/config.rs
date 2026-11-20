use anyhow::{ensure, Context, Result};
use serde::Deserialize;
use std::{
    collections::{BTreeMap, BTreeSet},
    fs,
    path::{Component, Path, PathBuf},
};

#[derive(Debug, Deserialize)]
#[serde(deny_unknown_fields)]
pub struct Config {
    pub elf: PathBuf,
    pub output: PathBuf,
    pub namespace: String,
    pub code_sections: Vec<String>,
    #[serde(default)]
    pub data_sections: Vec<String>,
    #[serde(default)]
    pub entries: BTreeMap<String, String>,
    #[serde(default)]
    pub rust_panics: bool,
    #[serde(default)]
    pub features: Vec<String>,
    /// Embed the whole ELF file as `fileBytes` (`file.bin`), take each section's bytes from it
    /// instead of writing a `.bin` file per section, and write `File.lean`, views of it.
    #[serde(default)]
    pub include_file: bool,
}

fn identifier(s: &str) -> bool {
    let mut chars = s.chars();
    chars.next().is_some_and(|c| c.is_ascii_alphabetic())
        && chars.all(|c| c.is_ascii_alphanumeric() || c == '_')
}

impl Config {
    pub fn sections(&self) -> impl Iterator<Item = (&str, bool)> {
        self.code_sections
            .iter()
            .map(|n| (n.as_str(), true))
            .chain(self.data_sections.iter().map(|n| (n.as_str(), false)))
    }

    pub fn load(path: &Path) -> Result<Self> {
        let path = path.canonicalize().context("finding extraction config")?;
        let mut config: Self =
            toml::from_str(&fs::read_to_string(&path)?).context("reading extraction config")?;
        config.validate()?;
        let base = path.parent().unwrap();
        config.elf = base
            .join(&config.elf)
            .canonicalize()
            .context("finding input ELF")?;
        // Joined to the canonical directory, without `.` components, and with the leading `..`
        // that `validate` allows resolved, so that the path passes `validate` again.
        let mut output = base.to_path_buf();
        for component in config.output.components() {
            match component {
                Component::CurDir => {}
                Component::ParentDir => {
                    output.pop();
                }
                other => output.push(other),
            }
        }
        config.output = output;
        Ok(config)
    }

    pub fn validate(&self) -> Result<()> {
        ensure!(
            !self.elf.as_os_str().is_empty() && !self.output.as_os_str().is_empty(),
            "elf and output must be specified"
        );
        ensure!(
            self.namespace
                .split('.')
                .all(|s| identifier(&s.replace('-', "_"))),
            "namespace must contain dotted ASCII identifiers (dashes are allowed)"
        );
        // `Path` drops `.` components, which `create_dir` does not, so `.` and `..` may only lead.
        let mut named = false;
        for part in self.output.to_string_lossy().split('/') {
            match part {
                "" => {}
                "." | ".." => ensure!(
                    !named,
                    "output may have `.` and `..` components only before its first name"
                ),
                _ => named = true,
            }
        }
        let components: Vec<_> = self.namespace.split('.').collect();
        // Generated modules import modules of these libraries, which the output would shadow.
        let root = components[0];
        ensure!(
            !matches!(
                root,
                "X86" | "Prelude" | "Elf" | "Lean" | "Init" | "Std" | "Lake"
            ),
            "the namespace cannot start with {root}, a library the generated modules import"
        );
        // Generated modules import each other by the namespace.
        ensure!(
            self.output
                .ends_with(components.iter().collect::<PathBuf>()),
            "output must end with the namespace's components, {}",
            components.join("/")
        );
        ensure!(
            !self.code_sections.is_empty(),
            "select at least one code section"
        );
        let mut names = BTreeSet::new();
        for (name, _) in self.sections() {
            ensure!(
                !name.is_empty() && names.insert(name),
                "empty or duplicate section: {name}"
            );
        }
        for (alias, symbol) in &self.entries {
            ensure!(
                identifier(alias) && !symbol.is_empty(),
                "invalid entry {alias:?}"
            );
        }
        let mut features = BTreeSet::new();
        for feature in &self.features {
            ensure!(
                matches!(feature.as_str(), "lzcnt" | "cet" | "cmpxchg16b"),
                "unsupported decoder feature: {feature}"
            );
            ensure!(features.insert(feature), "duplicate feature: {feature}");
        }
        Ok(())
    }

    pub fn lean_namespace(&self) -> String {
        // Lean reads a dotted name as one identifier, but a single word may be a keyword, and the
        // syntax that generated modules import adds keywords (`include_chunked_bytes`), so a
        // single-word namespace is always quoted.
        let word = !self.namespace.contains('.');
        self.namespace
            .split('.')
            .map(|s| {
                if identifier(s) && !word {
                    s.to_owned()
                } else {
                    format!("«{s}»")
                }
            })
            .collect::<Vec<_>>()
            .join(".")
    }
}

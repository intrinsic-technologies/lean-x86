use clap::Parser;
use std::path::PathBuf;

#[derive(Parser)]
#[command(version, about = "Dump x86-64 ELF instructions and data as Lean")]
struct Cli {
    config: PathBuf,
    /// Prebuilt XED decoder (defaults to this checkout's build).
    #[arg(long)]
    decoder: Option<PathBuf>,
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();
    let decoder = cli.decoder.unwrap_or_else(|| {
        PathBuf::from(env!("CARGO_MANIFEST_DIR")).join(".cache/decode-instructions")
    });
    x86_extract::run(&cli.config, &decoder)
}

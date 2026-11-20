# x86-extract

Read a linked x86-64 ELF, decode designated code sections with Intel XED, and
write Lean section bytes, symbol addresses and stack estimates.

## Build

Requires Rust 1.89+, Python 3 and a C compiler. Build the decoder once from the
repository's XED submodule, then build or install the Rust CLI:

```sh
git submodule update --init vendor/xed vendor/mbuild
make -C extraction
cargo install --path extraction --locked
```

Extraction itself does not build anything, invoke Lean, inspect Git, or hash
sources. The installed CLI defaults to this checkout's decoder; use
`--decoder /path/to/decode-instructions` to select another build. Run
`make -C extraction clean all` after changing XED or its build settings.

`src/elf/` reads the ELF: `mod.rs` holds the checks every supported ELF type
shares, and each type has its own module (`position_dependent.rs` for `ET_EXEC`,
`static_pie.rs` for static PIEs) for its checks and for where it stores
addresses. Add a new kind of executable as a new module and `ExecutableKind` variant, and match
every variant explicitly.

Large Lean output blocks live in `templates/`. Rust embeds them with
`include_str!`, so extraction does not read templates at runtime.

## Usage

Save an `extraction.toml` in the consuming project:

```toml
elf = "program.elf"
output = "Keccak/Spec/Extracted"
namespace = "Keccak.Spec.Extracted"
code_sections = [".text"]
data_sections = [".rodata"]

[entries]
keccak256 = "keccak256"
```

```sh
x86-extract extraction.toml
```

Paths are relative to the configuration file; the output directory must not
already exist, and must end with the namespace's components (`Keccak/Spec/Extracted`
for `Keccak.Spec.Extracted`), because the generated modules import each other by
the namespace. Entry keys name generated address definitions (`keccak256Address`);
values identify ELF symbols. Use `data_sections = []` for code-only programs.

Set `rust_panics = true` before `[entries]` to discover Rust panic and slice-index
failure functions from ELF symbols. This emits `panicAddresses` and checks their
instruction boundaries.

Input must be a linked, static x86-64 executable ELF: a position-dependent
executable (`ET_EXEC`), or a static PIE (`ET_DYN` without `PT_INTERP`, with one
`PT_DYNAMIC` where `_DYNAMIC` and any `.dynamic` section place the table) whose
relocations are all `R_X86_64_RELATIVE` and write only writable load segments.
The relocations checked are those startup applies: the RELA table that the
dynamic table names, both read from the bytes the load segments map, and the
dynamic table only up to `DT_NULL`. A static PIE's addresses are link-time;
Linux adds a load bias. Load segments must occupy disjoint 4 KiB pages. Select
every nonempty allocated read-only section; selected sections must be read-only
and file-backed, and code sections must contain only instructions. Writable and
TLS sections are not part of the images and are not selected.

Startup must not change the read-only image, and its relocations must be ones the
tool reads. A position-dependent executable may have no allocated relocation
sections and an empty `__rela_iplt_start`..`__rela_iplt_end` range; a static PIE's
`PT_DYNAMIC` may list no PLT relocations. musl's static executables and static PIEs
meet this. glibc's do not: they apply `R_X86_64_IRELATIVE` relocations for ifuncs,
whose values a resolver computes at startup, so they are not supported.

## Output

| Files | Contents |
|---|---|
| `Sections.lean`, `text.bin`, `rodata.bin` | Section addresses and bytes |
| `Symbols.lean` | Entry addresses, stack estimates, optional panic addresses |
| `Image.lean` | The selected sections (`programSections`) and the program image |
| `File.lean`, `file.bin` | The whole ELF file and views of it (`include_file = true`) |

The files contain definitions only. Binary filenames follow the selected sections.

Section bytes are `Prelude.Bytes.Chunked` (`textBytes`): one natural-number
literal per chunk of 8 KiB (larger above 8 MiB, so that there are at most 1024
chunks), so a byte lookup costs the kernel one chunk lookup and one shift. Evaluate
byte facts with `decide +kernel`: elaborator `decide` exceeds Lean's recursion
depth on a large section. `textByteArray` is the same bytes as a `ByteArray`. `programSections :
Prelude.ImageSections` lists the selected sections, code sections first; state
byte facts through `programSections.fetchByte`, whose kernel cost does not grow
with the address. `programImage` is `programSections.toCodeMap`, the `CodeMap`
the user-process model installs, where `X86.UserProcess.fetchByte` finds the same
bytes; evaluating it lists every byte. For a static PIE,
`programSections.addBias bias` moves the sections by a load bias.

Set `include_file = true` to embed the whole ELF instead, as `fileBytes`
(`file.bin`). There are then no per-section `.bin` files: each section's bytes are
a slice of the file, `textBytes := fileBytes.extract start stop` at its file
offsets, which shares the file's chunks, so lookups cost the same and the
sections' bytes are the file's by construction. `File.lean` holds definitions that
the `Elf` library computes from `fileBytes`:

| Definition | Contents |
|---|---|
| `segments` | ELF header and program headers |
| `relativeRelocations` | Offset and addend of each `DT_RELA` relocation, all `R_X86_64_RELATIVE` (static PIEs) |
| `sections`, `programFileSlices`, `programFileFetchByte` | Section headers; the selected sections as slices of the file; a byte of them, which agrees with `programSections.fetchByte` |
| `symbols`, `symbolNamed`, `<alias>Symbol` | The symbol table; a symbol by name; each configured entry |

Each is an `Except Elf.Error`: the value, or what the reader cannot read. They
describe the file at link-time addresses, not where Linux maps it at a load
bias. Name symbols as `symbolNamed (utf8_bytes "name")`.
Each view has the name of the `Elf` function it applies to `fileBytes`, so with
both the generated namespace and `Elf` open, qualify one of them.
`decide +kernel` evaluates a query on a 200 KB program in under a second.

Each entry gets `entryStackBytes : Option Nat`: an estimated stack budget below
entry RSP, or `none` if unresolved. The consuming proof must verify the budget.
Stack analysis treats recognized Rust panic calls as non-returning, regardless
of `rust_panics`.

Register the `.bin` files as Lake `input_file` dependencies in the library's
`needs` array.

## Guarantees

If extraction succeeds, the generated modules build with Lake's default options,
contain definitions only, and state the following.

**Guaranteed: a proof may rely on these.**

- For each selected section, `<sec>Bytes` holds exactly the bytes the process has at
  `<sec>Address`, plus the load bias for a static PIE (`programSections.addBias bias`).
  This holds from the end of `execve` on, including after the program's own startup
  code: selected sections lie in non-writable load segments, so startup code cannot
  write them, and text relocations, which would make them writable, are rejected.
- `programSections` and `programImage` hold those bytes:
  `programSections.fetchByte` and `X86.UserProcess.fetchByte programImage` agree.
- `<alias>Address` is the address of the unique defined symbol the entry names, and
  an instruction starts there in XED's linear decoding of its code section.
- `positionIndependent` is `true` exactly for a static PIE.
- With `include_file = true`, `fileBytes` is the ELF file, each section's bytes are
  its slice at the section's file offsets, and `File.lean`'s views are what the `Elf`
  library computes from `fileBytes`.

These assume Linux's ELF loader (`load_elf_binary`) and that nothing changes the
permissions of, or maps over, the selected ranges before the point a statement
describes.

**Heuristic: a proof must check these.**

- `<alias>StackBytes`, recognized from compiler patterns. Calls through memory may
  target any function pointer in read-only data or any relocated slot; the
  relocation values the tool reads feed only this estimate.
- `panicAddresses`: functions named like Rust's panic and slice-index failures.

**Not described:** writable and TLS sections, unselected memory, and the process
after code changes page permissions. glibc's static executables and static PIEs are
not supported: their startup applies ifunc relocations. A section may be at most
256 MiB, the largest the generated Lean is known to build. With `include_file = true`,
the whole ELF file must also fit within 256 MiB, including its unselected sections.

## Tests

ELF fixtures require GNU `as` and `ld`; naming tests also use `objcopy`. The integration
test additionally needs the decoder above and `lake build` in the repository root. Lean
is used by this test, not by the extractor.

```sh
cargo test --manifest-path extraction/Cargo.toml --locked
cargo test --manifest-path extraction/Cargo.toml --locked --test extraction -- --ignored
cargo clippy --manifest-path extraction/Cargo.toml --locked --all-targets -- -D warnings
```

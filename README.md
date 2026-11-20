# lean-x86

Lean 4 semantics for x86-64-v1.

## Layout

```text
X86.lean                Umbrella import for the X86 library.
X86/                    Executable semantics and machine integration.
├── State.lean          Machine state and monadic accessors.
├── Config.lean         Settings, checked reads, validation and pure defaults.
├── Cpuid.lean          CPUID feature encodings and queries.
├── Instructions/       Instruction pages, one per Intel XML page.
├── Helpers/            Helpers from Intel XML, local ISA source and the
│                       ISA-tools standard library, plus the decoder maps.
├── Syntax/             Typed decoded instructions: operand types and XED-derived forms.
├── Decode/             Static decoder: prefix parsing and form selection.
├── Machine/            Concrete machine: memory, state, bindings for bodyless Intel
│                       helpers, CPUID queries and the machine step.
├── UserProcess/        Initial states (CPL3 or CPL0), code image, state view and user runner.
├── Runtime/            ISA-language operations used by translated definitions.
└── BitWidth.lean       Positive-width fact used by memory helpers.
Prelude.lean            Umbrella import for the Prelude library.
Prelude/                Common objects for defining statements about x86 programs.
Elf.lean, Elf/          ELF64 reader for statements about ELF files; core Lean only.
extraction/             x86-extract: writes Lean section bytes and symbols from a linked ELF.
vendor/                 Intel XED and mbuild submodules, used by extraction.
tools/                  Trust audit and the authored-proof check used by extraction tests.
.github/workflows/      CI workflows.
```

The `x86` Lake package provides three libraries. `X86` defines the instruction semantics and a
machine that runs them, `Prelude` defines common objects for stating properties of x86 programs,
and `Elf` reads ELF files. The package depends only on Lean's core and standard libraries.

## Semantics

The `X86` library defines what each instruction does. Most definitions are translated from
Intel's executable specification, and locally written specifications fill its gaps.

### Source provenance

The translated definitions come from one commit of Intel's executable specification,
[intel/SDM](https://github.com/intel/SDM), which has no tags or releases. This release uses commit
[`35eface1b7ee003a1cda95005ec5fd83de658a64`](https://github.com/intel/SDM/commit/35eface1b7ee003a1cda95005ec5fd83de658a64)
(`ia-spec` release 1.92.4, SDM 92).

### Custom specifications and fixes

Locally written ISA specifications supply what Intel's executable specification lacks: missing
register and memory declarations, capability queries derived from CPUID, instruction definitions
based on the manual, and missing floating-point helpers. Examples include NOP/PAUSE, CMPS, POPF,
scalar port I/O, SYSRET and LTR. These modules sit beside the translated Intel modules; the first
line of each names its local source, and its comments explain its origin and limits. Some
translated Intel definitions also carry a reviewed correction based on the manual, and their first
line says so.

## Machine and execution

`X86/Machine/` connects the definitions to a concrete machine and runs one instruction step
(`Step.lean`). `X86/UserProcess/` builds initial states and runs a user-mode program on that
machine. The machine does not depend on the user process.

| Module | Role |
| --- | --- |
| [`Machine/State.lean`](X86/Machine/State.lean), [`Machine/Ram.lean`](X86/Machine/Ram.lean) | The executable state `X86.Machine.RamState`, which is `X86.State Ram`; `Ram` stores physical bytes. |
| [`Machine/Cpuid.lean`](X86/Machine/Cpuid.lean), [`Machine/Processor.lean`](X86/Machine/Processor.lean) | The caller-supplied CPUID query, which does not query the host CPU, and the processor settings derived from it. |
| [`Machine/MemoryType.lean`](X86/Machine/MemoryType.lean) | Constant MTRRCAP capabilities and the protected SMRR read response. |
| [`Machine/Bindings.lean`](X86/Machine/Bindings.lean), [`Machine/Bindings/`](X86/Machine/Bindings) | `X86.Machine.Bindings`, what the caller selects for each run, with one implementation file per area. |
| [`UserProcess/Profile.lean`](X86/UserProcess/Profile.lean), [`UserProcess/CodeImage.lean`](X86/UserProcess/CodeImage.lean) | The initial machine, segments and page tables, and code images installed in memory. |
| [`UserProcess/StateView.lean`](X86/UserProcess/StateView.lean) | The smaller view used to initialize a process and inspect results. |
| [`UserProcess/Runner.lean`](X86/UserProcess/Runner.lean), [`UserProcess/RunResult.lean`](X86/UserProcess/RunResult.lean) | Repeat machine steps until a function return, an OS entry, another terminal outcome or the end of the step budget. |

[`X86.Machine.Bindings`](X86/Machine/Bindings.lean) holds what the caller selects for each run: the
processor, the memory-type configuration, the MSR, port, cache and timestamp behavior, and the
implementation choices below. Anything the caller does not supply is rejected by default, and the
machine does not emulate a complete PC.

Some bindings are part of the model rather than parameters of it, because no `Bindings` field
selects them. They:

- supply VMCS controls that disable VMX for address translation, and reject every other VMCS
  input, EPT access and VM exit;
- record fence events without enforcing memory ordering;
- discard Intel's trace hooks and reject its fault-injection hook;
- reject CET shadow-stack accesses and unsupported reset, SMM-entry, task-switch and FRED
  operations;
- continue past Intel's locking markers, since the machine has one core.

### Implementation choices

Where Intel's specification lets processors differ, lean-x86 allows the caller to supply behavior
through `X86.Machine.Bindings`: numerical approximations, FPREM reduction width, FXSAVE image
contents, CMPS operand access, IRET access, REP string grouping, and the memory types used when
caching is disabled. The arithmetic, register updates, checks and fault delivery stay in the ISA
sources. A theorem that holds for every choice of bindings therefore does not depend on any one
processor's choices.

## Prelude

`Prelude` provides common objects for stating properties of x86 programs, including the
predicates the next section describes. Import `Prelude` to use it; its definitions are in the
`Prelude`, `Prelude.Stack` and `Prelude.Bytes` namespaces.

- [`Memory/`](Prelude/Memory): regions, stack conditions, identity mapping and memory write frames.
- [`Bindings/`](Prelude/Bindings): contracts for the binding groups the caller selects, and for
  memory access.
- [`Execution/`](Prelude/Execution): binding and CPU assumptions such as
  `MachineRamUnitStrideDecodable`, return conditions, execution predicates such as
  `UniqueExecution`, and a callee's return under the System V calling convention
  (`SysVCalleeReturn`, in the namespace `Prelude.Execution.CallingConvention`).
- [`Invariant.lean`](Prelude/Invariant.lean): invariant machine-state conditions for running a
  program, combined in `SupportedIntegerMachineState`: CPU configuration, identity-mapped memory and
  readiness to execute.
- [`Bytes/`](Prelude/Bytes) (namespace `Prelude.Bytes`):
  - [`Chunked.lean`](Prelude/Bytes/Chunked.lean): `Chunked` stores bytes as natural-number chunks,
    so the kernel reads each fixed-width field with one chunk lookup and one shift. It is an
    `Elf.ByteSource`.
  - [`Include.lean`](Prelude/Bytes/Include.lean): embeds a binary file with `include_bytes "path"`,
    or as `Chunked` with `include_chunked_bytes "path"`, relative to the Lean source. Declare each
    binary as a Lake build dependency.
  - [`Utf8.lean`](Prelude/Bytes/Utf8.lean): `utf8_bytes "main"` gives the bytes of a UTF-8 string.
    It names a section or symbol for the `Elf` reader, and the kernel compares the bytes without
    decoding a string.
- [`ImageSections.lean`](Prelude/ImageSections.lean): program images as sections (`ImageSections`),
  with `fetchByte` lookups, the `CodeMap` they form, and `addBias` for a load bias.

## Execution assumptions

The model is one x86-64-v1 processor running in 64-bit mode. What a statement about a program
on it means depends on two things: what the model covers and what the statement itself must
supply.

**What the model covers**

- **Instructions:** the definitions and decoder maps give modeled paths for x86-64-v1 instruction
  forms. A modeled path does not mean that every processor reports the features the path needs.
- **Memory access:** code is fetched from RAM with executable-page checks. Data and stack accesses
  use Intel's segmentation, paging and permission checks over persistent physical RAM.
- **Initial state:** [`X86.UserProcess.Profile`](X86/UserProcess/Profile.lean) builds one.
  `Profile.initializeMapped` identity-maps regions the caller chooses, using 1-GiB pages, starts at
  CPL3 with flat user segments or at CPL0 with flat kernel segments, and initializes memory as
  write-back. The program must not write the page-table bytes it reserves. This is a starting
  state for proofs, not a processor reset or an OS loader.
- **Runs:** [`Runner.run`](X86/UserProcess/Runner.lean) steps the machine until a function return,
  an OS entry, another terminal outcome or the end of its step budget. `outOfFuel` means the budget
  ran out; a single step can still run indefinitely, so the budget is not a timeout. Source
  exceptions and runtime faults stay distinct.

**What a statement must supply**

- **A processor:** Intel's specification depends on processor details it leaves open, such as what
  CPUID reports, Core or Atom, address widths and cache geometry, so lean-x86 takes them as a
  parameter instead of fixing one chip. A statement can fix one processor or quantify over all of
  them. [`Machine.Processor`](X86/Machine/Processor.lean), held in `Machine.Bindings.processor`,
  holds the caller's CPUID query, the Core/Atom selection and configuration values.
  `Processor.initialize` validates widths and cache geometry and accepts physical-address widths
  from 32 through 52 bits. Nothing shows that the CPUID query, Core/Atom selection, MTRR
  capabilities, SMRR response or cache-control binding match a real processor, so a claim about
  hardware must justify them. The caller must also keep capabilities and geometry constant across
  later control changes.
- **Bindings:** any choice of [`X86.Machine.Bindings`](X86/Machine/Bindings.lean). Statements
  usually restrict them only through
  [`Prelude.MachineRamUnitStrideDecodable`](Prelude/Execution/Bindings.lean), a single hypothesis
  about one state that requires:
  - no matching SMRR range;
  - write-back memory below the 4-GiB user address limit, at PAT selector zero;
  - positive string counts selecting stride one;
  - a reported leading-zero-count (LZCNT) feature, which the decoder queries.

  These conditions must hold wherever a proof uses them. Writable memory MSRs do not preserve them
  automatically. [`Prelude.Bindings.Satisfies`](Prelude/Bindings.lean) states the SDM's contracts
  for statements that need them.
- **Machine-state conditions:** [`Prelude.SupportedIntegerMachineState`](Prelude/Invariant.lean)
  combines the integer-control, SSE, identity-mapping and execution-readiness conditions for one
  processor and state. It is not a full conformance check: `SupportedSSE`, for example, requires
  SSE but not SSE2.
- **Unspecified values:** an oracle chosen by the caller supplies every bit the specification leaves
  unspecified. [`Prelude.UniqueExecution`](Prelude/Execution/Termination.lean) fixes the initial
  state, the bindings and the oracle, and says that every successful run from that state, whatever
  its step budget, returns the same final state. To cover every outcome the model allows, a
  statement must quantify over every oracle and every allowed choice of bindings.

## Elf

`Elf` reads an ELF64 file through any `Elf.ByteSource`, such as a `ByteArray` or the
`Prelude.Bytes.Chunked` form that statements embed. It reads what the file declares: the header
and program headers, the section headers and names, symbols, `.rela.dyn`, and the dynamic entries
with the `DT_RELA` table they list. Each query returns `Except Elf.Error`. `Elf` describes only
the file format, not what Linux accepts and maps, and it imports only Lean's core library.

## Build and check

```sh
lake build
```

`lake build` compiles the `X86`, `Prelude` and `Elf` libraries and runs their elaboration-time
checks. CI builds with `--iofail`, which fails on any warning or info message, and then audits
what the libraries trust:

```sh
lake build --iofail
lake env lean --run tools/check_trust.lean --replay --roots X86 Prelude Elf
python3 tools/test_check_trust.py
```

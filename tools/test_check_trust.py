#!/usr/bin/env python3
"""Check that check_trust.lean reports every declaration that check_trust_planted.lean plants.

Usage, after `lake build`: python3 tools/test_check_trust.py
The test builds the same planted file in X86 and Elf in temporary directories,
links each library's built modules and sources, runs the check with --replay on it and
requires exactly the expected reports, so that a check that reports nothing, for example after a
toolchain update, is not taken for a pass.
"""
from pathlib import Path
import re
import subprocess
import sys
import tempfile

PROJECT = Path(__file__).resolve().parents[1]
TOOLS = PROJECT / "tools"


def expected(library):
    P = re.escape(library) + r"\.TrustPlanted\."

    # One pattern for each report. Every pattern must match a line, and every line a pattern.
    return [
        rf"forbidden axiom {P}plantedAxiom: ({P}usesAxiomIndirectly → )?{P}plantedAxiom",
        rf"forbidden axiom sorryAx: {P}usesSorry → sorryAx",
        rf"forbidden axiom {P}usesNativeDecide\._native\.native_decide\.ax_\S+: {P}usesNativeDecide → .*",
        rf"forbidden axiom {P}usesBvDecide\._native\.bv_decide\.ax_\S+: {P}usesBvDecide → .*",
        rf"@\[csimp\] {P}slow_eq_fast is not a manual override in csimpAllowed",
        rf"@\[csimp\] {P}slow_eq_fast_scoped is not a manual override in csimpAllowed",
        rf"\S+/{re.escape(library)}/TrustPlanted\.lean applies a local @\[csimp\], which the environment does not record",
        rf"compiled code of {P}unsafeImpl is not checked against its definition: unsafe",
        rf"compiled code of {P}implementedBy is not checked against its definition: implemented by {P}unsafeImpl",
        rf"compiled code of {P}externFn is not checked against its definition: extern",
        rf"compiled code of {P}opaqueFn is not checked against its definition: opaque or partial",
        rf"compiled code of {P}partialFn is not checked against its definition: opaque or partial",
        rf"compiled code of {P}instBEqTree\.beq is not checked against its definition: opaque or partial",
        rf"kernel replay failed: while replaying declaration '{P}forged':",
    ]


def check_library(library):
    patterns = expected(library)
    with tempfile.TemporaryDirectory() as directory:
        objects, sources = Path(directory) / "objects", Path(directory) / "sources"
        for root, source_library in ((objects, PROJECT / ".lake/build/lib/lean" / library),
                                     (sources, PROJECT / library)):
            (root / library).mkdir(parents=True)
            if source_library.is_dir():
                for entry in source_library.iterdir():
                    (root / library / entry.name).symlink_to(entry)
        source = sources / library / "TrustPlanted.lean"
        source.write_text((TOOLS / "check_trust_planted.lean").read_text()
                          .replace("X86.TrustPlanted", f"{library}.TrustPlanted"))
        subprocess.run(["lake", "env", "lean", "-R", sources, "-o",
                        objects / library / "TrustPlanted.olean", source],
                       cwd=PROJECT, check=True, stdout=subprocess.DEVNULL)
        # The temporary directories provide the selected library modules.
        result = subprocess.run(
            ["lake", "env", "sh", "-c",
             'LEAN_PATH="$0:$LEAN_PATH" LEAN_SRC_PATH="$1:$LEAN_SRC_PATH" '
             'exec lean --run "$2" --replay "$3"',
             objects, sources, TOOLS / "check_trust.lean", f"{library}.TrustPlanted"],
            cwd=PROJECT, capture_output=True, text=True)
    # The kernel's message continues over several lines; reports start at the first column.
    lines = [line for line in result.stderr.splitlines() if line and not line[0].isspace()
             and not line.startswith(("(kernel)", "but it"))]
    failures = []
    if result.returncode != 1:
        failures.append(f"exit code {result.returncode}, expected 1")
    for pattern in patterns:
        if not any(re.fullmatch(pattern, line) for line in lines):
            failures.append(f"missing report: {pattern}")
    for line in lines:
        if not any(re.fullmatch(pattern, line) for pattern in patterns):
            failures.append(f"unexpected report: {line}")
    if failures:
        print("\n".join(failures), file=sys.stderr)
        print(f"check output:\n{result.stdout}{result.stderr}", file=sys.stderr)
        return 1
    print(f"PASS check_trust reports all {len(patterns)} planted declarations in {library}")
    return 0


def main():
    return max(check_library(library) for library in ("X86", "Elf"))


if __name__ == "__main__":
    sys.exit(main())

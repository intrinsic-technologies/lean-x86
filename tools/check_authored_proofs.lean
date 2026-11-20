import AuthoredProofs

/-!
Fail if modules declare proofs that Lean did not generate. From the repository root, after
`lake build AuthoredProofs`:

```sh
lake env lean --run tools/check_authored_proofs.lean MODULE...
```

checks the modules `MODULE...` and every module they prefix.
-/

def main (arguments : List String) : IO UInt32 := do
  if arguments.isEmpty then
    IO.eprintln "usage: lean --run tools/check_authored_proofs.lean MODULE..."
    return 2
  -- Module components are file names, which need not be identifiers.
  let roots := arguments.map fun module ↦ (module.splitOn ".").foldl Lean.Name.str .anonymous
  -- The running `lean` binary's own library directory, plus `LEAN_PATH`
  Lean.initSearchPath (← Lean.getBuildDir)
  let env ← Lean.importModules (roots.map ({ module := · })).toArray {} (loadExts := false)
  let (found, _) ← ((AuthoredProofs.find roots).run' {}).toIO
    { fileName := "<check>", fileMap := default } { env }
  for name in found.qsort (·.toString < ·.toString) do
    IO.eprintln name
  if found.isEmpty then
    IO.println s!"No proofs in {", ".intercalate arguments}"
    return 0
  IO.eprintln s!"{found.size} proof(s); move them to a proof library"
  return 1

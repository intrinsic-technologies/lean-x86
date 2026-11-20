/-
Check what the executable libraries trust.

Usage, after `lake build`:
  lake env lean --run tools/check_trust.lean [--replay] [--roots] MODULE...

The check imports MODULE... and checks every constant of the modules they import outside Lean's
toolchain, which is trusted. With `--roots`, the axiom walk starts from every constant in MODULE...
and the executable libraries, and follows all dependencies, including third-party libraries.
The csimp and source checks cover those same modules. CI uses `--roots X86 Prelude Elf`. Kernel replay still covers
all imported non-toolchain constants. It reads the built environment, so it also sees declarations
that macros, generated code and tactics produce.

- Axioms. A constant may depend on no axiom beyond Lean's standard three: `propext`,
  `Quot.sound` and `Classical.choice`. This rejects `sorry` (`sorryAx`), each use of
  `native_decide` and of a `bv_decide` that calls the SAT solver (an auxiliary axiom
  `<declaration>._native.….ax_…`), `Lean.ofReduceBool`, `Lean.trustCompiler` and every `axiom`
  declaration. For each it prints the chain of references from a checked constant to the axiom.
- `@[csimp]`. A theorem `@f = @g` with this attribute makes compiled code call `g` for `f`. The
  kernel checks that `f` and `g` are equal, but not that compiled `g` runs as `g` does, nor its
  time, memory or panics. Only the manual overrides in `csimpAllowed` may do so, and each must
  exist. A `local` attribute leaves no entry in the environment, so the check rejects the words
  `local csimp` in the sources of the libraries, comments included.
- Compiled code of the libraries. Their compiled code runs the semantics that proofs are about,
  so in modules of `X86`, `Prelude` and `Elf` it
  rejects code that the kernel does not check against the definition: `@[implemented_by]`,
  `@[extern]`, `unsafe` definitions, and `partial` definitions and `opaque` constants, which compile
  but which the kernel cannot unfold. That includes the `partial` instances that `deriving` makes for nested
  inductive types. Tests may use them.
- With `--replay`, the kernel checks every constant again, replayed into an environment that
  holds only the toolchain, as `leanchecker --fresh` does. This finds declarations that reached
  the environment without the kernel's check: `debug.skipKernelTC`, a metaprogram that adds
  declarations directly, an edited `.olean`. It reads only the modules that MODULE... import, not
  every `.olean` in the build directory: unlike `leanchecker`'s module prefixes, it does not read
  a stale `.olean` of a deleted module. Like `leanchecker`, it skips `unsafe` and `partial`
  constants, which proofs cannot use and which the libraries do not have.

It walks the references of every checked constant once, sharing visited constants, instead of
calling `collectAxioms` per declaration.
-/
import Lean

open Lean

def allowedAxioms : NameSet := .ofList [``propext, ``Quot.sound, ``Classical.choice]

/-- Manual overrides: the `@[csimp]` theorems that may replace compiled code. -/
def csimpAllowed : NameSet := .ofList [
  -- X86/Runtime/BitsImpl.lean: the semantics slice bit vectors for each instruction, and Lean's
  -- `2 ^ n`, `<<<` and `BitVec` operations call GMP for each slice.
  `Nat.pow_eq_powImpl, `Nat.instNatPowNat_eq_instNatPowNatImpl,
  `Nat.shiftLeft_eq_shiftLeftImpl, `Nat.instShiftLeft_eq_instShiftLeftImpl,
  `BitVec.ofNat_eq_ofNatImpl, `BitVec.instOfNat_eq_instOfNatImpl,
  `BitVec.allOnes_eq_allOnesImpl, `BitVec.extractLsb'_eq_extractLsb'Impl,
  `BitVec.add_eq_addImpl, `BitVec.sub_eq_subImpl, `BitVec.not_eq_notImpl,
  `BitVec.ofInt_eq_ofIntImpl, `BitVec.toInt_eq_toIntImpl, `BitVec.instAdd_eq_instAddImpl,
  `BitVec.instSub_eq_instSubImpl, `BitVec.instComplement_eq_instComplementImpl]

/-- The libraries whose compiled code must be the code of their definitions. -/
def libraries : List Name := [`X86, `Prelude, `Elf]

/-- Constants of the libraries whose compiled code may differ, each because the semantics need
it. -/
def compiledAllowed : NameSet := {}

/-- Namespaces of declarations that checks plant to show that they report them. The check does not
start from these declarations, but reports what they lead to from other declarations. None
remain in this repository. -/
def planted : List Name := []

/-- The constants that `c` refers to, as `CollectAxioms` follows them. -/
def references (env : Environment) (c : Name) : Array Name :=
  let used (e : Expr) := e.getUsedConstants
  match env.find? c with
  | some (.axiomInfo v) | some (.ctorInfo v) | some (.recInfo v) => used v.type
  | some (.defnInfo v) => used v.type ++ used v.value
  | some (.thmInfo v) => used v.type ++ used v.value
  | some (.opaqueInfo v) => used v.type ++ used v.value
  | some (.inductInfo v) => used v.type ++ v.ctors.toArray
  | some (.quotInfo _) | none => #[]

/-- The chain of references from a checked constant to `c`. Constants refer to each other in
cycles, so the chain stops at a repeated constant. -/
partial def chain (parent : Std.HashMap Name Name) (c : Name) (acc : List Name := []) : List Name :=
  match parent[c]? with
  | some p => if acc.contains p || p == c then c :: acc else chain parent p (c :: acc)
  | none => c :: acc

/-- The axioms that `roots` depend on, each with its chain of references. -/
def axiomsOf (env : Environment) (roots : Array Name) : Array (Name × List Name) := Id.run do
  let rootSet : NameSet := .ofArray roots
  let mut parent : Std.HashMap Name Name := {}
  let mut visited := rootSet
  let mut stack := roots
  let mut axioms : Array Name := #[]
  while h : stack.size > 0 do
    let c := stack.back
    stack := stack.pop
    if env.find? c matches some (.axiomInfo _) then
      axioms := axioms.push c
    for d in references env c do
      if !visited.contains d then
        visited := visited.insert d
        parent := parent.insert d c
        stack := stack.push d
      -- A checked constant also gets its first referrer, so that an auxiliary axiom of
      -- `native_decide` names the declaration that uses it.
      else if rootSet.contains d && d != c && !parent.contains d then
        parent := parent.insert d c
  return axioms.map fun a => (a, chain parent a)

/-- The `@[csimp]` theorems that `modules` declare, global or scoped. -/
def csimpTheorems (env : Environment) (modules : Array ModuleIdx) : Array Name := Id.run do
  let mut theorems := #[]
  for i in modules do
    for entry in Compiler.CSimp.ext.ext.getModuleEntries env i do
      match entry with
      | .global e | .scoped _ e => theorems := theorems.push e.thmName
  return theorems

/-- Whether `text` applies `csimp` as a `local` attribute: the word `local`, then `csimp`. -/
def localCsimp (text : String) : Bool :=
  (text.splitOn "csimp").dropLast.any fun before =>
    let words := (before.map fun c => if c == '[' || c == ',' then ' ' else c).splitOn " "
      |>.flatMap (·.splitOn "\n") |>.filter (· != "")
    words.getLast? == some "local"

/-- Why compiled code of `c` may differ from the definition that proofs use, if it may. -/
def compiledOverride (env : Environment) (c : Name) (info : ConstantInfo) : Option String :=
  if let some impl := Compiler.getImplementedBy? env c then some s!"implemented by {impl}"
  else if isExtern env c then some "extern"
  else if info.isUnsafe then some "unsafe"
  -- A `partial` definition is an opaque constant with a `partial` `_unsafe_rec` definition that
  -- compiled code calls. Report the constant.
  else if c matches .str _ "_unsafe_rec" then none
  else if info.isPartial then some "partial"
  else if info matches .opaqueInfo _ then some "opaque or partial"
  else none

def main (args : List String) : IO UInt32 := do
  let (flags, modules) := args.partition (·.startsWith "-")
  let replay := "--replay" ∈ flags
  let rootsOnly := "--roots" ∈ flags
  if modules.isEmpty || flags.any (fun flag => flag != "--replay" && flag != "--roots") then
    IO.eprintln "usage: lake env lean --run tools/check_trust.lean [--replay] [--roots] MODULE..."
    return 2
  let sysroot ← findSysroot
  initSearchPath sysroot
  let toolchain := (sysroot / "lib" / "lean").toString
  let env ← importModules (modules.toArray.map ({ module := ·.toName })) {}
  let mut checked : Array ModuleIdx := #[]
  let mut toolchainImports : Array Import := #[]
  for module in env.header.moduleNames, i in [:env.header.moduleNames.size] do
    if (← findOLean module).toString.startsWith toolchain then
      toolchainImports := toolchainImports.push { module }
    else
      checked := checked.push i
  let named : NameSet := .ofList (modules.map String.toName)
  let audited := checked.filter fun i =>
    !rootsOnly || named.contains env.header.moduleNames[i]! ||
      libraries.any (·.isPrefixOf env.header.moduleNames[i]!)
  let roots := audited.flatMap (env.header.moduleData[·]!.constNames) |>.filter fun c =>
    !planted.any (·.isPrefixOf (privateToUserName? c |>.getD c))
  let mut failed := false

  let axioms := axiomsOf env roots
  let forbidden := axioms.filter (!allowedAxioms.contains ·.1)
  for (a, path) in forbidden do
    IO.eprintln s!"forbidden axiom {a}: {" → ".intercalate (path.map toString)}"
  failed := failed || !forbidden.isEmpty

  let csimp := csimpTheorems env audited
  for thm in csimp.filter (!csimpAllowed.contains ·) do
    IO.eprintln s!"@[csimp] {thm} is not a manual override in csimpAllowed"
    failed := true
  for thm in csimpAllowed.toList.filter (!csimp.contains ·) do
    IO.eprintln s!"csimpAllowed lists {thm}, which is not a @[csimp] theorem of the checked modules"
    failed := true

  let mut compiledChecked := 0
  for i in checked do
    unless libraries.any (·.isPrefixOf env.header.moduleNames[i]!) do continue
    for c in env.header.moduleData[i]!.constNames do
      compiledChecked := compiledChecked + 1
      if compiledAllowed.contains c then continue
      let some info := env.find? c | continue
      if let some reason := compiledOverride env c info then
        IO.eprintln s!"compiled code of {c} is not checked against its definition: {reason}"
        failed := true
  let sources : SearchPath := System.SearchPath.parse ((← IO.getEnv "LEAN_SRC_PATH").getD "")
  for i in audited do
    let module := env.header.moduleNames[i]!
    match ← sources.findModuleWithExt "lean" module with
    | none =>
      IO.eprintln s!"no source of {module} in LEAN_SRC_PATH"
      failed := true
    | some file =>
      if localCsimp (← IO.FS.readFile file) then
        IO.eprintln s!"{file} applies a local @[csimp], which the environment does not record"
        failed := true
  for c in compiledAllowed.toList.filter (env.find? · |>.isNone) do
    IO.eprintln s!"compiledAllowed lists {c}, which the checked modules do not declare"
    failed := true

  if replay then
    -- Every checked constant, replayed onto only the toolchain modules.
    let base ← importModules toolchainImports {}
    let mut constants : Std.HashMap Name ConstantInfo := {}
    for i in checked do
      let data := env.header.moduleData[i]!
      for c in data.constNames, info in data.constants do
        constants := constants.insert c info
    try
      discard <| base.toKernelEnv.replay constants
    catch e =>
      IO.eprintln s!"kernel replay failed: {e}"
      failed := true

  if failed then return 1
  let names := (axioms.map (·.1)).qsort (·.toString < ·.toString)
  IO.println s!"{roots.size} constants of {audited.size} audited modules: axioms {names}, \
    {csimp.size} manual @[csimp] overrides, compiled code of {compiledChecked} library constants\
    {if replay then s!", all {checked.size} imported modules replayed in the kernel" else ""}"
  return 0

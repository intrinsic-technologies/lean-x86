import Lean

/-!
# Authored proofs

Which constants of a library are proofs that Lean did not generate: theorems, axioms, and
definitions or opaque constants whose type is a proposition. Lean generates equation lemmas, the
lemmas of constructors, the principles of inductive types and the projections of proposition
fields, and these are not reported.

`check_authored_proofs.lean` runs it on modules named on the command line; the extraction tests
use it on the modules they generate. It imports only `Lean`, so it builds in about a second.
-/

namespace AuthoredProofs

open Lean Meta

/-- Whether `s` is `stem` followed by a number, as Lean names its numbered auxiliaries
(`match_1`, `brecOn_2`). -/
def isNumbered (stem s : String) : Bool :=
  s.startsWith stem && s.length > stem.length && (s.drop stem.length).all Char.isDigit

/-- Whether Lean generated `name` as an auxiliary of another declaration. These are Lean's rules
(`Lean.isAutoDeclOrPrivate_Internal`), applied to the name without its private prefix, so that a
`private theorem` is not taken for an internal name, and with numbered auxiliaries (`match_1`,
`proof_1`) recognized by their number. -/
def isAuxiliary (env : Environment) (name : Name) : Bool :=
  let user := (privateToUserName? name).getD name
  user.hasMacroScopes || user.isInternal || isReservedName env name ||
  match name with
  | .str owner s =>
    (env.contains owner && isAuxiliary env owner) ||
    ["proof_", "match_", "unsafe_", "grind_"].any (isNumbered · s) ||
    (env.isConstructor owner &&
      ["injEq", "inj", "sizeOf_spec", "elim", "noConfusion"].contains s) ||
    (env.find? owner matches some (.inductInfo _) &&
      (isNumbered "brecOn_" s || isNumbered "below_" s ||
        ["casesOn", "recOn", "brecOn", "binductionOn", "below", "ndrec", "ndrecOn",
          "noConfusionType", "noConfusion", "ofNat", "toCtorIdx", "ctorIdx", "ofNat_ctorIdx",
          "ctorElim", "ctorElimType"].contains s ||
        (isSubobjectField? env owner (.mkSimple s)).isSome)) ||
    (env.find? (.str owner "_functor") matches some (.inductInfo _) &&
      (["functor_unfold", "casesOn", "mutual"].contains s ||
        env.isConstructor (.str (.str owner "_functor") s)))
  | _ => false

/-- Whether Lean generated `name`: an auxiliary of another declaration, or the projection of a
structure field (a field that is a proposition makes a theorem, such as `ExecutionReady.movss`).
A theorem named under a projection (`NonDet.Admits.foo`) is not generated. -/
def isGenerated (env : Environment) (name : Name) : Bool :=
  env.isProjectionFn name || isAuxiliary env name

/--
Whether Lean generated the declaration `name` of kind `info`. Lean generates no axioms. A theorem
whose name has macro scopes is judged without them, so that one a macro declares is not taken for
Lean's own.
-/
def isGeneratedProof (env : Environment) (name : Name) (info : ConstantInfo) : Bool :=
  match info with
  | .axiomInfo _ => false
  | .thmInfo _ => isGenerated env name.eraseMacroScopes
  | _ => isGenerated env name

/-- The proofs, besides `allowed`, that modules under `roots` declare, and those the current file
declares whose names without a private prefix satisfy `inCurrentFile`. -/
def find (roots : List Name) (allowed : List Name := [])
    (inCurrentFile : Name → Bool := fun _ ↦ false) :
    MetaM (Array Name) := do
  let env ← getEnv
  -- Only the constants of the modules in scope, not every imported constant,
  let mut candidates : Array (Name × ConstantInfo) := #[]
  for module in env.header.moduleNames, data in env.header.moduleData do
    if roots.any (·.isPrefixOf module) then
      for name in data.constNames, info in data.constants do
        candidates := candidates.push (name, info)
  -- and those the current file declares
  candidates := env.constants.foldStage2 (fun acc name info ↦
    if inCurrentFile ((privateToUserName? name).getD name) then acc.push (name, info) else acc) candidates
  let authored := candidates.filter fun (name, info) ↦
    !isGeneratedProof env name info && !allowed.contains ((privateToUserName? name).getD name)
  authored.filterMapM fun (name, info) ↦ do
    match info with
    | .thmInfo _ | .axiomInfo _ => return some name
    | .defnInfo _ | .opaqueInfo _ =>
      return if ← isProp info.type then some name else none
    | _ => return none

end AuthoredProofs

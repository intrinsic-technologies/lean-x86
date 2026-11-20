/-
Declarations that `check_trust.lean` must report, one for each of its rules.
`test_check_trust.py` builds this fixture inside selected executable libraries and checks the report.
-/
import Lean
import Std.Tactic.BVDecide
import X86.Runtime.BitsImpl

open Lean Elab Command

namespace X86.TrustPlanted

axiom plantedAxiom : True

theorem usesSorry : 1 = 2 := sorry

theorem usesNativeDecide : 2 + 2 = 4 := by native_decide

theorem usesBvDecide (x y : BitVec 8) : x * y = y * x := by bv_decide

/-- Uses an axiom only through another declaration. -/
theorem usesAxiomIndirectly : True := plantedAxiom

def slow (n : Nat) : Nat := n
def fast (n : Nat) : Nat := n

theorem slow_eq_fast : @slow = @fast := rfl
attribute [csimp] slow_eq_fast

theorem slow_eq_fast_scoped : @slow = @fast := rfl
attribute [scoped csimp] slow_eq_fast_scoped

theorem slow_eq_fast_local : @slow = @fast := rfl
attribute [local csimp] slow_eq_fast_local

unsafe def unsafeImpl (n : Nat) : Nat := n

@[implemented_by unsafeImpl] def implementedBy (n : Nat) : Nat := n

@[extern "planted_extern"] opaque externFn : Nat → Nat

opaque opaqueFn : Nat → Nat

partial def partialFn (n : Nat) : Nat := if n = 0 then 0 else partialFn (n - 1)

/-- `deriving BEq` makes a `partial` instance for a nested inductive type. -/
inductive Tree where
  | node (children : List Tree)
  deriving BEq

-- A proof of `False` that skipped the kernel's check.
set_option debug.skipKernelTC true in
run_cmd liftCoreM do
  addDecl (Declaration.thmDecl
    { name := `X86.TrustPlanted.forged, levelParams := [], type := mkConst ``False,
      value := mkConst ``True.intro })

end X86.TrustPlanted

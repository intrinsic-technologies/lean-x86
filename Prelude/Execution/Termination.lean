import Prelude.Execution.Return
import X86.UserProcess.Runner

namespace Prelude

variable {σ : Type} [X86.Machine.PhysicalMemory σ] [bindings : X86.Machine.Bindings]

open X86 X86.UserProcess

/--
The run returns `final` with minimum successful fuel `fuel`. Every successful run
from `initial` has at least this much fuel and returns the same final state.
-/
def UniqueExecution (initial : X86.State σ) (fuel : Nat) (final : X86.State σ) : Prop :=
  ∃ boundary, nearReturn64Boundary initial = .ok boundary ∧
  Runner.run boundary fuel initial = some (.returned final) ∧
  ∀ (fuel' : Nat) (final' : X86.State σ),
    Runner.run boundary fuel' initial = some (.returned final') →
    fuel ≤ fuel' ∧ final' = final

/--
Every finite-fuel run relative to `boundary` exhausts its budget with final RIP outside
`panicAddresses`.
-/
def Diverges (boundary : ReturnBoundary) (initial : X86.State σ)
    (panicAddresses : List (BitVec 64)) : Prop :=
  ∀ fuel, ∃ after,
    Runner.run boundary fuel initial = some (.outOfFuel after) ∧
    after.RIP ∉ panicAddresses

end Prelude

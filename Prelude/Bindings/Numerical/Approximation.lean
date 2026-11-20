import Prelude.Float.Binary32
import Prelude.Bindings.Contract
import X86.State

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Approximation

open X86 X86.Runtime

/-- Intel SDM 093, RCPSS/RCPPS and RSQRTSS/RSQRTPS: 1.5 * 2^-12. -/
def relativeErrorBound : Rat := mkRat 3 8192

def lowerFactor : Rat := 1 - relativeErrorBound

def upperFactor : Rat := 1 + relativeErrorBound

/-- SDM 093 RCPSS/RSQRTSS do not depend on MXCSR.RC. Only RC changes;
all other state is fixed. -/
def RoundingControlIndependent {σ ε : Type}
    (implementation : Bits 32 → ReaderT (State σ) (Except (Runtime.Error ε)) (Bits 32)) : Prop :=
  ∀ x (before : State σ) (rounding : Bits 2), Prelude.Float.Binary32.isNormal x = true →
    let changed := {before with MXCSR := MXCSR_Type.setRC before.MXCSR rounding}
    match (implementation x).run before, (implementation x).run changed with
    | .ok first, .ok second => first = second
    | _, _ => True

end Prelude.Bindings.Numerical.Approximation

-- Generated from data/definitions.xml.gz: FP::QNaN_Indefinite; do not edit.
-- Source SHA256: 43b6d55a6e4a1750f31514fd47a233af56fa3d44f12d82008cda8adf93900f2e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AQNaN_Indefinite)
import X86.Runtime
import X86.Helpers.FP.QNaN
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.QNaN_Indefinite (E : Int) (N : Int) : Runtime.SpecM Exception (State σ) (Bits N) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  return (← FP.QNaN (payload := (← Std.Bits.Zero (N - E - 2))) (E := E) (N := N) (is_negative := true))

end X86.Helpers

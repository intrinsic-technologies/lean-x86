-- Generated from data/definitions.xml.gz: FP::QNaN; do not edit.
-- Source SHA256: 6ce860636be9d62654aaa98109965b76268ad2db01acf0212d8d02af15e5a4ed
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AQNaN)
import X86.Runtime
import X86.Helpers.FP.Pack
import X86.Helpers.UFloatClass
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.QNaN
    (E : Int) (N : Int) (payload : Bits ((N - E) - (2 : Int))) (is_negative : Bool := false) :
    Runtime.SpecM Exception (State σ) (Bits N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (N == 16 || N == 32 || N == 64)

  let ctx : RoundingContext E N ← IEEE754Context E N
  let is_quiet : Bool := true
  return (← FP.Pack (size := N) (e_size := E) (← IEEE754ContextNan (E := E) (N := N) ctx is_negative is_quiet payload))

end X86.Helpers

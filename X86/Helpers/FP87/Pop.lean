-- Generated from data/definitions.xml.gz: FP87::Pop; do not edit.
-- Source SHA256: 21a7f102f4ffcd0686c469b77493e3ebdac2062f64dcaeb2c7e71a680450661a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3APop)
import X86.Runtime
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Std.Bits.Add_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Pop  : Runtime.SpecM Exception (State σ) Unit := do
  let __check69 : Int := Unsigned (← FP87_Status.TOP)
  Runtime.assert (decide (__check69 * 2 ≤ 14))
  Runtime.assert (decide (0 ≤ __check69))
  FP87_Tag_Word.setSlice (__check69 * (2 : Int)) 2 (3 : Bits 2)
  FP87_Status.setTOP (← Std.Bits.Add_int (n := 3) (← FP87_Status.TOP) 1)

end X86.Helpers

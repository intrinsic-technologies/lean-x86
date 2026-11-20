-- Generated from data/definitions.xml.gz: YMM; do not edit.
-- Source SHA256: c5b4d14c671bcc576ace6e3735dd0ae3cee5af4f376e037e5d79ed5a40f94036
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=YMM)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def YMM (r : Int) : Runtime.SpecM Exception (State σ) (Bits 256) := do
  return (← Runtime.CheckedSlice.read (← (do Runtime.assert (decide (r < 32)); Runtime.assert (decide (0 ≤ r)); pure (← ZMM.get r))) 0 256)

def YMM_write (r : Int) (value : Bits 256) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (decide (r < 32))
  Runtime.assert (decide (0 ≤ r))
  ZMM.set r (← setSliceChecked (← ZMM.get r) 0 256 value)

end X86.Helpers

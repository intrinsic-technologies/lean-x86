-- Generated from data/definitions.xml.gz: XMM; do not edit.
-- Source SHA256: f984fd170f0d9df339e705cc085759bb2f9f96cf6f5a66816b327df8ce0dcb54
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=XMM)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def XMM (r : Int) : Runtime.SpecM Exception (State σ) (Bits 128) := do
  return (← Runtime.CheckedSlice.read (← (do Runtime.assert (decide (r < 32)); Runtime.assert (decide (0 ≤ r)); pure (← ZMM.get r))) 0 128)

def XMM_write (r : Int) (value : Bits 128) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (decide (r < 32))
  Runtime.assert (decide (0 ≤ r))
  ZMM.set r (← setSliceChecked (← ZMM.get r) 0 128 value)

end X86.Helpers

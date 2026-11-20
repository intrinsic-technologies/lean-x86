-- Generated from data/definitions.xml.gz: FP87::Push; do not edit.
-- Source SHA256: bbe04484db64345eb799ae07588872fb79a60bde3d51ca19f7a486b91fae672f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3APush)
import X86.Runtime
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Std.Bits.Subtract_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Push  : Runtime.SpecM Exception (State σ) Unit := do
  FP87_Status.setTOP (← Std.Bits.Subtract_int (n := 3) (← FP87_Status.TOP) 1)

end X86.Helpers

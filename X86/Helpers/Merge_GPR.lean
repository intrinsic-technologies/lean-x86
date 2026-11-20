-- Generated from data/definitions.xml.gz: Merge_GPR; do not edit.
-- Source SHA256: f102683de393a8da99d31810a5e47f45943db6eb83a64c540e969daf76d009bf
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Merge_GPR)
import X86.Runtime
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Merge_GPR {size : Int}
    (value : Bits size) (old_gpr : Bits 64) :
    Except (Runtime.Error Empty) (Bits 64) := do
  Runtime.assert (size == 8 || size == 16 || size == 32 || size == 64)

  if (size == 32) then
    return (← Std.Bits.Zero_Extend (source_size := size) value 64)
  else
    -- Merge value into bottom size bits of old_gpr
    let mut new_gpr : Bits 64 := old_gpr
    Runtime.assert (decide (size ≤ 64))
    new_gpr := (← setSliceChecked new_gpr 0 size value)
    return new_gpr

end X86.Helpers

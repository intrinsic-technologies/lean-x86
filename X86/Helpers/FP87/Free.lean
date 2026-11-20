-- Generated from data/definitions.xml.gz: FP87::Free; do not edit.
-- Source SHA256: 70113398a24a76b89fdc1a122d966ab8466b8f0b1c6c661fee6665a2c4f04bb8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AFree)
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

def FP87.Free (i : Int) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (i in {0..7})

  let index : Bits 3 ← Std.Bits.Add_int (n := 3) (← FP87_Status.TOP) i
  Runtime.assert (decide (Unsigned index * 2 ≤ 14))
  Runtime.assert (decide (0 ≤ Unsigned index))
  FP87_Tag_Word.setSlice ((Unsigned index) * (2 : Int)) 2 (3 : Bits 2)

end X86.Helpers

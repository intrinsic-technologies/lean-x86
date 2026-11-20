-- Generated from data/definitions.xml.gz: Set_Canonical_Wrt_Paging_Mode; do not edit.
-- Source SHA256: 5bd07c3032bba65ac4b3b5ae7d1b30f784e1fb53d762b16a8a9254c52f849fc6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Set_Canonical_Wrt_Paging_Mode)
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Set_Canonical_Wrt_Paging_Mode
    (address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert ((← CR0.PG) == 1 and (← CR4.PAE) == 1 and (← get).IA32_EFER.LME == 1)
  let position : Int ← do
    if (← CR4.LA57) == 1 then
      pure 57
    else
      pure 48

  return (← (do if (← address[position - 1 +: 1]) == 0 then pure (BitVec.cast (by omega) (← concatBits (leftSize := ((64 : Int) - position)) (rightSize := position) (← Std.Bits.Zero (64 - position)) (← address[0 +: position])) : Bits 64) else pure (BitVec.cast (by omega) (← concatBits (leftSize := ((64 : Int) - position)) (rightSize := position) (← Std.Bits.All_Ones (64 - position)) (← address[0 +: position])) : Bits 64)))

end X86.Helpers

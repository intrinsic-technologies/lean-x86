-- Generated from data/definitions.xml.gz: CET::Is_Valid_Shadow_Stack_Address; do not edit.
-- Source SHA256: 975a108b0134d50a44d52788242e7372ec76ad80b7b3c003370254e1d0d805ae
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AIs_Valid_Shadow_Stack_Address)
import X86.Runtime
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def CET.Is_Valid_Shadow_Stack_Address
    (new_ssp : SSP_Type) (new_cs : Segment) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  return (← (do if (← Is_64Bit_Code_Segment new_cs) then pure (← Is_Canonical_Wrt_Paging_Mode new_ssp 0 false) else pure (← Std.Bits.Is_Zero (size := 32) (← new_ssp[63:32]))))

end X86.Helpers

-- Generated from data/definitions.xml.gz: CET::Get_Expected_Target; do not edit.
-- Source SHA256: 5224db2001062b0ce46aca3281467c9bd2a9577f1fca63b116a84f9d35f3cdd7
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AGet_Expected_Target)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Read
import X86.Helpers.Std.Bits.Add_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]

def CET.Get_Expected_Target
     :
    Runtime.SpecM Exception (State σ) (Bits 64 × Bits 64 × SSP_Type × SSP_Type) := do
  let expected_cs : Bits 64 ← CET.Shadow_Stack_Read (← Std.Bits.Add_int (n := 64) (← get).SSP 16) 64 false false
  let expected_lip : Bits 64 ← CET.Shadow_Stack_Read (← Std.Bits.Add_int (n := 64) (← get).SSP 8) 64 false false
  let new_ssp : Bits 64 ← CET.Shadow_Stack_Read (← get).SSP 64 false false
  let old_ssp : Bits 64 ← Std.Bits.Add_int (n := 64) (← get).SSP 24
  return (expected_cs, expected_lip, new_ssp, old_ssp)

end X86.Helpers

-- Generated from data/definitions.xml.gz: CET::Shadow_Stack_Set_Token_Busy_Bit; do not edit.
-- Source SHA256: 9dadebccf869585a3bc5f0b081c47dbba5d2f89c78c0557695dd9d2476e56800
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AShadow_Stack_Set_Token_Busy_Bit)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Compare_Exchange
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]

def CET.Shadow_Stack_Set_Token_Busy_Bit
    (curr_ssp : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let expected_token_value : Bits 64 := curr_ssp
  let new_token_value : Bits 64 ← concatBits (leftSize := 63) (rightSize := 1) (← curr_ssp[63:1]) (1 : Runtime.Bit)
  let actual_token_value : SSP_Type ← CET.Shadow_Stack_Compare_Exchange curr_ssp new_token_value expected_token_value
  return actual_token_value == expected_token_value

end X86.Helpers

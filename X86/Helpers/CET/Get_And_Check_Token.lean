-- Generated from data/definitions.xml.gz: CET::Get_And_Check_Token; do not edit.
-- Source SHA256: 67d3bcf78ef094fdb3123db2924f7692583af5207e95630f5b1098de09b16464
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AGet_And_Check_Token)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Compare_Exchange
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Aligned
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero
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

def CET.Get_And_Check_Token
    (new_ssp : SSP_Type) (push_stack_frame : Bool) (new_cs : Segment) :
    Runtime.SpecM Exception (State σ) (SSP_Type × Bool) := do
  if (not (← Is_Aligned (n := 64) new_ssp 8)) then
    return ((← Std.Bits.Zero 64), false)

  if push_stack_frame then
    -- the 8-byte supervisor shadow stack token and the stack frame must be fully contained
    -- within a 32-byte region that is aligned to 32-bytes on the shadow stack
    let ssp_less_24 : Bits 64 ← Std.Bits.Subtract_int (n := 64) new_ssp 24
    if ((← ssp_less_24[63:5]) != (← new_ssp[63:5])) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let expected_token_value : SSP_Type := new_ssp
  let new_token_value : Bits 64 ← concatBits (leftSize := 63) (rightSize := 1) (← new_ssp[63:1]) (1 : Runtime.Bit)
  let token : SSP_Type ← CET.Shadow_Stack_Compare_Exchange new_ssp new_token_value expected_token_value
  if (SSP_Type.Busy token == 1 or SSP_Type.Reserved token != 0 or not (← Is_64Bit_Code_Segment new_cs) and not (← Std.Bits.Is_Zero (size := 32) (← token[63:32])) or SSP_Type.LinearAddress token != SSP_Type.LinearAddress new_ssp) then
    return (token, false)

  return (token, true)

end X86.Helpers

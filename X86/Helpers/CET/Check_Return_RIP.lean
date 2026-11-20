-- Generated from data/definitions.xml.gz: CET::Check_Return_RIP; do not edit.
-- Source SHA256: 0439f7dfdb33659b64b1078c7998fd012728d8e7636ac827e6616884a82a86f5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3ACheck_Return_RIP)
import X86.Runtime
import X86.Helpers.CET.Shadow_Stack_Pop
import X86.Helpers.CP_Error_Code
import X86.Helpers.Report_Control_Protection_Exception
import X86.Helpers.Std.Unreachable
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]

def CET.Check_Return_RIP
    (operand_size : Int) (new_rip : Bits 64) :
    Runtime.SpecM Exception (State σ) (SSP_Type) := do
  match operand_size with
  | 16 | 32 => do
    let (temp_ss_eip, new_ssp) ← CET.Shadow_Stack_Pop (← get).SSP 32
    if (temp_ss_eip != (← new_rip[0 +: 32])) then
      Report_Control_Protection_Exception CP_Error_Code.NEAR_RET
    return new_ssp
  | 64 => do
    let (temp_ss_rip, new_ssp) ← CET.Shadow_Stack_Pop (← get).SSP 64
    if (temp_ss_rip != new_rip) then
      Report_Control_Protection_Exception CP_Error_Code.NEAR_RET
    return new_ssp
  | _ => do
    Std.Unreachable

end X86.Helpers

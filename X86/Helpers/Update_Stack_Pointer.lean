-- Generated from data/definitions.xml.gz: Update_Stack_Pointer; do not edit.
-- Source SHA256: 686ce8dc6838955247342fe6b790951762f97239a5f373a0a2bf02bac1dc5ccb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Update_Stack_Pointer)
import X86.Runtime
import X86.Helpers.Registers
import X86.Helpers.Segment
import X86.Helpers.Stack_Address_Size
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Update_Stack_Pointer
    (new_ss : Segment) (new_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (← Runtime.readInitialized new_ss.is_stack)
  modify ({ · with SS := new_ss })
  if ((← Stack_Address_Size new_ss) == 16) then
    let mut RSP_target ← RSP
    RSP_target := (← setSliceChecked RSP_target 0 16 (← new_rsp[0 +: 16]))
    RSP_write RSP_target
  else
    RSP_write new_rsp

end X86.Helpers

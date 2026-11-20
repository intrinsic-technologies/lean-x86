-- Generated from data/definitions.xml.gz: VMX::Check_Exception_Bitmap; do not edit.
-- Source SHA256: 487630e63d99955d8654281f09edb63f52bcc495cec747437c1b3d9ac3edc557
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ACheck_Exception_Bitmap)
import X86.Runtime
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Exception_Bitmap.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.Page_Fault_Error_Code_Mask.Binding σ]
  [X86.Page_Fault_Error_Code_Match.Binding σ]

def VMX.Check_Exception_Bitmap
    (vector : Int) (error_code : Bits 32) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (vector in {0..31})

  let bitmap : Bits 32 ← Exception_Bitmap (← get).Current_VMCS_Pointer

  if (vector == PF_Exception) then
    let pfec_mask : Bits 32 ← Page_Fault_Error_Code_Mask (← get).Current_VMCS_Pointer
    let pfec_match : Bits 32 ← Page_Fault_Error_Code_Match (← get).Current_VMCS_Pointer

    if ((error_code and pfec_mask) == pfec_match) then
      if ((← bitmap[PF_Exception +: 1]) == 1) then
        VM_Exit VMX_EXIT_EXCEPTION_NMI
    else
      if ((← bitmap[PF_Exception +: 1]) == 0) then
        VM_Exit VMX_EXIT_EXCEPTION_NMI
  else
    if ((← bitmap[vector +: 1]) == 1) then
      VM_Exit VMX_EXIT_EXCEPTION_NMI

end X86.Helpers

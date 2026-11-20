-- Generated from data/definitions.xml.gz: EPT::Handle_Violation; do not edit.
-- Source SHA256: 656c7c572346b010af16540fe0002b36f709140c5e285283867e84391a2053c9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT%3A%3AHandle_Violation)
import X86.Runtime
import X86.Helpers.EPT.Is_Convertible_Violation
import X86.Helpers.Report_Virtualization_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Translation
import X86.Helpers.VMX.Save_Virtualization_Exception_Information
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
  [X86.EPTP_Index.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]

def EPT.Handle_Violation
    (translation : Translation) (exit_qualification : Bits 64) (ept_entry_present : Bool := true) (ept_entry_maps_a_page : Bool := false) (suppress_ve : Bool := false) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (← EPT.Is_Convertible_Violation ept_entry_present ept_entry_maps_a_page suppress_ve) then

    VMX.Save_Virtualization_Exception_Information (← Std.Bits.Zero_Extend (source_size := 16) VMX_EXIT_EPT_VIOLATION 32) exit_qualification translation.linear_address translation.guest_physical_address
    liftM (Report_Virtualization_Exception)
  else
    VM_Exit VMX_EXIT_EPT_VIOLATION

end X86.Helpers

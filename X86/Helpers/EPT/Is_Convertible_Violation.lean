-- Generated from data/definitions.xml.gz: EPT::Is_Convertible_Violation; do not edit.
-- Source SHA256: a9d05d8ecc8e49f5e82271b6a4764d0968071cf1426d3beb7cb283ab59221414
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT%3A%3AIs_Convertible_Violation)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Physical_Address
import X86.Helpers.Is_EPT_Enabled
import X86.Helpers.Memory_Type
import X86.Helpers.Physical_Mem_Read
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]

def EPT.Is_Convertible_Violation
    (ept_entry_present ept_entry_maps_a_page suppress_ve : Bool) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (← Is_EPT_Enabled)

  if ((← VM_Exec_Controls2).EPT_Violation_VE == 0) then
    return false

  if suppress_ve then
    if (not ept_entry_present or ept_entry_maps_a_page) then
      return false

  -- Delivery of virtualization exceptions writes the value FFFFFFFFH to offset 4 in the
  -- virtualization-exception information area.  Thus, once a virtualization exception occurs,
  -- another can occur only if software clears this field.
  let ve_address : Bits 64 ← Virtualization_Exception_Information_Address (← get).Current_VMCS_Pointer
  let physical : Address_Translation ← Create_Physical_Address (← Std.Bits.Add_int (n := 64) ve_address 4) 32 Memory_Type.Memory_Type_Strong_Uncacheable
  let ve_delivered : Bits 32 ← Physical_Mem_Read physical 32

  if (not (← Std.Bits.Is_Zero (size := 32) ve_delivered)) then
    return false

  return true

end X86.Helpers

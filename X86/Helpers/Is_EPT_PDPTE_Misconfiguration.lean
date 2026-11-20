-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 3ca366775e36ac1b103a4cbf3e4fb52a3d26eef082710e94c26da0de74b126bf
import X86.Runtime
import X86.Helpers.Convert_To_Memory_Type
import X86.Helpers.EPT_PDPTE_1GByte_Type
import X86.Helpers.EPT_PML5E_PML4E_PDPTE_Or_PDE_Type
import X86.Helpers.Is_EPT_Entry_Misconfiguration
import X86.Helpers.Memory_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

def Is_EPT_PDPTE_Misconfiguration
    (ept_pdpte_1gbyte : EPT_PDPTE_1GByte_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if (EPT_PDPTE_1GByte_Type.MAPS_1GBYTE_PAGE ept_pdpte_1gbyte == 1) then
    if (not (← Std.Bits.Is_Zero (size := 18) (EPT_PDPTE_1GByte_Type.RESERVED_MBZ ept_pdpte_1gbyte))) then
      return true
    else
      if (EPT_PDPTE_1GByte_Type.READ ept_pdpte_1gbyte == 0 and (← VM_Exec_Controls3).EPT_Paging_Write_Control == 1 and EPT_PDPTE_1GByte_Type.PAGING_WRITE_ACCESS ept_pdpte_1gbyte == 1) then
        return true
      else
        if ((← Convert_To_Memory_Type (EPT_PDPTE_1GByte_Type.EPT_MEMORY_TYPE ept_pdpte_1gbyte)) == Memory_Type.Memory_Type_Unknown or EPT_PDPTE_1GByte_Type.EPT_MEMORY_TYPE ept_pdpte_1gbyte == 7) then
          return true
  else
    let ept_pdpte : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type := ept_pdpte_1gbyte

    if (not (← Std.Bits.Is_Zero (size := 5) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.RESERVED_MBZ ept_pdpte))) then
      return true

  -- Perform the common checks for all EPT entries
  return (← Is_EPT_Entry_Misconfiguration ept_pdpte_1gbyte)

end X86.Helpers

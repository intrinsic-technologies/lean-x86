-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 624a407e0edb68e1cafd31150a959ad8643c063525a4f41c471295700cbca6de
import X86.Runtime
import X86.Helpers.Convert_To_Memory_Type
import X86.Helpers.EPT_PTE_Type
import X86.Helpers.Is_EPT_Entry_Misconfiguration
import X86.Helpers.Memory_Type
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

def Is_EPT_PTE_Misconfiguration
    (ept_pte : EPT_PTE_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if (EPT_PTE_Type.READ ept_pte == 0 and (← VM_Exec_Controls3).EPT_Paging_Write_Control == 1 and EPT_PTE_Type.PAGING_WRITE_ACCESS ept_pte == 1) then
    return true
  else
    if ((← Convert_To_Memory_Type (EPT_PTE_Type.EPT_MEMORY_TYPE ept_pte)) == Memory_Type.Memory_Type_Unknown or EPT_PTE_Type.EPT_MEMORY_TYPE ept_pte == 7) then
      return true
    else
      -- Perform the common checks for all EPT entries
      return (← Is_EPT_Entry_Misconfiguration ept_pte)

end X86.Helpers

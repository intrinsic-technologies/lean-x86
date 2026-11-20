-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 2fa12a4a41efa9e2b9ed62553470348e83ff1bb54a64c52bc65657095f2da2af
import X86.Runtime
import X86.Helpers.Convert_To_Memory_Type
import X86.Helpers.EPT_PDE_2MByte_Type
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

def Is_EPT_PDE_Misconfiguration
    (ept_pde_2mbyte : EPT_PDE_2MByte_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if (EPT_PDE_2MByte_Type.MAPS_2MBYTE_PAGE ept_pde_2mbyte == 1) then
    if (not (← Std.Bits.Is_Zero (size := 9) (EPT_PDE_2MByte_Type.RESERVED_MBZ ept_pde_2mbyte))) then
      return true
    else
      if (EPT_PDE_2MByte_Type.READ ept_pde_2mbyte == 0 and (← VM_Exec_Controls3).EPT_Paging_Write_Control == 1 and EPT_PDE_2MByte_Type.PAGING_WRITE_ACCESS ept_pde_2mbyte == 1) then
        return true
      else
        if ((← Convert_To_Memory_Type (EPT_PDE_2MByte_Type.EPT_MEMORY_TYPE ept_pde_2mbyte)) == Memory_Type.Memory_Type_Unknown or EPT_PDE_2MByte_Type.EPT_MEMORY_TYPE ept_pde_2mbyte == 7) then
          return true
  else
    let ept_pde : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type := ept_pde_2mbyte

    if (not (← Std.Bits.Is_Zero (size := 5) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.RESERVED_MBZ ept_pde))) then
      return true

  -- Perform the common checks for all EPT entries
  return (← Is_EPT_Entry_Misconfiguration ept_pde_2mbyte)

end X86.Helpers

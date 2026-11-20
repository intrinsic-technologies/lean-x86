-- Generated from data/definitions.xml.gz: EPT::Is_Entry_Present; do not edit.
-- Source SHA256: bcd740531b03567bc82f57f6a67ab409531066f20db5ecdcecef09ff9647d9a3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT%3A%3AIs_Entry_Present)
import X86.Runtime
import X86.Helpers.EPT_PML5E_PML4E_PDPTE_Or_PDE_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.VM_Exec_Controls2.Binding σ]

def EPT.Is_Entry_Present
    (ept_pmle_pdpte_pde_or_pte : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  -- The bits used to check whether EPT entry is present, are common across all formats of EPT Page-Table entries
  let ept_entry : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type := ept_pmle_pdpte_pde_or_pte

  -- An EPT paging-structure entry is present if any of bits 2:0 is 1; otherwise, the entry is not present
  if (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.READ ept_entry == 1 or EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.WRITE ept_entry == 1 or EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EXECUTE_SUPERVISOR ept_entry == 1) then
    return true
  else
    return (← VM_Exec_Controls2).Mode_Based_Execute_Control_For_EPT == 1 and EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EXECUTE_USER ept_entry == 1

end X86.Helpers

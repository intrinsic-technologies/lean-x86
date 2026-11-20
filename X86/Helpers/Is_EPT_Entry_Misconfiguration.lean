-- Generated from data/definitions.xml.gz: Is_EPT_Entry_Misconfiguration; do not edit.
-- Source SHA256: f5f724ebc722ace2f02fb8f06e5bac7e2553da7dcab97c0c0303af49de4bf686
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_EPT_Entry_Misconfiguration)
import X86.Runtime
import X86.Helpers.EPT_PML5E_PML4E_PDPTE_Or_PDE_Type
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
  [X86.Config.Value.Max_Physical_Address]

def Is_EPT_Entry_Misconfiguration
    (ept_entry : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  -- The bits used to check whether EPT entry is present, are common across all formats of EPT Page-Table entries
  if (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.READ ept_entry == 0 and EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.WRITE ept_entry == 1) then
    return true
  else
    if (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.READ ept_entry == 0 and (← get).IA32_VMX_EPT_VPID_CAP.SUPPORTS_EPT_EXECUTE_ONLY == 0) then
      if (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EXECUTE_SUPERVISOR ept_entry == 1) then
        return true
      else
        if ((← VM_Exec_Controls2).Mode_Based_Execute_Control_For_EPT == 1 and EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EXECUTE_USER ept_entry == 1) then
          return true
    else
      if (decide ((← Config.Read.Max_Physical_Address (exception := Exception)) < 52) and not (← (do
        let Config__Max_Physical_Address ← Config.Read.Max_Physical_Address (exception := Exception)
        return (← Std.Bits.Is_Zero (size := ((52 : Int) + (- Config__Max_Physical_Address))) (← (do Runtime.assert (decide (Config__Max_Physical_Address ≤ 52)); pure (BitVec.cast (by omega) (← ept_entry[51:Config__Max_Physical_Address]) : Bits ((52 : Int) + (- Config__Max_Physical_Address))))))))) then
        return true
  return false

end X86.Helpers

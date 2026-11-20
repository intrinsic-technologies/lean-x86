-- Generated from data/definitions.xml.gz: EPT::Translate; do not edit.
-- Source SHA256: 90ec83ad3acaeef64ca1bdd24bc3787775121a7e1d5483e18bbe07324644505b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT%3A%3ATranslate)
import X86.Runtime
import X86.Helpers.Convert_To_Memory_Type
import X86.Helpers.EPT.Get_Exit_Qualification
import X86.Helpers.EPT.Handle_Violation
import X86.Helpers.EPT.Is_Access_Violation
import X86.Helpers.EPT.Is_Entry_Present
import X86.Helpers.EPT_Entries_Combined_Access_Permissions_Type
import X86.Helpers.EPT_Exit_Qualification_Type
import X86.Helpers.EPT_PDE_2MByte_Type
import X86.Helpers.EPT_PDPTE_1GByte_Type
import X86.Helpers.EPT_PML5E_PML4E_PDPTE_Or_PDE_Type
import X86.Helpers.EPT_PTE_Type
import X86.Helpers.Is_EPT_Enabled
import X86.Helpers.Is_EPT_Entry_Misconfiguration
import X86.Helpers.Is_EPT_PDE_Misconfiguration
import X86.Helpers.Is_EPT_PDPTE_Misconfiguration
import X86.Helpers.Is_EPT_PTE_Misconfiguration
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Physical_Mem_Read_EPT
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Translation
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
  [X86.Helpers.EPT.Get_Exit_Qualification.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Read_EPT.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

def EPT.Translate
    (gpa_translation : Translation) (access_type : Memory_Access_Type) (is_page_ad_bit_update : Bool := false) (ia_paging_level : Paging_Level_Type := Paging_Level_Type.Paging_Level_Unknown) :
    Runtime.SpecM Exception (State σ) (Translation) := do
  let mut final_physical : Translation := gpa_translation
  Runtime.assert (← Is_EPT_Enabled)

  let is_page_walk_access : Bool := is_page_ad_bit_update or ia_paging_level != Paging_Level_Type.Paging_Level_Unknown

  let mut ept_access_permissions : EPT_Entries_Combined_Access_Permissions_Type ← Std.Bits.All_Ones 4
  let mut ept_non_leaf_write_permission : Runtime.Bit := EPT_Entries_Combined_Access_Permissions_Type.WRITE ept_access_permissions

  -- Update guest physical address fields in Translation record
  final_physical := { final_physical with is_guest_physical_address_valid := true }
  final_physical := { final_physical with guest_physical_address := final_physical.physical_address }

  -- The EPT page-walk length is configured using the extended-page-table pointer (VMCS::EPTP).
  -- Bits 5:3 contain a value one less than EPT page-walk length.
  let EPT_level : Int := Unsigned (← «VMCS::EPTP».EPT_Page_Walk_Length) + 1
  Runtime.assert (EPT_level == 4 or EPT_level == 5)

  let ept_memory_type : Memory_Type ← do
    if (← CR0.CD) == 1 then
      pure Memory_Type.Memory_Type_Strong_Uncacheable
    else
      Convert_To_Memory_Type (← «VMCS::EPTP».Memory_Type)

  let mut ept_pml5e : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type ← Std.Bits.Zero 64

  -- If EPT length is 5, compute EPT PML5E address and read its value from memory
  let ept_pml4e_address_bits_51_12 : Bits 40 ← do
    if EPT_level == 5 then
      let ept_pml5e_address_bits_51_12 : Bits 40 ← «VMCS::EPTP».EPT_PML4_Or_PML5_Table_Physical_Address
      let ept_pml5e_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) ept_pml5e_address_bits_51_12 (← concatBits (leftSize := 9) (rightSize := 3) (← final_physical.guest_physical_address[56:48]) (← Std.Bits.Zero 3)))

      ept_pml5e := (← Physical_Mem_Read_EPT ept_pml5e_address 64 ept_memory_type ia_paging_level Paging_Level_Type.PML5E)

      ept_access_permissions := ept_access_permissions and EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EU_ES_W_R ept_pml5e

      -- Check for EPT Violation or EPT Misconfiguration
      if (not (← EPT.Is_Entry_Present ept_pml5e)) then
        let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access
        EPT.Handle_Violation final_physical exit_qualification false false false
      else
        if (not (← Std.Bits.Is_Zero (size := 5) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.RESERVED_MBZ ept_pml5e)) or (← Is_EPT_Entry_Misconfiguration ept_pml5e)) then
          VM_Exit VMX_EXIT_EPT_MISCONFIG

      -- Compute EPT PML4E address
      let ept_pml4e_address_bits_51_12 : Bits 40 := EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EPT_PML4T_PDPT_PD_OR_PT_ADDRESS ept_pml5e
      pure ept_pml4e_address_bits_51_12
    else
      -- 4-level EPT

      if (not (← Std.Bits.Is_Zero (size := 16) (← final_physical.guest_physical_address[63:48]))) then
        VM_Exit VMX_EXIT_EPT_VIOLATION

      -- Compute EPT PML4E address
      let ept_pml4e_address_bits_51_12 : Bits 40 ← «VMCS::EPTP».EPT_PML4_Or_PML5_Table_Physical_Address
      pure ept_pml4e_address_bits_51_12
  let ept_pml4e_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) ept_pml4e_address_bits_51_12 (← concatBits (leftSize := 9) (rightSize := 3) (← final_physical.guest_physical_address[47:39]) (← Std.Bits.Zero 3)))

  -- Read PML4E value from memory
  let ept_pml4e : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type ← Physical_Mem_Read_EPT ept_pml4e_address 64 ept_memory_type ia_paging_level Paging_Level_Type.PML4E

  ept_access_permissions := ept_access_permissions and EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EU_ES_W_R ept_pml4e

  -- Check for EPT Violation or EPT Misconfiguration
  if (not (← EPT.Is_Entry_Present ept_pml4e)) then
    let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access
    EPT.Handle_Violation final_physical exit_qualification false false false

  if (not (← Std.Bits.Is_Zero (size := 5) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.RESERVED_MBZ ept_pml4e)) or (← Is_EPT_Entry_Misconfiguration ept_pml4e)) then
    VM_Exit VMX_EXIT_EPT_MISCONFIG

  -- Compute EPT PDPTE address
  let ept_pdpte_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EPT_PML4T_PDPT_PD_OR_PT_ADDRESS ept_pml4e) (← concatBits (leftSize := 9) (rightSize := 3) (← final_physical.guest_physical_address[38:30]) (← Std.Bits.Zero 3)))

  -- Read PDPTE value from memory
  let ept_pdpte_1gbyte : EPT_PDPTE_1GByte_Type ← Physical_Mem_Read_EPT ept_pdpte_address 64 ept_memory_type ia_paging_level Paging_Level_Type.PDPTE

  ept_non_leaf_write_permission := EPT_Entries_Combined_Access_Permissions_Type.WRITE ept_access_permissions
  ept_access_permissions := ept_access_permissions and EPT_PDPTE_1GByte_Type.EU_ES_W_R ept_pdpte_1gbyte

  -- Check for EPT Violation or EPT Misconfiguration
  if (not (← EPT.Is_Entry_Present ept_pdpte_1gbyte)) then
    let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access
    EPT.Handle_Violation final_physical exit_qualification false (EPT_PDPTE_1GByte_Type.MAPS_1GBYTE_PAGE ept_pdpte_1gbyte == 1) (EPT_PDPTE_1GByte_Type.SUPPRESS_VE ept_pdpte_1gbyte == 1)

  if (← Is_EPT_PDPTE_Misconfiguration ept_pdpte_1gbyte) then
    VM_Exit VMX_EXIT_EPT_MISCONFIG

  if (EPT_PDPTE_1GByte_Type.MAPS_1GBYTE_PAGE ept_pdpte_1gbyte == 1) then
    -- EPT PDPTE maps a 1-GByte page; compute the final physical address
    final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 52 12 (← Std.Bits.Zero 12)) }
    final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 30 22 (EPT_PDPTE_1GByte_Type.EPT_PAGE_PHYSICAL_ADDRESS ept_pdpte_1gbyte)) }
    final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 0 30 (← final_physical.guest_physical_address[29:0])) }

    if (← EPT.Is_Access_Violation access_type final_physical is_page_ad_bit_update ept_access_permissions (ept_non_leaf_write_permission == 1) (EPT_PDPTE_1GByte_Type.PAGING_WRITE_ACCESS ept_pdpte_1gbyte == 1)) then
      let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access

      EPT.Handle_Violation final_physical exit_qualification true true (EPT_PDPTE_1GByte_Type.SUPPRESS_VE ept_pdpte_1gbyte == 1)

    return final_physical

  -- EPT PDPTE[7] is 0; a 4-KByte naturally aligned EPT page directory is located at the physical
  -- address specified in bits 51:12 of the EPT PDPTE
  let ept_pdpte : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type := ept_pdpte_1gbyte

  -- Compute EPT PDE address and read its value from memory
  let ept_pde_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EPT_PML4T_PDPT_PD_OR_PT_ADDRESS ept_pdpte) (← concatBits (leftSize := 9) (rightSize := 3) (← final_physical.guest_physical_address[29:21]) (← Std.Bits.Zero 3)))

  let ept_pde_2mbyte : EPT_PDE_2MByte_Type ← Physical_Mem_Read_EPT ept_pde_address 64 ept_memory_type ia_paging_level Paging_Level_Type.PDE

  ept_non_leaf_write_permission := EPT_Entries_Combined_Access_Permissions_Type.WRITE ept_access_permissions
  ept_access_permissions := ept_access_permissions and EPT_PDE_2MByte_Type.EU_ES_W_R ept_pde_2mbyte

  -- Check for EPT Violation or EPT Misconfiguration
  if (not (← EPT.Is_Entry_Present ept_pde_2mbyte)) then
    let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access
    EPT.Handle_Violation final_physical exit_qualification false (EPT_PDE_2MByte_Type.MAPS_2MBYTE_PAGE ept_pde_2mbyte == 1) (EPT_PDE_2MByte_Type.SUPPRESS_VE ept_pde_2mbyte == 1)

  if (← Is_EPT_PDE_Misconfiguration ept_pde_2mbyte) then
    VM_Exit VMX_EXIT_EPT_MISCONFIG

  if (EPT_PDE_2MByte_Type.MAPS_2MBYTE_PAGE ept_pde_2mbyte == 1) then
    -- EPT PDE maps a 2-MByte page; compute final physical address
    final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 52 12 (← Std.Bits.Zero 12)) }
    final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 21 31 (EPT_PDE_2MByte_Type.EPT_PAGE_PHYSICAL_ADDRESS ept_pde_2mbyte)) }
    final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 0 21 (← final_physical.guest_physical_address[20:0])) }

    if (← EPT.Is_Access_Violation access_type final_physical is_page_ad_bit_update ept_access_permissions (ept_non_leaf_write_permission == 1) (EPT_PDE_2MByte_Type.PAGING_WRITE_ACCESS ept_pde_2mbyte == 1)) then
      let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access

      EPT.Handle_Violation final_physical exit_qualification true true (EPT_PDE_2MByte_Type.SUPPRESS_VE ept_pde_2mbyte == 1)

    return final_physical

  -- EPT PDE[7] is 0; a 4-KByte naturally aligned EPT page table is located at the physical
  -- address specified in bits 51:12 of the EPT PDE
  let ept_pde : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type := ept_pde_2mbyte

  -- Compute EPT PTE address and read its value from memory
  let ept_pte_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EPT_PML4T_PDPT_PD_OR_PT_ADDRESS ept_pde) (← concatBits (leftSize := 9) (rightSize := 3) (← final_physical.guest_physical_address[20:12]) (← Std.Bits.Zero 3)))

  let ept_pte : EPT_PTE_Type ← Physical_Mem_Read_EPT ept_pte_address 64 ept_memory_type ia_paging_level Paging_Level_Type.PTE

  ept_non_leaf_write_permission := EPT_Entries_Combined_Access_Permissions_Type.WRITE ept_access_permissions
  ept_access_permissions := ept_access_permissions and EPT_PTE_Type.EU_ES_W_R ept_pte

  -- Check for EPT Violation or EPT Misconfiguration
  if (not (← EPT.Is_Entry_Present ept_pte)) then
    let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access
    EPT.Handle_Violation final_physical exit_qualification false true (EPT_PTE_Type.SUPPRESS_VE ept_pte == 1)

  if (← Is_EPT_PTE_Misconfiguration ept_pte) then
    VM_Exit VMX_EXIT_EPT_MISCONFIG

  -- Compute final physical address
  final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 52 12 (← Std.Bits.Zero 12)) }
  final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 12 40 (EPT_PTE_Type.EPT_PAGE_PHYSICAL_ADDRESS ept_pte)) }
  final_physical := { final_physical with physical_address := (← setSliceChecked final_physical.physical_address 0 12 (← final_physical.guest_physical_address[11:0])) }

  if (← EPT.Is_Access_Violation access_type final_physical is_page_ad_bit_update ept_access_permissions (ept_non_leaf_write_permission == 1) (EPT_PTE_Type.PAGING_WRITE_ACCESS ept_pte == 1)) then
    let exit_qualification : EPT_Exit_Qualification_Type ← EPT.Get_Exit_Qualification final_physical access_type ept_access_permissions is_page_walk_access

    EPT.Handle_Violation final_physical exit_qualification true true (EPT_PTE_Type.SUPPRESS_VE ept_pte == 1)

  return final_physical

end X86.Helpers

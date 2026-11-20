-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 5ee2d0b85dc0a4801d19b9b6a28383466148835b187d0945167c29cac7e75265
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Bit32_Paging_PDE_4MB_Page_Type
import X86.Helpers.Bit32_Paging_PDE_PT_Type
import X86.Helpers.Bit32_Paging_PTE_Type
import X86.Helpers.Calculate_Page_Fault_Error_Code
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Page_AD_Bit_Update
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Physical_Mem_Read_PTW
import X86.Helpers.Report_Page_Fault
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.EPTP_Index.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.EPT.Get_Exit_Qualification.Binding σ]
  [X86.Helpers.Get_Cache_Disabled_Memory_Type.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Read_EPT.Binding σ]
  [X86.Helpers.Physical_Mem_Read_PTW.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Physical_Mem_Write_PTW.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]
  [X86.__Implements_Processor_Type.Binding]
  [X86.Config.Value.Max_Physical_Address]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_Early_Page_Access_Bit_Update]

def Translate_With_32Bit_Paging
    (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Translation) := do
  let pde_address_bits_31_12 : Bits 20 ← sliceInclusive (← get).CR3 31 12
  let pde_address : Bits 64 ← concatBits (leftSize := 32) (rightSize := 32) (← Std.Bits.Zero 32) (← concatBits (leftSize := 20) (rightSize := 12) pde_address_bits_31_12 (← concatBits (leftSize := 10) (rightSize := 2) (← linear.linear_address[31:22]) (← Std.Bits.Zero 2)))
  let cr3_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (← CR3.PCD)) (← CR3.PWT)

  let pde : Bit32_Paging_PDE_PT_Type ← Physical_Mem_Read_PTW linear.linear_address pde_address 32 cr3_pat Paging_Level_Type.PDE

  if (Bit32_Paging_PDE_PT_Type.P pde == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Bit32_Paging_PDE_PT_Type.A pde == 0) then
    Page_AD_Bit_Update linear.linear_address pde_address cr3_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

  if ((← CR4.PSE) == 1 and Bit32_Paging_PDE_PT_Type.PS pde == 1) then
    -- "PDE maps a 4-MByte page"

    let pde_4mb_page : Bit32_Paging_PDE_4MB_Page_Type := pde

    -- TODO: add condition to check whether PSE-36 mechanism is supported.
    -- TODO: check whether PAT is supported

    let pse36_width : Int := Std.Integer.Min (← Config.Read.Max_Physical_Address (exception := Exception)) 40
    if (not (← Std.Bits.Is_Zero (size := 1) (Bit32_Paging_PDE_4MB_Page_Type.RESERVED pde_4mb_page)) or not (← Std.Bits.Is_Zero (size := ((40 : Int) + (- pse36_width))) (← (do Runtime.assert (decide (pse36_width - 19 ≤ 21)); pure (BitVec.cast (by omega) (← pde[20:pse36_width - 19]) : Bits ((40 : Int) + (- pse36_width))))))) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false false false
      liftM (Report_Page_Fault error_code linear.linear_address)

    -- update access and dirty bits
    if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
      let update_dirty_bit : Bool := not (← CPUID_CET_SS) or Bit32_Paging_PDE_PT_Type.RW pde == 1
      Page_AD_Bit_Update linear.linear_address pde_address cr3_pat (← pde[0 +: 8]) Paging_Level_Type.PDE update_dirty_bit
    else
      if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Bit32_Paging_PDE_PT_Type.A pde == 0) then
        Page_AD_Bit_Update linear.linear_address pde_address cr3_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

    let pa : Bits 64 ← concatBits (leftSize := 42) (rightSize := 22) (← concatBits (leftSize := 24) (rightSize := 18) (← Std.Bits.Zero 24) (Bit32_Paging_PDE_4MB_Page_Type.PAGE_ADDRESS pde_4mb_page)) (← linear.linear_address[21:0])
    let translation : Translation := ({
      size_in_bytes := linear.num_bytes,
      linear_address := linear.linear_address,
      guest_physical_address := pa,
      physical_address := pa,
      is_write_allowed := Bit32_Paging_PDE_4MB_Page_Type.RW pde_4mb_page == 1,
      is_user_mode_address := Bit32_Paging_PDE_4MB_Page_Type.US pde_4mb_page == 1,
      is_execute_disabled := false,
      is_shadow_stack_address := Bit32_Paging_PDE_4MB_Page_Type.RW pde_4mb_page == 0 and Bit32_Paging_PDE_4MB_Page_Type.D pde_4mb_page == 1,
      is_guest_physical_address_valid := false,
      page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (Bit32_Paging_PDE_4MB_Page_Type.PAT pde_4mb_page) (Bit32_Paging_PDE_4MB_Page_Type.PCD pde_4mb_page)) (Bit32_Paging_PDE_4MB_Page_Type.PWT pde_4mb_page)),
      memory_type := Memory_Type.Memory_Type_Unknown
    } : Translation)
    return translation

  -- "4-KByte naturally aligned page table is located at the physical address"
  let pte_address : Bits 64 ← concatBits (leftSize := 32) (rightSize := 32) (← Std.Bits.Zero 32) (← concatBits (leftSize := 20) (rightSize := 12) (Bit32_Paging_PDE_PT_Type.PAGE_TABLE_ADDRESS pde) (← concatBits (leftSize := 10) (rightSize := 2) (← linear.linear_address[21:12]) (← Std.Bits.Zero 2)))
  let pde_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (Bit32_Paging_PDE_PT_Type.PCD pde)) (Bit32_Paging_PDE_PT_Type.PWT pde)

  let pte : Bit32_Paging_PTE_Type ← Physical_Mem_Read_PTW linear.linear_address pte_address 32 pde_pat Paging_Level_Type.PTE

  if (Bit32_Paging_PTE_Type.P pte == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  -- update access and dirty bits
  if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Bit32_Paging_PDE_PT_Type.A pde == 0) then
    Page_AD_Bit_Update linear.linear_address pde_address cr3_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

  if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
    let update_dirty_bit : Bool := not (← CPUID_CET_SS) or Bit32_Paging_PTE_Type.RW pte == 1
    Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE update_dirty_bit
  else
    if (Bit32_Paging_PTE_Type.A pte == 0) then
      Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE false

  if ((← CR4.PSE) == 1) then
    pure ()

  let pa : Bits 64 ← concatBits (leftSize := 52) (rightSize := 12) (← concatBits (leftSize := 32) (rightSize := 20) (← Std.Bits.Zero 32) (Bit32_Paging_PTE_Type.PAGE_ADDRESS pte)) (← linear.linear_address[11:0])
  let translation : Translation := ({
    size_in_bytes := linear.num_bytes,
    linear_address := linear.linear_address,
    guest_physical_address := pa,
    physical_address := pa,
    is_write_allowed := Bit32_Paging_PTE_Type.RW pte == 1 and Bit32_Paging_PDE_PT_Type.RW pde == 1,
    is_user_mode_address := Bit32_Paging_PTE_Type.US pte == 1 and Bit32_Paging_PDE_PT_Type.US pde == 1,
    is_execute_disabled := false,
    is_shadow_stack_address := Bit32_Paging_PTE_Type.RW pte == 0 and Bit32_Paging_PTE_Type.D pte == 1 and Bit32_Paging_PDE_PT_Type.RW pde == 1,
    is_guest_physical_address_valid := false,
    page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (Bit32_Paging_PTE_Type.PAT pte) (Bit32_Paging_PTE_Type.PCD pte)) (Bit32_Paging_PTE_Type.PWT pte)),
    memory_type := Memory_Type.Memory_Type_Unknown
  } : Translation)
  return translation

end X86.Helpers

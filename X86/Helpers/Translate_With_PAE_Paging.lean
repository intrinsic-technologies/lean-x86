-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 0f504eac3183c1fccc7d52c20f7f1d7555b0e3e885f3d58da53f3bd524f207f8
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_Page_Fault_Error_Code
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Type
import X86.Helpers.PAE_paging_PDE_2MB_page_type
import X86.Helpers.PAE_paging_PDE_PT_type
import X86.Helpers.PAE_paging_PDPTE_type
import X86.Helpers.PAE_paging_PTE_4KB_page_type
import X86.Helpers.Page_AD_Bit_Update
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Physical_Mem_Read_PTW
import X86.Helpers.Report_Page_Fault
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
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

def Translate_With_PAE_Paging
    (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Translation) := do
  let page_directory_pointer_table_base : Bits 64 ← concatBits (leftSize := 59) (rightSize := 5) (← concatBits (leftSize := 32) (rightSize := 27) (← Std.Bits.Zero 32) (← sliceInclusive (← get).CR3 31 5)) (← Std.Bits.Zero 5)

  let pdpte_index : Int := Unsigned (← linear.linear_address[31:30])
  let pdpte_address : Bits 64 ← Std.Bits.Add_int (n := 64) page_directory_pointer_table_base (pdpte_index * 8)
  let cr3_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (← CR3.PCD)) (← CR3.PWT)

  let pdpte : PAE_paging_PDPTE_type ← Physical_Mem_Read_PTW linear.linear_address pdpte_address 64 cr3_pat Paging_Level_Type.PDPTE

  if (PAE_paging_PDPTE_type.P pdpte == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if (not (← Std.Bits.Is_Zero (size := 18) (PAE_paging_PDPTE_type.RESERVED pdpte)) or not (← (do
    let Config__Max_Physical_Address ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((64 : Int) + (- Config__Max_Physical_Address))) (← (do Runtime.assert (decide (Config__Max_Physical_Address ≤ 64)); pure (BitVec.cast (by omega) (← pdpte[63:Config__Max_Physical_Address]) : Bits ((64 : Int) + (- Config__Max_Physical_Address))))))))) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  let pde_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (PAE_paging_PDPTE_type.PAGE_DIRECTORY_ADDRESS pdpte) (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[29:21]) (← Std.Bits.Zero 3)))
  let pdpte_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (PAE_paging_PDPTE_type.PCD pdpte)) (PAE_paging_PDPTE_type.PWT pdpte)

  let pde : PAE_paging_PDE_PT_type ← Physical_Mem_Read_PTW linear.linear_address pde_address 64 pdpte_pat Paging_Level_Type.PDE

  if (PAE_paging_PDE_PT_type.P pde == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and PAE_paging_PDE_PT_type.A pde == 0) then
    Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

  if (not (← (do
    let Config__Max_Physical_Address_1 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((63 : Int) + (- Config__Max_Physical_Address_1))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_1 ≤ 63)); pure (BitVec.cast (by omega) (← pde[62:Config__Max_Physical_Address_1]) : Bits ((63 : Int) + (- Config__Max_Physical_Address_1)))))))) or (← get).IA32_EFER.NXE == 0 and PAE_paging_PDE_PT_type.XD pde == 1) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  -- the XD bit is accumulated over all paging levels and checked once the
  -- translation is complete (the PAE PDPTE has no XD bit)
  let mut is_execute_disabled : Bool := PAE_paging_PDE_PT_type.XD pde == 1

  if (PAE_paging_PDE_PT_type.PS pde == 1) then
    -- "PDE maps a 2-MByte page"

    let pde_2mb_page : PAE_paging_PDE_2MB_page_type := pde

    if (not (← Std.Bits.Is_Zero (size := 19) (PAE_paging_PDE_2MB_page_type.RESERVED pde_2mb_page))) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false false false
      liftM (Report_Page_Fault error_code linear.linear_address)

    if (access_type == Memory_Access_Type.Memory_Execute and is_execute_disabled and (← get).IA32_EFER.NXE == 1) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
      liftM (Report_Page_Fault error_code linear.linear_address)

    -- update access and dirty bits
    if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
      let update_dirty_bit : Bool := not (← CPUID_CET_SS) or PAE_paging_PDE_PT_type.RW pde == 1
      Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE update_dirty_bit
    else
      if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and PAE_paging_PDE_PT_type.A pde == 0) then
        Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

    let pa : Bits 64 ← concatBits (leftSize := 43) (rightSize := 21) (← concatBits (leftSize := 12) (rightSize := 31) (← Std.Bits.Zero 12) (PAE_paging_PDE_2MB_page_type.PAGE_ADDRESS pde_2mb_page)) (← linear.linear_address[20:0])
    let translation : Translation := ({
      size_in_bytes := linear.num_bytes,
      linear_address := linear.linear_address,
      guest_physical_address := pa,
      physical_address := pa,
      is_write_allowed := PAE_paging_PDE_2MB_page_type.RW pde_2mb_page == 1,
      is_user_mode_address := PAE_paging_PDE_2MB_page_type.US pde_2mb_page == 1,
      is_execute_disabled := is_execute_disabled,
      is_shadow_stack_address := PAE_paging_PDE_2MB_page_type.RW pde_2mb_page == 0 and PAE_paging_PDE_2MB_page_type.D pde_2mb_page == 1,
      is_guest_physical_address_valid := false,
      page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (PAE_paging_PDE_2MB_page_type.PAT pde_2mb_page) (PAE_paging_PDE_2MB_page_type.PCD pde_2mb_page)) (PAE_paging_PDE_2MB_page_type.PWT pde_2mb_page)),
      memory_type := Memory_Type.Memory_Type_Unknown
    } : Translation)
    return translation

  -- "4-KByte naturally aligned page table is located at the physical address"
  let pte_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (PAE_paging_PDE_PT_type.PAGE_TABLE_ADDRESS pde) (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[20:12]) (← Std.Bits.Zero 3)))
  -- a PDE that references a page table has no PAT bit (bit 12 is part of the
  -- page-table address), so the high bit of the PAT index is always 0
  let pde_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (PAE_paging_PDE_PT_type.PCD pde)) (PAE_paging_PDE_PT_type.PWT pde)

  let pte : PAE_paging_PTE_4KB_page_type ← Physical_Mem_Read_PTW linear.linear_address pte_address 64 pde_pat Paging_Level_Type.PTE

  if (PAE_paging_PTE_4KB_page_type.P pte == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and PAE_paging_PTE_4KB_page_type.A pte == 0) then
    Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE false

  if (not (← (do
    let Config__Max_Physical_Address_2 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((63 : Int) + (- Config__Max_Physical_Address_2))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_2 ≤ 63)); pure (BitVec.cast (by omega) (← pte[62:Config__Max_Physical_Address_2]) : Bits ((63 : Int) + (- Config__Max_Physical_Address_2)))))))) or (← get).IA32_EFER.NXE == 0 and PAE_paging_PTE_4KB_page_type.XD pte == 1) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  is_execute_disabled := is_execute_disabled or PAE_paging_PTE_4KB_page_type.XD pte == 1

  if (access_type == Memory_Access_Type.Memory_Execute and is_execute_disabled and (← get).IA32_EFER.NXE == 1) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  -- update access and dirty bits
  if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and PAE_paging_PDE_PT_type.A pde == 0) then
    Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

  if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
    let update_dirty_bit : Bool := not (← CPUID_CET_SS) or PAE_paging_PTE_4KB_page_type.RW pte == 1
    Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE update_dirty_bit
  else
    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and PAE_paging_PTE_4KB_page_type.A pte == 0) then
      Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE false

  let pa : Bits 64 ← concatBits (leftSize := 52) (rightSize := 12) (← concatBits (leftSize := 12) (rightSize := 40) (← Std.Bits.Zero 12) (PAE_paging_PTE_4KB_page_type.PAGE_ADDRESS pte)) (← linear.linear_address[11:0])
  let translation : Translation := ({
    size_in_bytes := linear.num_bytes,
    linear_address := linear.linear_address,
    guest_physical_address := pa,
    physical_address := pa,
    is_write_allowed := PAE_paging_PTE_4KB_page_type.RW pte == 1 and PAE_paging_PDE_PT_type.RW pde == 1,
    is_user_mode_address := PAE_paging_PTE_4KB_page_type.US pte == 1 and PAE_paging_PDE_PT_type.US pde == 1,
    is_execute_disabled := is_execute_disabled,
    is_shadow_stack_address := PAE_paging_PTE_4KB_page_type.RW pte == 0 and PAE_paging_PTE_4KB_page_type.D pte == 1 and PAE_paging_PDE_PT_type.RW pde == 1,
    is_guest_physical_address_valid := false,
    page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (PAE_paging_PTE_4KB_page_type.PAT pte) (PAE_paging_PTE_4KB_page_type.PCD pte)) (PAE_paging_PTE_4KB_page_type.PWT pte)),
    memory_type := Memory_Type.Memory_Type_Unknown
  } : Translation)
  return translation

end X86.Helpers

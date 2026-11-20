-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 54f409f2147480f1d3c27a659b17a141b0898294c53e7565d958737de0dc2b22
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_Page_Fault_Error_Code
import X86.Helpers.Check_Protection_Key_Access_Violation
import X86.Helpers.HLAT.Is_Address_Enabled
import X86.Helpers.Level_5_Or_4_Paging_PDE_2MB_Page_Type
import X86.Helpers.Level_5_Or_4_Paging_PDE_Type
import X86.Helpers.Level_5_Or_4_Paging_PDPTE_1GB_page_Type
import X86.Helpers.Level_5_Or_4_Paging_PDPTE_PD_Type
import X86.Helpers.Level_5_Or_4_Paging_PML4E_Type
import X86.Helpers.Level_5_Or_4_Paging_PTE_Type
import X86.Helpers.Level_5_Paging_PML5E_Type
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Page_AD_Bit_Update
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Physical_Mem_Read_PTW
import X86.Helpers.Report_Page_Fault
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
  [X86.HLAT_PLR_Prefix_Size.Binding σ]
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

-- Allow elaboration of the complete source body's termination proof.
set_option maxRecDepth 8192 in
-- The restart measure reads only a Boolean parameter, so preprocessing
-- the body for well-founded recursion only adds elaboration time.
set_option wf.preprocess false in
def Translate_With_5Level_Paging
    (linear : Address_Translation) (access_type : Memory_Access_Type) (is_restarted : Bool := false) :
    Runtime.SpecM Exception (State σ) (Translation) := do
  let ⟨is_hlat_translation, _enabled⟩ ← Runtime.guardedBool ((not is_restarted)) (fun () => HLAT.Is_Address_Enabled linear.linear_address)

  let pml5e_address_bits_51_12 : Bits 40 ← do
    if is_hlat_translation then
      sliceInclusive (← get).«VMCS::HLATP» 51 12
    else
      sliceInclusive (← get).CR3 51 12
  let pml5e_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) pml5e_address_bits_51_12 (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[56:48]) (← Std.Bits.Zero 3)))
  let cr3_pat : Bits 3 ← do
    if is_hlat_translation then
      concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (← «VMCS::HLATP».PCD)) (← «VMCS::HLATP».PWT)
    else
      concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (← CR3.PCD)) (← CR3.PWT)

  let pml5e : Level_5_Paging_PML5E_Type ← Physical_Mem_Read_PTW linear.linear_address pml5e_address 64 cr3_pat Paging_Level_Type.PML5E

  if (Level_5_Paging_PML5E_Type.P pml5e == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if (not (← Std.Bits.Is_Zero (size := 1) (Level_5_Paging_PML5E_Type.RESERVED pml5e)) or (← get).IA32_EFER.NXE == 0 and Level_5_Paging_PML5E_Type.XD pml5e == 1 or decide ((← Config.Read.Max_Physical_Address (exception := Exception)) < 52) and not (← (do
    let Config__Max_Physical_Address ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((52 : Int) + (- Config__Max_Physical_Address))) (← (do Runtime.assert (decide (Config__Max_Physical_Address ≤ 52)); pure (BitVec.cast (by omega) (← pml5e[51:Config__Max_Physical_Address]) : Bits ((52 : Int) + (- Config__Max_Physical_Address))))))))) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if _restart : (is_hlat_translation and Level_5_Paging_PML5E_Type.RESTART pml5e == 1) then
    return (← Translate_With_5Level_Paging linear access_type true)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Paging_PML5E_Type.A pml5e == 0) then
    Page_AD_Bit_Update linear.linear_address pml5e_address cr3_pat (← pml5e[0 +: 8]) Paging_Level_Type.PML5E false

  -- the XD bit is accumulated over all paging levels and checked once the
  -- translation is complete
  let mut is_execute_disabled : Bool := Level_5_Paging_PML5E_Type.XD pml5e == 1

  let pml4e_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (Level_5_Paging_PML5E_Type.PML4_TABLE_ADDRESS pml5e) (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[47:39]) (← Std.Bits.Zero 3)))
  let pml5e_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (Level_5_Paging_PML5E_Type.PCD pml5e)) (Level_5_Paging_PML5E_Type.PWT pml5e)

  let pml4e : Level_5_Or_4_Paging_PML4E_Type ← Physical_Mem_Read_PTW linear.linear_address pml4e_address 64 pml5e_pat Paging_Level_Type.PML4E

  if (Level_5_Or_4_Paging_PML4E_Type.P pml4e == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if (not (← Std.Bits.Is_Zero (size := 1) (Level_5_Or_4_Paging_PML4E_Type.RESERVED pml4e)) or (← get).IA32_EFER.NXE == 0 and Level_5_Or_4_Paging_PML4E_Type.XD pml4e == 1 or decide ((← Config.Read.Max_Physical_Address (exception := Exception)) < 52) and not (← (do
    let Config__Max_Physical_Address_1 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((52 : Int) + (- Config__Max_Physical_Address_1))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_1 ≤ 52)); pure (BitVec.cast (by omega) (← pml4e[51:Config__Max_Physical_Address_1]) : Bits ((52 : Int) + (- Config__Max_Physical_Address_1))))))))) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if _restart : (is_hlat_translation and Level_5_Or_4_Paging_PML4E_Type.RESTART pml4e == 1) then
    return (← Translate_With_5Level_Paging linear access_type true)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PML4E_Type.A pml4e == 0) then
    Page_AD_Bit_Update linear.linear_address pml4e_address pml5e_pat (← pml4e[0 +: 8]) Paging_Level_Type.PML4E false

  is_execute_disabled := is_execute_disabled or Level_5_Or_4_Paging_PML4E_Type.XD pml4e == 1

  let pdpte_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (Level_5_Or_4_Paging_PML4E_Type.PDPT_ADDRESS pml4e) (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[38:30]) (← Std.Bits.Zero 3)))
  let pml4e_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (Level_5_Or_4_Paging_PML4E_Type.PCD pml4e)) (Level_5_Or_4_Paging_PML4E_Type.PWT pml4e)

  let pdpte : Level_5_Or_4_Paging_PDPTE_PD_Type ← Physical_Mem_Read_PTW linear.linear_address pdpte_address 64 pml4e_pat Paging_Level_Type.PDPTE

  if (Level_5_Or_4_Paging_PDPTE_PD_Type.P pdpte == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if ((← get).IA32_EFER.NXE == 0 and Level_5_Or_4_Paging_PDPTE_PD_Type.XD pdpte == 1 or decide ((← Config.Read.Max_Physical_Address (exception := Exception)) < 52) and not (← (do
    let Config__Max_Physical_Address_2 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((52 : Int) + (- Config__Max_Physical_Address_2))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_2 ≤ 52)); pure (BitVec.cast (by omega) (← pdpte[51:Config__Max_Physical_Address_2]) : Bits ((52 : Int) + (- Config__Max_Physical_Address_2))))))))) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if _restart : (is_hlat_translation and Level_5_Or_4_Paging_PDPTE_PD_Type.RESTART pdpte == 1) then
    return (← Translate_With_5Level_Paging linear access_type true)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDPTE_PD_Type.A pdpte == 0) then
    Page_AD_Bit_Update linear.linear_address pdpte_address pml4e_pat (← pdpte[0 +: 8]) Paging_Level_Type.PDPTE false

  is_execute_disabled := is_execute_disabled or Level_5_Or_4_Paging_PDPTE_PD_Type.XD pdpte == 1

  if (Level_5_Or_4_Paging_PDPTE_PD_Type.PS pdpte == 1) then
    -- "PDPTE maps a 1-GByte page"

    let pdpte_1gb_page : Level_5_Or_4_Paging_PDPTE_1GB_page_Type := pdpte

    if (not (← Std.Bits.Is_Zero (size := 17) (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.RESERVED pdpte_1gb_page))) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
      liftM (Report_Page_Fault error_code linear.linear_address)

    let pa : Bits 64 ← concatBits (leftSize := 34) (rightSize := 30) (← concatBits (leftSize := 12) (rightSize := 22) (← Std.Bits.Zero 12) (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PAGE_ADDRESS pdpte_1gb_page)) (← linear.linear_address[29:0])
    let translation : Translation := ({
      size_in_bytes := linear.num_bytes,
      linear_address := linear.linear_address,
      guest_physical_address := pa,
      physical_address := pa,
      is_write_allowed := Level_5_Or_4_Paging_PDPTE_1GB_page_Type.RW pdpte_1gb_page == 1 and Level_5_Or_4_Paging_PML4E_Type.RW pml4e == 1 and Level_5_Paging_PML5E_Type.RW pml5e == 1,
      is_user_mode_address := Level_5_Or_4_Paging_PDPTE_1GB_page_Type.US pdpte_1gb_page == 1 and Level_5_Or_4_Paging_PML4E_Type.US pml4e == 1 and Level_5_Paging_PML5E_Type.US pml5e == 1,
      is_execute_disabled := is_execute_disabled,
      is_shadow_stack_address := Level_5_Or_4_Paging_PDPTE_1GB_page_Type.RW pdpte_1gb_page == 0 and Level_5_Or_4_Paging_PDPTE_1GB_page_Type.D pdpte_1gb_page == 1 and Level_5_Or_4_Paging_PML4E_Type.RW pml4e == 1 and Level_5_Paging_PML5E_Type.RW pml5e == 1,
      is_guest_physical_address_valid := false,
      page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PAT pdpte_1gb_page) (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PCD pdpte_1gb_page)) (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PWT pdpte_1gb_page)),
      memory_type := Memory_Type.Memory_Type_Unknown
    } : Translation)

    if (access_type == Memory_Access_Type.Memory_Execute and is_execute_disabled and (← get).IA32_EFER.NXE == 1) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
      liftM (Report_Page_Fault error_code linear.linear_address)

    Check_Protection_Key_Access_Violation linear access_type (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PROTECTION_KEY pdpte_1gb_page) translation.is_user_mode_address

    -- update access and dirty bits
    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Paging_PML5E_Type.A pml5e == 0) then
      Page_AD_Bit_Update linear.linear_address pml5e_address cr3_pat (← pml5e[0 +: 8]) Paging_Level_Type.PML5E false

    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PML4E_Type.A pml4e == 0) then
      Page_AD_Bit_Update linear.linear_address pml4e_address pml5e_pat (← pml4e[0 +: 8]) Paging_Level_Type.PML4E false

    if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
      let update_dirty_bit : Bool := not (← CPUID_CET_SS) or Level_5_Or_4_Paging_PDPTE_PD_Type.RW pdpte == 1
      Page_AD_Bit_Update linear.linear_address pdpte_address pml4e_pat (← pdpte[0 +: 8]) Paging_Level_Type.PDPTE update_dirty_bit
    else
      if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDPTE_PD_Type.A pdpte == 0) then
        Page_AD_Bit_Update linear.linear_address pdpte_address pml4e_pat (← pdpte[0 +: 8]) Paging_Level_Type.PDPTE false

    return translation

  -- "PDPTE References a Page Directory"

  -- "4-KByte naturally aligned page directory is located at the physical address"
  let pde_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (Level_5_Or_4_Paging_PDPTE_PD_Type.PAGE_DIRECTORY_ADDRESS pdpte) (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[29:21]) (← Std.Bits.Zero 3)))
  let pdpte_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (Level_5_Or_4_Paging_PDPTE_PD_Type.PCD pdpte)) (Level_5_Or_4_Paging_PDPTE_PD_Type.PWT pdpte)

  let pde : Level_5_Or_4_Paging_PDE_Type ← Physical_Mem_Read_PTW linear.linear_address pde_address 64 pdpte_pat Paging_Level_Type.PDE

  if (Level_5_Or_4_Paging_PDE_Type.P pde == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if ((← get).IA32_EFER.NXE == 0 and Level_5_Or_4_Paging_PDE_Type.XD pde == 1 or decide ((← Config.Read.Max_Physical_Address (exception := Exception)) < 52) and not (← (do
    let Config__Max_Physical_Address_3 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((52 : Int) + (- Config__Max_Physical_Address_3))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_3 ≤ 52)); pure (BitVec.cast (by omega) (← pde[51:Config__Max_Physical_Address_3]) : Bits ((52 : Int) + (- Config__Max_Physical_Address_3))))))))) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if _restart : (is_hlat_translation and Level_5_Or_4_Paging_PDE_Type.RESTART pde == 1) then
    return (← Translate_With_5Level_Paging linear access_type true)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDE_Type.A pde == 0) then
    Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

  is_execute_disabled := is_execute_disabled or Level_5_Or_4_Paging_PDE_Type.XD pde == 1

  if (Level_5_Or_4_Paging_PDE_Type.PS pde == 1) then
    -- "PDE maps a 2-MByte page"

    let pde_2mb_page : Level_5_Or_4_Paging_PDE_2MB_Page_Type := pde

    if (not (← Std.Bits.Is_Zero (size := 8) (Level_5_Or_4_Paging_PDE_2MB_Page_Type.RESERVED pde_2mb_page))) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
      liftM (Report_Page_Fault error_code linear.linear_address)

    let pa : Bits 64 ← concatBits (leftSize := 43) (rightSize := 21) (← concatBits (leftSize := 12) (rightSize := 31) (← Std.Bits.Zero 12) (Level_5_Or_4_Paging_PDE_2MB_Page_Type.PAGE_ADDRESS pde_2mb_page)) (← linear.linear_address[20:0])
    let translation : Translation := ({
      size_in_bytes := linear.num_bytes,
      linear_address := linear.linear_address,
      guest_physical_address := pa,
      physical_address := pa,
      is_write_allowed := Level_5_Or_4_Paging_PDE_2MB_Page_Type.RW pde_2mb_page == 1 and Level_5_Or_4_Paging_PDPTE_PD_Type.RW pdpte == 1 and Level_5_Or_4_Paging_PML4E_Type.RW pml4e == 1 and Level_5_Paging_PML5E_Type.RW pml5e == 1,
      is_user_mode_address := Level_5_Or_4_Paging_PDE_2MB_Page_Type.US pde_2mb_page == 1 and Level_5_Or_4_Paging_PDPTE_PD_Type.US pdpte == 1 and Level_5_Or_4_Paging_PML4E_Type.US pml4e == 1 and Level_5_Paging_PML5E_Type.US pml5e == 1,
      is_execute_disabled := is_execute_disabled,
      is_shadow_stack_address := Level_5_Or_4_Paging_PDE_2MB_Page_Type.RW pde_2mb_page == 0 and Level_5_Or_4_Paging_PDE_2MB_Page_Type.D pde_2mb_page == 1 and Level_5_Or_4_Paging_PDPTE_PD_Type.RW pdpte == 1 and Level_5_Or_4_Paging_PML4E_Type.RW pml4e == 1 and Level_5_Paging_PML5E_Type.RW pml5e == 1,
      is_guest_physical_address_valid := false,
      page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (Level_5_Or_4_Paging_PDE_2MB_Page_Type.PAT pde_2mb_page) (Level_5_Or_4_Paging_PDE_2MB_Page_Type.PCD pde_2mb_page)) (Level_5_Or_4_Paging_PDE_2MB_Page_Type.PWT pde_2mb_page)),
      memory_type := Memory_Type.Memory_Type_Unknown
    } : Translation)

    if (access_type == Memory_Access_Type.Memory_Execute and is_execute_disabled and (← get).IA32_EFER.NXE == 1) then
      let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
      liftM (Report_Page_Fault error_code linear.linear_address)

    Check_Protection_Key_Access_Violation linear access_type (Level_5_Or_4_Paging_PDE_2MB_Page_Type.PROTECTION_KEY pde_2mb_page) translation.is_user_mode_address

    -- update access and dirty bits
    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Paging_PML5E_Type.A pml5e == 0) then
      Page_AD_Bit_Update linear.linear_address pml5e_address cr3_pat (← pml5e[0 +: 8]) Paging_Level_Type.PML5E false

    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PML4E_Type.A pml4e == 0) then
      Page_AD_Bit_Update linear.linear_address pml4e_address pml5e_pat (← pml4e[0 +: 8]) Paging_Level_Type.PML4E false

    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDPTE_PD_Type.A pdpte == 0) then
      Page_AD_Bit_Update linear.linear_address pdpte_address pml4e_pat (← pdpte[0 +: 8]) Paging_Level_Type.PDPTE false

    if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
      let update_dirty_bit : Bool := not (← CPUID_CET_SS) or Level_5_Or_4_Paging_PDE_Type.RW pde == 1
      Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE update_dirty_bit
    else
      if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDE_Type.A pde == 0) then
        Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

    return translation

  -- 4-KByte naturally aligned page table is located at the physical address"
  let pte_address : Bits 64 ← concatBits (leftSize := 12) (rightSize := 52) (← Std.Bits.Zero 12) (← concatBits (leftSize := 40) (rightSize := 12) (Level_5_Or_4_Paging_PDE_Type.PAGE_TABLE_ADDRESS pde) (← concatBits (leftSize := 9) (rightSize := 3) (← linear.linear_address[20:12]) (← Std.Bits.Zero 3)))
  let pde_pat : Bits 3 ← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (Level_5_Or_4_Paging_PDE_Type.PCD pde)) (Level_5_Or_4_Paging_PDE_Type.PWT pde)

  let pte : Level_5_Or_4_Paging_PTE_Type ← Physical_Mem_Read_PTW linear.linear_address pte_address 64 pde_pat Paging_Level_Type.PTE

  if (Level_5_Or_4_Paging_PTE_Type.P pte == 0) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type true false false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if ((← get).IA32_EFER.NXE == 0 and Level_5_Or_4_Paging_PTE_Type.XD pte == 1 or decide ((← Config.Read.Max_Physical_Address (exception := Exception)) < 52) and not (← (do
    let Config__Max_Physical_Address_4 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((52 : Int) + (- Config__Max_Physical_Address_4))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_4 ≤ 52)); pure (BitVec.cast (by omega) (← pte[51:Config__Max_Physical_Address_4]) : Bits ((52 : Int) + (- Config__Max_Physical_Address_4))))))))) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false true false is_hlat_translation false
    liftM (Report_Page_Fault error_code linear.linear_address)

  if _restart : (is_hlat_translation and Level_5_Or_4_Paging_PTE_Type.RESTART pte == 1) then
    return (← Translate_With_5Level_Paging linear access_type true)

  -- update access bit
  if ((← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PTE_Type.A pte == 0) then
    Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE false

  is_execute_disabled := is_execute_disabled or Level_5_Or_4_Paging_PTE_Type.XD pte == 1

  let pa : Bits 64 ← concatBits (leftSize := 52) (rightSize := 12) (← concatBits (leftSize := 12) (rightSize := 40) (← Std.Bits.Zero 12) (Level_5_Or_4_Paging_PTE_Type.PAGE_ADDRESS pte)) (← linear.linear_address[11:0])
  let translation : Translation := ({
    size_in_bytes := linear.num_bytes,
    linear_address := linear.linear_address,
    guest_physical_address := pa,
    physical_address := pa,
    is_write_allowed := Level_5_Or_4_Paging_PTE_Type.RW pte == 1 and Level_5_Or_4_Paging_PDE_Type.RW pde == 1 and Level_5_Or_4_Paging_PDPTE_PD_Type.RW pdpte == 1 and Level_5_Or_4_Paging_PML4E_Type.RW pml4e == 1 and Level_5_Paging_PML5E_Type.RW pml5e == 1,
    is_user_mode_address := Level_5_Or_4_Paging_PTE_Type.US pte == 1 and Level_5_Or_4_Paging_PDE_Type.US pde == 1 and Level_5_Or_4_Paging_PDPTE_PD_Type.US pdpte == 1 and Level_5_Or_4_Paging_PML4E_Type.US pml4e == 1 and Level_5_Paging_PML5E_Type.US pml5e == 1,
    is_execute_disabled := is_execute_disabled,
    is_shadow_stack_address := Level_5_Or_4_Paging_PTE_Type.RW pte == 0 and Level_5_Or_4_Paging_PTE_Type.D pte == 1 and Level_5_Or_4_Paging_PDE_Type.RW pde == 1 and Level_5_Or_4_Paging_PDPTE_PD_Type.RW pdpte == 1 and Level_5_Or_4_Paging_PML4E_Type.RW pml4e == 1 and Level_5_Paging_PML5E_Type.RW pml5e == 1,
    is_guest_physical_address_valid := false,
    page_pat_pcd_pwt := (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (Level_5_Or_4_Paging_PTE_Type.PAT pte) (Level_5_Or_4_Paging_PTE_Type.PCD pte)) (Level_5_Or_4_Paging_PTE_Type.PWT pte)),
    memory_type := Memory_Type.Memory_Type_Unknown
  } : Translation)

  if (access_type == Memory_Access_Type.Memory_Execute and is_execute_disabled and (← get).IA32_EFER.NXE == 1) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  Check_Protection_Key_Access_Violation linear access_type (Level_5_Or_4_Paging_PTE_Type.PROTECTION_KEY pte) translation.is_user_mode_address

  -- update access and dirty bits
  if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Paging_PML5E_Type.A pml5e == 0) then
    Page_AD_Bit_Update linear.linear_address pml5e_address cr3_pat (← pml5e[0 +: 8]) Paging_Level_Type.PML5E false

  if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PML4E_Type.A pml4e == 0) then
    Page_AD_Bit_Update linear.linear_address pml4e_address pml5e_pat (← pml4e[0 +: 8]) Paging_Level_Type.PML4E false

  if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDPTE_PD_Type.A pdpte == 0) then
    Page_AD_Bit_Update linear.linear_address pdpte_address pml4e_pat (← pdpte[0 +: 8]) Paging_Level_Type.PDPTE false

  if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PDE_Type.A pde == 0) then
    Page_AD_Bit_Update linear.linear_address pde_address pdpte_pat (← pde[0 +: 8]) Paging_Level_Type.PDE false

  if ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)) then
    let update_dirty_bit : Bool := not (← CPUID_CET_SS) or Level_5_Or_4_Paging_PTE_Type.RW pte == 1
    Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE update_dirty_bit
  else
    if (not (← Config.Read.Feature_Early_Page_Access_Bit_Update (exception := Exception)) and Level_5_Or_4_Paging_PTE_Type.A pte == 0) then
      Page_AD_Bit_Update linear.linear_address pte_address pde_pat (← pte[0 +: 8]) Paging_Level_Type.PTE false

  return translation

termination_by if is_restarted then 0 else 1
decreasing_by
  all_goals
    change (is_hlat_translation && _) = true at _restart
    have h := _enabled (Bool.and_eq_true_iff.mp _restart).1
    cases is_restarted <;> simp_all

end X86.Helpers

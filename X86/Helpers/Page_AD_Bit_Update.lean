-- Generated from data/definitions.xml.gz: Page_AD_Bit_Update; do not edit.
-- Source SHA256: 5fd3089c3073b3d6e040fcf50041319745dca1e018af122fc466ea704f4568f1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Page_AD_Bit_Update)
import X86.Runtime
import X86.Helpers.AD_Assist_Byte
import X86.Helpers.Check_Bus_Lock_Trap
import X86.Helpers.Check_Split_Lock
import X86.Helpers.Check_UC_Lock
import X86.Helpers.EPT.Translate
import X86.Helpers.Get_Memory_Type
import X86.Helpers.Is_EPT_Enabled
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Physical_Mem_Write_PTW
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

def Page_AD_Bit_Update
    (la pa : Bits 64) (pat : Bits 3) (value : Bits 8) (level : Paging_Level_Type) (update_D_bit : Bool := false) :
    Runtime.SpecM Exception (State σ) Unit := do
  let mut data : AD_Assist_Byte := value
  let mut physical_address : Bits 64 := pa

  if (AD_Assist_Byte.A data == 1 and (AD_Assist_Byte.D data == 1 or not update_D_bit)) then
    return ()

  data := AD_Assist_Byte.setA data (1 : Runtime.Bit)

  if (update_D_bit and AD_Assist_Byte.D data == 0) then
    data := AD_Assist_Byte.setD data (1 : Runtime.Bit)

  if (← Is_EPT_Enabled) then
    let mut ptw_translation : Translation := ({
      size_in_bytes := 1,
      linear_address := la,
      guest_physical_address := pa,
      physical_address := pa,
      is_write_allowed := false,
      is_user_mode_address := false,
      is_execute_disabled := false,
      is_shadow_stack_address := false,
      is_guest_physical_address_valid := true,
      page_pat_pcd_pwt := pat,
      memory_type := Memory_Type.Memory_Type_Unknown
    } : Translation)

    ptw_translation := (← EPT.Translate ptw_translation Memory_Access_Type.Memory_Write true Paging_Level_Type.Paging_Level_Unknown)
    physical_address := ptw_translation.physical_address

  let memory_type : Memory_Type ← Runtime.liftNoSourceException (Get_Memory_Type physical_address pat)
  Physical_Mem_Write_PTW physical_address memory_type level data

  Check_UC_Lock memory_type
  Check_Split_Lock physical_address 64
  Check_Bus_Lock_Trap physical_address 64 memory_type

end X86.Helpers

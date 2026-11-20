-- Generated from data/definitions.xml.gz: Translate; do not edit.
-- Source SHA256: d69684f4335405ec15ea8fe39b8f51146b49fddfc935a14cd2e8b030c5e760db
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Translate)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_Page_Fault_Error_Code
import X86.Helpers.Check_Access_Rights_Permission
import X86.Helpers.EPT.Translate
import X86.Helpers.Get_Memory_Type
import X86.Helpers.Is_EPT_Enabled
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Report_Page_Fault
import X86.Helpers.Translate_With_32Bit_Paging
import X86.Helpers.Translate_With_4Level_Paging
import X86.Helpers.Translate_With_5Level_Paging
import X86.Helpers.Translate_With_PAE_Paging
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

def Translate
    (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Translation) := do
  let mut translation : Translation ← do
    if (← CR4.PAE) == 0 then
      let translation : Translation ← Translate_With_32Bit_Paging linear access_type
      pure translation
    else
      if (← get).IA32_EFER.LME == 0 then
        let translation : Translation ← Translate_With_PAE_Paging linear access_type
        pure translation
      else
        if (← CR4.LA57) == 0 then
          let translation : Translation ← Translate_With_4Level_Paging linear access_type false
          pure translation
        else
          let translation : Translation ← Translate_With_5Level_Paging linear access_type false
          pure translation

  if (linear.is_shadow_stack_access and not translation.is_shadow_stack_address) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

  Check_Access_Rights_Permission translation linear access_type

  if (← Is_EPT_Enabled) then
    translation := (← EPT.Translate translation access_type false Paging_Level_Type.Paging_Level_Unknown)

  translation := { translation with memory_type := (← Runtime.liftNoSourceException (Get_Memory_Type translation.physical_address translation.page_pat_pcd_pwt)) }

  return translation

end X86.Helpers

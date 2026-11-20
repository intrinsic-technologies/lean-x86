-- Generated from data/definitions.xml.gz: Calculate_Page_Fault_Error_Code; do not edit.
-- Source SHA256: 6fc0fe5991d12f637017621ff7e5276c2c6c6672350067f79c6798e49c9f6bad
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Calculate_Page_Fault_Error_Code)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Is_User_Mode_Access
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Calculate_Page_Fault_Error_Code
    (access : Address_Translation) (access_type : Memory_Access_Type) (is_page_not_present : Bool := false) (is_rsvd_bit_set : Bool := false) (is_protection_key_violation : Bool := false) (is_hlat_terminal_fault : Bool := false) (is_sgx_violation : Bool := false) :
    Runtime.SpecM Exception (State σ) (Page_Fault_Error_Code) := do
  let mut error_code : Page_Fault_Error_Code ← Std.Bits.Zero 32

  error_code := Page_Fault_Error_Code.setP error_code (if is_page_not_present then (0 : Runtime.Bit) else (1 : Runtime.Bit))
  error_code := Page_Fault_Error_Code.setW_R error_code (← Bit ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write)))
  error_code := Page_Fault_Error_Code.setU_S error_code (← Bit (← Is_User_Mode_Access access))
  error_code := Page_Fault_Error_Code.setRSVD error_code (← Bit is_rsvd_bit_set)

  if (access_type == Memory_Access_Type.Memory_Execute) then
    if ((← CR4.SMEP) == 1 or (← CR4.PAE) == 1 and (← get).IA32_EFER.NXE == 1) then
      error_code := Page_Fault_Error_Code.setI_D error_code (1 : Runtime.Bit)

  error_code := Page_Fault_Error_Code.setPK error_code (← Bit is_protection_key_violation)
  error_code := Page_Fault_Error_Code.setSS error_code (← Bit access.is_shadow_stack_access)
  error_code := Page_Fault_Error_Code.setHLAT error_code (← Bit is_hlat_terminal_fault)
  error_code := Page_Fault_Error_Code.setSGX error_code (← Bit is_sgx_violation)

  return error_code

end X86.Helpers

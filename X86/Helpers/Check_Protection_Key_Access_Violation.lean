-- Generated from data/definitions.xml.gz: Check_Protection_Key_Access_Violation; do not edit.
-- Source SHA256: 1ed3fefc81596f8aa5db8bbd841fdafdb23d8970881f8cb1045abd49d12b3b8d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Protection_Key_Access_Violation)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_Page_Fault_Error_Code
import X86.Helpers.Is_User_Mode_Access
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Report_Page_Fault
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Check_Protection_Key_Access_Violation
    (linear : Address_Translation) (access_type : Memory_Access_Type) (protection_key : Bits 4) (is_user_mode_address : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (access_type == Memory_Access_Type.Memory_Execute) then
    return ()

  let (enabled, reg) ← do
    if is_user_mode_address then
      pure ((← CR4.PKE), (← Std.Bits.Zero_Extend (source_size := 32) (← get).PKRU 64))
    else
      pure ((← CR4.PKS), (← get).IA32_PKRS)

  if (enabled == 0) then
    return ()

  Runtime.assert (decide (Unsigned protection_key ≤ 15))

  let access_disable_bit : Int := Unsigned protection_key * 2
  let write_disable_bit : Int := Unsigned protection_key * 2 + 1

  let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false true false false

  if ((← reg[access_disable_bit +: 1]) == 1) then
    liftM (Report_Page_Fault error_code linear.linear_address)

  if ((← reg[write_disable_bit +: 1]) == 1 and ((access_type == Memory_Access_Type.Memory_Write) || (access_type == Memory_Access_Type.Memory_Read_Modify_Write))) then
    if (← Is_User_Mode_Access linear) then
      liftM (Report_Page_Fault error_code linear.linear_address)
    else
      if ((← CR0.WP) == 1) then
        liftM (Report_Page_Fault error_code linear.linear_address)

end X86.Helpers

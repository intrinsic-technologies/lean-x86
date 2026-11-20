-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 83aafc366cd2754f337f7234aa68aa729b9b40b548ee20b8ff0761aa1763db73
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_Page_Fault_Error_Code
import X86.Helpers.Check_Supervisor_Mode_Access_Permission
import X86.Helpers.Check_User_Mode_Access_Permission
import X86.Helpers.Is_User_Mode_Access
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Page_Fault_Error_Code
import X86.Helpers.Report_Page_Fault
import X86.Helpers.Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Check_Access_Rights_Permission
    (translation : Translation) (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) Unit := do
  let permitted : Bool ← do
    if (← Is_User_Mode_Access linear) then
      Check_User_Mode_Access_Permission translation linear access_type
    else
      Check_Supervisor_Mode_Access_Permission translation linear access_type
  if (not permitted) then
    let error_code : Page_Fault_Error_Code ← Calculate_Page_Fault_Error_Code linear access_type false false false false false
    liftM (Report_Page_Fault error_code linear.linear_address)

end X86.Helpers

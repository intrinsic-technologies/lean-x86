-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 819bd48bb6d37bd5d826cdadf4be5cb25010fb71b58455e8e999d647b2ff9b94
import X86.Runtime
import X86.Helpers.EPT_Entries_Combined_Access_Permissions_Type
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]

def EPT.Is_Access_Violation
    (access_type : Memory_Access_Type) (translation : Translation) (is_page_ad_bit_update : Bool) (ept_access_permissions : EPT_Entries_Combined_Access_Permissions_Type) (is_ept_non_leaf_write_permission is_ept_paging_write : Bool) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let mut _is_access_violation : Bool := false

  let is_ept_write_access_permission : Bool ← do
    if (← VM_Exec_Controls3).EPT_Paging_Write_Control == 1 and is_page_ad_bit_update and (← «VMCS::EPTP».Enable_EPT_Accessed_And_Dirty_Flags) == 1 and is_ept_non_leaf_write_permission and is_ept_paging_write then
      let is_ept_write_access_permission : Bool := true
      pure is_ept_write_access_permission
    else
      let is_ept_write_access_permission : Bool := EPT_Entries_Combined_Access_Permissions_Type.WRITE ept_access_permissions == 1
      pure is_ept_write_access_permission

  match access_type with
  | Memory_Access_Type.Memory_Read => do
    if (EPT_Entries_Combined_Access_Permissions_Type.READ ept_access_permissions == 0) then
      return true
  | Memory_Access_Type.Memory_Write => do
    if (not is_ept_write_access_permission) then
      return true
  | Memory_Access_Type.Memory_Read_Modify_Write => do
    if (EPT_Entries_Combined_Access_Permissions_Type.READ ept_access_permissions == 0 or EPT_Entries_Combined_Access_Permissions_Type.WRITE ept_access_permissions == 0) then
      return true
  | Memory_Access_Type.Memory_Execute => do
    if ((← VM_Exec_Controls2).Mode_Based_Execute_Control_For_EPT == 0) then
      if (EPT_Entries_Combined_Access_Permissions_Type.EXECUTE_SUPERVISOR ept_access_permissions == 0) then
        return true
    else
      if (not translation.is_user_mode_address and EPT_Entries_Combined_Access_Permissions_Type.EXECUTE_SUPERVISOR ept_access_permissions == 0) then
        return true
      else
        if (translation.is_user_mode_address and EPT_Entries_Combined_Access_Permissions_Type.EXECUTE_USER ept_access_permissions == 0) then
          return true

  return false

end X86.Helpers

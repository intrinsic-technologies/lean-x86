-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 94a99563e85dfe579f03d300074764ad89399329a0c01d5fab6130876ae6e621
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Check_User_Mode_Access_Permission
    (translation : Translation) (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if linear.is_shadow_stack_access then
    -- User-mode shadow-stack accesses made outside enclave mode are allowed only to user-mode
    -- shadow-stack addresses.  User-mode shadow-stack accesses made in enclave
    -- mode are treated like ordinary data accesses
    if (not translation.is_user_mode_address or not translation.is_shadow_stack_address) then
      return false

    return true

  match access_type with
  | Memory_Access_Type.Memory_Read => do
    if (not translation.is_user_mode_address) then
      return false
  | Memory_Access_Type.Memory_Write | Memory_Access_Type.Memory_Read_Modify_Write => do
    if (not translation.is_user_mode_address or not translation.is_write_allowed) then
      return false
  | Memory_Access_Type.Memory_Execute => do
    if (not translation.is_user_mode_address or (← get).IA32_EFER.NXE == 1 and translation.is_execute_disabled) then
      return false
  return true

end X86.Helpers

-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 338b8de896f9cee63f3eb731a77c14bb7dad5de214655e91b6b9e96b4165f0e8
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

def Check_Supervisor_Mode_Access_Permission
    (translation : Translation) (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if linear.is_shadow_stack_access then
    -- Supervisor-mode shadow-stack accesses are allowed
    -- only to supervisor-mode shadow-stack addresses
    if (not translation.is_shadow_stack_address) then
      return false

    if (translation.is_user_mode_address and (linear.translation_cpl != 3 or not linear.is_implicit_supervisor_mode_access)) then
      return false
  else
    match access_type with
    | Memory_Access_Type.Memory_Read => do
      if (translation.is_user_mode_address and (← CR4.SMAP) == 1) then
        if ((← RFLAGS.AC) == 0 or linear.is_implicit_supervisor_mode_access) then
          return false
    | Memory_Access_Type.Memory_Write | Memory_Access_Type.Memory_Read_Modify_Write => do
      if (not translation.is_user_mode_address) then
        if ((← CR0.WP) == 1 and not translation.is_write_allowed) then
          return false
      else
        -- SMAP: with CR4.SMAP = 1 a supervisor-mode write to a user-mode address is
        -- permitted only for an explicit access with RFLAGS.AC = 1; implicit
        -- supervisor-mode accesses are treated as if RFLAGS.AC = 0 (SDM Vol. 3, 4.6.1)
        if ((← CR0.WP) == 0) then
          if ((← CR4.SMAP) == 1) then
            if ((← RFLAGS.AC) == 0 or linear.is_implicit_supervisor_mode_access) then
              return false
        else
          if ((← CR4.SMAP) == 0) then
            if (not translation.is_write_allowed) then
              return false
          else
            if ((← RFLAGS.AC) == 1 and not linear.is_implicit_supervisor_mode_access) then
              if (not translation.is_write_allowed) then
                return false
            else
              return false
    | Memory_Access_Type.Memory_Execute => do
      if (not translation.is_user_mode_address) then
        if ((← get).IA32_EFER.NXE == 1 and translation.is_execute_disabled) then
          return false
      else
        if ((← CR4.SMEP) == 0) then
          if ((← get).IA32_EFER.NXE == 1 and translation.is_execute_disabled) then
            return false
        else
          -- SMEP: supervisor-mode instruction fetches from user-mode addresses
          -- are never allowed
          return false
  return true

end X86.Helpers

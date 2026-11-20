-- Generated from data/definitions.xml.gz: Create_Translation; do not edit.
-- Source SHA256: 6b61522cb12e7c42ad895120254793e6bf8a8400a7101f084606375e38da69d9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Create_Translation)
import X86.Runtime
import X86.Helpers.Memory_Type
import X86.Helpers.Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Create_Translation
    (la : Bits 64) (pa : Bits 64) (memory_type : Memory_Type := Memory_Type.Memory_Type_Unknown) :
    Runtime.SpecM Exception (State σ) (Translation) := do
  return ({
    size_in_bytes := 0,
    linear_address := la,
    guest_physical_address := (← UNSPECIFIED (size := 64)),
    physical_address := pa,
    is_write_allowed := (← UNSPECIFIED (size := 1)).getLsbD 0,
    is_user_mode_address := (← UNSPECIFIED (size := 1)).getLsbD 0,
    is_execute_disabled := (← UNSPECIFIED (size := 1)).getLsbD 0,
    is_shadow_stack_address := (← UNSPECIFIED (size := 1)).getLsbD 0,
    is_guest_physical_address_valid := (← UNSPECIFIED (size := 1)).getLsbD 0,
    page_pat_pcd_pwt := (← UNSPECIFIED (size := 3)),
    memory_type := memory_type
  } : Translation)

end X86.Helpers

-- Generated from data/definitions.xml.gz: Translation; do not edit.
-- Source SHA256: 52d2ee31f3569e01a540b50dd32d85c5caca1a5efd4f100dbbf3264b39bce1b3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Translation)
import X86.Runtime
import X86.Helpers.Memory_Type

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure Translation where
  size_in_bytes : Int
  linear_address : Bits 64
  guest_physical_address : Bits 64
  physical_address : Bits 64
  is_write_allowed : Bool
  is_user_mode_address : Bool
  is_execute_disabled : Bool
  is_shadow_stack_address : Bool
  is_guest_physical_address_valid : Bool
  page_pat_pcd_pwt : Bits 3
  memory_type : Memory_Type
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

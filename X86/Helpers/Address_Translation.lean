-- Generated from data/definitions.xml.gz: Address_Translation; do not edit.
-- Source SHA256: 8402488d344e1612a8aa2026b417d0841270450b26e7f5ecf8ad9b7f793f54a9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Address_Translation)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Translation

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure Address_Translation where
  num_bytes : Int
  segment : Segment
  offset : Bits 64
  linear_address : Bits 64
  is_implicit_supervisor_mode_access : Bool
  is_shadow_stack_access : Bool
  translation_cpl : Int
  is_split_access : Bool
  translation1 : Translation
  translation2 : Translation
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

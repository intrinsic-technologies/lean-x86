-- Generated from data/definitions.xml.gz: Create_Logical_Address; do not edit.
-- Source SHA256: 466e48671c2761abed8980dd58c9c7cd70d4d524dfc88bea441980896fc97923
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Create_Logical_Address)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Translation
import X86.Helpers.Memory_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Create_Logical_Address
    (segment : Segment) (offset : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) (Address_Translation) := do
  Runtime.assert (decide (size > 0))
  Runtime.assert ((← Std.Integer.Positive_Remainder size 8) == 0)
  return ({
    num_bytes := (← Std.Integer.Positive_Divide size 8),
    segment := segment,
    offset := offset,
    linear_address := (← UNSPECIFIED (size := 64)),
    is_implicit_supervisor_mode_access := false,
    is_shadow_stack_access := false,
    translation_cpl := (← get).CPL,
    is_split_access := false,
    translation1 := (← Create_Translation (← UNSPECIFIED (size := 64)) (← UNSPECIFIED (size := 64)) Memory_Type.Memory_Type_Unknown),
    translation2 := (← Create_Translation (← UNSPECIFIED (size := 64)) (← UNSPECIFIED (size := 64)) Memory_Type.Memory_Type_Unknown)
  } : Address_Translation)

end X86.Helpers

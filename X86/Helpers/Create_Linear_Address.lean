-- Generated from data/definitions.xml.gz: Create_Linear_Address; do not edit.
-- Source SHA256: f5906576c7facbc2f45257110abb2aab39e1cf4a5c29e4c40e1cfed12915d85b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Create_Linear_Address)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Translation
import X86.Helpers.Memory_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Create_Linear_Address
    (linear_address : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) (Address_Translation) := do
  Runtime.assert ((← Std.Integer.Positive_Remainder size 8) == 0)

  return ({
    num_bytes := (← Std.Integer.Positive_Divide size 8),
    segment := (← Null_Segment (← get).DS),
    offset := (← UNSPECIFIED (size := 64)),
    linear_address := (← (do if (← get).IA32_EFER.LMA == 1 then pure linear_address else pure (← Std.Bits.Zero_Extend (source_size := 32) (← linear_address[0 +: 32]) 64))),
    is_implicit_supervisor_mode_access := false,
    is_shadow_stack_access := false,
    translation_cpl := (← get).CPL,
    is_split_access := false,
    translation1 := (← Create_Translation linear_address (← UNSPECIFIED (size := 64)) Memory_Type.Memory_Type_Unknown),
    translation2 := (← Create_Translation linear_address (← UNSPECIFIED (size := 64)) Memory_Type.Memory_Type_Unknown)
  } : Address_Translation)

end X86.Helpers

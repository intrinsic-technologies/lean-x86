-- Generated from data/definitions.xml.gz: Create_Physical_Address; do not edit.
-- Source SHA256: 2ebfd86aad321a1ddecf29c55d9ad8f31ded6a7024957b115701235ce956b4c7
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Create_Physical_Address)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Translation
import X86.Helpers.Memory_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Create_Physical_Address
    (physical_address : Bits 64) (size : Int) (memory_type : Memory_Type := Memory_Type.Memory_Type_Unknown) :
    Runtime.SpecM Exception (State σ) (Address_Translation) := do
  Runtime.assert ((size == (8 : Int)) || (size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)) || (size == (128 : Int)) || (size == (256 : Int)) || (size == (384 : Int)) || (size == (512 : Int)) || (size == (1024 : Int)))

  return ({
    num_bytes := (← Std.Integer.Positive_Divide size 8),
    segment := (← Null_Segment (← get).DS),
    offset := (← UNSPECIFIED (size := 64)),
    linear_address := (← UNSPECIFIED (size := 64)),
    is_implicit_supervisor_mode_access := false,
    is_shadow_stack_access := false,
    translation_cpl := (← get).CPL,
    is_split_access := false,
    translation1 := (← Create_Translation (← UNSPECIFIED (size := 64)) physical_address memory_type),
    translation2 := (← Create_Translation (← UNSPECIFIED (size := 64)) (← UNSPECIFIED (size := 64)) Memory_Type.Memory_Type_Unknown)
  } : Address_Translation)

end X86.Helpers

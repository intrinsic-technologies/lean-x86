-- Generated from data/definitions.xml.gz: Check_Logical_Address_Is_Readable; do not edit.
-- Source SHA256: 15fc25c53efa63e454fafdfd1f900a4b3dce1a2005ac326889840f84dbe7c45e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Logical_Address_Is_Readable)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Read_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Check_Logical_Address_Is_Readable
    (segment : Segment) (offset : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Check_Read_Permission segment

  Runtime.assert (decide (size > 0))
  Runtime.assert ((← Std.Integer.Positive_Remainder size 8) == 0)
  let logical : Address_Translation ← Create_Logical_Address segment offset size
  let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Normal_Alignment (← get).CS false
  let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Read

end X86.Helpers

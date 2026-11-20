-- Generated from data/definitions.xml.gz: Is_Task_Segment; do not edit.
-- Source SHA256: ce416d8a4832781af12839644aa53796a1695b9d89744919cf5c384e8cb14127
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Task_Segment)
import X86.Runtime
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Segment
import X86.Helpers.Segment_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Task_Segment (segment : Segment) : Except (Runtime.Error Empty) (Bool) := do
  let seg_type : Segment_Type ← Get_Segment_Type segment
  return ((seg_type == Segment_Type.System_Task_Gate) || (seg_type == Segment_Type.System_16Bit_TSS_Available) || (seg_type == Segment_Type.System16Bit_TSS_Busy) || (seg_type == Segment_Type.System_TSS_Available) || (seg_type == Segment_Type.System_TSS_Busy))

end X86.Helpers

-- Generated from data/definitions.xml.gz: Is_16Bit_Task; do not edit.
-- Source SHA256: 73c7198a711799ccf8a9a23197ae8adcc80c8b3c2f98169cf14d96965aa904f5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_16Bit_Task)
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

def Is_16Bit_Task (task : Segment) : Except (Runtime.Error Empty) (Bool) := do
  let seg_type : Segment_Type ← Get_Segment_Type task
  return ((seg_type == Segment_Type.System_16Bit_TSS_Available) || (seg_type == Segment_Type.System16Bit_TSS_Busy))

end X86.Helpers

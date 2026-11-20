-- Generated from data/definitions.xml.gz: Check_Segment_Limit; do not edit.
-- Source SHA256: aa371144f36e245ab391925de3d857296e771d7e1e0c89314e204a5ea669b335
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Segment_Limit)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Is_Segment_Limit_Violation
import X86.Helpers.Is_System_Segment
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Type
import X86.Helpers.Std.Unreachable
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Check_Segment_Limit
    (segment : Segment) (offset : Bits 64) (num_bytes : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (← Is_Segment_Limit_Violation segment offset num_bytes) then
    let seg_type : Segment_Type ← Get_Segment_Type segment

    if ((seg_type == Segment_Type.System_16Bit_TSS_Available) || (seg_type == Segment_Type.System16Bit_TSS_Busy) || (seg_type == Segment_Type.System_TSS_Available) || (seg_type == Segment_Type.System_TSS_Busy)) then
      liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector segment.selector))
    else
      if (← Is_System_Segment segment) then
        Std.Unreachable
      else
        if (← Runtime.readInitialized segment.is_stack) then
          liftM (Report_Stack_Fault (← get).Default_Error_Code)
        else
          liftM (Report_General_Protection_Exception (← get).Default_Error_Code)

end X86.Helpers

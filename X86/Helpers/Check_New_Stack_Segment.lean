-- Generated from data/definitions.xml.gz: Check_New_Stack_Segment; do not edit.
-- Source SHA256: 691b975f2acb48b6e874d1394c1fbf74e88fe4da1e06d134283a0ee6f451d657
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_New_Stack_Segment)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Check_New_Stack_Segment (segment : Segment) (cpl : Int) : Result Unit := do
  Runtime.assert (cpl in {0..3})

  Runtime.assert (← Runtime.readInitialized segment.is_stack)

  if (not (← Is_Null_Segment_Selector segment.selector)) then
    -- stack segment register can only be loaded with a readable data segment
    if (not (← Is_Data_Segment segment) or (← Segment_Descriptor.R.partial segment.descriptor) == 0) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector segment.selector))

    if (Unsigned (← Segment_Descriptor.DPL.partial segment.descriptor) != cpl) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector segment.selector))

    if ((← Segment_Descriptor.P.partial segment.descriptor) == 0) then
      liftM (Report_Stack_Fault (← Get_Error_Code_From_Selector segment.selector))

end X86.Helpers

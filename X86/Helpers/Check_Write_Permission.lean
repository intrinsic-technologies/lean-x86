-- Generated from data/definitions.xml.gz: Check_Write_Permission; do not edit.
-- Source SHA256: 5c09fc8abc5010d6022c36c6f24a938c2ed449a53addbdadbca85cd6c76da8cd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Write_Permission)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Code_Segment
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Check_Write_Permission (segment : Segment) : Runtime.SpecM Exception (State σ) Unit := do
  if (not (← In_64Bit_Mode)) then
    -- code segments are writable in Real mode
    if ((← Is_Code_Segment segment) and (← Current_Mode) != Execution_Mode.Real_Address_Mode) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
    else
      if ((← Is_Data_Segment segment) and (← Segment_Descriptor.R.partial segment.descriptor) == 0) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

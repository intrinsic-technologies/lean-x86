-- Generated from data/definitions.xml.gz: Check_Read_Permission; do not edit.
-- Source SHA256: 31b4972c8ddabfab7c884eb167e4d3a09b2f91c2e11bd7aa865f71d1d3cb14dc
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Read_Permission)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Code_Segment
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

def Check_Read_Permission (segment : Segment) : Runtime.SpecM Exception (State σ) Unit := do
  if (not (← In_64Bit_Mode)) then
    if ((← Is_Code_Segment segment) and (← Segment_Descriptor.R.partial segment.descriptor) == 0) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

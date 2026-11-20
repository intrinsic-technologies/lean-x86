-- Generated from data/definitions.xml.gz: Get_Segment_Limit; do not edit.
-- Source SHA256: 412acba9dd2f7515b6d0c0ee2b5434dba54e0131560fda679b20ab080dcf3ea1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Segment_Limit)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Std.Bits.All_Ones
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Segment_Limit (segment : Segment) : Except (Runtime.Error Empty) (Int) := do
  if ((← Segment_Descriptor.G.partial segment.descriptor) == 1) then
    return Unsigned (← concatBits (leftSize := 20) (rightSize := 12) (← Segment_Descriptor.Limit.partial segment.descriptor) (← Std.Bits.All_Ones 12))
  else
    return Unsigned (← Segment_Descriptor.Limit.partial segment.descriptor)

end X86.Helpers

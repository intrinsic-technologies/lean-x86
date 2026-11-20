-- Generated from data/definitions.xml.gz: Null_Segment; do not edit.
-- Source SHA256: 677b74182c29659f70ae5737722712251c7dd75de14d1cf69e8ca40c8498d93d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Null_Segment)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Null_Segment (segment : Segment) : Except (Runtime.Error Empty) (Segment) := do
  let new_segment : Segment := ({
    selector := (← Std.Bits.Zero 16),
    descriptor := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64),
    descriptor_high := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64),
    descriptor_valid := some false,
    is_stack := segment.is_stack,
    is_code := segment.is_code,
    is_64bit_mode_data_segment := segment.is_64bit_mode_data_segment
  } : Segment)
  return new_segment

end X86.Helpers

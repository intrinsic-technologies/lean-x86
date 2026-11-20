-- Generated from data/definitions.xml.gz: Get_Init_Segment_Value; do not edit.
-- Source SHA256: bce2b3fbaeebe10a188ea37f495b398a5b8176e647f53c0d9d5196c1fc1c8a97
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Init_Segment_Value)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Init_Segment_Value  : Except (Runtime.Error Empty) (Segment) := do
  let mut segment : Segment := ({
    selector := (← Std.Bits.Zero 16),
    descriptor := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64),
    descriptor_high := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64),
    descriptor_valid := some false,
    is_stack := some false,
    is_code := some false,
    is_64bit_mode_data_segment := some false
  } : Segment)

  segment := { segment with selector := (← Std.Bits.Zero 16) }
  segment := { segment with descriptor := (← Segment_Descriptor.setLimit.partial segment.descriptor (65535 : Bits 20)) }
  segment := { segment with descriptor := (← Segment_Descriptor.setA.partial segment.descriptor (1 : Runtime.Bit)) }
  segment := { segment with descriptor := (← Segment_Descriptor.setR.partial segment.descriptor (1 : Runtime.Bit)) }
  segment := { segment with descriptor := (← Segment_Descriptor.setS.partial segment.descriptor (1 : Runtime.Bit)) }
  segment := { segment with descriptor := (← Segment_Descriptor.setP.partial segment.descriptor (1 : Runtime.Bit)) }
  segment := { segment with descriptor_valid := some true }

  return segment

end X86.Helpers

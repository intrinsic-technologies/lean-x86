-- Generated from data/definitions.xml.gz: Load_Real_Or_VM86_Segment; do not edit.
-- Source SHA256: 032097808798c3ac1ff743f78be5beca3c2182813b1155d464d28dd090183837
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_Real_Or_VM86_Segment)
import X86.Runtime
import X86.Helpers.Execution_Mode
import X86.Helpers.Segment
import X86.Helpers.Set_Segment_Base
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Load_Real_Or_VM86_Segment
    (mode : Execution_Mode) (segment_selector : Bits 16) (segment : Segment) :
    Except (Runtime.Error Empty) (Segment) := do
  Runtime.assert ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode))

  let mut new_segment : Segment := segment
  new_segment := { new_segment with selector := segment_selector }
  new_segment := (← Set_Segment_Base (← Std.Bits.Zero_Extend (source_size := 20) (← concatBits (leftSize := 16) (rightSize := 4) segment_selector (← Std.Bits.Zero 4)) 64) new_segment)
  new_segment := { new_segment with descriptor_valid := some true }

  -- real mode segment loads only change the base and selector
  if (mode == Execution_Mode.Virtual_8086_Mode) then
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setLimit.partial new_segment.descriptor (65535 : Bits 20)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setType.partial new_segment.descriptor (3 : Bits 4)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setS.partial new_segment.descriptor (1 : Runtime.Bit)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setDPL.partial new_segment.descriptor (3 : Bits 2)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setP.partial new_segment.descriptor (1 : Runtime.Bit)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setAVL.partial new_segment.descriptor (0 : Runtime.Bit)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setL.partial new_segment.descriptor (0 : Runtime.Bit)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setD.partial new_segment.descriptor (0 : Runtime.Bit)) }
    new_segment := { new_segment with descriptor := (← Segment_Descriptor.setG.partial new_segment.descriptor (0 : Runtime.Bit)) }

  return new_segment

end X86.Helpers

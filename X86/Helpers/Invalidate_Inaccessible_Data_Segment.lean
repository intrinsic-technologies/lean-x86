-- Generated from data/definitions.xml.gz: Invalidate_Inaccessible_Data_Segment; do not edit.
-- Source SHA256: 455392cb9f2f27afcb805e9f092939aec7c4bf080c6a5262641f19b24e65939e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Invalidate_Inaccessible_Data_Segment)
import X86.Runtime
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Null_Segment
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Invalidate_Inaccessible_Data_Segment
    (new_cpl : Bits 2) (segment : Segment) :
    Except (Runtime.Error Empty) (Segment) := do
  return (← (do if not (← Runtime.readInitialized segment.descriptor_valid) then pure (← Null_Segment segment) else pure (← (do if decide (Unsigned (← Segment_Descriptor.DPL.partial segment.descriptor) < Unsigned new_cpl) and ((← Is_Data_Segment segment) or (← Is_Non_Conforming_Code_Segment segment)) then pure (← Null_Segment segment) else pure segment))))

end X86.Helpers

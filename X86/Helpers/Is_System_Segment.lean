-- Generated from data/definitions.xml.gz: Is_System_Segment; do not edit.
-- Source SHA256: c7c2558b7a1a0d5b5b32d6949109c55712ff3817bc142ee6afe449fef79d9571
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_System_Segment)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_System_Segment (segment : Segment) : Except (Runtime.Error Empty) (Bool) := do
  return (← (do
    let operand := some ((← Segment_Descriptor.S.partial segment.descriptor) == 0)
    let operand_1 := segment.descriptor_valid
    let value ← Runtime.readInitialized operand
    let value_1 ← Runtime.readInitialized operand_1
    pure (value and value_1)))

end X86.Helpers

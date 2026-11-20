-- Generated from data/definitions.xml.gz: Get_Effective_Segment; do not edit.
-- Source SHA256: 1d094cb480396394ef963dd4e47102aecde778725d29aa0857743c018ea746db
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Effective_Segment)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Effective_Segment
    (context : Instruction_Context) (ea_segment : Segment) :
    Except (Runtime.Error Empty) (Segment) := do
  return (← (do if context.seg_prefix_present then pure context.segment else pure (← (do if context.is_mode64 then pure (← Null_Segment ea_segment) else pure ea_segment))))

end X86.Helpers

-- Generated from data/definitions.xml.gz: Get_System_Segment_Size; do not edit.
-- Source SHA256: 8b33344a2422a86c448a9e3d21d60aeaf770e21ddb9344407eec324321cb052a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_System_Segment_Size)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Get_System_Segment_Size (segment : Segment) : Runtime.SpecM Exception (State σ) (Int) := do
  Runtime.assert ((← Segment_Descriptor.S.partial segment.descriptor) == 0)

  if ((← Runtime.CheckedSlice.read (← Segment_Descriptor.«Type».partial segment.descriptor) 3 1) == 1) then
    if ((← get).IA32_EFER.LMA == 1) then
      return 64
    else
      return 32
  else
    return 16

end X86.Helpers

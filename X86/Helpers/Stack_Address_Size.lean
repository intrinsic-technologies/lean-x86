-- Generated from data/definitions.xml.gz: Stack_Address_Size; do not edit.
-- Source SHA256: 0b0cf689c2644d4602b430608294badc996e4bbf40e48e34232ad6da883ea1d9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Stack_Address_Size)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Stack_Address_Size (segment : Segment) : Runtime.SpecM Exception (State σ) (Int) := do
  Runtime.assert (← Runtime.readInitialized segment.is_stack)

  let stack_address_size : Int ← do
    if (← In_64Bit_Mode) then
      pure 64
    else
      if (← Segment_Descriptor.D.partial segment.descriptor) == 1 then
        pure 32
      else
        pure 16

  return stack_address_size

end X86.Helpers

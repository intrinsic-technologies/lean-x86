-- Generated from data/definitions.xml.gz: Is_Valid_Segment_Index; do not edit.
-- Source SHA256: 38c1fa982315e19e3fd84165d43e6f60b1f2d75795f7d4df2933fb0451e1c28b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Valid_Segment_Index)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Is_Valid_Segment_Index
    (index : Bits 3) (is_write : Bool) :
    Except (Runtime.Error Empty) (Bool) := do
  -- Not allowed to write to CS (0x001)
  return if is_write then ((index == (0 : Bits 3)) || (index == (2 : Bits 3)) || (index == (3 : Bits 3)) || (index == (4 : Bits 3)) || (index == (5 : Bits 3))) else ((index == (0 : Bits 3)) || (index == (1 : Bits 3)) || (index == (2 : Bits 3)) || (index == (3 : Bits 3)) || (index == (4 : Bits 3)) || (index == (5 : Bits 3)))

end X86.Helpers

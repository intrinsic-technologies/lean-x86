-- Generated from data/definitions.xml.gz: Is_Valid_Code_Segment; do not edit.
-- Source SHA256: 70d55349e9c393eb28f7302bf3ae7055d042e4072c0249a036969382ccc632b2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Valid_Code_Segment)
import X86.Runtime
import X86.Helpers.Is_Conforming_Code_Segment
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Valid_Code_Segment
    (new_cs : Segment) (cpl : Int) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (cpl in {0..3})

  let dpl : Int := Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor)

  return (← (do if (← Is_Conforming_Code_Segment new_cs) then pure (decide (dpl ≤ cpl)) else pure (if (← Is_Non_Conforming_Code_Segment new_cs) then dpl == cpl else false)))

end X86.Helpers

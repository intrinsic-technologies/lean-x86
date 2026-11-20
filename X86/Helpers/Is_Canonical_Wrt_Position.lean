-- Generated from data/definitions.xml.gz: Is_Canonical_Wrt_Position; do not edit.
-- Source SHA256: 82356ad354a3bdb8d02ca05db1946a7f19802eb4b71ff22a16d7a86a36ddb366
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Canonical_Wrt_Position)
import X86.Runtime
import X86.Helpers.Std.Bits.Is_All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Canonical_Wrt_Position
    (address : Bits 64) (position : Int) :
    Except (Runtime.Error Empty) (Bool) := do
  if ((← address[position - 1 +: 1]) == 0) then
    return (← Std.Bits.Is_Zero (size := ((64 : Int) + (- position))) (← (do Runtime.assert (decide (position ≤ 64)); pure (BitVec.cast (by omega) (← address[63:position]) : Bits ((64 : Int) + (- position))))))
  else
    return (← Std.Bits.Is_All_Ones (size := ((64 : Int) + (- position))) (← (do Runtime.assert (decide (position ≤ 64)); pure (BitVec.cast (by omega) (← address[63:position]) : Bits ((64 : Int) + (- position))))))

end X86.Helpers

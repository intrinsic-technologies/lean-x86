-- Generated from data/definitions.xml.gz: FP87::Three_Quarter_Pi; do not edit.
-- Source SHA256: cce33bc656592dcd66bcfa14ae5ec94a71fb67302cfd5d919fdb58e05e9311e9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AThree_Quarter_Pi)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Three_Quarter_Pi  : Except (Runtime.Error Empty) (F80_Type) := do
  let three_quarter_pi : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) (0 : Runtime.Bit) (← concatBits (leftSize := 15) (rightSize := 64) (← (16384 : Bits 16)[0 +: 15]) (10866029187115684264 : Bits 64))
  return three_quarter_pi

end X86.Helpers

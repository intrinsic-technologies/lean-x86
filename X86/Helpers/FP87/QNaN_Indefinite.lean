-- Generated from data/definitions.xml.gz: FP87::QNaN_Indefinite; do not edit.
-- Source SHA256: 5c8392b8a0ffabafb09c2d61ad4ebd6808ee855705abb2926380d549a471a1f2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AQNaN_Indefinite)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.QNaN_Indefinite  : Except (Runtime.Error Empty) (F80_Type) := do
  let qnan_indefinite : F80_Type ← concatBits (leftSize := 1) (rightSize := 79) (1 : Runtime.Bit) (← concatBits (leftSize := 15) (rightSize := 64) (← (32767 : Bits 16)[0 +: 15]) (13835058055282163712 : Bits 64))
  return qnan_indefinite

end X86.Helpers

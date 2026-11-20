-- Generated from data/definitions.xml.gz: FP87::Normalize; do not edit.
-- Source SHA256: c05191a0ef11819561057c80c3b9e4d71a7292d0f8d1f7dd1ba7a0a7e82dd8c7
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ANormalize)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Shift_Left_Logical
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

open scoped X86.Runtime.PartialSyntax in
def FP87.Normalize (x : F80_Type) : Runtime.PartialResult Empty (F80_Type) := do
  let mut result : F80_Type := x

  while (← (F80_Type.Mantissa result)[63 +: 1]) == 0 and not (← Std.Bits.Is_Zero (size := 64) (F80_Type.Mantissa result)) do
    result := F80_Type.setMantissa result (← Std.Bits.Shift_Left_Logical (size := 64) (F80_Type.Mantissa result) 1)
    result := F80_Type.setExponent result ((BitVec.cast (by omega) (F80_Type.Exponent result) : Bits 15) - (← Std.Bits.Zero_Extend (source_size := 4) 1 15))

  return result

end X86.Helpers

-- Generated from data/definitions.xml.gz: FP87::Convert_From_Integer; do not edit.
-- Source SHA256: bf239c859c3b48640a322a86ad22f5e1c9b07365730a5138c756187521cfbee4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AConvert_From_Integer)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Normalize
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Shift_Left_Logical
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Subtract
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Convert_From_Integer {size : Int}
    (x : Bits size) :
    Runtime.PartialResult Empty (F80_Type) := do
  Runtime.assert (size == 16 || size == 32 || size == 64)

  let mut result : F80_Type ← Std.Bits.Zero 80

  result := F80_Type.setMantissa result (← Std.Bits.Shift_Left_Logical (size := 64) (← Std.Bits.Zero_Extend (source_size := size) x 64) (64 - size))

  let sign : Runtime.Bit ← x[size - 1 +: 1]
  if (sign == 1) then
    -- perform two's complement on negative
    let (result_part, _, _, _) ← Subtract (size := 64) (← Std.Bits.Zero 64) (F80_Type.Mantissa result)
    result := F80_Type.setMantissa result result_part
    result := F80_Type.setSign result (1 : Runtime.Bit)

  if (not (← Std.Bits.Is_Zero (size := 64) (F80_Type.Mantissa result))) then
    let f80_bias : Bits 15 ← (16383 : Bits 16)[0 +: 15]
    result := F80_Type.setExponent result (f80_bias + (← (size - 1)[0 +: 15]))
    result := (← FP87.Normalize result)

  return result

end X86.Helpers

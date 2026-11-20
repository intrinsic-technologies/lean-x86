-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 312bb25fe1cd7bb882f42e3a44c4519efd048223763018726f8e87c8799c8d61
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87_Class_Type
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- XML calls this helper but omits its declaration and body. This local body
-- covers SNaN and QNaN inputs, including the result selected by FP87::Add.
-- Intel SDM 325462-089US, Vol. 1, Section 4.8.3.5: quieting sets the highest
-- fraction bit and preserves the other bits. XML F80_Type and FP87::Classify
-- identify that bit as Mantissa[62]. QNaNs retain every bit; other classes are unsupported.
def FP87.Quietize_NaN (x : F80_Type) : Except (Runtime.Error Empty) (F80_Type) := do
  Runtime.assert (← (do
    let __check85 : FP87_Class_Type ← FP87.Classify x
    pure ((__check85 == FP87_Class_Type.FP87_Class_SNaN) || (__check85 == FP87_Class_Type.FP87_Class_QNaN))))
  let quiet_bit : Bits 64 ← concatBits (leftSize := 2) (rightSize := 62) (1 : Bits 2) (← Std.Bits.Zero 62)
  let mut result : F80_Type := x
  result := F80_Type.setMantissa result ((BitVec.cast (by omega) (F80_Type.Mantissa x) : Bits 64) or quiet_bit)
  return result

end X86.Helpers

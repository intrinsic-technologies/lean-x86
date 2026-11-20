-- Generated from data/definitions.xml.gz: FP87::Get_NAN_Result; do not edit.
-- Source SHA256: 13ab8c7dcf51e1bacbce74961f2174c65a469760691db37941b678f5a11ccbdd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AGet_NAN_Result)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87_Class_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Get_NAN_Result (src1 src2 : F80_Type) : Except (Runtime.Error Empty) (F80_Type) := do
  Runtime.assert (← (do
    let __check86 : FP87_Class_Type ← FP87.Classify src1
    pure ((__check86 == FP87_Class_Type.FP87_Class_QNaN) || (__check86 == FP87_Class_Type.FP87_Class_SNaN))))
  Runtime.assert (← (do
    let __check87 : FP87_Class_Type ← FP87.Classify src2
    pure ((__check87 == FP87_Class_Type.FP87_Class_QNaN) || (__check87 == FP87_Class_Type.FP87_Class_SNaN))))

  let result : F80_Type ← do
    if F80_Type.Mantissa src1 == F80_Type.Mantissa src2 then
      let mut result : F80_Type := src1
      -- sign is negative only if both sources are negative
      result := F80_Type.setSign result (F80_Type.Sign src1 and F80_Type.Sign src2)
      pure result
    else
      if decide (Unsigned (F80_Type.Mantissa src1) > Unsigned (F80_Type.Mantissa src2)) then
        let result : F80_Type := src1
        pure result
      else
        let result : F80_Type := src2
        pure result

  return result

end X86.Helpers

-- Generated from a local ISA specification; do not edit.
-- Source SHA256: ccb8976c2c4f7fcbd8555f3207380db8b287ff1ba74870c55aab836b03041d5e
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Convert_From_Float
import X86.Helpers.FP87.Convert_To_Integer
import X86.Helpers.FP87.Zero
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Rounding_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP.To_Int {N : Int}
    (x : Bits N) (is_signed : Bool) (M : Int) (denormals_are_zeros : Bool) (rm : Rounding_Mode) (suppress_precise_exceptions : Bool := false) :
    Runtime.PartialResult Empty (Bits M × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)
  Runtime.assert (0 ≤ M)

  Runtime.assert (N == 32 or N == 64)
  Runtime.assert (is_signed and not suppress_precise_exceptions and (M == 32 or M == 64))
  let (wide, denormal) ← FP87.Convert_From_Float (size := N) x
  let operand : F80_Type ← do
    if denormals_are_zeros and denormal then
      pure (← FP87.Zero (F80_Type.Sign wide))
    else
      pure wide
  let rounding : Bits 2 := if rm == Rounding_Mode.Rounding_Mode_RNE then 0 else if rm == Rounding_Mode.Rounding_Mode_RTN then 1 else if rm == Rounding_Mode.Rounding_Mode_RTP then 2 else 3
  let (value, _, exceptions) ← FP87.Convert_To_Integer operand rounding M true
  return (value, exceptions)

end X86.Helpers

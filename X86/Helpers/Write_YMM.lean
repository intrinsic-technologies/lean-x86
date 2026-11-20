-- Generated from data/definitions.xml.gz: Write_YMM; do not edit.
-- Source SHA256: 6c7184a07941cd1276c769b6561a5021cc0af4bc13efe433c175f675dcd33e7c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_YMM)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.YMM
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Write_YMM (rrrrr : Bits 5) (value : Bits 256) : Runtime.SpecM Exception (State σ) Unit := do
  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])

  YMM_write (Unsigned index) value

  if ((← concatBits (leftSize := 1) (rightSize := 1) (← XCR0.ZMM_Hi256) (← XCR0.Hi16_ZMM)) == (3 : Bits 2)) then
    let __check83 : Int := Unsigned index
    Runtime.assert (decide (__check83 < 32))
    Runtime.assert (decide (0 ≤ __check83))
    ZMM.set __check83 (← setSliceChecked (← ZMM.get __check83) 256 256 (← Std.Bits.Zero 256))

end X86.Helpers

-- Generated from data/definitions.xml.gz: Write_XMM; do not edit.
-- Source SHA256: 8d1e4a01dc5c2da61521a266c5aab269dc3b0ee504e234ccf67ba1e8ac0ac24d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_XMM)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.XMM
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Write_XMM {size : Int}
    (rrrrr : Bits 5) (value : Bits size) (zero_upper : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  Runtime.assert (decide (size ≤ 128))

  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])

  XMM_write (Unsigned index) (← Std.Bits.Zero_Extend (source_size := size) value 128)

  if zero_upper then
    if ((← XCR0.AVX) == 1) then
      let __check81 : Int := Unsigned index
      Runtime.assert (decide (__check81 < 32))
      Runtime.assert (decide (0 ≤ __check81))
      ZMM.set __check81 (← setSliceChecked (← ZMM.get __check81) 128 128 (← Std.Bits.Zero 128))
    if ((← concatBits (leftSize := 1) (rightSize := 1) (← XCR0.ZMM_Hi256) (← XCR0.Hi16_ZMM)) == (3 : Bits 2)) then
      let __check82 : Int := Unsigned index
      Runtime.assert (decide (__check82 < 32))
      Runtime.assert (decide (0 ≤ __check82))
      ZMM.set __check82 (← setSliceChecked (← ZMM.get __check82) 256 256 (← Std.Bits.Zero 256))

end X86.Helpers

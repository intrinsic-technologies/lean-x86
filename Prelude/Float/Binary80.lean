import X86.Helpers.F80_Type
import Init.Data.Rat

set_option autoImplicit false

namespace Prelude.Float.Binary80

open X86.Helpers

def scale2 (exponent : Int) : Rat :=
  if exponent < 0 then 1 / (2 ^ exponent.natAbs : Nat) else (2 ^ exponent.toNat : Nat)

/-- Computed finite results use canonical binary80 encodings. -/
def finite (x : BitVec 80) : Prop :=
  let exponent := (F80_Type.Exponent x).toNat
  let significand := (F80_Type.Mantissa x).toNat
  exponent < 32767 ∧
    (if exponent = 0 then significand < 2 ^ 63 else 2 ^ 63 ≤ significand)

/-- Pseudo-denormal inputs are supported and are treated as exponent-one denormals. -/
def supportedFinite (x : BitVec 80) : Prop :=
  let exponent := (F80_Type.Exponent x).toNat
  exponent < 32767 ∧
    (exponent = 0 ∨ 2 ^ 63 ≤ (F80_Type.Mantissa x).toNat)

def value (x : BitVec 80) : Rat :=
  let exponent : Int := (max 1 (F80_Type.Exponent x).toNat : Nat) - (16446 : Int)
  let magnitude := ((F80_Type.Mantissa x).toNat : Rat) * scale2 exponent
  if (F80_Type.Sign x).toNat = 0 then magnitude else -magnitude

def one : BitVec 80 := BitVec.ofNat 80 0x3fff8000000000000000

end Prelude.Float.Binary80

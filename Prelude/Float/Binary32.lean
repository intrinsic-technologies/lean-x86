import Prelude.Float.Binary
import Init.Data.Rat

set_option autoImplicit false

namespace Prelude.Float.Binary32

open X86

open X86.Runtime

def sign (x : Bits 32) : Bool := x.toNat / 2 ^ 31 != 0

def exponent (x : Bits 32) : Nat := Binary.exponent x

def fraction (x : Bits 32) : Nat := Binary.fraction x

def isNormal (x : Bits 32) : Bool :=
  exponent x != 0 && exponent x != 255

def isZero (x : Bits 32) : Bool := x.toNat % 2 ^ 31 == 0

def isInfinite (x : Bits 32) : Bool := exponent x == 255 && fraction x == 0

def isNaN (x : Bits 32) : Bool := exponent x == 255 && fraction x != 0

/-- Exact unsigned value, used only for finite binary32 encodings. -/
def magnitude (x : Bits 32) : Rat :=
  let e := exponent x
  let f := fraction x
  if e == 0 then
    mkRat f (2 ^ 149)
  else if e < 150 then
    mkRat (2 ^ 23 + f) (2 ^ (150 - e))
  else
    Rat.ofInt ((2 ^ 23 + f) * 2 ^ (e - 150))

def signedZero (x : Bits 32) : Bits 32 := if sign x then 0x80000000 else 0

def signedInfinity (x : Bits 32) : Bits 32 := if sign x then 0xff800000 else 0x7f800000

/-- SDM Vol. 1 §4.8.3.5: quiet a NaN by setting its most significant fraction bit. -/
def quietNaN (x : Bits 32) : Bits 32 := x ||| 0x00400000

/-- The unique binary32 indefinite in SDM Vol. 1 Table 4-3. -/
def indefinite : Bits 32 := 0xffc00000

def minimumNormal : Rat := mkRat 1 (2 ^ 126)

end Prelude.Float.Binary32

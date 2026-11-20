import X86.Runtime.Bits

set_option autoImplicit false

namespace Prelude.Float.Binary

open X86 X86.Runtime

/-- SDM093 Vol.1 §4.2.2: the supported IEEE sign, exponent and fraction layouts. -/
def supportedFormat (E N : Int) : Prop :=
  (E = 8 ∧ N = 32) ∨ (E = 11 ∧ N = 64)

instance (E N : Int) : Decidable (supportedFormat E N) :=
  inferInstanceAs (Decidable (_ ∨ _))

def exponentWidth (N : Int) : Nat := if N = 32 then 8 else 11

def fractionWidth (N : Int) : Nat := N.toNat - exponentWidth N - 1

def exponent {N : Int} (bits : Bits N) : Nat :=
  bits.toNat / 2 ^ fractionWidth N % 2 ^ exponentWidth N

def fraction {N : Int} (bits : Bits N) : Nat :=
  bits.toNat % 2 ^ fractionWidth N

end Prelude.Float.Binary

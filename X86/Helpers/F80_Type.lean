-- Generated from data/definitions.xml.gz: F80_Type; do not edit.
-- Source SHA256: d5a75010174dc539fec64786835b2c1ac65f45f38cd74536b95f73ba08cf5ea8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=F80_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev F80_Type := Bits 80

def F80_Type.Mantissa (bits : F80_Type) : Bits 64 :=
  BitVec.extractLsb' 0 64 bits

def F80_Type.setMantissa (bits : F80_Type) (value : Bits 64) : F80_Type :=
  setSlice bits 0 64 value

def F80_Type.Mantissa.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 80) : m (Bits 64) := do
  return (← bits.readSlice 0 64)

def F80_Type.setMantissa.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 80) (value : Bits 64) : m (Runtime.InitializedBits 80) := do
  bits.writeSlice 0 64 (BitVec.extractLsb' 0 64 value)

def F80_Type.Exponent (bits : F80_Type) : Bits 15 :=
  BitVec.extractLsb' 64 15 bits

def F80_Type.setExponent (bits : F80_Type) (value : Bits 15) : F80_Type :=
  setSlice bits 64 15 value

def F80_Type.Exponent.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 80) : m (Bits 15) := do
  return (← bits.readSlice 64 15)

def F80_Type.setExponent.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 80) (value : Bits 15) : m (Runtime.InitializedBits 80) := do
  bits.writeSlice 64 15 (BitVec.extractLsb' 0 15 value)

def F80_Type.Sign (bits : F80_Type) : Runtime.Bit :=
  BitVec.extractLsb' 79 1 bits

def F80_Type.setSign (bits : F80_Type) (value : Runtime.Bit) : F80_Type :=
  setSlice bits 79 1 value

def F80_Type.Sign.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 80) : m (Runtime.Bit) := do
  return (← bits.readSlice 79 1)

def F80_Type.setSign.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 80) (value : Runtime.Bit) : m (Runtime.InitializedBits 80) := do
  bits.writeSlice 79 1 (BitVec.extractLsb' 0 1 value)

end X86.Helpers

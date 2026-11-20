-- Generated from data/definitions.xml.gz: Descriptor_High; do not edit.
-- Source SHA256: 36ba45178c78307f09ef73dda55ff8610ae48ff1273f045be109bc6558a4afe2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Descriptor_High)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Descriptor_High := Bits 64

def Descriptor_High.Base_High (bits : Descriptor_High) : Bits 32 :=
  BitVec.extractLsb' 0 32 bits

def Descriptor_High.setBase_High (bits : Descriptor_High) (value : Bits 32) : Descriptor_High :=
  setSlice bits 0 32 value

def Descriptor_High.Base_High.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 32) := do
  return (← bits.readSlice 0 32)

def Descriptor_High.setBase_High.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Bits 32) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 0 32 (BitVec.extractLsb' 0 32 value)

def Descriptor_High.Offset_High (bits : Descriptor_High) : Bits 32 :=
  BitVec.extractLsb' 0 32 bits

def Descriptor_High.setOffset_High (bits : Descriptor_High) (value : Bits 32) : Descriptor_High :=
  setSlice bits 0 32 value

def Descriptor_High.Offset_High.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 32) := do
  return (← bits.readSlice 0 32)

def Descriptor_High.setOffset_High.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Bits 32) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 0 32 (BitVec.extractLsb' 0 32 value)

def Descriptor_High.Reserved1 (bits : Descriptor_High) : Bits 8 :=
  BitVec.extractLsb' 32 8 bits

def Descriptor_High.setReserved1 (bits : Descriptor_High) (value : Bits 8) : Descriptor_High :=
  setSlice bits 32 8 value

def Descriptor_High.Type2 (bits : Descriptor_High) : Bits 5 :=
  BitVec.extractLsb' 40 5 bits

def Descriptor_High.setType2 (bits : Descriptor_High) (value : Bits 5) : Descriptor_High :=
  setSlice bits 40 5 value

def Descriptor_High.Type2.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 5) := do
  return (← bits.readSlice 40 5)

def Descriptor_High.Reserved2 (bits : Descriptor_High) : Bits 19 :=
  BitVec.extractLsb' 45 19 bits

def Descriptor_High.setReserved2 (bits : Descriptor_High) (value : Bits 19) : Descriptor_High :=
  setSlice bits 45 19 value

end X86.Helpers

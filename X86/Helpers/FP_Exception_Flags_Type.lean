-- Generated from data/definitions.xml.gz: FP_Exception_Flags_Type; do not edit.
-- Source SHA256: 7e6a50e9bd08fc86a2c3acb7b4cdac36a2a97d93cbbb5f30a55b4fdf93656d10
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP_Exception_Flags_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev FP_Exception_Flags_Type := Bits 6

def FP_Exception_Flags_Type.IE (bits : FP_Exception_Flags_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def FP_Exception_Flags_Type.setIE (bits : FP_Exception_Flags_Type) (value : Runtime.Bit) : FP_Exception_Flags_Type :=
  setSlice bits 0 1 value

def FP_Exception_Flags_Type.IE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) : m (Runtime.Bit) := do
  return (← bits.readSlice 0 1)

def FP_Exception_Flags_Type.setIE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) (value : Runtime.Bit) : m (Runtime.InitializedBits 6) := do
  bits.writeSlice 0 1 (BitVec.extractLsb' 0 1 value)

def FP_Exception_Flags_Type.DE (bits : FP_Exception_Flags_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def FP_Exception_Flags_Type.setDE (bits : FP_Exception_Flags_Type) (value : Runtime.Bit) : FP_Exception_Flags_Type :=
  setSlice bits 1 1 value

def FP_Exception_Flags_Type.DE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) : m (Runtime.Bit) := do
  return (← bits.readSlice 1 1)

def FP_Exception_Flags_Type.setDE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) (value : Runtime.Bit) : m (Runtime.InitializedBits 6) := do
  bits.writeSlice 1 1 (BitVec.extractLsb' 0 1 value)

def FP_Exception_Flags_Type.ZE (bits : FP_Exception_Flags_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def FP_Exception_Flags_Type.setZE (bits : FP_Exception_Flags_Type) (value : Runtime.Bit) : FP_Exception_Flags_Type :=
  setSlice bits 2 1 value

def FP_Exception_Flags_Type.ZE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) : m (Runtime.Bit) := do
  return (← bits.readSlice 2 1)

def FP_Exception_Flags_Type.setZE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) (value : Runtime.Bit) : m (Runtime.InitializedBits 6) := do
  bits.writeSlice 2 1 (BitVec.extractLsb' 0 1 value)

def FP_Exception_Flags_Type.OE (bits : FP_Exception_Flags_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def FP_Exception_Flags_Type.setOE (bits : FP_Exception_Flags_Type) (value : Runtime.Bit) : FP_Exception_Flags_Type :=
  setSlice bits 3 1 value

def FP_Exception_Flags_Type.OE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) : m (Runtime.Bit) := do
  return (← bits.readSlice 3 1)

def FP_Exception_Flags_Type.setOE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) (value : Runtime.Bit) : m (Runtime.InitializedBits 6) := do
  bits.writeSlice 3 1 (BitVec.extractLsb' 0 1 value)

def FP_Exception_Flags_Type.UE (bits : FP_Exception_Flags_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def FP_Exception_Flags_Type.setUE (bits : FP_Exception_Flags_Type) (value : Runtime.Bit) : FP_Exception_Flags_Type :=
  setSlice bits 4 1 value

def FP_Exception_Flags_Type.UE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) : m (Runtime.Bit) := do
  return (← bits.readSlice 4 1)

def FP_Exception_Flags_Type.setUE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) (value : Runtime.Bit) : m (Runtime.InitializedBits 6) := do
  bits.writeSlice 4 1 (BitVec.extractLsb' 0 1 value)

def FP_Exception_Flags_Type.PE (bits : FP_Exception_Flags_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def FP_Exception_Flags_Type.setPE (bits : FP_Exception_Flags_Type) (value : Runtime.Bit) : FP_Exception_Flags_Type :=
  setSlice bits 5 1 value

def FP_Exception_Flags_Type.setPE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 6) (value : Runtime.Bit) : m (Runtime.InitializedBits 6) := do
  bits.writeSlice 5 1 (BitVec.extractLsb' 0 1 value)

end X86.Helpers

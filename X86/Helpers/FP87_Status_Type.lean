-- Generated from data/definitions.xml.gz: FP87_Status_Type; do not edit.
-- Source SHA256: 28ae2ae47467408769591cd1c25acdf6257cb19f2771f370444cf424fbd045bb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87_Status_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev FP87_Status_Type := Bits 16

def FP87_Status_Type.IE (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def FP87_Status_Type.setIE (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 0 1 value

def FP87_Status_Type.setIE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 0 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.DE (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def FP87_Status_Type.setDE (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 1 1 value

def FP87_Status_Type.setDE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 1 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.ZE (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def FP87_Status_Type.setZE (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 2 1 value

def FP87_Status_Type.setZE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 2 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.OE (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def FP87_Status_Type.setOE (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 3 1 value

def FP87_Status_Type.setOE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 3 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.UE (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def FP87_Status_Type.setUE (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 4 1 value

def FP87_Status_Type.setUE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 4 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.PE (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def FP87_Status_Type.setPE (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 5 1 value

def FP87_Status_Type.setPE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 5 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.Exception_Flags (bits : FP87_Status_Type) : Bits 6 :=
  BitVec.extractLsb' 0 6 bits

def FP87_Status_Type.setException_Flags (bits : FP87_Status_Type) (value : Bits 6) : FP87_Status_Type :=
  setSlice bits 0 6 value

def FP87_Status_Type.Exception_Flags.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 6) := do
  return (← bits.readSlice 0 6)

def FP87_Status_Type.setException_Flags.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 6) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 0 6 (BitVec.extractLsb' 0 6 value)

def FP87_Status_Type.SF (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def FP87_Status_Type.setSF (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 6 1 value

def FP87_Status_Type.SF.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 6 1)

def FP87_Status_Type.setSF.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 6 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.ES (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def FP87_Status_Type.setES (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 7 1 value

def FP87_Status_Type.ES.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 7 1)

def FP87_Status_Type.setES.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 7 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.C0 (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def FP87_Status_Type.setC0 (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 8 1 value

def FP87_Status_Type.C0.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 8 1)

def FP87_Status_Type.setC0.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 8 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.C1 (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def FP87_Status_Type.setC1 (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 9 1 value

def FP87_Status_Type.C1.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 9 1)

def FP87_Status_Type.setC1.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 9 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.C2 (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def FP87_Status_Type.setC2 (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 10 1 value

def FP87_Status_Type.C2.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 10 1)

def FP87_Status_Type.setC2.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 10 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.TOP (bits : FP87_Status_Type) : Bits 3 :=
  BitVec.extractLsb' 11 3 bits

def FP87_Status_Type.setTOP (bits : FP87_Status_Type) (value : Bits 3) : FP87_Status_Type :=
  setSlice bits 11 3 value

def FP87_Status_Type.TOP.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 3) := do
  return (← bits.readSlice 11 3)

def FP87_Status_Type.setTOP.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 3) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 11 3 (BitVec.extractLsb' 0 3 value)

def FP87_Status_Type.C3 (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 14 1 bits

def FP87_Status_Type.setC3 (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 14 1 value

def FP87_Status_Type.C3.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 14 1)

def FP87_Status_Type.setC3.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 14 1 (BitVec.extractLsb' 0 1 value)

def FP87_Status_Type.CC (bits : FP87_Status_Type) : Bits 4 :=
  BitVec.append (BitVec.extractLsb' 14 1 bits) (BitVec.extractLsb' 8 3 bits)

def FP87_Status_Type.setCC (bits : FP87_Status_Type) (value : Bits 4) : FP87_Status_Type :=
  let bits := setSlice bits 8 3 (BitVec.extractLsb' 0 3 value)
  setSlice bits 14 1 (BitVec.extractLsb' 3 1 value)

def FP87_Status_Type.setCC.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 4) : m (Runtime.InitializedBits 16) := do
  let bits ← bits.writeSlice 8 3 (BitVec.extractLsb' 0 3 value)
  bits.writeSlice 14 1 (BitVec.extractLsb' 3 1 value)

def FP87_Status_Type.B (bits : FP87_Status_Type) : Runtime.Bit :=
  BitVec.extractLsb' 15 1 bits

def FP87_Status_Type.setB (bits : FP87_Status_Type) (value : Runtime.Bit) : FP87_Status_Type :=
  setSlice bits 15 1 value

def FP87_Status_Type.setB.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 15 1 (BitVec.extractLsb' 0 1 value)

end X86.Helpers

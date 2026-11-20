-- Generated from data/definitions.xml.gz: FP87_Control_Type; do not edit.
-- Source SHA256: dd9ea40de1afb6c685771d1af1f15e753f711c9046d121417f9d9e9acec4710c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87_Control_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev FP87_Control_Type := Bits 16

def FP87_Control_Type.IM (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def FP87_Control_Type.setIM (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 0 1 value

def FP87_Control_Type.IM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 0 1)

def FP87_Control_Type.setIM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 0 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.DM (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def FP87_Control_Type.setDM (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 1 1 value

def FP87_Control_Type.DM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 1 1)

def FP87_Control_Type.setDM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 1 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.ZM (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def FP87_Control_Type.setZM (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 2 1 value

def FP87_Control_Type.setZM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 2 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.OM (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def FP87_Control_Type.setOM (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 3 1 value

def FP87_Control_Type.OM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 3 1)

def FP87_Control_Type.setOM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 3 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.UM (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def FP87_Control_Type.setUM (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 4 1 value

def FP87_Control_Type.UM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 4 1)

def FP87_Control_Type.setUM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 4 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.PM (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def FP87_Control_Type.setPM (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 5 1 value

def FP87_Control_Type.setPM.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 5 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.Exception_Masks (bits : FP87_Control_Type) : Bits 6 :=
  BitVec.extractLsb' 0 6 bits

def FP87_Control_Type.setException_Masks (bits : FP87_Control_Type) (value : Bits 6) : FP87_Control_Type :=
  setSlice bits 0 6 value

def FP87_Control_Type.Exception_Masks.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 6) := do
  return (← bits.readSlice 0 6)

def FP87_Control_Type.setException_Masks.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 6) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 0 6 (BitVec.extractLsb' 0 6 value)

def FP87_Control_Type.RESERVED_ONE (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def FP87_Control_Type.setRESERVED_ONE (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 6 1 value

def FP87_Control_Type.setRESERVED_ONE.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 6 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.PC (bits : FP87_Control_Type) : Bits 2 :=
  BitVec.extractLsb' 8 2 bits

def FP87_Control_Type.setPC (bits : FP87_Control_Type) (value : Bits 2) : FP87_Control_Type :=
  setSlice bits 8 2 value

def FP87_Control_Type.PC.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 2) := do
  return (← bits.readSlice 8 2)

def FP87_Control_Type.setPC.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 2) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 8 2 (BitVec.extractLsb' 0 2 value)

def FP87_Control_Type.RC (bits : FP87_Control_Type) : Bits 2 :=
  BitVec.extractLsb' 10 2 bits

def FP87_Control_Type.setRC (bits : FP87_Control_Type) (value : Bits 2) : FP87_Control_Type :=
  setSlice bits 10 2 value

def FP87_Control_Type.RC.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 2) := do
  return (← bits.readSlice 10 2)

def FP87_Control_Type.setRC.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 2) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 10 2 (BitVec.extractLsb' 0 2 value)

def FP87_Control_Type.X (bits : FP87_Control_Type) : Runtime.Bit :=
  BitVec.extractLsb' 12 1 bits

def FP87_Control_Type.setX (bits : FP87_Control_Type) (value : Runtime.Bit) : FP87_Control_Type :=
  setSlice bits 12 1 value

def FP87_Control_Type.setX.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Runtime.Bit) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 12 1 (BitVec.extractLsb' 0 1 value)

def FP87_Control_Type.RESERVED_ZERO (bits : FP87_Control_Type) : Bits 4 :=
  BitVec.append (BitVec.extractLsb' 13 3 bits) (BitVec.extractLsb' 7 1 bits)

def FP87_Control_Type.setRESERVED_ZERO (bits : FP87_Control_Type) (value : Bits 4) : FP87_Control_Type :=
  let bits := setSlice bits 7 1 (BitVec.extractLsb' 0 1 value)
  setSlice bits 13 3 (BitVec.extractLsb' 1 3 value)

def FP87_Control_Type.setRESERVED_ZERO.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 4) : m (Runtime.InitializedBits 16) := do
  let bits ← bits.writeSlice 7 1 (BitVec.extractLsb' 0 1 value)
  bits.writeSlice 13 3 (BitVec.extractLsb' 1 3 value)

end X86.Helpers

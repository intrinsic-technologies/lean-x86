-- Generated from data/definitions.xml.gz: Segment_Descriptor; do not edit.
-- Source SHA256: e3625e20aa8eb57d73c995a66c0d740e600dfcb61cc4e6236499b89f8ab8ea98
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Segment_Descriptor)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Segment_Descriptor := Bits 64

def Segment_Descriptor.Limit (bits : Segment_Descriptor) : Bits 20 :=
  BitVec.append (BitVec.extractLsb' 48 4 bits) (BitVec.extractLsb' 0 16 bits)

def Segment_Descriptor.setLimit (bits : Segment_Descriptor) (value : Bits 20) : Segment_Descriptor :=
  let bits := setSlice bits 0 16 (BitVec.extractLsb' 0 16 value)
  setSlice bits 48 4 (BitVec.extractLsb' 16 4 value)

def Segment_Descriptor.Limit.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 20) := do
  return BitVec.append ((← bits.readSlice 48 4)) ((← bits.readSlice 0 16))

def Segment_Descriptor.setLimit.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Bits 20) : m (Runtime.InitializedBits 64) := do
  let bits ← bits.writeSlice 0 16 (BitVec.extractLsb' 0 16 value)
  bits.writeSlice 48 4 (BitVec.extractLsb' 16 4 value)

def Segment_Descriptor.Base (bits : Segment_Descriptor) : Bits 32 :=
  BitVec.append (BitVec.append (BitVec.extractLsb' 56 8 bits) (BitVec.extractLsb' 32 8 bits)) (BitVec.extractLsb' 16 16 bits)

def Segment_Descriptor.setBase (bits : Segment_Descriptor) (value : Bits 32) : Segment_Descriptor :=
  let bits := setSlice bits 16 16 (BitVec.extractLsb' 0 16 value)
  let bits := setSlice bits 32 8 (BitVec.extractLsb' 16 8 value)
  setSlice bits 56 8 (BitVec.extractLsb' 24 8 value)

def Segment_Descriptor.Base.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 32) := do
  return BitVec.append (BitVec.append ((← bits.readSlice 56 8)) ((← bits.readSlice 32 8))) ((← bits.readSlice 16 16))

def Segment_Descriptor.setBase.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Bits 32) : m (Runtime.InitializedBits 64) := do
  let bits ← bits.writeSlice 16 16 (BitVec.extractLsb' 0 16 value)
  let bits ← bits.writeSlice 32 8 (BitVec.extractLsb' 16 8 value)
  bits.writeSlice 56 8 (BitVec.extractLsb' 24 8 value)

def Segment_Descriptor.A (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 40 1 bits

def Segment_Descriptor.setA (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 40 1 value

def Segment_Descriptor.A.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 40 1)

def Segment_Descriptor.setA.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 40 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.Code (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 43 1 bits

def Segment_Descriptor.setCode (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 43 1 value

def Segment_Descriptor.Code.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 43 1)

def Segment_Descriptor.setCode.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 43 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.AVL (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 52 1 bits

def Segment_Descriptor.setAVL (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 52 1 value

def Segment_Descriptor.AVL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 52 1)

def Segment_Descriptor.setAVL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 52 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.L (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 53 1 bits

def Segment_Descriptor.setL (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 53 1 value

def Segment_Descriptor.L.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 53 1)

def Segment_Descriptor.setL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 53 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.G (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 55 1 bits

def Segment_Descriptor.setG (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 55 1 value

def Segment_Descriptor.G.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 55 1)

def Segment_Descriptor.setG.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 55 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.R (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 41 1 bits

def Segment_Descriptor.setR (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 41 1 value

def Segment_Descriptor.R.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 41 1)

def Segment_Descriptor.setR.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 41 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.Conforming (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 42 1 bits

def Segment_Descriptor.setConforming (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 42 1 value

def Segment_Descriptor.Conforming.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 42 1)

def Segment_Descriptor.setConforming.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 42 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.D (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 54 1 bits

def Segment_Descriptor.setD (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 54 1 value

def Segment_Descriptor.D.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 54 1)

def Segment_Descriptor.setD.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 54 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.W (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 41 1 bits

def Segment_Descriptor.setW (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 41 1 value

def Segment_Descriptor.W.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 41 1)

def Segment_Descriptor.setW.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 41 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.ExpandDown (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 42 1 bits

def Segment_Descriptor.setExpandDown (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 42 1 value

def Segment_Descriptor.ExpandDown.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 42 1)

def Segment_Descriptor.setExpandDown.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 42 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.Big (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 54 1 bits

def Segment_Descriptor.setBig (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 54 1 value

def Segment_Descriptor.Big.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 54 1)

def Segment_Descriptor.setBig.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 54 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.«Type» (bits : Segment_Descriptor) : Bits 4 :=
  BitVec.extractLsb' 40 4 bits

def Segment_Descriptor.setType (bits : Segment_Descriptor) (value : Bits 4) : Segment_Descriptor :=
  setSlice bits 40 4 value

def Segment_Descriptor.«Type».partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 4) := do
  return (← bits.readSlice 40 4)

def Segment_Descriptor.setType.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Bits 4) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 40 4 (BitVec.extractLsb' 0 4 value)

def Segment_Descriptor.Busy (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 41 1 bits

def Segment_Descriptor.setBusy (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 41 1 value

def Segment_Descriptor.Busy.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 41 1)

def Segment_Descriptor.setBusy.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 41 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.Offset (bits : Segment_Descriptor) : Bits 32 :=
  BitVec.append (BitVec.extractLsb' 48 16 bits) (BitVec.extractLsb' 0 16 bits)

def Segment_Descriptor.setOffset (bits : Segment_Descriptor) (value : Bits 32) : Segment_Descriptor :=
  let bits := setSlice bits 0 16 (BitVec.extractLsb' 0 16 value)
  setSlice bits 48 16 (BitVec.extractLsb' 16 16 value)

def Segment_Descriptor.Offset.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 32) := do
  return BitVec.append ((← bits.readSlice 48 16)) ((← bits.readSlice 0 16))

def Segment_Descriptor.Selector (bits : Segment_Descriptor) : Bits 16 :=
  BitVec.extractLsb' 16 16 bits

def Segment_Descriptor.setSelector (bits : Segment_Descriptor) (value : Bits 16) : Segment_Descriptor :=
  setSlice bits 16 16 value

def Segment_Descriptor.Selector.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 16) := do
  return (← bits.readSlice 16 16)

def Segment_Descriptor.Parameter_count (bits : Segment_Descriptor) : Bits 5 :=
  BitVec.extractLsb' 32 5 bits

def Segment_Descriptor.setParameter_count (bits : Segment_Descriptor) (value : Bits 5) : Segment_Descriptor :=
  setSlice bits 32 5 value

def Segment_Descriptor.Parameter_count.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 5) := do
  return (← bits.readSlice 32 5)

def Segment_Descriptor.IST (bits : Segment_Descriptor) : Bits 3 :=
  BitVec.extractLsb' 32 3 bits

def Segment_Descriptor.setIST (bits : Segment_Descriptor) (value : Bits 3) : Segment_Descriptor :=
  setSlice bits 32 3 value

def Segment_Descriptor.IST.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 3) := do
  return (← bits.readSlice 32 3)

def Segment_Descriptor.Stuck_at_0 (bits : Segment_Descriptor) : Bits 3 :=
  BitVec.extractLsb' 37 3 bits

def Segment_Descriptor.setStuck_at_0 (bits : Segment_Descriptor) (value : Bits 3) : Segment_Descriptor :=
  setSlice bits 37 3 value

def Segment_Descriptor.S (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 44 1 bits

def Segment_Descriptor.setS (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 44 1 value

def Segment_Descriptor.S.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 44 1)

def Segment_Descriptor.setS.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 44 1 (BitVec.extractLsb' 0 1 value)

def Segment_Descriptor.DPL (bits : Segment_Descriptor) : Bits 2 :=
  BitVec.extractLsb' 45 2 bits

def Segment_Descriptor.setDPL (bits : Segment_Descriptor) (value : Bits 2) : Segment_Descriptor :=
  setSlice bits 45 2 value

def Segment_Descriptor.DPL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Bits 2) := do
  return (← bits.readSlice 45 2)

def Segment_Descriptor.setDPL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Bits 2) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 45 2 (BitVec.extractLsb' 0 2 value)

def Segment_Descriptor.P (bits : Segment_Descriptor) : Runtime.Bit :=
  BitVec.extractLsb' 47 1 bits

def Segment_Descriptor.setP (bits : Segment_Descriptor) (value : Runtime.Bit) : Segment_Descriptor :=
  setSlice bits 47 1 value

def Segment_Descriptor.P.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) : m (Runtime.Bit) := do
  return (← bits.readSlice 47 1)

def Segment_Descriptor.setP.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 64) (value : Runtime.Bit) : m (Runtime.InitializedBits 64) := do
  bits.writeSlice 47 1 (BitVec.extractLsb' 0 1 value)

end X86.Helpers

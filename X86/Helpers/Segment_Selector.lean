-- Generated from data/definitions.xml.gz: Segment_Selector; do not edit.
-- Source SHA256: b9180e5367b08c20e5c6dacbc17da4dcfbe6ad08d61dfdcbe9d6bd5afbabebc9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Segment_Selector)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Segment_Selector := Bits 16

def Segment_Selector.RPL (bits : Segment_Selector) : Bits 2 :=
  BitVec.extractLsb' 0 2 bits

def Segment_Selector.setRPL (bits : Segment_Selector) (value : Bits 2) : Segment_Selector :=
  setSlice bits 0 2 value

def Segment_Selector.RPL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 2) := do
  return (← bits.readSlice 0 2)

def Segment_Selector.setRPL.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) (value : Bits 2) : m (Runtime.InitializedBits 16) := do
  bits.writeSlice 0 2 (BitVec.extractLsb' 0 2 value)

def Segment_Selector.TI (bits : Segment_Selector) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Segment_Selector.setTI (bits : Segment_Selector) (value : Runtime.Bit) : Segment_Selector :=
  setSlice bits 2 1 value

def Segment_Selector.TI.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Runtime.Bit) := do
  return (← bits.readSlice 2 1)

def Segment_Selector.Index (bits : Segment_Selector) : Bits 13 :=
  BitVec.extractLsb' 3 13 bits

def Segment_Selector.setIndex (bits : Segment_Selector) (value : Bits 13) : Segment_Selector :=
  setSlice bits 3 13 value

def Segment_Selector.Index.partial {exception : Type} {m : Type → Type} [Monad m] [MonadExcept (Runtime.Error exception) m] (bits : Runtime.InitializedBits 16) : m (Bits 13) := do
  return (← bits.readSlice 3 13)

end X86.Helpers

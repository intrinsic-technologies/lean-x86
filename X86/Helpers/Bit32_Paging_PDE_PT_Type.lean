-- Generated from data/definitions.xml.gz: Bit32_Paging_PDE_PT_Type; do not edit.
-- Source SHA256: d36b23390bb772ed6c3731de0d14679e63246898491086d945b6981f2352478f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Bit32_Paging_PDE_PT_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Bit32_Paging_PDE_PT_Type := Bits 32

def Bit32_Paging_PDE_PT_Type.P (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Bit32_Paging_PDE_PT_Type.setP (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 0 1 value

def Bit32_Paging_PDE_PT_Type.RW (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Bit32_Paging_PDE_PT_Type.setRW (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 1 1 value

def Bit32_Paging_PDE_PT_Type.US (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Bit32_Paging_PDE_PT_Type.setUS (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 2 1 value

def Bit32_Paging_PDE_PT_Type.PWT (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def Bit32_Paging_PDE_PT_Type.setPWT (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 3 1 value

def Bit32_Paging_PDE_PT_Type.PCD (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def Bit32_Paging_PDE_PT_Type.setPCD (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 4 1 value

def Bit32_Paging_PDE_PT_Type.A (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def Bit32_Paging_PDE_PT_Type.setA (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 5 1 value

def Bit32_Paging_PDE_PT_Type.IGNORED (bits : Bit32_Paging_PDE_PT_Type) : Bits 5 :=
  BitVec.append (BitVec.extractLsb' 8 4 bits) (BitVec.extractLsb' 6 1 bits)

def Bit32_Paging_PDE_PT_Type.setIGNORED (bits : Bit32_Paging_PDE_PT_Type) (value : Bits 5) : Bit32_Paging_PDE_PT_Type :=
  let bits := setSlice bits 6 1 (BitVec.extractLsb' 0 1 value)
  setSlice bits 8 4 (BitVec.extractLsb' 1 4 value)

def Bit32_Paging_PDE_PT_Type.PS (bits : Bit32_Paging_PDE_PT_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def Bit32_Paging_PDE_PT_Type.setPS (bits : Bit32_Paging_PDE_PT_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 7 1 value

def Bit32_Paging_PDE_PT_Type.PAGE_TABLE_ADDRESS (bits : Bit32_Paging_PDE_PT_Type) : Bits 20 :=
  BitVec.extractLsb' 12 20 bits

def Bit32_Paging_PDE_PT_Type.setPAGE_TABLE_ADDRESS (bits : Bit32_Paging_PDE_PT_Type) (value : Bits 20) : Bit32_Paging_PDE_PT_Type :=
  setSlice bits 12 20 value

end X86.Helpers

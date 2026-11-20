-- Generated from data/definitions.xml.gz: Bit32_Paging_PDE_4MB_Page_Type; do not edit.
-- Source SHA256: 1af3526f79e5ae14d74dff5bbb2dd19744904682396fb44f8ff38def27c6508f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Bit32_Paging_PDE_4MB_Page_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Bit32_Paging_PDE_4MB_Page_Type := Bits 32

def Bit32_Paging_PDE_4MB_Page_Type.P (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setP (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 0 1 value

def Bit32_Paging_PDE_4MB_Page_Type.RW (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setRW (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 1 1 value

def Bit32_Paging_PDE_4MB_Page_Type.US (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setUS (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 2 1 value

def Bit32_Paging_PDE_4MB_Page_Type.PWT (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setPWT (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 3 1 value

def Bit32_Paging_PDE_4MB_Page_Type.PCD (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setPCD (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 4 1 value

def Bit32_Paging_PDE_4MB_Page_Type.A (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setA (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 5 1 value

def Bit32_Paging_PDE_4MB_Page_Type.D (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setD (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 6 1 value

def Bit32_Paging_PDE_4MB_Page_Type.PS (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setPS (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 7 1 value

def Bit32_Paging_PDE_4MB_Page_Type.G (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setG (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 8 1 value

def Bit32_Paging_PDE_4MB_Page_Type.IGNORED (bits : Bit32_Paging_PDE_4MB_Page_Type) : Bits 3 :=
  BitVec.extractLsb' 9 3 bits

def Bit32_Paging_PDE_4MB_Page_Type.setIGNORED (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Bits 3) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 9 3 value

def Bit32_Paging_PDE_4MB_Page_Type.PAT (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 12 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setPAT (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 12 1 value

def Bit32_Paging_PDE_4MB_Page_Type.PAGE_ADDRESS (bits : Bit32_Paging_PDE_4MB_Page_Type) : Bits 18 :=
  BitVec.append (BitVec.extractLsb' 13 8 bits) (BitVec.extractLsb' 22 10 bits)

def Bit32_Paging_PDE_4MB_Page_Type.setPAGE_ADDRESS (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Bits 18) : Bit32_Paging_PDE_4MB_Page_Type :=
  let bits := setSlice bits 22 10 (BitVec.extractLsb' 0 10 value)
  setSlice bits 13 8 (BitVec.extractLsb' 10 8 value)

def Bit32_Paging_PDE_4MB_Page_Type.RESERVED (bits : Bit32_Paging_PDE_4MB_Page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 21 1 bits

def Bit32_Paging_PDE_4MB_Page_Type.setRESERVED (bits : Bit32_Paging_PDE_4MB_Page_Type) (value : Runtime.Bit) : Bit32_Paging_PDE_4MB_Page_Type :=
  setSlice bits 21 1 value

end X86.Helpers

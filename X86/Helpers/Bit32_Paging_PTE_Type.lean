-- Generated from data/definitions.xml.gz: Bit32_Paging_PTE_Type; do not edit.
-- Source SHA256: 5c209bd7e94ee5a81fe7dee77fa8bc9579865e0da48577176fc064b235b5a5b4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Bit32_Paging_PTE_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Bit32_Paging_PTE_Type := Bits 32

def Bit32_Paging_PTE_Type.P (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Bit32_Paging_PTE_Type.setP (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 0 1 value

def Bit32_Paging_PTE_Type.RW (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Bit32_Paging_PTE_Type.setRW (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 1 1 value

def Bit32_Paging_PTE_Type.US (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Bit32_Paging_PTE_Type.setUS (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 2 1 value

def Bit32_Paging_PTE_Type.PWT (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def Bit32_Paging_PTE_Type.setPWT (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 3 1 value

def Bit32_Paging_PTE_Type.PCD (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def Bit32_Paging_PTE_Type.setPCD (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 4 1 value

def Bit32_Paging_PTE_Type.A (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def Bit32_Paging_PTE_Type.setA (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 5 1 value

def Bit32_Paging_PTE_Type.D (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def Bit32_Paging_PTE_Type.setD (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 6 1 value

def Bit32_Paging_PTE_Type.PAT (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def Bit32_Paging_PTE_Type.setPAT (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 7 1 value

def Bit32_Paging_PTE_Type.G (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def Bit32_Paging_PTE_Type.setG (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 8 1 value

def Bit32_Paging_PTE_Type.IGNORED (bits : Bit32_Paging_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def Bit32_Paging_PTE_Type.setIGNORED (bits : Bit32_Paging_PTE_Type) (value : Runtime.Bit) : Bit32_Paging_PTE_Type :=
  setSlice bits 9 1 value

def Bit32_Paging_PTE_Type.PAGE_ADDRESS (bits : Bit32_Paging_PTE_Type) : Bits 20 :=
  BitVec.extractLsb' 12 20 bits

def Bit32_Paging_PTE_Type.setPAGE_ADDRESS (bits : Bit32_Paging_PTE_Type) (value : Bits 20) : Bit32_Paging_PTE_Type :=
  setSlice bits 12 20 value

end X86.Helpers

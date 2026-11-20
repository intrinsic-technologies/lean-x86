-- Generated from data/definitions.xml.gz: Level_5_Or_4_Paging_PDPTE_1GB_page_Type; do not edit.
-- Source SHA256: 0dc2940c003e8af63655d085bff1875cc67510797e56f3a23b8bb9636c4d8224
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Level_5_Or_4_Paging_PDPTE_1GB_page_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Level_5_Or_4_Paging_PDPTE_1GB_page_Type := Bits 64

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.P (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setP (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 0 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.RW (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setRW (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 1 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.US (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setUS (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 2 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PWT (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPWT (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 3 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PCD (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPCD (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 4 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.A (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setA (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 5 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.D (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setD (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 6 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PS (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPS (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 7 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.G (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setG (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 8 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.IGNORED (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Bits 9 :=
  BitVec.append (BitVec.extractLsb' 52 7 bits) (BitVec.extractLsb' 9 2 bits)

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setIGNORED (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Bits 9) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  let bits := setSlice bits 9 2 (BitVec.extractLsb' 0 2 value)
  setSlice bits 52 7 (BitVec.extractLsb' 2 7 value)

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.RESTART (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setRESTART (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 11 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PAT (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 12 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPAT (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 12 1 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.RESERVED (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Bits 17 :=
  BitVec.extractLsb' 13 17 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setRESERVED (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Bits 17) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 13 17 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PAGE_ADDRESS (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Bits 22 :=
  BitVec.extractLsb' 30 22 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPAGE_ADDRESS (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Bits 22) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 30 22 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.PROTECTION_KEY (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Bits 4 :=
  BitVec.extractLsb' 59 4 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPROTECTION_KEY (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Bits 4) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 59 4 value

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.XD (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) : Runtime.Bit :=
  BitVec.extractLsb' 63 1 bits

def Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setXD (bits : Level_5_Or_4_Paging_PDPTE_1GB_page_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PDPTE_1GB_page_Type :=
  setSlice bits 63 1 value

end X86.Helpers

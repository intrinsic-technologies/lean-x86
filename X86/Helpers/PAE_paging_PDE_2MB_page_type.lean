-- Generated from data/definitions.xml.gz: PAE_paging_PDE_2MB_page_type; do not edit.
-- Source SHA256: 4a9f12af6a6baa6e3f2db1ecaed674ddf975d9e62847459a0a95e1b12dcd4243
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=PAE_paging_PDE_2MB_page_type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev PAE_paging_PDE_2MB_page_type := Bits 64

def PAE_paging_PDE_2MB_page_type.P (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def PAE_paging_PDE_2MB_page_type.setP (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 0 1 value

def PAE_paging_PDE_2MB_page_type.RW (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def PAE_paging_PDE_2MB_page_type.setRW (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 1 1 value

def PAE_paging_PDE_2MB_page_type.US (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def PAE_paging_PDE_2MB_page_type.setUS (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 2 1 value

def PAE_paging_PDE_2MB_page_type.PWT (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def PAE_paging_PDE_2MB_page_type.setPWT (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 3 1 value

def PAE_paging_PDE_2MB_page_type.PCD (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def PAE_paging_PDE_2MB_page_type.setPCD (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 4 1 value

def PAE_paging_PDE_2MB_page_type.A (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def PAE_paging_PDE_2MB_page_type.setA (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 5 1 value

def PAE_paging_PDE_2MB_page_type.D (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def PAE_paging_PDE_2MB_page_type.setD (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 6 1 value

def PAE_paging_PDE_2MB_page_type.PS (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def PAE_paging_PDE_2MB_page_type.setPS (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 7 1 value

def PAE_paging_PDE_2MB_page_type.G (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def PAE_paging_PDE_2MB_page_type.setG (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 8 1 value

def PAE_paging_PDE_2MB_page_type.IGNORED (bits : PAE_paging_PDE_2MB_page_type) : Bits 3 :=
  BitVec.extractLsb' 9 3 bits

def PAE_paging_PDE_2MB_page_type.setIGNORED (bits : PAE_paging_PDE_2MB_page_type) (value : Bits 3) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 9 3 value

def PAE_paging_PDE_2MB_page_type.PAT (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 12 1 bits

def PAE_paging_PDE_2MB_page_type.setPAT (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 12 1 value

def PAE_paging_PDE_2MB_page_type.RESERVED (bits : PAE_paging_PDE_2MB_page_type) : Bits 19 :=
  BitVec.append (BitVec.extractLsb' 52 11 bits) (BitVec.extractLsb' 13 8 bits)

def PAE_paging_PDE_2MB_page_type.setRESERVED (bits : PAE_paging_PDE_2MB_page_type) (value : Bits 19) : PAE_paging_PDE_2MB_page_type :=
  let bits := setSlice bits 13 8 (BitVec.extractLsb' 0 8 value)
  setSlice bits 52 11 (BitVec.extractLsb' 8 11 value)

def PAE_paging_PDE_2MB_page_type.PAGE_ADDRESS (bits : PAE_paging_PDE_2MB_page_type) : Bits 31 :=
  BitVec.extractLsb' 21 31 bits

def PAE_paging_PDE_2MB_page_type.setPAGE_ADDRESS (bits : PAE_paging_PDE_2MB_page_type) (value : Bits 31) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 21 31 value

def PAE_paging_PDE_2MB_page_type.XD (bits : PAE_paging_PDE_2MB_page_type) : Runtime.Bit :=
  BitVec.extractLsb' 63 1 bits

def PAE_paging_PDE_2MB_page_type.setXD (bits : PAE_paging_PDE_2MB_page_type) (value : Runtime.Bit) : PAE_paging_PDE_2MB_page_type :=
  setSlice bits 63 1 value

end X86.Helpers

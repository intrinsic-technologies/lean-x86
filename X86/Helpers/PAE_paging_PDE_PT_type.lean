-- Generated from data/definitions.xml.gz: PAE_paging_PDE_PT_type; do not edit.
-- Source SHA256: 69c3693b3294b189ea96c4b5ff8b61a706ef5f53a1b2d8b8186f6598fd5432bb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=PAE_paging_PDE_PT_type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev PAE_paging_PDE_PT_type := Bits 64

def PAE_paging_PDE_PT_type.P (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def PAE_paging_PDE_PT_type.setP (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 0 1 value

def PAE_paging_PDE_PT_type.RW (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def PAE_paging_PDE_PT_type.setRW (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 1 1 value

def PAE_paging_PDE_PT_type.US (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def PAE_paging_PDE_PT_type.setUS (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 2 1 value

def PAE_paging_PDE_PT_type.PWT (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def PAE_paging_PDE_PT_type.setPWT (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 3 1 value

def PAE_paging_PDE_PT_type.PCD (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def PAE_paging_PDE_PT_type.setPCD (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 4 1 value

def PAE_paging_PDE_PT_type.A (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def PAE_paging_PDE_PT_type.setA (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 5 1 value

def PAE_paging_PDE_PT_type.IGNORED (bits : PAE_paging_PDE_PT_type) : Bits 5 :=
  BitVec.append (BitVec.extractLsb' 8 4 bits) (BitVec.extractLsb' 6 1 bits)

def PAE_paging_PDE_PT_type.setIGNORED (bits : PAE_paging_PDE_PT_type) (value : Bits 5) : PAE_paging_PDE_PT_type :=
  let bits := setSlice bits 6 1 (BitVec.extractLsb' 0 1 value)
  setSlice bits 8 4 (BitVec.extractLsb' 1 4 value)

def PAE_paging_PDE_PT_type.PS (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def PAE_paging_PDE_PT_type.setPS (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 7 1 value

def PAE_paging_PDE_PT_type.PAGE_TABLE_ADDRESS (bits : PAE_paging_PDE_PT_type) : Bits 40 :=
  BitVec.extractLsb' 12 40 bits

def PAE_paging_PDE_PT_type.setPAGE_TABLE_ADDRESS (bits : PAE_paging_PDE_PT_type) (value : Bits 40) : PAE_paging_PDE_PT_type :=
  setSlice bits 12 40 value

def PAE_paging_PDE_PT_type.RESERVED (bits : PAE_paging_PDE_PT_type) : Bits 11 :=
  BitVec.extractLsb' 52 11 bits

def PAE_paging_PDE_PT_type.setRESERVED (bits : PAE_paging_PDE_PT_type) (value : Bits 11) : PAE_paging_PDE_PT_type :=
  setSlice bits 52 11 value

def PAE_paging_PDE_PT_type.XD (bits : PAE_paging_PDE_PT_type) : Runtime.Bit :=
  BitVec.extractLsb' 63 1 bits

def PAE_paging_PDE_PT_type.setXD (bits : PAE_paging_PDE_PT_type) (value : Runtime.Bit) : PAE_paging_PDE_PT_type :=
  setSlice bits 63 1 value

end X86.Helpers

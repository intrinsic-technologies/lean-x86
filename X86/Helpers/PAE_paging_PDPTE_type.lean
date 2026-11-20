-- Generated from data/definitions.xml.gz: PAE_paging_PDPTE_type; do not edit.
-- Source SHA256: f06fe54dd6159efefdbcf9956234775fce3c2947dfc9a133e9584eda96906f47
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=PAE_paging_PDPTE_type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev PAE_paging_PDPTE_type := Bits 64

def PAE_paging_PDPTE_type.P (bits : PAE_paging_PDPTE_type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def PAE_paging_PDPTE_type.setP (bits : PAE_paging_PDPTE_type) (value : Runtime.Bit) : PAE_paging_PDPTE_type :=
  setSlice bits 0 1 value

def PAE_paging_PDPTE_type.RESERVED (bits : PAE_paging_PDPTE_type) : Bits 18 :=
  BitVec.append (BitVec.append (BitVec.extractLsb' 52 12 bits) (BitVec.extractLsb' 5 4 bits)) (BitVec.extractLsb' 1 2 bits)

def PAE_paging_PDPTE_type.setRESERVED (bits : PAE_paging_PDPTE_type) (value : Bits 18) : PAE_paging_PDPTE_type :=
  let bits := setSlice bits 1 2 (BitVec.extractLsb' 0 2 value)
  let bits := setSlice bits 5 4 (BitVec.extractLsb' 2 4 value)
  setSlice bits 52 12 (BitVec.extractLsb' 6 12 value)

def PAE_paging_PDPTE_type.PWT (bits : PAE_paging_PDPTE_type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def PAE_paging_PDPTE_type.setPWT (bits : PAE_paging_PDPTE_type) (value : Runtime.Bit) : PAE_paging_PDPTE_type :=
  setSlice bits 3 1 value

def PAE_paging_PDPTE_type.PCD (bits : PAE_paging_PDPTE_type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def PAE_paging_PDPTE_type.setPCD (bits : PAE_paging_PDPTE_type) (value : Runtime.Bit) : PAE_paging_PDPTE_type :=
  setSlice bits 4 1 value

def PAE_paging_PDPTE_type.IGNORED (bits : PAE_paging_PDPTE_type) : Bits 3 :=
  BitVec.extractLsb' 9 3 bits

def PAE_paging_PDPTE_type.setIGNORED (bits : PAE_paging_PDPTE_type) (value : Bits 3) : PAE_paging_PDPTE_type :=
  setSlice bits 9 3 value

def PAE_paging_PDPTE_type.PAGE_DIRECTORY_ADDRESS (bits : PAE_paging_PDPTE_type) : Bits 40 :=
  BitVec.extractLsb' 12 40 bits

def PAE_paging_PDPTE_type.setPAGE_DIRECTORY_ADDRESS (bits : PAE_paging_PDPTE_type) (value : Bits 40) : PAE_paging_PDPTE_type :=
  setSlice bits 12 40 value

end X86.Helpers

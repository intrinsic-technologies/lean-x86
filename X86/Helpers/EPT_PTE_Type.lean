-- Generated from data/definitions.xml.gz: EPT_PTE_Type; do not edit.
-- Source SHA256: eebff518f9c261408148805bace3befaeaddccd373c5b9c83bdef8623c3b4019
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT_PTE_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev EPT_PTE_Type := Bits 64

def EPT_PTE_Type.READ (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def EPT_PTE_Type.setREAD (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 0 1 value

def EPT_PTE_Type.WRITE (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def EPT_PTE_Type.setWRITE (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 1 1 value

def EPT_PTE_Type.EXECUTE_SUPERVISOR (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def EPT_PTE_Type.setEXECUTE_SUPERVISOR (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 2 1 value

def EPT_PTE_Type.EU_ES_W_R (bits : EPT_PTE_Type) : Bits 4 :=
  BitVec.append (BitVec.extractLsb' 10 1 bits) (BitVec.extractLsb' 0 3 bits)

def EPT_PTE_Type.setEU_ES_W_R (bits : EPT_PTE_Type) (value : Bits 4) : EPT_PTE_Type :=
  let bits := setSlice bits 0 3 (BitVec.extractLsb' 0 3 value)
  setSlice bits 10 1 (BitVec.extractLsb' 3 1 value)

def EPT_PTE_Type.EPT_MEMORY_TYPE (bits : EPT_PTE_Type) : Bits 3 :=
  BitVec.extractLsb' 3 3 bits

def EPT_PTE_Type.setEPT_MEMORY_TYPE (bits : EPT_PTE_Type) (value : Bits 3) : EPT_PTE_Type :=
  setSlice bits 3 3 value

def EPT_PTE_Type.IGNORE_PAT_MEMORY_TYPE (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def EPT_PTE_Type.setIGNORE_PAT_MEMORY_TYPE (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 6 1 value

def EPT_PTE_Type.ACCESSED_FLAG (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def EPT_PTE_Type.setACCESSED_FLAG (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 8 1 value

def EPT_PTE_Type.DIRTY_FLAG (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def EPT_PTE_Type.setDIRTY_FLAG (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 9 1 value

def EPT_PTE_Type.EXECUTE_USER (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def EPT_PTE_Type.setEXECUTE_USER (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 10 1 value

def EPT_PTE_Type.EPT_PAGE_PHYSICAL_ADDRESS (bits : EPT_PTE_Type) : Bits 40 :=
  BitVec.extractLsb' 12 40 bits

def EPT_PTE_Type.setEPT_PAGE_PHYSICAL_ADDRESS (bits : EPT_PTE_Type) (value : Bits 40) : EPT_PTE_Type :=
  setSlice bits 12 40 value

def EPT_PTE_Type.VERIFY_GUEST_PAGING (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 57 1 bits

def EPT_PTE_Type.setVERIFY_GUEST_PAGING (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 57 1 value

def EPT_PTE_Type.PAGING_WRITE_ACCESS (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 58 1 bits

def EPT_PTE_Type.setPAGING_WRITE_ACCESS (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 58 1 value

def EPT_PTE_Type.SUPERVISOR_SHADOW_STACK (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 60 1 bits

def EPT_PTE_Type.setSUPERVISOR_SHADOW_STACK (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 60 1 value

def EPT_PTE_Type.SUB_PAGE_WRITE_PERMISSIONS (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 61 1 bits

def EPT_PTE_Type.setSUB_PAGE_WRITE_PERMISSIONS (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 61 1 value

def EPT_PTE_Type.SUPPRESS_VE (bits : EPT_PTE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 63 1 bits

def EPT_PTE_Type.setSUPPRESS_VE (bits : EPT_PTE_Type) (value : Runtime.Bit) : EPT_PTE_Type :=
  setSlice bits 63 1 value

def EPT_PTE_Type.IGNORED (bits : EPT_PTE_Type) : Bits 9 :=
  BitVec.append (BitVec.append (BitVec.append (BitVec.append (BitVec.extractLsb' 62 1 bits) (BitVec.extractLsb' 59 1 bits)) (BitVec.extractLsb' 52 5 bits)) (BitVec.extractLsb' 11 1 bits)) (BitVec.extractLsb' 7 1 bits)

def EPT_PTE_Type.setIGNORED (bits : EPT_PTE_Type) (value : Bits 9) : EPT_PTE_Type :=
  let bits := setSlice bits 7 1 (BitVec.extractLsb' 0 1 value)
  let bits := setSlice bits 11 1 (BitVec.extractLsb' 1 1 value)
  let bits := setSlice bits 52 5 (BitVec.extractLsb' 2 5 value)
  let bits := setSlice bits 59 1 (BitVec.extractLsb' 7 1 value)
  setSlice bits 62 1 (BitVec.extractLsb' 8 1 value)

end X86.Helpers

-- Generated from data/definitions.xml.gz: EPT_PDE_2MByte_Type; do not edit.
-- Source SHA256: 665732e8a23f24f4b3bc59a0bf748defa564ae0d20201d89292dd8e047d1c313
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT_PDE_2MByte_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev EPT_PDE_2MByte_Type := Bits 64

def EPT_PDE_2MByte_Type.READ (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def EPT_PDE_2MByte_Type.setREAD (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 0 1 value

def EPT_PDE_2MByte_Type.WRITE (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def EPT_PDE_2MByte_Type.setWRITE (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 1 1 value

def EPT_PDE_2MByte_Type.EXECUTE_SUPERVISOR (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def EPT_PDE_2MByte_Type.setEXECUTE_SUPERVISOR (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 2 1 value

def EPT_PDE_2MByte_Type.EU_ES_W_R (bits : EPT_PDE_2MByte_Type) : Bits 4 :=
  BitVec.append (BitVec.extractLsb' 10 1 bits) (BitVec.extractLsb' 0 3 bits)

def EPT_PDE_2MByte_Type.setEU_ES_W_R (bits : EPT_PDE_2MByte_Type) (value : Bits 4) : EPT_PDE_2MByte_Type :=
  let bits := setSlice bits 0 3 (BitVec.extractLsb' 0 3 value)
  setSlice bits 10 1 (BitVec.extractLsb' 3 1 value)

def EPT_PDE_2MByte_Type.EPT_MEMORY_TYPE (bits : EPT_PDE_2MByte_Type) : Bits 3 :=
  BitVec.extractLsb' 3 3 bits

def EPT_PDE_2MByte_Type.setEPT_MEMORY_TYPE (bits : EPT_PDE_2MByte_Type) (value : Bits 3) : EPT_PDE_2MByte_Type :=
  setSlice bits 3 3 value

def EPT_PDE_2MByte_Type.IGNORE_PAT_MEMORY_TYPE (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def EPT_PDE_2MByte_Type.setIGNORE_PAT_MEMORY_TYPE (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 6 1 value

def EPT_PDE_2MByte_Type.MAPS_2MBYTE_PAGE (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def EPT_PDE_2MByte_Type.setMAPS_2MBYTE_PAGE (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 7 1 value

def EPT_PDE_2MByte_Type.ACCESSED_FLAG (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def EPT_PDE_2MByte_Type.setACCESSED_FLAG (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 8 1 value

def EPT_PDE_2MByte_Type.DIRTY_FLAG (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def EPT_PDE_2MByte_Type.setDIRTY_FLAG (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 9 1 value

def EPT_PDE_2MByte_Type.EXECUTE_USER (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def EPT_PDE_2MByte_Type.setEXECUTE_USER (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 10 1 value

def EPT_PDE_2MByte_Type.RESERVED_MBZ (bits : EPT_PDE_2MByte_Type) : Bits 9 :=
  BitVec.extractLsb' 12 9 bits

def EPT_PDE_2MByte_Type.setRESERVED_MBZ (bits : EPT_PDE_2MByte_Type) (value : Bits 9) : EPT_PDE_2MByte_Type :=
  setSlice bits 12 9 value

def EPT_PDE_2MByte_Type.EPT_PAGE_PHYSICAL_ADDRESS (bits : EPT_PDE_2MByte_Type) : Bits 31 :=
  BitVec.extractLsb' 21 31 bits

def EPT_PDE_2MByte_Type.setEPT_PAGE_PHYSICAL_ADDRESS (bits : EPT_PDE_2MByte_Type) (value : Bits 31) : EPT_PDE_2MByte_Type :=
  setSlice bits 21 31 value

def EPT_PDE_2MByte_Type.VERIFY_GUEST_PAGING (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 57 1 bits

def EPT_PDE_2MByte_Type.setVERIFY_GUEST_PAGING (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 57 1 value

def EPT_PDE_2MByte_Type.PAGING_WRITE_ACCESS (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 58 1 bits

def EPT_PDE_2MByte_Type.setPAGING_WRITE_ACCESS (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 58 1 value

def EPT_PDE_2MByte_Type.SUPERVISOR_SHADOW_STACK (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 60 1 bits

def EPT_PDE_2MByte_Type.setSUPERVISOR_SHADOW_STACK (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 60 1 value

def EPT_PDE_2MByte_Type.SUPPRESS_VE (bits : EPT_PDE_2MByte_Type) : Runtime.Bit :=
  BitVec.extractLsb' 63 1 bits

def EPT_PDE_2MByte_Type.setSUPPRESS_VE (bits : EPT_PDE_2MByte_Type) (value : Runtime.Bit) : EPT_PDE_2MByte_Type :=
  setSlice bits 63 1 value

def EPT_PDE_2MByte_Type.IGNORED (bits : EPT_PDE_2MByte_Type) : Bits 9 :=
  BitVec.append (BitVec.append (BitVec.append (BitVec.extractLsb' 61 2 bits) (BitVec.extractLsb' 59 1 bits)) (BitVec.extractLsb' 52 5 bits)) (BitVec.extractLsb' 11 1 bits)

def EPT_PDE_2MByte_Type.setIGNORED (bits : EPT_PDE_2MByte_Type) (value : Bits 9) : EPT_PDE_2MByte_Type :=
  let bits := setSlice bits 11 1 (BitVec.extractLsb' 0 1 value)
  let bits := setSlice bits 52 5 (BitVec.extractLsb' 1 5 value)
  let bits := setSlice bits 59 1 (BitVec.extractLsb' 6 1 value)
  setSlice bits 61 2 (BitVec.extractLsb' 7 2 value)

end X86.Helpers

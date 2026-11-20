-- Generated from data/definitions.xml.gz: EPT_Exit_Qualification_Type; do not edit.
-- Source SHA256: d882a46ddc70cc3dbaf1b173be32244e8191fc242c205b2a859fcd3582edeb7f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT_Exit_Qualification_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev EPT_Exit_Qualification_Type := Bits 64

def EPT_Exit_Qualification_Type.READ (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def EPT_Exit_Qualification_Type.setREAD (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 0 1 value

def EPT_Exit_Qualification_Type.WRITE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def EPT_Exit_Qualification_Type.setWRITE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 1 1 value

def EPT_Exit_Qualification_Type.EXECUTE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def EPT_Exit_Qualification_Type.setEXECUTE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 2 1 value

def EPT_Exit_Qualification_Type.EPT_READABLE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def EPT_Exit_Qualification_Type.setEPT_READABLE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 3 1 value

def EPT_Exit_Qualification_Type.EPT_WRITABLE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def EPT_Exit_Qualification_Type.setEPT_WRITABLE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 4 1 value

def EPT_Exit_Qualification_Type.EPT_EXECUTABLE_SUPERVISOR (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def EPT_Exit_Qualification_Type.setEPT_EXECUTABLE_SUPERVISOR (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 5 1 value

def EPT_Exit_Qualification_Type.EPT_EXECUTABLE_USER (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def EPT_Exit_Qualification_Type.setEPT_EXECUTABLE_USER (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 6 1 value

def EPT_Exit_Qualification_Type.GUEST_LINEAR_ADDR_VALID (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def EPT_Exit_Qualification_Type.setGUEST_LINEAR_ADDR_VALID (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 7 1 value

def EPT_Exit_Qualification_Type.LINEAR_ADDR_TRANSLATION (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def EPT_Exit_Qualification_Type.setLINEAR_ADDR_TRANSLATION (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 8 1 value

def EPT_Exit_Qualification_Type.USER_MODE_LINEAR_ADDR (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def EPT_Exit_Qualification_Type.setUSER_MODE_LINEAR_ADDR (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 9 1 value

def EPT_Exit_Qualification_Type.READ_WRITE_PAGE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def EPT_Exit_Qualification_Type.setREAD_WRITE_PAGE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 10 1 value

def EPT_Exit_Qualification_Type.EXECUTE_DISABLE_PAGE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def EPT_Exit_Qualification_Type.setEXECUTE_DISABLE_PAGE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 11 1 value

def EPT_Exit_Qualification_Type.NMI_BLOCKING_DUE_TO_IRET (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 12 1 bits

def EPT_Exit_Qualification_Type.setNMI_BLOCKING_DUE_TO_IRET (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 12 1 value

def EPT_Exit_Qualification_Type.SHADOW_STACK_ACCESS (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 13 1 bits

def EPT_Exit_Qualification_Type.setSHADOW_STACK_ACCESS (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 13 1 value

def EPT_Exit_Qualification_Type.SHADOW_STACK_STORE (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 14 1 bits

def EPT_Exit_Qualification_Type.setSHADOW_STACK_STORE (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 14 1 value

def EPT_Exit_Qualification_Type.GUEST_PAGING_VERIFICATION (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 15 1 bits

def EPT_Exit_Qualification_Type.setGUEST_PAGING_VERIFICATION (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 15 1 value

def EPT_Exit_Qualification_Type.ASYNCHRONOUS (bits : EPT_Exit_Qualification_Type) : Runtime.Bit :=
  BitVec.extractLsb' 16 1 bits

def EPT_Exit_Qualification_Type.setASYNCHRONOUS (bits : EPT_Exit_Qualification_Type) (value : Runtime.Bit) : EPT_Exit_Qualification_Type :=
  setSlice bits 16 1 value

def EPT_Exit_Qualification_Type.UNDEFINED (bits : EPT_Exit_Qualification_Type) : Bits 47 :=
  BitVec.extractLsb' 17 47 bits

def EPT_Exit_Qualification_Type.setUNDEFINED (bits : EPT_Exit_Qualification_Type) (value : Bits 47) : EPT_Exit_Qualification_Type :=
  setSlice bits 17 47 value

end X86.Helpers

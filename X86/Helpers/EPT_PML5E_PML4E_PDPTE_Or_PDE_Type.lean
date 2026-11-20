-- Generated from data/definitions.xml.gz: EPT_PML5E_PML4E_PDPTE_Or_PDE_Type; do not edit.
-- Source SHA256: 1709ed380dd76a60e3615361925214ca1ff8bfb672e97caa8ede7cc492542e23
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT_PML5E_PML4E_PDPTE_Or_PDE_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev EPT_PML5E_PML4E_PDPTE_Or_PDE_Type := Bits 64

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.READ (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setREAD (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Runtime.Bit) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 0 1 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.WRITE (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setWRITE (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Runtime.Bit) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 1 1 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EXECUTE_SUPERVISOR (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setEXECUTE_SUPERVISOR (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Runtime.Bit) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 2 1 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EU_ES_W_R (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Bits 4 :=
  BitVec.append (BitVec.extractLsb' 10 1 bits) (BitVec.extractLsb' 0 3 bits)

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setEU_ES_W_R (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Bits 4) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  let bits := setSlice bits 0 3 (BitVec.extractLsb' 0 3 value)
  setSlice bits 10 1 (BitVec.extractLsb' 3 1 value)

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.RESERVED_MBZ (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Bits 5 :=
  BitVec.extractLsb' 3 5 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setRESERVED_MBZ (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Bits 5) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 3 5 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.ACCESSED (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setACCESSED (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Runtime.Bit) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 8 1 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EXECUTE_USER (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setEXECUTE_USER (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Runtime.Bit) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 10 1 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.EPT_PML4T_PDPT_PD_OR_PT_ADDRESS (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Bits 40 :=
  BitVec.extractLsb' 12 40 bits

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setEPT_PML4T_PDPT_PD_OR_PT_ADDRESS (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Bits 40) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  setSlice bits 12 40 value

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.IGNORED (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) : Bits 14 :=
  BitVec.append (BitVec.append (BitVec.extractLsb' 52 12 bits) (BitVec.extractLsb' 11 1 bits)) (BitVec.extractLsb' 9 1 bits)

def EPT_PML5E_PML4E_PDPTE_Or_PDE_Type.setIGNORED (bits : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type) (value : Bits 14) : EPT_PML5E_PML4E_PDPTE_Or_PDE_Type :=
  let bits := setSlice bits 9 1 (BitVec.extractLsb' 0 1 value)
  let bits := setSlice bits 11 1 (BitVec.extractLsb' 1 1 value)
  setSlice bits 52 12 (BitVec.extractLsb' 2 12 value)

end X86.Helpers

-- Generated from data/definitions.xml.gz: Page_Fault_Error_Code; do not edit.
-- Source SHA256: 5a2c636dc3c7aa56e9d34e6e56e2109a88c2e83741c1fb6521c27480aa0a5d30
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Page_Fault_Error_Code)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Page_Fault_Error_Code := Bits 32

def Page_Fault_Error_Code.P (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Page_Fault_Error_Code.setP (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 0 1 value

def Page_Fault_Error_Code.W_R (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Page_Fault_Error_Code.setW_R (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 1 1 value

def Page_Fault_Error_Code.U_S (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Page_Fault_Error_Code.setU_S (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 2 1 value

def Page_Fault_Error_Code.RSVD (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def Page_Fault_Error_Code.setRSVD (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 3 1 value

def Page_Fault_Error_Code.I_D (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def Page_Fault_Error_Code.setI_D (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 4 1 value

def Page_Fault_Error_Code.PK (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def Page_Fault_Error_Code.setPK (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 5 1 value

def Page_Fault_Error_Code.SS (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def Page_Fault_Error_Code.setSS (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 6 1 value

def Page_Fault_Error_Code.HLAT (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def Page_Fault_Error_Code.setHLAT (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 7 1 value

def Page_Fault_Error_Code.RESERVED (bits : Page_Fault_Error_Code) : Bits 23 :=
  BitVec.append (BitVec.extractLsb' 16 16 bits) (BitVec.extractLsb' 8 7 bits)

def Page_Fault_Error_Code.setRESERVED (bits : Page_Fault_Error_Code) (value : Bits 23) : Page_Fault_Error_Code :=
  let bits := setSlice bits 8 7 (BitVec.extractLsb' 0 7 value)
  setSlice bits 16 16 (BitVec.extractLsb' 7 16 value)

def Page_Fault_Error_Code.SGX (bits : Page_Fault_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 15 1 bits

def Page_Fault_Error_Code.setSGX (bits : Page_Fault_Error_Code) (value : Runtime.Bit) : Page_Fault_Error_Code :=
  setSlice bits 15 1 value

end X86.Helpers

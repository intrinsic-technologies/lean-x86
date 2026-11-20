-- Generated from data/definitions.xml.gz: Selector_Error_Code; do not edit.
-- Source SHA256: 57917263226eb4fb2563f04f004b11056be271db1a5987022995a9110487d368
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Selector_Error_Code)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Selector_Error_Code := Bits 32

def Selector_Error_Code.EXT (bits : Selector_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Selector_Error_Code.setEXT (bits : Selector_Error_Code) (value : Runtime.Bit) : Selector_Error_Code :=
  setSlice bits 0 1 value

def Selector_Error_Code.IDT (bits : Selector_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Selector_Error_Code.setIDT (bits : Selector_Error_Code) (value : Runtime.Bit) : Selector_Error_Code :=
  setSlice bits 1 1 value

def Selector_Error_Code.TI (bits : Selector_Error_Code) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Selector_Error_Code.setTI (bits : Selector_Error_Code) (value : Runtime.Bit) : Selector_Error_Code :=
  setSlice bits 2 1 value

def Selector_Error_Code.Index (bits : Selector_Error_Code) : Bits 13 :=
  BitVec.extractLsb' 3 13 bits

def Selector_Error_Code.setIndex (bits : Selector_Error_Code) (value : Bits 13) : Selector_Error_Code :=
  setSlice bits 3 13 value

def Selector_Error_Code.RESERVED (bits : Selector_Error_Code) : Bits 16 :=
  BitVec.extractLsb' 16 16 bits

def Selector_Error_Code.setRESERVED (bits : Selector_Error_Code) (value : Bits 16) : Selector_Error_Code :=
  setSlice bits 16 16 value

end X86.Helpers

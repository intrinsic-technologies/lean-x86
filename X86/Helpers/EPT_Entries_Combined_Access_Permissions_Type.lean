-- Generated from data/definitions.xml.gz: EPT_Entries_Combined_Access_Permissions_Type; do not edit.
-- Source SHA256: 9cfc489c7e48bef824152fe80d292bf0668f381b83fe8cb10053fc08cebd0a39
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT_Entries_Combined_Access_Permissions_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev EPT_Entries_Combined_Access_Permissions_Type := Bits 4

def EPT_Entries_Combined_Access_Permissions_Type.READ (bits : EPT_Entries_Combined_Access_Permissions_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def EPT_Entries_Combined_Access_Permissions_Type.setREAD (bits : EPT_Entries_Combined_Access_Permissions_Type) (value : Runtime.Bit) : EPT_Entries_Combined_Access_Permissions_Type :=
  setSlice bits 0 1 value

def EPT_Entries_Combined_Access_Permissions_Type.WRITE (bits : EPT_Entries_Combined_Access_Permissions_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def EPT_Entries_Combined_Access_Permissions_Type.setWRITE (bits : EPT_Entries_Combined_Access_Permissions_Type) (value : Runtime.Bit) : EPT_Entries_Combined_Access_Permissions_Type :=
  setSlice bits 1 1 value

def EPT_Entries_Combined_Access_Permissions_Type.EXECUTE_SUPERVISOR (bits : EPT_Entries_Combined_Access_Permissions_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def EPT_Entries_Combined_Access_Permissions_Type.setEXECUTE_SUPERVISOR (bits : EPT_Entries_Combined_Access_Permissions_Type) (value : Runtime.Bit) : EPT_Entries_Combined_Access_Permissions_Type :=
  setSlice bits 2 1 value

def EPT_Entries_Combined_Access_Permissions_Type.EXECUTE_USER (bits : EPT_Entries_Combined_Access_Permissions_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def EPT_Entries_Combined_Access_Permissions_Type.setEXECUTE_USER (bits : EPT_Entries_Combined_Access_Permissions_Type) (value : Runtime.Bit) : EPT_Entries_Combined_Access_Permissions_Type :=
  setSlice bits 3 1 value

end X86.Helpers

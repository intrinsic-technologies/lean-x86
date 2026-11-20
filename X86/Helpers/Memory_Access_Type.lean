-- Generated from data/definitions.xml.gz: Memory_Access_Type; do not edit.
-- Source SHA256: f8ecf5f08467906fc7397990708db1f11539855a72329a653817a4ac2b75f05b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Memory_Access_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Memory_Access_Type where
  | Memory_Read
  | Memory_Write
  | Memory_Read_Modify_Write
  | Memory_Execute
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

-- Generated from data/definitions.xml.gz: Memory_Type; do not edit.
-- Source SHA256: d1eb82549ee316cd7dfe4f3ea4493dd54bcab97006723f317b058e51a64562ed
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Memory_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Memory_Type where
  | Memory_Type_Strong_Uncacheable
  | Memory_Type_Uncacheable
  | Memory_Type_Write_Combining
  | Memory_Type_Write_Through
  | Memory_Type_Write_Back
  | Memory_Type_Write_Protected
  | Memory_Type_Unknown
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

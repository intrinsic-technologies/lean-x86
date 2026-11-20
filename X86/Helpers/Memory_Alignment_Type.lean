-- Generated from data/definitions.xml.gz: Memory_Alignment_Type; do not edit.
-- Source SHA256: 9c21966f4db934c07ca568cf76bd99471c06a22abaebc7441304dd2d284245e6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Memory_Alignment_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Memory_Alignment_Type where
  | Normal_Alignment
  | Explicitly_Aligned
  | Explicitly_Unaligned
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

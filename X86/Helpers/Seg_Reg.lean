-- Generated from data/definitions.xml.gz: Seg_Reg; do not edit.
-- Source SHA256: 3846d44eace6f5e85fab07c06c73e44f7f2d15e58b81c6c10b6dcafdc61e76a9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Seg_Reg)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Seg_Reg where
  | Seg_Reg_CS
  | Seg_Reg_DS
  | Seg_Reg_ES
  | Seg_Reg_FS
  | Seg_Reg_GS
  | Seg_Reg_SS
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

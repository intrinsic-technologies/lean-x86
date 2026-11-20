-- Generated from data/definitions.xml.gz: CP_Error_Code; do not edit.
-- Source SHA256: 4c3bb3dfbf66fcf584a94106c3a34688418d45cd96328721f1ef05db274bc921
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CP_Error_Code)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive CP_Error_Code where
  | NEAR_RET
  | FAR_RET_or_IRET
  | ENDBRANCH
  | RSTORSSP
  | SETSSBSY
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

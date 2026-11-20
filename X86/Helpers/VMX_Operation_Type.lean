-- Generated from data/definitions.xml.gz: VMX_Operation_Type; do not edit.
-- Source SHA256: 1b1a96c268fb92d25ba6880edd634f6e18d0c232e76f655f8087a99684bca3e6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX_Operation_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive VMX_Operation_Type where
  | Outside_VMX_Operation
  | VMX_Root
  | VMX_Non_Root
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

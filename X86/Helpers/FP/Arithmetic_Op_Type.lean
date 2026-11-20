-- Generated from data/definitions.xml.gz: FP::Arithmetic_Op_Type; do not edit.
-- Source SHA256: c132463817382017392eb94fbc07da1da2cb5b6b44193a7973ef6b880831f473
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AArithmetic_Op_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive «FP::Arithmetic_Op_Type» where
  | FP_ADD
  | FP_SUB
  | FP_MUL
  | FP_DIV
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

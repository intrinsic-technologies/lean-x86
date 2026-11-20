-- Generated from data/definitions.xml.gz: Exception_Info; do not edit.
-- Source SHA256: 4668481dc941873c2020d84358866ec280746539556f4d54309bb9821fbe46db
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Exception_Info)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Exception_Info where
  vector : Int
  linear_address : Bits 64
  error_code : Bits 32
  deriving Repr, DecidableEq

end X86.Helpers

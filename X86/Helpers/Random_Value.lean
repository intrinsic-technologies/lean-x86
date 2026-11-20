-- Generated from data/definitions.xml.gz: Random_Value; do not edit.
-- Source SHA256: 39a7ec33fb8d39bcfa50f9b14f73149a2414c31a5c695267d07391e0d3e95892
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Random_Value)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Random_Value where
  Ready : Bool
  Data : Bits 384
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

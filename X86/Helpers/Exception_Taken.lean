-- Generated from data/definitions.xml.gz: Exception_Taken; do not edit.
-- Source SHA256: 9a4216b770a08bba592f3c1f41cb5df0c37509355b4a7207ec36b1bf66da4488
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Exception_Taken)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Exception_Taken where
  deriving Repr, DecidableEq

end X86.Helpers

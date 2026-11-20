-- Generated from data/definitions.xml.gz: Descriptor_Table_Register; do not edit.
-- Source SHA256: 2dc418888868cccedd333493799793675338dbf270b99ef61d276edcdd91c5f0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Descriptor_Table_Register)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Descriptor_Table_Register where
  limit : Bits 16
  base : Bits 64
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers

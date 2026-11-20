-- Generated from data/definitions.xml.gz: INTR_PERMISSION_BASE_OFFSET; do not edit.
-- Source SHA256: 98dbd6f965b421eb603d7be80733f43157f9e1d01cec418824f6b90d77b46975
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=INTR_PERMISSION_BASE_OFFSET)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def INTR_PERMISSION_BASE_OFFSET : Bits 64 := (102 : Bits 64)

end X86.Helpers

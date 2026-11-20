-- Generated from data/definitions.xml.gz: Num_Debug_Breakpoints; do not edit.
-- Source SHA256: 3619227f444934b0af679e439af1426fd42f13325b6103d9f40456dcff1f0386
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Num_Debug_Breakpoints)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Num_Debug_Breakpoints : Int := 4

end X86.Helpers

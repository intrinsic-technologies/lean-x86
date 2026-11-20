-- Generated from data/definitions.xml.gz: Is_Canonical_Wrt_Max_Size; do not edit.
-- Source SHA256: 4d502aafc47527d6f1a52518c2ce3e3baaf3f8290add27183aad6c44c738b2f2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Canonical_Wrt_Max_Size)
import X86.Runtime
import X86.Helpers.Is_Canonical_Wrt_Position
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable
  [X86.Config.Value.Max_Linear_Address]

def Is_Canonical_Wrt_Max_Size (address : Bits 64) : Except (Runtime.Error Empty) (Bool) := do
  return (← Is_Canonical_Wrt_Position address (← Config.Read.Max_Linear_Address (exception := Empty)))

end X86.Helpers

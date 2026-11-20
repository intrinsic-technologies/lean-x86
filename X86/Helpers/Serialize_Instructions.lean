-- Generated from data/definitions.xml.gz: Serialize_Instructions; do not edit.
-- Source SHA256: 8209ff4f0fd53c189a4177457c65be353bc5e488322aae96a6e47bc075c7901e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Serialize_Instructions)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Serialize_Instructions  : Except (Runtime.Error Empty) Unit := do
  pure ()

end X86.Helpers

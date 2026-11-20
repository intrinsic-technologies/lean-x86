-- Generated from data/definitions.xml.gz: Physical_Mem_Fetch; do not edit.
-- Source SHA256: b6ec0e3e125ad05d9b440c47ea7efc7071e5e664092d17e874a5ec3c6463a88a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Physical_Mem_Fetch)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.__Physical_Mem_Fetch.Binding σ]

def Physical_Mem_Fetch
    (physical : Address_Translation) :
    Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← __Physical_Mem_Fetch physical.translation1.physical_address physical.translation1.memory_type)

end X86.Helpers

-- Generated from data/definitions.xml.gz: FP87::Is_Enabled; do not edit.
-- Source SHA256: 40113026f3ecec6a4243a666ae5fac46d8dcf7a4bae2278d9aa850072107ddf4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AIs_Enabled)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def FP87.Is_Enabled  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← CR0.EM) == 0 and (← CR0.TS) == 0

end X86.Helpers

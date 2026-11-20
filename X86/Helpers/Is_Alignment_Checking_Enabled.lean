-- Generated from data/definitions.xml.gz: Is_Alignment_Checking_Enabled; do not edit.
-- Source SHA256: ab39accca707f5f66141b36c332591bcb5e172c174d1226adba00b8de500b8ee
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Alignment_Checking_Enabled)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def Is_Alignment_Checking_Enabled  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← get).CPL == 3 and (← CR0.AM) == 1 and (← RFLAGS.AC) == 1

end X86.Helpers

-- Generated from data/definitions.xml.gz: Is_EPT_Enabled; do not edit.
-- Source SHA256: 68dba0487cd0d95089481c2ffef5ecea5bf97d85f859b26c1087e159aa297895
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_EPT_Enabled)
import X86.Runtime
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.VM_Exec_Controls2.Binding σ]

def Is_EPT_Enabled  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root and (← VM_Exec_Controls2).Enable_EPT == 1

end X86.Helpers

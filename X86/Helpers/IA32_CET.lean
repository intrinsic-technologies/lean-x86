-- Generated from data/definitions.xml.gz: IA32_CET; do not edit.
-- Source SHA256: 8ab385b847043cd82f10413df37c7fe1c92453a11ab4924e4235cd30d3bb9bd8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=IA32_CET)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def IA32_CET (cpl : Int) : Runtime.SpecM Exception (State σ) (IA32_U_CET_Type) := do
  Runtime.assert (cpl in {0..3})

  return (← (do if cpl == 3 then pure (← get).IA32_U_CET else pure (← get).IA32_S_CET))

def IA32_CET_write
    (cpl : Int) (value : IA32_U_CET_Type) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (cpl in {0..3})

  if (cpl == 3) then
    modify ({ · with IA32_U_CET := value })
  else
    modify ({ · with IA32_S_CET := value })

end X86.Helpers

-- Generated from data/definitions.xml.gz: Monitor::Clear_FSM; do not edit.
-- Source SHA256: 90093edc07ab5473d8bea19d950da3730dd7a496ea8aa65b0bf8ed224f17953a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Monitor%3A%3AClear_FSM)
import X86.Runtime
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Thread_Status_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Monitor.Clear_FSM  : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with «Monitor::Is_Armed» := false })
  «Monitor::Address».assign (← Std.Bits.Zero 64)
  modify ({ · with «Monitor::Is_User_Monitor» := false })

  if ((← get).Thread_Status == Thread_Status_Type.THREAD_MWAITING) then
    modify ({ · with Thread_Status := Thread_Status_Type.THREAD_ACTIVE })

end X86.Helpers

-- Generated from data/definitions.xml.gz: Handle_Multiple_Exceptions; do not edit.
-- Source SHA256: 7762c77a494909cef507b8bcfff35c858ade761e12081b04fc6190aefdce84b6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Handle_Multiple_Exceptions)
import X86.Runtime
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Flags_To_Save_On_Exception
import X86.Helpers.Is_Contributory
import X86.Helpers.Is_Page_Fault
import X86.Helpers.Report_Double_Fault
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Handle_Multiple_Exceptions
    (exception1 exception2 : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (exception1 in {0..255})
  Runtime.assert (exception2 in {0..255})

  if ((← Is_Contributory exception1) and (← Is_Contributory exception2) or (← Is_Page_Fault exception1) and (← Is_Contributory exception2) or (← Is_Page_Fault exception1) and (← Is_Page_Fault exception2)) then
    liftM (Report_Double_Fault)
  else
    if (exception1 == DF_Exception and ((← Is_Contributory exception2) or (← Is_Page_Fault exception2))) then
      Triple_Fault_Shutdown

end X86.Helpers

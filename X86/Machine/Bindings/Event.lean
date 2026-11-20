import X86.Helpers.Enter_SMM
import X86.Helpers.Check_New_TSS
import X86.Helpers.Load_New_TSS
import X86.Helpers.FRED.Event_Delivery

namespace X86.Machine.Bindings.Event

open X86.Helpers

-- These reset, SMM-entry, task-switch and FRED contracts have no public Intel body.
-- Reaching one is an external failure, not an invented architectural exception. The message
-- prefix is the one the local event source uses for Flags_To_Save_On_Exception.
private def unsupported {σ : Type} {exception α : Type} (operation : String) :
    X86.Runtime.SpecM exception (X86.State σ) α :=
  throw (.externalFailure s!"unsupported source event operation: {operation}")

instance {σ : Type} : X86.Reset_Registers.Binding σ where
  call _ := unsupported "Reset_Registers"

instance {σ : Type} : X86.Reset_MSRs.Binding σ where
  call _ := unsupported "Reset_MSRs"

instance {σ : Type} : Enter_SMM.Binding σ where
  call _ := unsupported "Enter_SMM"

instance {σ : Type} : Check_New_TSS.Binding σ where
  call _ _ := unsupported "Check_New_TSS"

instance {σ : Type} : Load_New_TSS.Binding σ where
  call _ _ := unsupported "Load_New_TSS"

instance {σ : Type} : FRED.Event_Delivery.Binding σ where
  call _ _ _ _ _ _ := unsupported "FRED.Event_Delivery"

end X86.Machine.Bindings.Event

import X86.Helpers.CET.Shadow_Stack_Read
import X86.Helpers.CET.Shadow_Stack_Write

namespace X86.Machine.Bindings.ShadowStack

open X86.Helpers

variable {σ : Type}

private def unsupported {exception α : Type} (operation : String) :
    X86.Runtime.SpecM exception (X86.State σ) α :=
  throw (.externalFailure s!"unsupported shadow-stack operation: {operation}")

-- This machine does not model CET shadow-stack memory.
instance : CET.Shadow_Stack_Read.Binding σ where
  call _ _ _ _ := unsupported "CET.Shadow_Stack_Read"

instance : CET.Shadow_Stack_Write.Binding σ where
  call _ _ _ _ _ := unsupported "CET.Shadow_Stack_Write"

end X86.Machine.Bindings.ShadowStack

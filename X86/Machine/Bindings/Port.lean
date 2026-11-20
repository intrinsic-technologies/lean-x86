import X86.Helpers.IO_Read
import X86.Helpers.IO_Write

namespace X86.Machine.Bindings.Port

open X86.Helpers

-- Device behavior is an explicit machine input.
instance {σ : Type} : IO_Read.Binding σ where
  call _ _ := throw (.externalFailure "IO_Read requires a caller binding")

instance {σ : Type} : IO_Write.Binding σ where
  call _ _ _ := throw (.externalFailure "IO_Write requires a caller binding")

end X86.Machine.Bindings.Port

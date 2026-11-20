import X86.Helpers.Is_RDMSR_Allowed

set_option autoImplicit false

namespace X86.Machine.Bindings.Msr

open X86.Helpers

-- The caller supplies the processor-specific inventory, permissions and effects.
instance {σ : Type} : Other_MSR_Read_Allowed.Binding σ where
  call _ := throw (.externalFailure "Other_MSR_Read_Allowed requires a caller binding")

instance {σ : Type} : Other_MSR_Write_Allowed.Binding σ where
  call _ _ := throw (.externalFailure "Other_MSR_Write_Allowed requires a caller binding")

instance {σ : Type} : Other_MSR_Read.Binding σ where
  call _ := throw (.externalFailure "Other_MSR_Read requires a caller binding")

instance {σ : Type} : Other_MSR_Write_Behavior.Binding σ where
  call _ _ := throw (.externalFailure "Other_MSR_Write_Behavior requires a caller binding")

instance {σ : Type} : Other_MSR_Commit.Binding σ where
  call _ _ := throw (.externalFailure "Other_MSR_Commit requires a caller binding")

end X86.Machine.Bindings.Msr

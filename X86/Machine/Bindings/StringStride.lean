import X86.Helpers.Get_Repeat_String_Stride

namespace X86.Machine.Bindings.StringStride

open X86.Helpers

-- Intel publishes no repeat-stride body or bounds; the caller selects a policy.
instance {σ : Type} : Get_Repeat_String_Stride.Binding σ where
  call _ _ := throw (.externalFailure "Get_Repeat_String_Stride requires a caller binding")

end X86.Machine.Bindings.StringStride

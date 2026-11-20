-- Generated from data/definitions.xml.gz: VMX::Check_CR4_Fixed_Bits; do not edit.
-- Source SHA256: 9e4c122955a6937bc6c315bfab318d455dc3fd58e8e81c4ee7790a450d6fe972
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ACheck_CR4_Fixed_Bits)
import X86.Runtime
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def VMX.Check_CR4_Fixed_Bits (new_value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  if (not (← get).«SMM::In_SMM» and (← get).VMX_Operation_Mode != VMX_Operation_Type.Outside_VMX_Operation) then
    if (not (← Std.Bits.Is_Zero (size := 64) (new_value and ~~~ (← get).IA32_VMX_CR4_FIXED1)) or not (← Std.Bits.Is_Zero (size := 64) (~~~ new_value and (← get).IA32_VMX_CR4_FIXED0))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

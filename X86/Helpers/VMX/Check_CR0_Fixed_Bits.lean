-- Generated from data/definitions.xml.gz: VMX::Check_CR0_Fixed_Bits; do not edit.
-- Source SHA256: be861ae0552f765035b25087fb7c0600a14befd413ca685f1c3d5b8f75da1c51
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ACheck_CR0_Fixed_Bits)
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

variable
  [X86.VM_Exec_Controls2.Binding σ]

def VMX.Check_CR0_Fixed_Bits (new_value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  if (not (← get).«SMM::In_SMM» and (← get).VMX_Operation_Mode != VMX_Operation_Type.Outside_VMX_Operation) then
    let mut fixed_at_1 : CR0_Type := (← get).IA32_VMX_CR0_FIXED1
    let mut fixed_at_0 : CR0_Type := (← get).IA32_VMX_CR0_FIXED0

    if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root and (← VM_Exec_Controls2).Unrestricted_Guest == 1) then
      fixed_at_1 := CR0_Type.setPE fixed_at_1 (1 : Runtime.Bit)
      fixed_at_1 := CR0_Type.setPG fixed_at_1 (1 : Runtime.Bit)
      fixed_at_0 := CR0_Type.setPE fixed_at_0 (0 : Runtime.Bit)
      fixed_at_0 := CR0_Type.setPG fixed_at_0 (0 : Runtime.Bit)

    if (not (← Std.Bits.Is_Zero (size := 64) (new_value and ~~~ fixed_at_1)) or not (← Std.Bits.Is_Zero (size := 64) (~~~ new_value and fixed_at_0))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

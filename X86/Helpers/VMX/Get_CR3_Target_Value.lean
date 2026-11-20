-- Generated from data/definitions.xml.gz: VMX::Get_CR3_Target_Value; do not edit.
-- Source SHA256: d5e08c65519feadd82447c12af8815837613a6a165dbcde1603efc8bc1e25ad5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3AGet_CR3_Target_Value)
import X86.Runtime
import X86.Helpers.Std.Unreachable
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.CR3_Target_Value0.Binding σ]
  [X86.CR3_Target_Value1.Binding σ]
  [X86.CR3_Target_Value2.Binding σ]
  [X86.CR3_Target_Value3.Binding σ]

def VMX.Get_CR3_Target_Value (index : Int) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (index in {0..3})

  match index with
  | 0 => do
    return (← CR3_Target_Value0 (← get).Current_VMCS_Pointer)
  | 1 => do
    return (← CR3_Target_Value1 (← get).Current_VMCS_Pointer)
  | 2 => do
    return (← CR3_Target_Value2 (← get).Current_VMCS_Pointer)
  | 3 => do
    return (← CR3_Target_Value3 (← get).Current_VMCS_Pointer)
  | _ => do
    Std.Unreachable

end X86.Helpers

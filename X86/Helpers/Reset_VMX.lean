-- Generated from data/definitions.xml.gz: Reset_VMX; do not edit.
-- Source SHA256: 8637aec6fb5c3bfcbc1859e34870fb4474c0f2c691f11db1e87e2e2774541492
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Reset_VMX)
import X86.Runtime
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Reset_VMX  : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with VMX_Operation_Mode := VMX_Operation_Type.Outside_VMX_Operation })
  VMX_On_Pointer.assign (← Std.Bits.Zero 64)
  Current_VMCS_Pointer.assign (← Std.Bits.Zero 64)
  «VMCS::Primary_VM_Exec_Controls».assign (← Std.Bits.Zero 32)
  «VMCS::Secondary_VM_Exec_Controls».assign (← Std.Bits.Zero 32)
  «VMCS::Tertiary_VM_Exec_Controls».assign (← Std.Bits.Zero 64)
  «VMCS::EPTP».assign (← Std.Bits.Zero 64)

end X86.Helpers

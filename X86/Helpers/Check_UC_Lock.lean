-- Generated from data/definitions.xml.gz: Check_UC_Lock; do not edit.
-- Source SHA256: 94061b4305183d8aa4a7b71e60fce1644ef4ba8b8675a2b0248e2fb3d55afd9b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_UC_Lock)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Memory_Type
import X86.Helpers.Report_Alignment_Check_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def Check_UC_Lock (memory_type : Memory_Type) : Runtime.SpecM Exception (State σ) Unit := do
  if (memory_type != Memory_Type.Memory_Type_Write_Back) then
    if ((← get).MEMORY_CONTROL.UC_LOCK_DISABLE == 1) then
      if (← CPUID_UC_LOCK_DISABLE) then
        liftM (Report_Alignment_Check_Exception (← Std.Bits.Zero_Extend (source_size := 4) 4 32))
      else
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

-- Generated from data/definitions.xml.gz: Check_Bus_Lock_Trap; do not edit.
-- Source SHA256: 79c700e755942a045a0c61cba91fcc445e1de9e3729b888bd61c71b6f4cc2495
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Bus_Lock_Trap)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Is_Cache_Split_Access
import X86.Helpers.Memory_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Config.Value.Cache_Line_Size]

def Check_Bus_Lock_Trap
    (address : Bits 64) (size : Int) (memory_type : Memory_Type) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not (← CPUID_BUS_LOCK_DETECT)) then
    return ()

  if ((← IA32_DEBUGCTL.BUS_LOCK_DETECT) == 1 and (← get).CPL != 0) then
    if ((← Is_Cache_Split_Access address size) or memory_type != Memory_Type.Memory_Type_Write_Back) then
      modify ({ · with Debug_Bus_Lock_Trap_Detected := true })

end X86.Helpers

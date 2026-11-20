-- Generated from a local ISA specification; do not edit.
-- Source SHA256: e41a1cf61b2a7a0f3e224ff022300e75d399b207c44df404d484b5d5ffdf557d
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

-- SDM Vol. 2 MOV CR/DR and Vol. 3A 2.5, 13.8.6.1, Vol. 3B Figure 20-1.
-- The generated MOV bodies check privilege, reserved high bits and mode rules
-- before these missing commit helpers run. The page walker has no TLB cache.
def Write_CR (index : Bits 5) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  match Unsigned index with
  | 0 => do
    modify ({ · with CR0 := value })
  | 2 => do
    modify ({ · with CR2 := value })
  | 3 => do
    if ((← CR4.PCIDE) == 1) then
      modify ({ · with CR3 := value })
    else
      if ((← get).IA32_EFER.LMA == 1 or (← CR4.PAE) == 0) then
        modify ({ · with CR3 := value and ~~~ (4071 : Bits 64) })
      else
        modify ({ · with CR3 := value and ~~~ (31 : Bits 64) })
  | 4 => do
    modify ({ · with CR4 := value })
  | 8 => do
    APIC_TPR.assign (← concatBits (leftSize := 4) (rightSize := 4) (← value[3:0]) (← Std.Bits.Zero 4))
  | _ => do
    liftM (Report_Invalid_Opcode)

def Write_DR (index : Bits 5) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  let actual : Bits 5 ← do
    if (← CR4.DE) == 0 and index == 4 then
      pure 6
    else
      pure (if (← CR4.DE) == 0 and index == 5 then 7 else index)
  match Unsigned actual with
  | 0 => do
    modify ({ · with DR0 := value })
  | 1 => do
    modify ({ · with DR1 := value })
  | 2 => do
    modify ({ · with DR2 := value })
  | 3 => do
    modify ({ · with DR3 := value })
  | 6 => do
    let mut result : Bits 64 := value and 124943 or 4294838256
    if (not (← CPUID_BUS_LOCK_DETECT)) then
      result := (← setSliceChecked result 11 1 1)
    if (not (← CPUID_RTM)) then
      result := (← setSliceChecked result 16 1 1)
    modify ({ · with DR6 := result })
  | 7 => do
    let mut result : Bits 64 := value and 68719422463 or 1024
    if (not (← CPUID_RTM)) then
      result := (← setSliceChecked result 11 1 0)
    modify ({ · with DR7 := result })
  | _ => do
    liftM (Report_Invalid_Opcode)

end X86.Helpers

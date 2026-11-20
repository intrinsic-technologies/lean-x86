-- Generated from data/definitions.xml.gz: Check_LASS_Violation; do not edit.
-- Source SHA256: b0fceefe05f96b03678faaaed548f8128cd68c318c56eec177c171407bff9718
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_LASS_Violation)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Stack_Fault
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

def Check_LASS_Violation
    (linear : Address_Translation) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not (← CPUID_LASS) or (← CR4.LASS) == 0 or (← get).IA32_EFER.LMA == 0) then
    return ()

  if ((← get).CPL == 3 and not linear.is_implicit_supervisor_mode_access) then
    if ((← linear.linear_address[63 +: 1]) == 1) then
      if (← (do
        let operand_2 := linear.segment.is_stack
        let operand_3 := some linear.is_shadow_stack_access
        let value_2 ← Runtime.readInitialized operand_2
        let value_3 ← Runtime.readInitialized operand_3
        pure (value_2 or value_3))) then
        liftM (Report_Stack_Fault (← Std.Bits.Zero 32))
      else
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  else
    if ((← get).CPL != 3) then
      let sup_fault : Bool ← do
        if (← Runtime.readInitialized linear.segment.is_code) then
          pure ((← linear.linear_address[63 +: 1]) == 0)
        else
          pure ((← CR4.SMAP) == 1 and ((← RFLAGS.AC) == 0 or linear.is_implicit_supervisor_mode_access) and (← linear.linear_address[63 +: 1]) == 0)

      if sup_fault then
        if (← (do
          let operand := linear.segment.is_stack
          let operand_1 := some linear.is_shadow_stack_access
          let value ← Runtime.readInitialized operand
          let value_1 ← Runtime.readInitialized operand_1
          pure (value or value_1))) then
          liftM (Report_Stack_Fault (← Std.Bits.Zero 32))
        else
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

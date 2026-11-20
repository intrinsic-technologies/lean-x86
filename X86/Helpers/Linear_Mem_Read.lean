-- Generated from data/definitions.xml.gz: Linear_Mem_Read; do not edit.
-- Source SHA256: d0e6d0e09944b58ee90b9c0da598b1add14c9afa8169fa43f5e5f625d629ecc5
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Linear_Mem_Read)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Data_Read_Breakpoint
import X86.Helpers.Check_LASS_Violation
import X86.Helpers.Create_Linear_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Physical_Mem_Read
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Translate_Linear_To_Physical
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def Linear_Mem_Read
    (linear_address : Bits 64) (size : Int) (is_implicit_supervisor_mode_access : Bool := true) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((size == (8 : Int)) || (size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)) || (size == (128 : Int)) || (size == (256 : Int)) || (size == (384 : Int)) || (size == (512 : Int)) || (size == (1024 : Int)))

  if (← (do if (← In_64Bit_Mode) then pure (not (← Is_Canonical_Wrt_Paging_Mode linear_address size false)) else pure false)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let mut linear : Address_Translation ← Create_Linear_Address linear_address size
  -- direct linear accesses to system structures (descriptor tables, IDT, UITT, ...) are
  -- implicit supervisor accesses; instructions that take a linear address as a data
  -- operand (RDMSRLIST, PBNDKB, ...) pass False to make an explicit access
  linear := { linear with is_implicit_supervisor_mode_access := is_implicit_supervisor_mode_access }

  Check_LASS_Violation linear

  Check_Data_Read_Breakpoint linear.linear_address (← Std.Integer.Positive_Divide size 8)
  let physical : Address_Translation ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Read
  let value : Bits size ← Physical_Mem_Read physical size
  return value

end X86.Helpers

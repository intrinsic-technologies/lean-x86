-- Generated from data/definitions.xml.gz: VMX::Check_MSR_Bitmap; do not edit.
-- Source SHA256: f7104e8e4dc8b468f889fa6ceca326c0530e8ad3281f3385b9edecc42038e560
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ACheck_MSR_Bitmap)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Physical_Address
import X86.Helpers.Memory_Type
import X86.Helpers.Physical_Mem_Read
import X86.Helpers.Std.Bits.Unsigned_Saturate
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]

def VMX.Check_MSR_Bitmap
    (msr : Int) (is_rdmsr : Bool) (exit_reason : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  if ((← VM_Exec_Controls1).Use_MSR_Bitmaps == 0) then
    return ()

  let msr_address : Bits 64 ← Std.Bits.Unsigned_Saturate msr 64
  let mut bitmap_offset : Int := Unsigned (← msr_address[12:3])

  if (decide (msr ≥ Unsigned (3221225472 : Bits 32)) and decide (msr ≤ Unsigned (3221233663 : Bits 32))) then
    bitmap_offset := bitmap_offset + 1024
  else
    if (decide (msr > Unsigned (8191 : Bits 16))) then
      VM_Exit exit_reason

  if (not is_rdmsr) then
    bitmap_offset := bitmap_offset + 2048

  let bitmap_address : Bits 64 := (← bitmap_offset[0 +: 64]) + (← get).«VMCS::Address_Of_MSR_Bitmaps»

  let physical : Address_Translation ← Create_Physical_Address bitmap_address 8 Memory_Type.Memory_Type_Strong_Uncacheable
  let value : Bits 8 ← Physical_Mem_Read physical 8

  let bit_index : Int := Unsigned (← msr_address[0 +: 3])
  if ((← value[bit_index +: 1]) == 1) then
    VM_Exit exit_reason

end X86.Helpers

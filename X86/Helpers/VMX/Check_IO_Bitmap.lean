-- Generated from data/definitions.xml.gz: VMX::Check_IO_Bitmap; do not edit.
-- Source SHA256: 69082fb7c8a30f644192ef841ea96e5c487b5a13a8ac4f04cd7a3523e4dbaa40
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VMX%3A%3ACheck_IO_Bitmap)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Physical_Address
import X86.Helpers.Memory_Type
import X86.Helpers.Physical_Mem_Read
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]

def VMX.Check_IO_Bitmap
    (port : Bits 32) (size_in_bytes : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  if ((← VM_Exec_Controls1).Use_IO_Bitmaps == 0) then
    return ()

  let last_port_byte : Bits 32 := port + (← (size_in_bytes - 1)[0 +: 32])

  if (decide (Unsigned last_port_byte > Unsigned (65535 : Bits 16))) then
    VM_Exit VMX_EXIT_IO_INSTRUCTION

  let first_byte_bitmap_id : Runtime.Bit ← port[15 +: 1]
  let last_byte_bitmap_id : Runtime.Bit ← last_port_byte[15 +: 1]

  let first_byte_offset : Bits 64 ← Std.Bits.Zero_Extend (source_size := 12) (← port[14:3]) 64
  let last_byte_offset : Bits 64 ← Std.Bits.Zero_Extend (source_size := 12) (← last_port_byte[14:3]) 64

  let bit_offset : Int := Unsigned (← port[2:0])
  let mut bitmap_value : Bits 16 ← Std.Bits.Zero 16

  if (first_byte_bitmap_id == last_byte_bitmap_id) then
    let bitmap_address : Bits 64 ← do
      if first_byte_bitmap_id == 0 then
        Address_Of_IO_Bitmap_A (← get).Current_VMCS_Pointer
      else
        Address_Of_IO_Bitmap_B (← get).Current_VMCS_Pointer

    let address : Bits 64 := bitmap_address + first_byte_offset

    if (first_byte_offset == last_byte_offset) then
      let physical : Address_Translation ← Create_Physical_Address address 8 Memory_Type.Memory_Type_Strong_Uncacheable
      bitmap_value := (← setSliceChecked bitmap_value 0 8 (← Physical_Mem_Read physical 8))
    else
      let physical : Address_Translation ← Create_Physical_Address address 16 Memory_Type.Memory_Type_Strong_Uncacheable
      bitmap_value := (← Physical_Mem_Read physical 16)
  else
    let address_A : Bits 64 := (← Address_Of_IO_Bitmap_A (← get).Current_VMCS_Pointer) + first_byte_offset
    let physical_A : Address_Translation ← Create_Physical_Address address_A 8 Memory_Type.Memory_Type_Strong_Uncacheable
    bitmap_value := (← setSliceChecked bitmap_value 0 8 (← Physical_Mem_Read physical_A 8))

    let address_B : Bits 64 := (← Address_Of_IO_Bitmap_B (← get).Current_VMCS_Pointer) + last_byte_offset
    let physical_B : Address_Translation ← Create_Physical_Address address_B 8 Memory_Type.Memory_Type_Strong_Uncacheable
    bitmap_value := (← setSliceChecked bitmap_value 8 8 (← Physical_Mem_Read physical_B 8))

  if (not (← Std.Bits.Is_Zero (size := size_in_bytes) (← bitmap_value[bit_offset +: size_in_bytes]))) then
    VM_Exit VMX_EXIT_IO_INSTRUCTION

end X86.Helpers

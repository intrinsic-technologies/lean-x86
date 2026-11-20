-- Generated from data/definitions.xml.gz: Check_IO_Permissions; do not edit.
-- Source SHA256: 838fd4df24755e0f2af0b58020d0b7fe435d7ab5dd73a958e3694998d12476d6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_IO_Permissions)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Is_16Bit_Task
import X86.Helpers.Is_Segment_Limit_Violation
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
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
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Check_IO_Permissions
    (port : Bits 32) (num_bytes : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode or (← CR0.PE) == 1 and decide ((← get).CPL > Unsigned (← RFLAGS.IOPL))) then
    if (← Is_16Bit_Task (← get).TR) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- load I/O permission bitmap address
    let io_bitmap_base : Bits 16 ← Logical_Mem_Read (← get).TR (← Std.Bits.Zero_Extend (source_size := 8) 102 64) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    let io_bitmap_offset : Bits 64 := (← Std.Bits.Zero_Extend (source_size := 16) io_bitmap_base 64) + (← Std.Bits.Zero_Extend (source_size := 13) (← port[15:3]) 64)

    -- load I/O permission bitmap
    if (← Is_Segment_Limit_Violation (← get).TR io_bitmap_offset (← Std.Integer.Positive_Divide 16 8)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
    let io_bitmap : Bits 16 ← Logical_Mem_Read (← get).TR io_bitmap_offset 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false

    let low_bit : Int := Unsigned (← port[2:0])
    if (not (← Std.Bits.Is_Zero (size := num_bytes) (← io_bitmap[low_bit +: num_bytes]))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

end X86.Helpers

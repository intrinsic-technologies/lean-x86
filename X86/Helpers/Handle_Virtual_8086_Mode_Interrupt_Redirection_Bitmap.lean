-- Generated from data/definitions.xml.gz: Handle_Virtual_8086_Mode_Interrupt_Redirection_Bitmap; do not edit.
-- Source SHA256: 9be18eac7e8d6151514f297adcbbb02e7588576d8bfe9bfce63821b12cd877b1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Handle_Virtual_8086_Mode_Interrupt_Redirection_Bitmap)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.Check_New_RIP
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Segment_Limit
import X86.Helpers.INTR_PERMISSION_BASE_OFFSET
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Multiply_int
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Vectored_Event_Type
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Handle_Virtual_8086_Mode_Interrupt_Redirection_Bitmap
    (interrupt_type : Vectored_Event_Type) (vector : Int) (return_ip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (vector in {0..255})

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode and interrupt_type == Vectored_Event_Type.Software_Interrupt_INTn) then
    if ((← CR4.VME) == 1) then
      let vme_bitmap_base : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) (← Logical_Mem_Read (← get).TR INTR_PERMISSION_BASE_OFFSET 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) 64
      -- calculate the byte in the bitmap for this vector
      let vme_bitmap_offset : Bits 64 ← Std.Bits.Add_int (n := 64) (← Std.Bits.Subtract_int (n := 64) vme_bitmap_base 32) (← shiftIntegerRight vector (3 : Int))
      if (decide (Unsigned vme_bitmap_offset > (← Get_Segment_Limit (← get).TR))) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
      let vme_bitmap_byte : Bits 8 ← Logical_Mem_Read (← get).TR vme_bitmap_offset 8 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      let vector_index : Bits 8 ← vector[0 +: 8]

      if ((← Runtime.invalidOperands (result := Runtime.Bit) (vme_bitmap_byte, (← vector_index[2:0]))) == 0) then
        let handler_entry_address : Bits 64 ← Std.Bits.Multiply_int (n := 64) (← vector[0 +: 64]) 4
        let handler_entry : Bits 32 ← Linear_Mem_Read handler_entry_address 32 true
        let new_cs : Segment ← Load_Real_Or_VM86_Segment Execution_Mode.Virtual_8086_Mode (← handler_entry[31:16]) (← get).CS
        let new_rip : Bits 64 ← Std.Bits.Sign_Extend (source_size := 16) (← handler_entry[0 +: 16]) 64

        Check_New_RIP new_cs new_rip

        let mut flags_to_save : RFLAGS_Type := (← get).RFLAGS
        if ((← RFLAGS.IOPL) != 3) then
          flags_to_save := RFLAGS_Type.setIF flags_to_save (← RFLAGS.VIF)
          flags_to_save := RFLAGS_Type.setIOPL flags_to_save (3 : Bits 2)

        let mut new_rsp : Bits 64 ← Push_Stack (← get).SS (← RSP) (← get).CS 16 16 (← flags_to_save[0 +: 16]) false
        new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS 16 16 (← get).CS.selector false)
        RSP_write (← Push_Stack (← get).SS new_rsp (← get).CS 16 16 (← return_ip[0 +: 16]) false)

        if ((← RFLAGS.IOPL) == 3) then
          RFLAGS.setIF 0
        else
          RFLAGS.setVIF 0

        RFLAGS.setTF 0

        Branch_Far new_cs new_rip

        return true
      else
        if ((← RFLAGS.IOPL) != 3) then
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  return false

end X86.Helpers

-- Generated from data/instruction/MASKMOVQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 988cb9d48d4bca6e1808751fd7fda30a210b12879fcfb66ac8741170b6e66005
-- Description: data/sdm/MASKMOVQ.docbook
-- Stores selected bytes from the source operand (first operand) into a 64-bit memory location.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MASKMOVQ)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Read_MMX
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.MASKMOVQ
    (address_size : Int) (context : Instruction_Context) (src1 src2 : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let element_size : Int := 8
  let register_size : Int := 64
  let elements : Int ← Std.Integer.Positive_Divide register_size element_size

  let effective_segment : Segment ← Get_Effective_Segment context (← get).DS
  let effective_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) 64

  -- check the writability of the full 8 bytes before performing any of the writes
  Check_Logical_Address_Is_Writable effective_segment effective_address 64 Memory_Alignment_Type.Normal_Alignment

  for i in intRange (0 : Int) (elements - 1) do
    let data_byte : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ 64 - element_size))
      pure (← src1[i *: element_size])
    let mask_byte : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ 64 - element_size))
      pure (← src2[i *: element_size])
    let mask : Runtime.Bit ← do
      Runtime.assert (decide (element_size - 1 < element_size))
      Runtime.assert (decide (0 ≤ element_size - 1))
      pure (← mask_byte[element_size - 1 +: 1])
    if (mask == 1) then
      Logical_Mem_Write (size := element_size) effective_segment (← Std.Bits.Add_int (n := 64) effective_address i) data_byte Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown true

-- MASKMOVQ_MMXq_MMXq: NP 0F F7 /r
-- CPUID group: PENTIUMMMX
def Instructions.MASKMOVQ_MMXq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src1 : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX reg) 0 64
  let src2 : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX rm) 0 64

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)
  modify ({ · with Next_IP := ip })

  Instructions.Operations.MASKMOVQ address_size context src1 src2

end X86

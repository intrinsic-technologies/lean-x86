-- Generated from data/instruction/MASKMOVDQU.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 4498e35ab9978c56b83b4d8c1bcff598d2d5c2c3b9623064ec9b8b77528ab72b
-- Description: data/sdm/MASKMOVDQU.docbook
-- Stores selected bytes from the source operand (first operand) into an 128-bit memory location.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MASKMOVDQU)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Read_XMM
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
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

def Instructions.Operations.MASKMOVDQU
    (address_size : Int) (context : Instruction_Context) (src1 src2 : Bits 128) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let element_size : Int := 8
  let register_size : Int := 128
  let elements : Int ← Std.Integer.Positive_Divide register_size element_size

  let effective_segment : Segment ← Get_Effective_Segment context (← get).DS
  let effective_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) 64

  -- check the writability and alignment of the low 8 bytes followed by the high 8 bytes
  -- before performing any of the writes
  Check_Logical_Address_Is_Writable effective_segment effective_address 64 Memory_Alignment_Type.Normal_Alignment
  Check_Logical_Address_Is_Writable effective_segment (← Std.Bits.Add_int (n := 64) effective_address 8) 64 Memory_Alignment_Type.Normal_Alignment

  for i in intRange (0 : Int) (elements - 1) do
    let data_byte : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ 128 - element_size))
      pure (← src1[i *: element_size])
    let mask_byte : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ 128 - element_size))
      pure (← src2[i *: element_size])
    let mask : Runtime.Bit ← do
      Runtime.assert (decide (element_size - 1 < element_size))
      Runtime.assert (decide (0 ≤ element_size - 1))
      pure (← mask_byte[element_size - 1 +: 1])
    if (mask == 1) then
      Logical_Mem_Write (size := element_size) effective_segment (← Std.Bits.Add_int (n := 64) effective_address i) data_byte Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown true

-- MASKMOVDQU_XMMxub_XMMxub: 66 0F F7 /r
-- CPUID group: SSE2
def Instructions.MASKMOVDQU_XMMxub_XMMxub
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MASKMOVDQU address_size context src1 src2

-- VMASKMOVDQU_XMMxub_XMMxub: VEX.L0.66.0F.WIG F7 /r
-- CPUID group: AVX
def Instructions.VMASKMOVDQU_XMMxub_XMMxub
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.vex_pp == 1 and context.vex_LL == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MASKMOVDQU address_size context src1 src2

end X86

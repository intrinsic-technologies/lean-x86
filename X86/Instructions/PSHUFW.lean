-- Generated from data/instruction/PSHUFW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: ec74aee3708607ed1e3ad7011e6efcdcdf09364a1c2107b124c67d4ec8387d3d
-- Description: data/sdm/PSHUFW.docbook
-- Copies words from the source operand (second operand) and inserts them in the destination
-- operand (first operand) at word locations selected with the order operand (third operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PSHUFW)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_MMX
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Align_Down
import X86.Helpers.Std.Integer.Log2
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.Helpers.Write_MMX
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.SHUF
    (element_size register_size : Int) (src1 : Bits register_size) (imm8 : Bits 8) :
    Runtime.PartialResult Empty (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let index_size : Int ← Std.Integer.Log2 elements
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    let index : Int := (← Std.Integer.Align_Down i elements) + Unsigned (← (do
      let __check373 : Int ← Std.Integer.Positive_Remainder i elements
      Runtime.assert (decide (__check373 * index_size ≤ 8 - index_size))
      Runtime.assert (decide (0 ≤ index_size))
      Runtime.assert (decide (0 ≤ __check373))
      pure (← imm8[__check373 *: index_size])))
    let r : Bits element_size ← do
      Runtime.assert (decide (index * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      Runtime.assert (decide (0 ≤ index))
      pure (← src1[index *: element_size])
    Runtime.assert (decide (i * element_size ≤ register_size - element_size))
    Runtime.assert (decide (0 ≤ element_size))
    result := (← setSliceChecked result (i * element_size) element_size r)
  return result

-- PSHUFW_MMXq_MEMq_IMMb: NP 0F 70 /r ib
-- CPUID group: PENTIUMMMX
def Instructions.PSHUFW_MMXq_MEMq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let src1 : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (FP87_Status.setTOP 0)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUF element_size register_size src1 imm8

  Runtime.liftTotal (Write_MMX reg result)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))

-- PSHUFW_MMXq_MMXq_IMMb: NP 0F 70 /r ib
-- CPUID group: PENTIUMMMX
def Instructions.PSHUFW_MMXq_MMXq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let element_size : Int := 16

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (Read_MMX rm)) 0 register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  Runtime.liftTotal (FP87_Status.setTOP 0)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUF element_size register_size src1 imm8

  Runtime.liftTotal (Write_MMX reg result)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))

end X86

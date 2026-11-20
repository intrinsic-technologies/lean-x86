-- Generated from data/instruction/RET.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1235374ff2933d995c2bc61704444194320f6692b8505a6c10463954d9e03d42
-- Description: data/sdm/RET.docbook
-- Transfers program control to a return address located on the top of the stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=RET)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.Branch_Near
import X86.Helpers.CET.Check_Return_RIP
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.Check_New_RIP
import X86.Helpers.Code_Segment_Checks
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_Valid_Code_Segment
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Mem_Fetch
import X86.Helpers.Pop_Stack
import X86.Helpers.Registers
import X86.Helpers.Release_Parameters
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Return_To_Less_Privilege
import X86.Helpers.Return_To_Same_Privilege
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Stack_Address_Size
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
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.RET_NEAR
    (operand_size stack_address_size : Int) (src : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (stack_address_size == 16 || stack_address_size == 32 || stack_address_size == 64)

  let mut return_address : Bits 64 ← Std.Bits.Zero 64

  Runtime.assert (decide (operand_size ≤ 64))
  let (return_address_part, new_rsp) ← Pop_Stack (← get).SS (← RSP) operand_size operand_size
  return_address := (← setSliceChecked return_address 0 operand_size return_address_part)

  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    SSP.assign (← CET.Check_Return_RIP operand_size return_address)

  Check_New_RIP (← get).CS return_address

  Branch_Near return_address

  Runtime.assert (decide (stack_address_size ≤ 64))
  let RSP_part_value := (← new_rsp[0 +: stack_address_size]) + (← Std.Bits.Zero_Extend (source_size := 16) src stack_address_size)
  let mut RSP_target ← RSP
  RSP_target := (← setSliceChecked RSP_target 0 stack_address_size RSP_part_value)
  RSP_write RSP_target

def Instructions.Operations.RET_FAR
    (operand_size : Int) (src : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mode : Execution_Mode ← Current_Mode

  let mut new_rip : Bits 64 ← Std.Bits.Zero 64
  let mut new_cs_descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_cs_descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_cs_descriptor_valid : Option (Bool) := none
  let mut new_cs_is_stack : Option (Bool) := none
  let mut new_cs_is_code : Option (Bool) := none
  let mut new_cs_is_64bit_mode_data_segment : Option (Bool) := none

  -- pop CS before RIP
  -- pop only 16 bits, but increment RSP by operand_size (high-order bits discarded)
  let mut (new_cs_selector, new_rsp) ← Pop_Stack (← get).SS (← Std.Bits.Add_int (n := 64) (← RSP) (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
  Runtime.assert (decide (operand_size ≤ 64))
  let (new_rip_part, _) ← Pop_Stack (← get).SS (← RSP) operand_size operand_size
  new_rip := (← setSliceChecked new_rip 0 operand_size new_rip_part)

  if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
    let new_cs_replacement : Segment ← Load_Real_Or_VM86_Segment mode new_cs_selector (← get).CS
    new_cs_selector := new_cs_replacement.selector
    new_cs_descriptor := new_cs_replacement.descriptor
    new_cs_descriptor_high := new_cs_replacement.descriptor_high
    new_cs_descriptor_valid := new_cs_replacement.descriptor_valid
    new_cs_is_stack := new_cs_replacement.is_stack
    new_cs_is_code := new_cs_replacement.is_code
    new_cs_is_64bit_mode_data_segment := new_cs_replacement.is_64bit_mode_data_segment

    -- handle optional operand to release parameters from the stack
    new_rsp := (← setSliceChecked new_rsp 0 16 ((← new_rsp[0 +: 16]) + src))

    Check_New_RIP ({
      selector := new_cs_selector,
      descriptor := new_cs_descriptor,
      descriptor_high := new_cs_descriptor_high,
      descriptor_valid := new_cs_descriptor_valid,
      is_stack := new_cs_is_stack,
      is_code := new_cs_is_code,
      is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
    } : Segment) new_rip
    Branch_Far ({
      selector := new_cs_selector,
      descriptor := new_cs_descriptor,
      descriptor_high := new_cs_descriptor_high,
      descriptor_valid := new_cs_descriptor_valid,
      is_stack := new_cs_is_stack,
      is_code := new_cs_is_code,
      is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
    } : Segment) new_rip
    RSP_write new_rsp
  else
    if (← Is_Null_Segment_Selector new_cs_selector) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    let new_cs_replacement_1 : Segment ← Load_Segment_Descriptor new_cs_selector (← get).CS false
    new_cs_selector := new_cs_replacement_1.selector
    new_cs_descriptor := new_cs_replacement_1.descriptor
    new_cs_descriptor_high := new_cs_replacement_1.descriptor_high
    new_cs_descriptor_valid := new_cs_replacement_1.descriptor_valid
    new_cs_is_stack := new_cs_replacement_1.is_stack
    new_cs_is_code := new_cs_replacement_1.is_code
    new_cs_is_64bit_mode_data_segment := new_cs_replacement_1.is_64bit_mode_data_segment

    if ((← CR4.FRED) == 1 and decide (Unsigned (Segment_Selector.RPL new_cs_selector) > (← get).CPL) or decide (Unsigned (Segment_Selector.RPL new_cs_selector) < (← get).CPL) or not (← Is_Valid_Code_Segment ({
      selector := new_cs_selector,
      descriptor := new_cs_descriptor,
      descriptor_high := new_cs_descriptor_high,
      descriptor_valid := new_cs_descriptor_valid,
      is_stack := new_cs_is_stack,
      is_code := new_cs_is_code,
      is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
    } : Segment) (Unsigned (Segment_Selector.RPL new_cs_selector)))) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs_selector))

    Code_Segment_Checks ({
      selector := new_cs_selector,
      descriptor := new_cs_descriptor,
      descriptor_high := new_cs_descriptor_high,
      descriptor_valid := new_cs_descriptor_valid,
      is_stack := new_cs_is_stack,
      is_code := new_cs_is_code,
      is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
    } : Segment)

    if ((← Segment_Descriptor.A.partial new_cs_descriptor) == 0) then
      let new_cs_replacement_2 : Segment ← Set_Segment_Access_Bit ({
        selector := new_cs_selector,
        descriptor := new_cs_descriptor,
        descriptor_high := new_cs_descriptor_high,
        descriptor_valid := new_cs_descriptor_valid,
        is_stack := new_cs_is_stack,
        is_code := new_cs_is_code,
        is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
      } : Segment) false
      new_cs_selector := new_cs_replacement_2.selector
      new_cs_descriptor := new_cs_replacement_2.descriptor
      new_cs_descriptor_high := new_cs_replacement_2.descriptor_high
      new_cs_descriptor_valid := new_cs_replacement_2.descriptor_valid
      new_cs_is_stack := new_cs_replacement_2.is_stack
      new_cs_is_code := new_cs_replacement_2.is_code
      new_cs_is_64bit_mode_data_segment := new_cs_replacement_2.is_64bit_mode_data_segment

    new_rsp := (← Release_Parameters (← get).SS new_rsp src)

    if (Unsigned (Segment_Selector.RPL new_cs_selector) == (← get).CPL) then
      Return_To_Same_Privilege ({
        selector := new_cs_selector,
        descriptor := new_cs_descriptor,
        descriptor_high := new_cs_descriptor_high,
        descriptor_valid := new_cs_descriptor_valid,
        is_stack := new_cs_is_stack,
        is_code := new_cs_is_code,
        is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
      } : Segment) new_rip new_rsp
    else
      Return_To_Less_Privilege ({
        selector := new_cs_selector,
        descriptor := new_cs_descriptor,
        descriptor_high := new_cs_descriptor_high,
        descriptor_valid := new_cs_descriptor_valid,
        is_stack := new_cs_is_stack,
        is_code := new_cs_is_code,
        is_64bit_mode_data_segment := new_cs_is_64bit_mode_data_segment
      } : Segment) new_rip new_rsp operand_size src

-- RET_NEAR_IMMw: C2 iw
def Instructions.RET_NEAR_IMMw
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else 64
  let stack_address_size : Int ← Stack_Address_Size (← get).SS

  let src : Bits 16 ← Mem_Fetch ip 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 2)

  Instructions.Operations.RET_NEAR operand_size stack_address_size src

-- RET_FAR_IMMw: CA iw
def Instructions.RET_FAR_IMMw
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Bits 16 ← Mem_Fetch ip 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 2)

  Instructions.Operations.RET_FAR operand_size src

-- RET_NEAR: C3
def Instructions.RET_NEAR
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else 64
  let stack_address_size : Int ← Stack_Address_Size (← get).SS

  let src : Bits 16 ← Std.Bits.Zero 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.RET_NEAR operand_size stack_address_size src

-- RET_FAR: CB
def Instructions.RET_FAR
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Bits 16 ← Std.Bits.Zero 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.RET_FAR operand_size src

end X86

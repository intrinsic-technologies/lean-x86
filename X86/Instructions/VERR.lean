-- Generated from data/instruction/VERR-VERW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1b18d8486f23e9a2990e471d69e19be5659ab335b67fc8efd192ee5e135fa432
-- Description: data/sdm/VERR-VERW.docbook
-- Verifies whether the code or data segment specified with the source operand is readable (VERR)
-- or writable (VERW) from the current privilege level (CPL).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=VERR%2FVERW)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Get_Segment_Limit
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Conforming_Code_Segment
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_System_Segment
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.UFloatCompare
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

def Instructions.Operations.VERRW
    (verify_segment_for_read : Bool) (segment_selector : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  let mut verified : Bool := true
  let selector : Segment_Selector := segment_selector
  if ((← Is_Null_Segment_Selector selector) or (← Is_Local_Segment_Selector segment_selector) and not (← Runtime.readInitialized (← get).LDTR.descriptor_valid)) then
    verified := false
  else
    let base : Bits 64 ← do
      if (← Is_Local_Segment_Selector selector) then
        Get_Segment_Base (← get).LDTR
      else
        pure (← get).GDTR.base
    let descriptor_index : Int := Unsigned (← concatBits (leftSize := 13) (rightSize := 3) (Segment_Selector.Index selector) (0 : Bits 3))
    let descriptor_linear_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := 64) (← Std.Bits.Add_int (n := 64) base descriptor_index) 64
    let limit : Int ← do
      if (← Is_Local_Segment_Selector selector) then
        Get_Segment_Limit (← get).LDTR
      else
        pure (Unsigned (← get).GDTR.limit)
    let descriptor_access_size : Int := 8
    if (decide (descriptor_index + descriptor_access_size - 1 > limit)) then
      verified := false
    else
      let mut segment_descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
      let mut segment_descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
      let mut segment_descriptor_valid : Option (Bool) := none
      let mut segment_is_stack : Option (Bool) := none
      let mut segment_is_code : Option (Bool) := none
      let mut segment_is_64bit_mode_data_segment : Option (Bool) := none
      let segment_selector_1 : Segment_Selector := selector
      segment_descriptor := Runtime.InitializedBits.ofValue (← Linear_Mem_Read descriptor_linear_address 64 true)
      segment_descriptor_valid := some true
      if ((← Is_System_Segment ({
        selector := segment_selector_1,
        descriptor := segment_descriptor,
        descriptor_high := segment_descriptor_high,
        descriptor_valid := segment_descriptor_valid,
        is_stack := segment_is_stack,
        is_code := segment_is_code,
        is_64bit_mode_data_segment := segment_is_64bit_mode_data_segment
      } : Segment)) or verify_segment_for_read and (← Segment_Descriptor.Code.partial segment_descriptor) == 1 and (← Segment_Descriptor.R.partial segment_descriptor) == 0 or not verify_segment_for_read and ((← Segment_Descriptor.R.partial segment_descriptor) == 0 or not (← Is_Data_Segment ({
        selector := segment_selector_1,
        descriptor := segment_descriptor,
        descriptor_high := segment_descriptor_high,
        descriptor_valid := segment_descriptor_valid,
        is_stack := segment_is_stack,
        is_code := segment_is_code,
        is_64bit_mode_data_segment := segment_is_64bit_mode_data_segment
      } : Segment)))) then
        verified := false

      if (not (← Is_Conforming_Code_Segment ({
        selector := segment_selector_1,
        descriptor := segment_descriptor,
        descriptor_high := segment_descriptor_high,
        descriptor_valid := segment_descriptor_valid,
        is_stack := segment_is_stack,
        is_code := segment_is_code,
        is_64bit_mode_data_segment := segment_is_64bit_mode_data_segment
      } : Segment))) then
        if (decide ((← get).CPL > Unsigned (← Segment_Descriptor.DPL.partial segment_descriptor)) or decide (Unsigned (Segment_Selector.RPL selector) > Unsigned (← Segment_Descriptor.DPL.partial segment_descriptor))) then
          verified := false

  RFLAGS.setZF (← Bit verified)

-- VERR_GPR16: 0F 00 /4
def Instructions.VERR_GPR16
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let verify_segment_for_read : Bool := true

  let segment_selector : Bits 16 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.VERRW verify_segment_for_read segment_selector

-- VERR_MEMw: 0F 00 /4
def Instructions.VERR_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let verify_segment_for_read : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let segment_selector : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.VERRW verify_segment_for_read segment_selector

-- VERW_GPR16: 0F 00 /5
def Instructions.VERW_GPR16
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let verify_segment_for_read : Bool := false

  let segment_selector : Bits 16 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.VERRW verify_segment_for_read segment_selector

-- VERW_MEMw: 0F 00 /5
def Instructions.VERW_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let verify_segment_for_read : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let segment_selector : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.VERRW verify_segment_for_read segment_selector

end X86

-- Generated from data/instruction/FSAVE-FNSAVE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: a5d7348cb89c45de23ba7af6ab6e5b0070d8b52413770845cfa7503cc3f42d0c
-- Description: data/sdm/FSAVE-FNSAVE.docbook
-- Stores the current FPU state (operating environment and register stack) at the specified
-- destination in memory, and then re-initializes the FPU.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FSAVE%2FFNSAVE)
import X86.Runtime
import X86.Helpers.Calculate_Offset
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Store_Environment
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero
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
  [X86.__Fuzz_Next_Mem_Write.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_Ingore_FCS_FDS_Deprecation]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.FNSAVE
    (operand_size address_size : Int) (segment : Segment) (effective_address : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  -- check writability of the first byte
  Check_Logical_Address_Is_Writable segment effective_address 8 Memory_Alignment_Type.Normal_Alignment
  -- check writability of the last byte
  let fp_image_size : Int := if operand_size == 16 then 94 else 108
  Check_Logical_Address_Is_Writable segment (← Std.Bits.Subtract_int (n := 64) (← Std.Bits.Add_int (n := 64) effective_address fp_image_size) 1) 8 Memory_Alignment_Type.Normal_Alignment

  FP87.Store_Environment segment effective_address operand_size address_size

  -- FP registers
  let fp_offset : Int := if operand_size == 16 then 14 else 28
  for i in intRange (0 : Int) (7 : Int) do
    let offset : Bits 64 ← Calculate_Offset effective_address (fp_offset + i * 10) address_size
    Logical_Mem_Write (size := 80) segment offset (← ST i) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

  modify ({ · with FP87_Control := (895 : Bits 16) })
  FP87_Status.assign (← Std.Bits.Zero 16)
  FP87_Tag_Word.assign (← Std.Bits.All_Ones 16)
  FP87_FIP.assign (← Std.Bits.Zero 64)
  FP87_FCS.assign (← Std.Bits.Zero 16)
  FP87_FOP.assign (← Std.Bits.Zero 11)
  FP87_FDP.assign (← Std.Bits.Zero 64)
  FP87_FDS.assign (← Std.Bits.Zero 16)

-- FNSAVE_MEMmem108_0: DD /6
def Instructions.FNSAVE_MEMmem108_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

-- FNSAVE_MEMmem108_1: DD /6
def Instructions.FNSAVE_MEMmem108_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

-- FNSAVE_MEMmem108_2: DD /6
def Instructions.FNSAVE_MEMmem108_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

-- FNSAVE_MEMmem108_3: DD /6
def Instructions.FNSAVE_MEMmem108_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

-- FNSAVE_MEMmem94_0: DD /6
def Instructions.FNSAVE_MEMmem94_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

-- FNSAVE_MEMmem94_1: DD /6
def Instructions.FNSAVE_MEMmem94_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

-- FNSAVE_MEMmem94_2: DD /6
def Instructions.FNSAVE_MEMmem94_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FNSAVE operand_size address_size segment effective_address

end X86

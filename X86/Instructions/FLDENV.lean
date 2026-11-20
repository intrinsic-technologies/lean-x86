-- Generated from data/instruction/FLDENV.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: da00d154bcf3c8ffdfe32ae0643525c6d27d15442ae03af1bff19a882e062eb4
-- Description: data/sdm/FLDENV.docbook
-- Loads the complete x87 FPU operating environment from memory into the FPU registers.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FLDENV)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Readable
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Load_Environment
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Subtract_int
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

def Instructions.Operations.FLDENV
    (operand_size address_size : Int) (segment : Segment) (effective_address : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  -- check readability of the first byte
  Check_Logical_Address_Is_Readable segment effective_address 8
  -- check readability of the last byte
  let fp_image_size : Int := if operand_size == 16 then 14 else 28
  Check_Logical_Address_Is_Readable segment (← Std.Bits.Subtract_int (n := 64) (← Std.Bits.Add_int (n := 64) effective_address fp_image_size) 1) 8

  let (control, status, tag_word, fip, fcs, fop, fdp, fds) ← FP87.Load_Environment segment effective_address operand_size address_size

  modify ({ · with FP87_Control := control })
  modify ({ · with FP87_Status := status })
  modify ({ · with FP87_Tag_Word := tag_word })
  modify ({ · with FP87_FDP := fdp })
  modify ({ · with FP87_FDS := fds })
  modify ({ · with FP87_FIP := fip })
  modify ({ · with FP87_FCS := fcs })
  modify ({ · with FP87_FOP := fop })

-- FLDENV_MEMmem14_0: D9 /4
def Instructions.FLDENV_MEMmem14_0
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

-- FLDENV_MEMmem14_1: D9 /4
def Instructions.FLDENV_MEMmem14_1
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

-- FLDENV_MEMmem14_2: D9 /4
def Instructions.FLDENV_MEMmem14_2
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

-- FLDENV_MEMmem28_0: D9 /4
def Instructions.FLDENV_MEMmem28_0
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

-- FLDENV_MEMmem28_1: D9 /4
def Instructions.FLDENV_MEMmem28_1
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

-- FLDENV_MEMmem28_2: D9 /4
def Instructions.FLDENV_MEMmem28_2
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

-- FLDENV_MEMmem28_3: D9 /4
def Instructions.FLDENV_MEMmem28_3
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

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FLDENV operand_size address_size segment effective_address

end X86

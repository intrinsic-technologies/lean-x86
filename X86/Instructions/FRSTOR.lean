-- Generated from data/instruction/FRSTOR.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: acaeea4312eff4a7cf579bc2551fbef155b64ee517d609a520d5bca8e49ad552
-- Description: data/sdm/FRSTOR.docbook
-- Loads the FPU state (operating environment and register stack) from the memory area specified
-- with the source operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FRSTOR)
import X86.Runtime
import X86.Helpers.Calculate_Offset
import X86.Helpers.Check_Logical_Address_Is_Readable
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Calculate_Abridged_Tag_Word
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Expand_Abridged_Tag_Word
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Load_Environment
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
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

def Instructions.Operations.FRSTOR
    (operand_size address_size : Int) (segment : Segment) (effective_address : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  -- check readability of the first byte
  Check_Logical_Address_Is_Readable segment effective_address 8
  -- check readability of the last byte
  let fp_image_size : Int := if operand_size == 16 then 94 else 108
  Check_Logical_Address_Is_Readable segment (← Std.Bits.Subtract_int (n := 64) (← Std.Bits.Add_int (n := 64) effective_address fp_image_size) 1) 8

  let (control, status, tag_word, fip, fcs, fop, fdp, fds) ← FP87.Load_Environment segment effective_address operand_size address_size

  modify ({ · with FP87_Control := control })
  modify ({ · with FP87_Status := status })
  modify ({ · with FP87_FDP := fdp })
  modify ({ · with FP87_FDS := fds })
  modify ({ · with FP87_FIP := fip })
  modify ({ · with FP87_FCS := fcs })
  modify ({ · with FP87_FOP := fop })

  -- FP registers
  let fp_offset : Int := if operand_size == 16 then 14 else 28
  for i in intRange (0 : Int) (7 : Int) do
    let offset : Bits 64 ← Calculate_Offset effective_address (fp_offset + i * 10) address_size
    ST_write i (← Logical_Mem_Read segment offset 80 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)

  -- now that FP regsister are loaded, update tag word information
  modify ({ · with FP87_Tag_Word := tag_word })
  FP87_Tag_Word.assign (← FP87.Expand_Abridged_Tag_Word (← FP87.Calculate_Abridged_Tag_Word))

-- FRSTOR_MEMmem108_0: DD /4
def Instructions.FRSTOR_MEMmem108_0
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

-- FRSTOR_MEMmem108_1: DD /4
def Instructions.FRSTOR_MEMmem108_1
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

-- FRSTOR_MEMmem108_2: DD /4
def Instructions.FRSTOR_MEMmem108_2
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

-- FRSTOR_MEMmem108_3: DD /4
def Instructions.FRSTOR_MEMmem108_3
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

-- FRSTOR_MEMmem94_0: DD /4
def Instructions.FRSTOR_MEMmem94_0
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

-- FRSTOR_MEMmem94_1: DD /4
def Instructions.FRSTOR_MEMmem94_1
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

-- FRSTOR_MEMmem94_2: DD /4
def Instructions.FRSTOR_MEMmem94_2
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

  Instructions.Operations.FRSTOR operand_size address_size segment effective_address

end X86

-- Generated from data/instruction/SGDT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 8f4c7e06b13f3566f11e80ff890f97d45e6f319c4e30de387802bb674d0968ed
-- Description: data/sdm/SGDT.docbook
-- Stores the content of the global descriptor table register (GDTR) in the destination operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SGDT)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
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
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.SGDT
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits 16 × Bits operand_size) := do
  Runtime.assert (operand_size == 32 || operand_size == 64)

  let limit : Bits 16 := (← get).GDTR.limit
  let base : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← get).GDTR.base 0 operand_size)
  return (limit, base)

-- SGDT_MEMs: 0F 01 /0
def Instructions.SGDT_MEMs
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_GDTR_IDTR

  if ((← CR4.UMIP) == 1 and (← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := next_ip0 })

  let (limit, base) ← Instructions.Operations.SGDT operand_size

  Logical_Mem_Write (size := 16) segment effective_address limit Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  Logical_Mem_Write (size := operand_size) segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide 16 8)) base Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SGDT_MEMs64: 0F 01 /0
def Instructions.SGDT_MEMs64
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_GDTR_IDTR

  if ((← CR4.UMIP) == 1 and (← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := next_ip0 })

  let (limit, base) ← Instructions.Operations.SGDT operand_size

  Logical_Mem_Write (size := 16) segment effective_address limit Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  Logical_Mem_Write (size := operand_size) segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide 16 8)) base Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86

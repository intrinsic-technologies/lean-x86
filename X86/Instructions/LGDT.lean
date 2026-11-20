-- Generated from data/instruction/LGDT-LIDT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0365aa0e0da3d8c60dc070b54e606cad64b43117590cc5a1bdf3f2dd867f0c73
-- Description: data/sdm/LGDT-LIDT.docbook
-- Loads the values in the source operand into the global descriptor table register (GDTR) or the
-- interrupt descriptor table register (IDTR).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LGDT%2FLIDT)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Canonical_Wrt_Max_Size
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Max_Linear_Address]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.LGDT
    (osz_prefix : Bool) (operand_size : Int) (limit : Bits 16) (base : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 32 || operand_size == 64)

  if ((← In_64Bit_Mode) and not (← Is_Canonical_Wrt_Max_Size (← Std.Bits.Sign_Extend (source_size := operand_size) base 64))) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  GDTR.setlimit limit
  GDTR.setbase (← (do if (← In_64Bit_Mode) then pure (← Std.Bits.Zero_Extend (source_size := operand_size) base 64) else pure (← (do if (← Segment_Descriptor.D.partial (← get).CS.descriptor) == 0 and not osz_prefix or (← Segment_Descriptor.D.partial (← get).CS.descriptor) == 1 and osz_prefix then pure (← Std.Bits.Zero_Extend (source_size := 24) (← base[0 +: 24]) 64) else pure (← Std.Bits.Zero_Extend (source_size := operand_size) (← base[0 +: operand_size]) 64)))))

def Instructions.Operations.LIDT
    (operand_size : Int) (limit : Bits 16) (base : Bits operand_size) (osz_prefix : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 32 || operand_size == 64)

  if ((← In_64Bit_Mode) and not (← Is_Canonical_Wrt_Max_Size (← Std.Bits.Sign_Extend (source_size := operand_size) base 64))) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  IDTR.setlimit limit
  IDTR.setbase (← (do if (← In_64Bit_Mode) then pure (← Std.Bits.Zero_Extend (source_size := operand_size) base 64) else pure (← (do if (← Segment_Descriptor.D.partial (← get).CS.descriptor) == 0 and not osz_prefix or (← Segment_Descriptor.D.partial (← get).CS.descriptor) == 1 and osz_prefix then pure (← Std.Bits.Zero_Extend (source_size := 24) (← base[0 +: 24]) 64) else pure (← Std.Bits.Zero_Extend (source_size := operand_size) (← base[0 +: operand_size]) 64)))))

-- LGDT_MEMs: 0F 01 /2
def Instructions.LGDT_MEMs
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let osz_prefix : Bool := context.osz_prefix_present

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

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let limit : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let base : Bits operand_size ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide 16 8)) operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.LGDT osz_prefix operand_size limit base

-- LGDT_MEMs64: 0F 01 /2
def Instructions.LGDT_MEMs64
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let osz_prefix : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_GDTR_IDTR

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let limit : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let base : Bits operand_size ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide 16 8)) operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.LGDT osz_prefix operand_size limit base

-- LIDT_MEMs: 0F 01 /3
def Instructions.LIDT_MEMs
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let osz_prefix : Bool := context.osz_prefix_present

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

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let limit : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let base : Bits operand_size ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide 16 8)) operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.LIDT operand_size limit base osz_prefix

-- LIDT_MEMs64: 0F 01 /3
def Instructions.LIDT_MEMs64
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let osz_prefix : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_GDTR_IDTR

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let limit : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let base : Bits operand_size ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide 16 8)) operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.LIDT operand_size limit base osz_prefix

end X86

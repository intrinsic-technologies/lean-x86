-- Generated from data/instruction/LMSW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: eb9d84cba210f0934470d6b67f8b0880885c1e16409fea8574c78e6786913865
-- Description: data/sdm/LMSW.docbook
-- Loads the source operand into the machine status word, bits 0 through 15 of register CR0.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LMSW)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Serialize_Instructions
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX.Check_CR0_Fixed_Bits
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
  [X86.CR0_Guest_Host_Mask.Binding σ]
  [X86.CR0_Read_Shadow.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.LMSW (src : Bits 16) : Runtime.SpecM Exception (State σ) Unit := do
  Serialize_Instructions

  let mut new_cr0 : CR0_Type ← concatBits (leftSize := 60) (rightSize := 4) (← sliceInclusive (← get).CR0 63 4) (← src[3:0])

  if ((← get).VMX_Operation_Mode != VMX_Operation_Type.Outside_VMX_Operation) then
    if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
      let cr0_guest_host_mask : CR0_Type ← CR0_Guest_Host_Mask (← get).Current_VMCS_Pointer
      let cr0_read_shadow : CR0_Type ← CR0_Read_Shadow (← get).Current_VMCS_Pointer

      if (CR0_Type.PE cr0_guest_host_mask == 1 and CR0_Type.PE new_cr0 == 1 and CR0_Type.PE cr0_read_shadow == 0) then
        VM_Exit VMX_EXIT_CR_ACCESS

      if (not (← Std.Bits.Is_Zero (size := 3) ((← cr0_guest_host_mask[3:1]) and ((← new_cr0[3:1]) xor (← cr0_read_shadow[3:1]))))) then
        VM_Exit VMX_EXIT_CR_ACCESS

    VMX.Check_CR0_Fixed_Bits new_cr0

  if ((← CR0.PE) == 1) then
    -- While in protected mode, the LMSW instruction cannot be used to clear CR0.PE and
    -- force a switch back to real-address mode."
    new_cr0 := CR0_Type.setPE new_cr0 (1 : Runtime.Bit)

  modify ({ · with CR0 := new_cr0 })

-- LMSW_GPR16: 0F 01 /6
def Instructions.LMSW_GPR16
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src : Bits 16 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.LMSW src

-- LMSW_MEMw: 0F 01 /6
def Instructions.LMSW_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let src : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.LMSW src

end X86

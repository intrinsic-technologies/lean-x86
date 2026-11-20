-- Generated from data/instruction/SMSW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 9b5692b1d0c9c2175a58932037f7d6d3c1ba4233dbfbf59a5ec4ab9525b47a1c
-- Description: data/sdm/SMSW.docbook
-- Stores the machine status word (bits 0 through 15 of control register CR0) into the destination
-- operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SMSW)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.Write_GPR
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.SMSW
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let cr0 : Bits 64 ← do
    if (← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root then
      let cr0_guest_host_mask : CR0_Type ← CR0_Guest_Host_Mask (← get).Current_VMCS_Pointer
      let cr0_read_shadow : CR0_Type ← CR0_Read_Shadow (← get).Current_VMCS_Pointer
      let cr0 : Bits 64 := cr0_read_shadow and cr0_guest_host_mask or (← get).CR0 and ~~~ cr0_guest_host_mask
      pure cr0
    else
      let cr0 : Bits 64 := (← get).CR0
      pure cr0

  let result : Bits operand_size ← cr0[0 +: operand_size]
  return result

-- SMSW_GPRv: 0F 01 /4
def Instructions.SMSW_GPRv
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.UMIP) == 1 and (← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.SMSW operand_size

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- SMSW_MEMw: 0F 01 /4
def Instructions.SMSW_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.UMIP) == 1 and (← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.SMSW operand_size

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86

-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 6db11ab9010dd1212e57c5907b327d3b3ad3c279b429ca5a87ace62335d8843b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FXSAVE)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Select_FXSAVE_Fields
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
  [X86.Helpers.Select_FXSAVE_AC.Binding σ]
  [X86.Helpers.Select_FXSAVE_Fields.Binding σ]
  [X86.Helpers.Select_FXSAVE_Page_Fault_Priority.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Header.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Slot.Binding σ]
  [X86.Helpers.Select_FXSAVE_Schedule_Domain.Binding σ]
  [X86.Helpers.Select_FXSAVE_Write_Swap.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- Intel SDM093 Vol. 2A 3-412..419: local completion; XML supplies no body.
-- Vol. 1 10.5.1 says bytes416..511 are unused; software464..511 is never written.
def Instructions.Operations.FXSAVE
    (wide : Bool) (segment : Segment) (offset : Bits 64) (address_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let (first, last, reserved, padding, fields, order) ← Emulate_FXSAVE_Write_Plan wide segment offset address_size
  Emulate_FXSAVE_Write_Transfer wide segment offset address_size first last reserved padding fields order

def Instructions.FXSAVE_MEMmfpxenv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (offset, segment, next_ip, relative, _) ← Effective_Address context.address_size context mod rm 1 ip
  let address : Bits 64 ← Handle_RIP_Relative_Address context.address_size relative offset next_ip
  if (context.lock_prefix_present or not (← CPUID_FXSR)) then
    liftM (Report_Invalid_Opcode)
  if ((← CR0.TS) == 1 or (← CR0.EM) == 1) then
    liftM (Report_Not_Available_Exception)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.FXSAVE false segment address context.address_size

def Instructions.FXSAVE64_MEMmfpxenv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (offset, segment, next_ip, relative, _) ← Effective_Address context.address_size context mod rm 1 ip
  let address : Bits 64 ← Handle_RIP_Relative_Address context.address_size relative offset next_ip
  if (context.lock_prefix_present or not (← CPUID_FXSR)) then
    liftM (Report_Invalid_Opcode)
  if ((← CR0.TS) == 1 or (← CR0.EM) == 1) then
    liftM (Report_Not_Available_Exception)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.FXSAVE true segment address context.address_size

end X86

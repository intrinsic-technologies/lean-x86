-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1106f2afac15a377235875f318385f9838c68fc0d5576446a0e69a5e8f3d166e
-- Invalidates from every level of the cache hierarchy in the cache coherence domain the cache line
-- that contains the linear address specified with the memory operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CLFLUSH)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Cache.Flush_By_Address
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Cache.Flush_By_Address.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.CLFLUSH
    (segment : Segment) (effective_address : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  let logical : Address_Translation ← Create_Logical_Address segment effective_address 8
  let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Normal_Alignment (← get).CS false
  let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Read

  Cache.Flush_By_Address linear.linear_address true

-- CLFLUSH_MEMmprefetch: NP 0F AE /7
-- CPUID group: CLFSH
def Instructions.CLFLUSH_MEMmprefetch
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (← CPUID_CLFLUSH)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.CLFLUSH segment effective_address

end X86

-- Generated from data/instruction/PREFETCHh.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: e9394ad480c47098dd20f0db8f2d062d528d660396db371c17b89df27e20f696
-- Description: data/sdm/PREFETCHh.docbook
-- Fetches the line of data or code (instructions’ bytes) from memory that contains the byte
-- specified with the source operand to a location in the cache hierarchy specified by a locality
-- hint:
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PREFETCHh)
import X86.Runtime
import X86.Helpers.Cache.Prefetch_By_Address
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Cache.Prefetch_By_Address.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.PREFETCH
    (segment : Segment) (effective_address : Bits 64) (level : Int) (is_code : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (level in {0..3})

  let is_vector : Bool := true
  let is_exclusive : Bool := false
  let linear_address : Bits 64 ← Compute_Linear_Address segment effective_address (← get).CS
  Cache.Prefetch_By_Address linear_address level is_code is_vector is_exclusive

-- PREFETCHNTA_MEMmprefetch: 0F 18 /0
def Instructions.PREFETCHNTA_MEMmprefetch
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 0
  let is_code : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCH segment effective_address level is_code

-- PREFETCHT0_MEMmprefetch: 0F 18 /1
def Instructions.PREFETCHT0_MEMmprefetch
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 1
  let is_code : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCH segment effective_address level is_code

-- PREFETCHT1_MEMmprefetch: 0F 18 /2
def Instructions.PREFETCHT1_MEMmprefetch
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 2
  let is_code : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCH segment effective_address level is_code

-- PREFETCHT2_MEMmprefetch: 0F 18 /3
def Instructions.PREFETCHT2_MEMmprefetch
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 3
  let is_code : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCH segment effective_address level is_code

-- PREFETCHIT1_MEMu8: 0F 18 /6
-- CPUID group: ICACHE_PREFETCH
def Instructions.PREFETCHIT1_MEMu8
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 1
  let is_code : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCH segment effective_address level is_code

-- PREFETCHIT0_MEMu8: 0F 18 /7
-- CPUID group: ICACHE_PREFETCH
def Instructions.PREFETCHIT0_MEMu8
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 0
  let is_code : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCH segment effective_address level is_code

end X86

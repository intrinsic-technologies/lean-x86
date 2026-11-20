-- Generated from data/instruction/PREFETCHW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5d55f00fd6b4c80a5664a9cfe5ebac01e16eaa79643ee6084b1a18510db6651f
-- Description: data/sdm/PREFETCHW.docbook
-- Fetches the cache line of data from memory that contains the byte specified with the source
-- operand to a location in the 1st or 2nd level cache and invalidates other cached instances of
-- the line.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PREFETCHW)
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

def Instructions.Operations.PREFETCHW
    (segment : Segment) (effective_address : Bits 64) (level : Int) (is_vector : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (level in {0..3})

  let is_code : Bool := false
  let is_exclusive : Bool := true
  let linear_address : Bits 64 ← Compute_Linear_Address segment effective_address (← get).CS
  Cache.Prefetch_By_Address linear_address level is_code is_vector is_exclusive

-- PREFETCHW_0F0Dr1: 0F 0D /1
def Instructions.PREFETCHW_0F0Dr1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 0
  let is_vector : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCHW segment effective_address level is_vector

-- PREFETCHW_0F0Dr3: 0F 0D /3
def Instructions.PREFETCHW_0F0Dr3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let level : Int := 0
  let is_vector : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PREFETCHW segment effective_address level is_vector

end X86

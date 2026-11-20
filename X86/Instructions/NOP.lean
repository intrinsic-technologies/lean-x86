-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 348d73116ec38041c90feb03be1c3d81c2a44d43086a45a3c95a61046d9ca79e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=NOP)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
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
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- XML has no NOP body. This local body implements the SDM's architectural no-op;
-- instruction bytes are fetched, but the apparent memory operand is not read.
-- https://intel.github.io/SDM/sdm.html?instr=NOP
def Instructions.Operations.NOP  : Except (Runtime.Error Empty) Unit := do
  pure ()

def Instructions.NOP_90
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F1F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_0F1F
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  -- Reuse Intel's addressing parser to fetch SIB/displacement bytes only.
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

-- XED marks these additional legacy forms as NOP. They use the same local
-- no-op behavior; memory-shaped forms fetch address bytes but never read data.

def Instructions.NOP_GPRv_0F18r0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_0F18r7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_GPRv_0F19
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_GPRv_0F19
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_GPRv_0F1A
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_GPRv_0F1A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_GPRv_0F1B
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_GPRv_0F1B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_GPRv_0F1C
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_GPRv_0F1C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_GPRv_0F1D
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_GPRv_0F1D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_GPRv_0F1E
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_GPRv_GPRv_0F1E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

-- SDM093 group 16 defines memory forms of 0F 18 /4-/7 as reserved NOPs
-- (Table A-6, PDF3008).
def Instructions.NOP_MEMv_0F18r4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_0F18r5
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_0F18r6
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

def Instructions.NOP_MEMv_0F18r7
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (_, _, next_ip, _, _) ← Effective_Address context.address_size context mod rm 1 ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.NOP

-- The 8087 FENI and FDISI and the 287 FSETPM encodings perform no function and
-- affect no x87 state (SDM093 Vol.1 8.3.13, PDF232; Vol.3B 25.18.9, PDF4137).
-- As x87 escape opcodes they keep the device-not-available check.
def Instructions.Obsolete_X87_NOP
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.NOP

def Instructions.FENI8087_NOP
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Obsolete_X87_NOP ip context

def Instructions.FDISI8087_NOP
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Obsolete_X87_NOP ip context

def Instructions.FSETPM287_NOP
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Obsolete_X87_NOP ip context

end X86

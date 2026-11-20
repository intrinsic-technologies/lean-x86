-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f70d47fb1edc5e95488bdc39b9eef64d5cd8cfe24a96599ba272a067725d3a16
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=IN)
import X86.Runtime
import X86.Helpers.Check_Port_Access
import X86.Helpers.IO_Read
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.IO_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- Intel SDM Vol. 2, IN. The executable XML has no instruction body.
-- REX.W does not select a 64-bit port transfer. Flags are unchanged.
def Instructions.Operations.IN
    (port : Bits 32) (width : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (width == 8 || width == 16 || width == 32)

  Check_Port_Access port width
  let value : Bits width ← IO_Read port width
  Write_GPR (size := width) 0 value

def Instructions.IN_AL_DX
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let port : Bits 32 ← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32
  let next_ip : Bits 64 := ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.IN port 8

def Instructions.IN_AL_IMMb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let port : Bits 32 ← Std.Bits.Zero_Extend (source_size := 8) (← Mem_Fetch ip 8) 32
  let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) ip 1
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.IN port 8

def Instructions.IN_OeAX_DX
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let port : Bits 32 ← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32
  let next_ip : Bits 64 := ip
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.IN port (if context.operand_size == 16 then 16 else 32)

def Instructions.IN_OeAX_IMMb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let port : Bits 32 ← Std.Bits.Zero_Extend (source_size := 8) (← Mem_Fetch ip 8) 32
  let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) ip 1
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.IN port (if context.operand_size == 16 then 16 else 32)

end X86

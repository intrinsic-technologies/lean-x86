-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0ade02c4c9184f12034ad4d02642395c3c5dfe2e347179c6daad18fffd87671d
-- Locates a byte entry in a table in memory, using the contents of the AL register as a table
-- index, then copies the contents of the table entry back into the AL register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=XLAT%2FXLATB)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero_Extend
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
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.XLAT
    (address_size : Int) (segment : Segment) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let offset : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) ((← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RBX) 0 address_size))) + (← Std.Bits.Zero_Extend (source_size := 8) (← AL) address_size)) 64
  AL_write (← Logical_Mem_Read segment offset 8 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)

-- XLAT: D7
def Instructions.XLAT
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let (_, segment, _, _, _) ← Effective_Address address_size context 0 0 1 ip

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.XLAT address_size segment

end X86

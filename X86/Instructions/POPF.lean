-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 4862bf454605a754001a8aa6c09dd55026d6249df8c0767b6abd15ad88acba21
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=POPF)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Pop_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Write_RSP
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
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- The executable XML omits POPF. SDM Vol. 2, POPF/POPFD/POPFQ defines
-- field updates by privilege. This implementation supports 64-bit mode only.
-- Step clears RF before instruction execution. The popped RF bit is ignored.
def Instructions.Operations.POP_FLAGS
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 64)

  Runtime.assert (← In_64Bit_Mode)
  let (value, next_rsp) ← Pop_Stack (← get).SS (← RSP) operand_size operand_size
  let mut flags : RFLAGS_Type := (← get).RFLAGS
  flags := RFLAGS_Type.setCF flags (← (do Runtime.assert (decide (0 < operand_size)); pure (← value[0 +: 1])))
  flags := RFLAGS_Type.setPF flags (← (do Runtime.assert (decide (2 < operand_size)); pure (← value[2 +: 1])))
  flags := RFLAGS_Type.setAF flags (← (do Runtime.assert (decide (4 < operand_size)); pure (← value[4 +: 1])))
  flags := RFLAGS_Type.setZF flags (← (do Runtime.assert (decide (6 < operand_size)); pure (← value[6 +: 1])))
  flags := RFLAGS_Type.setSF flags (← (do Runtime.assert (decide (7 < operand_size)); pure (← value[7 +: 1])))
  flags := RFLAGS_Type.setTF flags (← (do Runtime.assert (decide (8 < operand_size)); pure (← value[8 +: 1])))
  flags := RFLAGS_Type.setDF flags (← (do Runtime.assert (decide (10 < operand_size)); pure (← value[10 +: 1])))
  flags := RFLAGS_Type.setOF flags (← (do Runtime.assert (decide (11 < operand_size)); pure (← value[11 +: 1])))
  flags := RFLAGS_Type.setNT flags (← (do Runtime.assert (decide (14 < operand_size)); pure (← value[14 +: 1])))
  if (decide ((← get).CPL ≤ Unsigned (← RFLAGS.IOPL))) then
    flags := RFLAGS_Type.setIF flags (← (do Runtime.assert (decide (9 < operand_size)); pure (← value[9 +: 1])))
  if ((← get).CPL == 0) then
    flags := RFLAGS_Type.setIOPL flags (← (do Runtime.assert (decide (13 < operand_size)); pure (← value[13:12])))
  if (operand_size == 64) then
    flags := RFLAGS_Type.setAC flags (← (do Runtime.assert (decide (18 < operand_size)); pure (← value[18 +: 1])))
    -- Intel's RFLAGS type omits the ID field name (architectural bit 21).
    flags := RFLAGS_Type.setID flags (← (do Runtime.assert (decide (21 < operand_size)); pure (← value[21 +: 1])))
  -- VM, VIF, VIP and reserved bits keep their previous values. Commit the
  -- stack pointer after the memory read and all operand-width checks finish.
  modify ({ · with RFLAGS := flags })
  Write_RSP (size := 64) next_rsp

def Instructions.POPF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.POP_FLAGS 16

def Instructions.POPFQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.POP_FLAGS 64

end X86

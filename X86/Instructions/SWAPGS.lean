-- Generated from data/instruction/SWAPGS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0ea4010ab748061af7b80a070bab7bafdc7f1bf200f9cc02d4112c3e5e0ad014
-- Description: data/sdm/SWAPGS.docbook
-- SWAPGS exchanges the current GS base register value with the IA32_KERNEL_GS_BASE MSR (MSR
-- address C0000102H).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SWAPGS)
import X86.Runtime
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Get_Segment_Base
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Set_Segment_Base
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.SWAPGS  : Runtime.SpecM Exception (State σ) Unit := do
  let temp : Bits 64 ← Get_Segment_Base (← get).GS
  GS.assign (← Set_Segment_Base (← get).IA32_KERNEL_GS_BASE (← get).GS)
  modify ({ · with IA32_KERNEL_GS_BASE := temp })

-- SWAPGS: 0F 01 F8
-- CPUID group: LONGMODE
def Instructions.SWAPGS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not ((← Data_Size_Of_Current_Mode) == 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.FRED) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SWAPGS

end X86

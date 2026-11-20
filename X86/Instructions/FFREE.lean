-- Generated from data/instruction/FFREE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0bf36bc2d6e4db4fca273f510b27cf2fd355a6621484ed0faf6120447a1df112
-- Description: data/sdm/FFREE.docbook
-- Sets the tag in the FPU tag register associated with register ST(i) to empty (11B).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FFREE)
import X86.Runtime
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Free
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]

def Instructions.Operations.FFREE (rm : Bits 3) : Runtime.SpecM Exception (State σ) Unit := do
  FP87.Free (Unsigned rm)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 0
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))

-- FFREE_X87: DD C0+i
def Instructions.FFREE_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  Instructions.Operations.FFREE rm

  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FFREEP_X87: DF C0+i
def Instructions.FFREEP_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  Instructions.Operations.FFREE rm

  FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86

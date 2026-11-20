-- Generated from data/definitions.xml.gz: FP87::Update_Instruction_Info; do not edit.
-- Source SHA256: ece50e5cc6153a562cdf944a9bb23ca3255e2a2cbe53aa689c9e1ca3b878630d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AUpdate_Instruction_Info)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.FP87_Status_Type
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Null_Segment
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]

def FP87.Update_Instruction_Info
    (opcode modrm : Bits 8) (has_mem_operand : Bool := false) (segment : Segment) (offset : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  FP87_FCS.assign (← get).CS.selector
  if (← Config.Read.Feature_FIP_Use_Linear_Address (exception := Exception)) then
    FP87_FIP.assign (← (do if (← In_64Bit_Mode) then pure (← get).RIP else pure (← Compute_Linear_Address (← get).CS (← get).RIP (← get).CS)))
  else
    FP87_FIP.assign (← get).RIP

  if ((← FP87_Status.ES) == 1 or not (← CPUID_FDP_EXCPTN_ONLY)) then
    if has_mem_operand then
      modify ({ · with FP87_FDS := segment.selector })
      if (← Config.Read.Feature_FIP_Use_Linear_Address (exception := Exception)) then
        FP87_FDP.assign (← Compute_Linear_Address segment offset (← get).CS)
      else
        modify ({ · with FP87_FDP := offset })
    else
      FP87_FDS.assign (← UNSPECIFIED (size := 16))
      FP87_FDP.assign (← UNSPECIFIED (size := 64))

    -- the opcode byte is the same for all floating point opcodes (11011B),
    -- only the lower 3 bits of this byte are stored in FOP.
    FP87_FOP.assign (← concatBits (leftSize := 3) (rightSize := 8) (← opcode[0 +: 3]) modrm)

end X86.Helpers

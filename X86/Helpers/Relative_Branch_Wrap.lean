-- Generated from data/definitions.xml.gz: Relative_Branch_Wrap; do not edit.
-- Source SHA256: 2e6577dd7764f63772f4eebc87a9b627abf1cbed94cc1ddba3e59244869c5489
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Relative_Branch_Wrap)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Relative_Branch_Wrap
    (operand_size : Int) (branch_target : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← (do if (← In_64Bit_Mode) or operand_size == 8 then pure branch_target else pure (← Std.Bits.Zero_Extend (source_size := operand_size) (← branch_target[0 +: operand_size]) 64)))

end X86.Helpers

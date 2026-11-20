-- Generated from data/definitions.xml.gz: Calculate_Bit_Offset; do not edit.
-- Source SHA256: 7562631f7a05ab5567fd6accae2222f44a08fff81956435589a0dc7eb2b5a5a3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Calculate_Bit_Offset)
import X86.Runtime
import X86.Helpers.Std.Bits.Align_Down
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Calculate_Bit_Offset {operand_size : Int}
    (src : Bits operand_size) :
    Except (Runtime.Error Empty) (Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  -- shift right 3, shifting in sign bit
  let offset : Bits 64 ← Std.Bits.Sign_Extend (source_size := (operand_size + (-3 : Int))) (BitVec.cast (by omega) (← src[operand_size - 1:3]) : Bits (operand_size + (-3 : Int))) 64
  return (← Std.Bits.Align_Down (size := 64) offset (← Std.Integer.Positive_Divide operand_size 8))

end X86.Helpers

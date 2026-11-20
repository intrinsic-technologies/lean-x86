-- Generated from data/definitions.xml.gz: Decode_Legacy_Map; do not edit.
-- Source SHA256: 69b01f47b810dec937f76f31b524fc7dc491f69f04977b94f9da7803e5059cfb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_Legacy_Map)
import X86.Runtime
import X86.Helpers.Instruction_Map
import X86.Helpers.Mem_Fetch
import X86.Helpers.Std.Bits.Add_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Decode_Legacy_Map
    (ip : Bits 64) (byte : Bits 8) :
    Runtime.SpecM Exception (State σ) (Instruction_Map × Bits 64) := do
  if (byte == 15) then
    let next_byte : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
    if (next_byte == 56) then
      return (Instruction_Map.Map_Legacy_2, (← Std.Bits.Add_int (n := 64) ip 2))
    else
      if (next_byte == 58) then
        return (Instruction_Map.Map_Legacy_3, (← Std.Bits.Add_int (n := 64) ip 2))
      else
        return (Instruction_Map.Map_Legacy_1, (← Std.Bits.Add_int (n := 64) ip 1))
  else
    return (Instruction_Map.Map_Legacy_0, ip)

end X86.Helpers

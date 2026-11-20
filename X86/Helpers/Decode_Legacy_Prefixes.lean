-- Generated from data/definitions.xml.gz: Decode_Legacy_Prefixes; do not edit.
-- Source SHA256: 5d3db2817609a0725af1e018d02a2a313df7f192f9e6668e472aab373ed8cec1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_Legacy_Prefixes)
import X86.Runtime
import X86.Helpers.Clear_REX_Prefix
import X86.Helpers.Decode_Legacy_Prefix
import X86.Helpers.Decode_REX_Prefix
import X86.Helpers.Initial_Instruction_Context
import X86.Helpers.Instruction_Context
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

open scoped X86.Runtime.PartialSyntax in
def Decode_Legacy_Prefixes
    (ip : Bits 64) :
    Runtime.PartialSpecM Exception (State σ) (Instruction_Context × Bits 8 × Int) := do
  let mut context : Instruction_Context ← Runtime.liftTotal (Initial_Instruction_Context)

  let mut byte : Runtime.InitializedBits 8 := Runtime.InitializedBits.empty 8
  let mut offset : Int := 0
  let mut legacy_prefix : Bool := true
  repeat
    byte := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip offset) 8))

    if (context.is_mode64 and (← (do let subject := (← Runtime.InitializedBits.read byte); pure ((subject &&& (240 : Bits 8)) == (64 : Bits 8))))) then
      context := (← Decode_REX_Prefix (← Runtime.InitializedBits.read byte) context)
    else
      let (legacy_prefix_1, context_1) ← Runtime.liftTotal (Decode_Legacy_Prefix (← Runtime.InitializedBits.read byte) context)
      legacy_prefix := legacy_prefix_1
      context := context_1

      if legacy_prefix then
        -- REX is ignored if not the last prefix
        context := (← Clear_REX_Prefix context)

    if legacy_prefix then
      offset := offset + 1
  until not legacy_prefix

  return (context, (← Runtime.InitializedBits.read byte), offset)

end X86.Helpers

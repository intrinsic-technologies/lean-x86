-- Generated from data/definitions.xml.gz: Decode_Legacy_Prefix; do not edit.
-- Source SHA256: b61836078871bf2193ca207c8373148d883865a4c0e24733049609c0ce5c6e90
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_Legacy_Prefix)
import X86.Runtime
import X86.Helpers.Decode_Segment_Prefix
import X86.Helpers.Instruction_Context
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Decode_Legacy_Prefix
    (byte : Bits 8) (context_in : Instruction_Context) :
    Runtime.SpecM Exception (State σ) (Bool × Instruction_Context) := do
  let mut context : Instruction_Context := context_in

  let (is_segment_prefix, segment_context) ← Decode_Segment_Prefix byte context
  if is_segment_prefix then
    return (true, segment_context)

  if (byte == 102) then
    -- 2.1.1: 16<->32 switch
    -- 2.1.2: or mandatory prefix when followed by escape opcode byte and actual opcode byte
    context := { context with osz_prefix_present := true }
  else
    if (byte == 103) then
      context := { context with asz_prefix_present := true }
    else
      if (byte == 240) then
        context := { context with lock_prefix_present := true }
      else
        if (byte == 242) then
          -- 2.1.1: also BND prefix if enabled and precedes near CALL, near RET, near JMP, short Jcc or near Jcc
          -- 2.1.2: or mandatory prefix when followed by escape opcode byte and actual opcode byte
          context := { context with rep_prefix := Unsigned (242 : Bits 8) }
        else
          if (byte == 243) then
            -- 2.1.2: or mandatory prefix when followed by escape opcode byte and actual opcode byte
            context := { context with rep_prefix := Unsigned (243 : Bits 8) }
          else
            return (false, context)

  return (true, context)

end X86.Helpers

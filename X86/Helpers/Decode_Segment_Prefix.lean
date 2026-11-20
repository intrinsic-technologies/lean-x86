-- Generated from data/definitions.xml.gz: Decode_Segment_Prefix; do not edit.
-- Source SHA256: 2cb2dbb20d0294e48dbdeccf48a23a17eab1ae4ccac1d7acbb6d6dc41075cda4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_Segment_Prefix)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Decode_Segment_Prefix
    (byte : Bits 8) (context_in : Instruction_Context) :
    Runtime.SpecM Exception (State σ) (Bool × Instruction_Context) := do
  let mut context : Instruction_Context := context_in

  if (byte == 38) then
    -- only FS/GS segment prefixes are recognized in long mode so, in
    -- 64-bit mode, this prefix is ignored and must not override the
    -- segment selected by an earlier FS or GS segment override prefix
    if (not context.is_mode64) then
      -- no-track prefix only valid when it is the last segment prefix
      context := { context with no_track_prefix := false }
      -- use with branch reserved
      context := { context with segment := (← get).ES }
      context := { context with seg_prefix_present := true }
  else
    if (byte == 46) then
      -- only FS/GS segment prefixes are recognized in long mode so, in
      -- 64-bit mode, this prefix is ignored and must not override the
      -- segment selected by an earlier FS or GS segment override prefix
      if (not context.is_mode64) then
        -- no-track prefix only valid when it is the last segment prefix
        context := { context with no_track_prefix := false }
        -- use with branch except Jcc reserved; branch-not-taken hint for Jcc
        context := { context with segment := (← get).CS }
        context := { context with seg_prefix_present := true }
    else
      if (byte == 54) then
        -- only FS/GS segment prefixes are recognized in long mode so, in
        -- 64-bit mode, this prefix is ignored and must not override the
        -- segment selected by an earlier FS or GS segment override prefix
        if (not context.is_mode64) then
          -- no-track prefix only valid when it is the last segment prefix
          context := { context with no_track_prefix := false }
          -- use with branch reserved
          context := { context with segment := (← get).SS }
          context := { context with seg_prefix_present := true }
      else
        if (byte == 62) then
          if context.is_mode64 then
            -- In 64-bit mode, the 3EH prefix on an indirect CALL or JMP is recognized
            -- as a no-track prefix if there isn’t a 64H/65H prefix on the instruction
            if (not context.seg_prefix_present) then
              -- use with branch=>CET no-track prefix
              context := { context with no_track_prefix := true }
          else
            context := { context with no_track_prefix := true }
            -- use with branch reserved; branch-taken hint for Jcc
            context := { context with segment := (← get).DS }
            context := { context with seg_prefix_present := true }
        else
          if (byte == 100) then
            -- no-track prefix only valid when it is the last segment prefix
            context := { context with no_track_prefix := false }
            -- use with branch reserved
            context := { context with segment := (← get).FS }
            context := { context with seg_prefix_present := true }
          else
            if (byte == 101) then
              -- no-track prefix only valid when it is the last segment prefix
              context := { context with no_track_prefix := false }
              -- use with branch reserved
              context := { context with segment := (← get).GS }
              context := { context with seg_prefix_present := true }
            else
              return (false, context)

  return (true, context)

end X86.Helpers

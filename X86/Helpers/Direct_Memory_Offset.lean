-- Generated from data/definitions.xml.gz: Direct_Memory_Offset; do not edit.
-- Source SHA256: d7ce74b635cb0c96ba03561442c50c8b9814db3160f53997cfc5845033b4f951
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Direct_Memory_Offset)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Instruction_Context
import X86.Helpers.LAM_Canonicalize_Effective_Address
import X86.Helpers.Mem_Fetch
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
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
  [X86.Config.Value.Feature_LAM_Moffs_Displacement]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Direct_Memory_Offset
    (address_size : Int) (context : Instruction_Context) (ip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Segment × Bits 64 × Bits 64) := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let ea_segment : Segment ← Get_Effective_Segment context context.segment
  let mut ea : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← Mem_Fetch ip address_size) 64
  if (address_size == 64 and (← CPUID_LAM) and (← Config.Read.Feature_LAM_Moffs_Displacement (exception := Exception))) then
    ea := (← LAM_Canonicalize_Effective_Address ea)
  return (ea_segment, ea, (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide address_size 8)))

end X86.Helpers

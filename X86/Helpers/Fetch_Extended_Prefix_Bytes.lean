-- Generated from data/definitions.xml.gz: Fetch_Extended_Prefix_Bytes; do not edit.
-- Source SHA256: 0e608b273e14cb95d79164fe5d946d1c3d54ef72bc308abae2a725bcb0c1e8c6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Fetch_Extended_Prefix_Bytes)
import X86.Runtime
import X86.Helpers.Mem_Fetch
import X86.Helpers.Std.Bits.Add_int
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
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Fetch_Extended_Prefix_Bytes
    (byte : Bits 8) (current_ip : Bits 64) (is_mode64 : Bool) :
    Runtime.SpecM Exception (State σ) (Bool × Bits 8 × Bits 8 × Bits 8) := do
  if (byte == 98) then
    let byte1 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 1) 8
    if (is_mode64 or (← byte1[7:6]) == 3) then
      let byte2 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 2) 8
      let byte3 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 3) 8
      return (true, byte1, byte2, byte3)
  else
    if (byte == 196) then
      let byte1 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 1) 8
      if (is_mode64 or (← byte1[7:6]) == 3) then
        let byte2 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 2) 8
        return (true, byte1, byte2, (← Std.Bits.Zero 8))
    else
      if (byte == 197) then
        let byte1 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 1) 8
        if (is_mode64 or (← byte1[7:6]) == 3) then
          return (true, byte1, (← Std.Bits.Zero 8), (← Std.Bits.Zero 8))
      else
        if (byte == 213 and is_mode64) then
          let byte1 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) current_ip 1) 8
          return (true, byte1, (← Std.Bits.Zero 8), (← Std.Bits.Zero 8))

  return (false, (← Std.Bits.Zero 8), (← Std.Bits.Zero 8), (← Std.Bits.Zero 8))

end X86.Helpers

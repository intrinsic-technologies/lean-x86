-- Generated from data/definitions.xml.gz: Read_SIB; do not edit.
-- Source SHA256: 5dfc32073665f49be7f4828bf5081c7303d461c9c97e02c453b270b544167e16
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_SIB)
import X86.Runtime
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Read_GPR
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Multiply_int
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Unreachable
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

def Read_SIB
    (context : Instruction_Context) (mod : Bits 2) (disp8n : Int) (ip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Segment × Bits 64 × Bits 64 × Int × Bits 64 × Bool) := do
  let sib : Bits 8 ← Mem_Fetch ip 8
  let scale : Int ← (2 : Int) ** Unsigned (← sib[7:6])
  let ix_reg : Bits 5 ← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_x4 context.rex_x3) (← sib[5:3])
  let base_reg : Bits 5 ← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← sib[2:0])
  let base : Bits 64 ← Read_GPR base_reg 64
  let index : Bits 64 ← do
    if ix_reg == (4 : Bits 5) then
      Std.Bits.Zero 64
    else
      Read_GPR ix_reg 64
  let base_uses_rsp : Bool := base_reg == (4 : Bits 5)
  -- SS is the default segment when RSP or RBP is the base register
  let ea_segment : Segment ← do
    if base_reg == (4 : Bits 5) or base_reg == (5 : Bits 5) then
      Get_Effective_Segment context (← get).SS
    else
      Get_Effective_Segment context (← get).DS
  Runtime.assert (mod != 3)
  match Unsigned mod with
  | 0b00 => do
    -- base_reg is ignored for mod=0 and base_reg=RSP/R13/R29
    if ((base_reg &&& (7 : Bits 5)) == (5 : Bits 5)) then
      let disp : Bits 64 ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 32) 64
      let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) ip 5
      -- no base register, so DS is the default_segment
      let effective_segment : Segment ← Get_Effective_Segment context (← get).DS
      return (effective_segment, disp, index, scale, next_ip, false)
    else
      return (ea_segment, base, index, scale, (← Std.Bits.Add_int (n := 64) ip 1), base_uses_rsp)
  | 0b01 => do
    let disp : Bits 64 ← Std.Bits.Multiply_int (n := 64) (← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8) 64) disp8n
    let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) ip 2
    return (ea_segment, base + disp, index, scale, next_ip, base_uses_rsp)
  | 0b10 => do
    let disp : Bits 64 ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 32) 64
    let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) ip 1) 4
    return (ea_segment, base + disp, index, scale, next_ip, base_uses_rsp)
  | 0b11 => do
    Std.Unreachable
  | _ => throw .unmatchedCase

end X86.Helpers

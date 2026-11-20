-- Generated from data/definitions.xml.gz: Effective_Address; do not edit.
-- Source SHA256: 5f52af97819d6fe2940c2bb2423078ea84aabf2fc8132a3570994da4f65b6193
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Effective_Address)
import X86.Runtime
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Read_GPR
import X86.Helpers.Read_SIB
import X86.Helpers.Registers
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Multiply_int
import X86.Helpers.Std.Bits.Sign_Extend
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

def Effective_Address
    (address_size : Int) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (disp8n : Int) (ip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64 × Segment × Bits 64 × Bool × Bool) := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  Runtime.assert (mod != 3)
  let mut ea : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut ea_segment : Option (Segment) := none

  if (address_size == 16) then
    if (rm == 6 and mod == 0) then
      let disp : Bits 16 ← Mem_Fetch ip 16
      let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) ip 2
      let effective_segment : Segment ← Get_Effective_Segment context (← get).DS
      return ((← Std.Bits.Sign_Extend (source_size := 16) disp 64), effective_segment, next_ip, false, false)
    else
      let (disp, next_ip) ← do
        if mod == 0 then
          pure ((← Std.Bits.Zero 64), ip)
        else
          if mod == 1 then
            pure ((← Std.Bits.Multiply_int (n := 64) (← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) 64) disp8n), (← Std.Bits.Add_int (n := 64) ip 1))
          else
            pure ((← Std.Bits.Sign_Extend (source_size := 16) (← Mem_Fetch ip 16) 64), (← Std.Bits.Add_int (n := 64) ip 2))
      match Unsigned rm with
      | 0b000 => do
        ea_segment := some (← get).DS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) ((← Runtime.CheckedSlice.read (← RBX) 0 16) + (← Runtime.CheckedSlice.read (← RSI) 0 16)) 64) + disp)
      | 0b001 => do
        ea_segment := some (← get).DS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) ((← Runtime.CheckedSlice.read (← RBX) 0 16) + (← Runtime.CheckedSlice.read (← RDI) 0 16)) 64) + disp)
      | 0b010 => do
        ea_segment := some (← get).SS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) ((← Runtime.CheckedSlice.read (← RBP) 0 16) + (← Runtime.CheckedSlice.read (← RSI) 0 16)) 64) + disp)
      | 0b011 => do
        ea_segment := some (← get).SS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) ((← Runtime.CheckedSlice.read (← RBP) 0 16) + (← Runtime.CheckedSlice.read (← RDI) 0 16)) 64) + disp)
      | 0b100 => do
        ea_segment := some (← get).DS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) (← Runtime.CheckedSlice.read (← RSI) 0 16) 64) + disp)
      | 0b101 => do
        ea_segment := some (← get).DS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) (← Runtime.CheckedSlice.read (← RDI) 0 16) 64) + disp)
      | 0b110 => do
        ea_segment := some (← get).SS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) (← Runtime.CheckedSlice.read (← RBP) 0 16) 64) + disp)
      | 0b111 => do
        ea_segment := some (← get).DS
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := 16) (← Runtime.CheckedSlice.read (← RBX) 0 16) 64) + disp)
      | _ => throw .unmatchedCase
      let effective_segment : Segment ← Get_Effective_Segment context (← Runtime.readInitialized ea_segment)
      return ((← Runtime.InitializedBits.read ea), effective_segment, next_ip, false, false)
  else
    if (rm == 4) then
      let (sib_ea_segment, base, index, scale, next_ip, base_uses_rsp) ← Read_SIB context mod disp8n ip
      let sib_ea : Bits 64 := base + (← Std.Bits.Multiply_int (n := 64) index scale)
      let effective_segment : Segment ← Get_Effective_Segment context sib_ea_segment
      return (sib_ea, effective_segment, next_ip, false, base_uses_rsp)
    else
      if (rm == 5 and mod == 0) then
        let disp : Bits 64 ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) 64
        let next_ip : Bits 64 ← Std.Bits.Add_int (n := 64) ip 4
        ea := Runtime.InitializedBits.ofValue disp
        let effective_segment : Segment ← Get_Effective_Segment context (← get).DS
        return ((← Runtime.InitializedBits.read ea), effective_segment, next_ip, context.is_mode64, false)
      else
        let (disp, next_ip) ← do
          if mod == 0 then
            pure ((← Std.Bits.Zero 64), ip)
          else
            if mod == 1 then
              pure ((← Std.Bits.Multiply_int (n := 64) (← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) 64) disp8n), (← Std.Bits.Add_int (n := 64) ip 1))
            else
              pure ((← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) 64), (← Std.Bits.Add_int (n := 64) ip 4))

        -- SS is the default segment register when RBP is the base register
        ea_segment := some (← (do if (← concatBits (leftSize := 1) (rightSize := 3) context.rex_b3 rm) == (5 : Bits 4) then pure (← get).SS else pure (← get).DS))
        ea := Runtime.InitializedBits.ofValue ((← Std.Bits.Sign_Extend (source_size := address_size) (← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) address_size) 64) + disp)
        let effective_segment : Segment ← Get_Effective_Segment context (← Runtime.readInitialized ea_segment)
        return ((← Runtime.InitializedBits.read ea), effective_segment, next_ip, false, (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) == (4 : Bits 5))

end X86.Helpers

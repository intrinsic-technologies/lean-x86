-- Generated from data/definitions.xml.gz: Mem_Fetch; do not edit.
-- Source SHA256: 437a4e17e73ce69df4c1a632e58f98d2fa7f4528f035efcdde668f14637aa633
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Mem_Fetch)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Create_Logical_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Physical_Mem_Fetch
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
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

def Mem_Fetch.source
    (rip : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((size == (8 : Int)) || (size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)))

  if (decide (Unsigned (← Std.Bits.Add_int (n := 64) (rip - (← get).RIP) (← Std.Integer.Positive_Divide size 8)) > 15)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let code_segment : Segment ← do
    if (← In_64Bit_Mode) then
      -- no segmentation in Long mode
      let code_segment : Segment ← Null_Segment (← get).CS
      pure code_segment
    else
      let code_segment : Segment := (← get).CS
      pure code_segment

  let num_bytes : Int ← Std.Integer.Positive_Divide size 8
  let mut value : Runtime.InitializedBits size := Runtime.InitializedBits.empty size
  let mut physical_address : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut memory_type : Option (Memory_Type) := none
  for i in intRange (0 : Int) (num_bytes - 1) do
    let logical : Address_Translation ← Create_Logical_Address code_segment (← Std.Bits.Add_int (n := 64) rip i) 8
    let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Normal_Alignment (← get).CS true
    let physical : Address_Translation ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Execute
    Runtime.assert (decide (i * 8 ≤ size - 8))
    value := (← Runtime.InitializedBits.writeSlice value (i * (8 : Int)) 8 (← Physical_Mem_Fetch physical))
    if (i == 0) then
      physical_address := Runtime.InitializedBits.ofValue physical.translation1.physical_address
      memory_type := some physical.translation1.memory_type
  __Trace_Physical_Mem (size := size) true "FETCH" (← Runtime.InitializedBits.read physical_address) (← Runtime.readInitialized memory_type) (← Runtime.InitializedBits.read value)

  return (← Runtime.InitializedBits.read value)

def Mem_Fetch [X86.Accelerate (Mem_Fetch.source (σ := σ))]
    (rip : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  accelerated Mem_Fetch.source rip size

end X86.Helpers

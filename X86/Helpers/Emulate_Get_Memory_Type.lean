-- Generated from a local ISA specification; do not edit.
-- Source SHA256: be291a0f257042a1d5b6e6469abee0b498e6d9e5218409aaa9c02b79707b581b
import X86.Runtime
import X86.Helpers.Convert_To_Memory_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure Memory_Type_Inputs where
  IA32_MTRRCAP : Bits 64
  IA32_MTRR_DEF_TYPE : Bits 64
  IA32_PAT : Bits 64
  MTRR_Fixed : Runtime.Array 11 (Bits 64)
  MTRR_Base : Runtime.Array 256 (Bits 64)
  MTRR_Mask : Runtime.Array 256 (Bits 64)
  Memory_Physical_Address_Bits : Int
  CR0 : Bits 64
  Processor_Is_Atom : Bool
  CPUID_MTRR : Bool
  CPUID_PAT : Bool
  IA32_SMRR_PHYSBASE : Bits 64
  IA32_SMRR_PHYSMASK : Bits 64
  In_SMM : Bool
  deriving Repr, DecidableEq, Inhabited

structure Memory_Type_Selection where
  Requires_Binding : Bool
  Known_Type : Memory_Type
  deriving Repr, DecidableEq, Inhabited

def Emulate_Memory.Known_Type
    (memory_type : Memory_Type) :
    Except (Runtime.Error Empty) (Memory_Type_Selection) := do
  return ({ Requires_Binding := false, Known_Type := memory_type } : Memory_Type_Selection)

def Emulate_Memory.Decode_MTRR (value : Bits 8) : Except (Runtime.Error Empty) (Memory_Type) := do
  Runtime.assert ((value == (0 : Bits 8)) || (value == (1 : Bits 8)) || (value == (4 : Bits 8)) || (value == (5 : Bits 8)) || (value == (6 : Bits 8)))
  return (← Convert_To_Memory_Type (← value[2:0]))

-- MTRRCAP.WC advertises whether the WC memory type is supported.
def Emulate_Memory.Supported_Type
    (cap : Bits 64) (kind : Memory_Type) :
    Except (Runtime.Error Empty) (Memory_Type) := do
  Runtime.assert (kind != Memory_Type.Memory_Type_Write_Combining or (← cap[10 +: 1]) == 1)
  return kind

def Emulate_Memory.MTRR_Type
    (config : Memory_Type_Inputs) (address : Bits 64) :
    Except (Runtime.Error Empty) (Memory_Type) := do
  Runtime.assert (decide (config.Memory_Physical_Address_Bits ≥ 12) and decide (config.Memory_Physical_Address_Bits ≤ 52))
  let mask_value : Int := (← (2 : Int) ** config.Memory_Physical_Address_Bits) - 1
  let address_mask : Bits 64 ← mask_value[0 +: 64]
  Runtime.assert ((address and ~~~ address_mask) == 0)
  if ((← config.IA32_MTRR_DEF_TYPE[11 +: 1]) == 0) then
    return Memory_Type.Memory_Type_Strong_Uncacheable
  let a : Int := Unsigned address
  if (decide (a < 1048576) and (← config.IA32_MTRRCAP[8 +: 1]) == 1 and (← config.IA32_MTRR_DEF_TYPE[10 +: 1]) == 1) then
    let (reg, slot) : (Int × Int) ← do
      if decide (a < 524288) then
        let reg : Int := 0
        let slot : Int ← Std.Integer.Positive_Divide a 65536
        pure (reg, slot)
      else
        if decide (a < 786432) then
          let reg : Int := 1 + (← Std.Integer.Positive_Divide (a - 524288) 131072)
          let slot : Int ← (do
            let __check30 : Int ← Std.Integer.Positive_Divide (a - 524288) 16384
            pure (← Std.Integer.Positive_Remainder __check30 8))
          pure (reg, slot)
        else
          let reg : Int := 3 + (← Std.Integer.Positive_Divide (a - 786432) 32768)
          let slot : Int ← (do
            let __check33 : Int ← Std.Integer.Positive_Divide (a - 786432) 4096
            pure (← Std.Integer.Positive_Remainder __check33 8))
          pure (reg, slot)
    return (← Emulate_Memory.Decode_MTRR (← (do
      let __check34 : Int := slot * 8
      Runtime.assert (decide (__check34 + 8 ≤ 64))
      Runtime.assert (decide (0 ≤ __check34))
      pure (← Runtime.CheckedSlice.read (← (do Runtime.assert (decide (reg < 11)); pure (← Runtime.Array.get config.MTRR_Fixed reg))) __check34 8))))
  -- The local MSR owner provides at most ten variable pairs.
  Runtime.assert (decide (Unsigned (← config.IA32_MTRRCAP[7:0]) ≤ 10))
  let mut seen_uc : Bool := false
  let mut seen_wc : Bool := false
  let mut seen_wt : Bool := false
  let mut seen_wp : Bool := false
  let mut seen_wb : Bool := false
  for i in intRange (0 : Int) (Unsigned (← config.IA32_MTRRCAP[7:0]) - 1) do
    let mask : Bits 64 ← do
      Runtime.assert (decide (i < 256))
      pure (← Runtime.Array.get config.MTRR_Mask i)
    let base : Bits 64 ← do
      Runtime.assert (decide (i < 256))
      pure (← Runtime.Array.get config.MTRR_Base i)
    let compare_mask : Bits 64 := mask and address_mask and 18446744073709547520
    if ((← mask[11 +: 1]) == 1 and (address and compare_mask) == (base and compare_mask)) then
      let kind : Memory_Type ← Emulate_Memory.Decode_MTRR (← base[7:0])
      seen_uc := seen_uc or kind == Memory_Type.Memory_Type_Strong_Uncacheable
      seen_wc := seen_wc or kind == Memory_Type.Memory_Type_Write_Combining
      seen_wt := seen_wt or kind == Memory_Type.Memory_Type_Write_Through
      seen_wp := seen_wp or kind == Memory_Type.Memory_Type_Write_Protected
      seen_wb := seen_wb or kind == Memory_Type.Memory_Type_Write_Back
  -- Do not fail on an intermediate conflict: a later UC match wins globally.
  if seen_uc then
    return Memory_Type.Memory_Type_Strong_Uncacheable
  if seen_wc then
    Runtime.assert (not (seen_wt or seen_wp or seen_wb))
    return Memory_Type.Memory_Type_Write_Combining
  if seen_wp then
    Runtime.assert (not (seen_wt or seen_wb))
    return Memory_Type.Memory_Type_Write_Protected
  if seen_wt then
    return Memory_Type.Memory_Type_Write_Through
  if seen_wb then
    return Memory_Type.Memory_Type_Write_Back
  return (← Emulate_Memory.Decode_MTRR (← config.IA32_MTRR_DEF_TYPE[7:0]))

def Emulate_Memory.Combine_PAT
    (mtrr pat : Memory_Type) :
    Except (Runtime.Error Empty) (Memory_Type) := do
  Runtime.assert ((mtrr == Memory_Type.Memory_Type_Strong_Uncacheable) || (mtrr == Memory_Type.Memory_Type_Write_Combining) || (mtrr == Memory_Type.Memory_Type_Write_Through) || (mtrr == Memory_Type.Memory_Type_Write_Back) || (mtrr == Memory_Type.Memory_Type_Write_Protected))
  Runtime.assert (pat != Memory_Type.Memory_Type_Unknown)
  if (pat == Memory_Type.Memory_Type_Write_Combining) then
    return Memory_Type.Memory_Type_Write_Combining
  if (pat == Memory_Type.Memory_Type_Strong_Uncacheable or mtrr == Memory_Type.Memory_Type_Strong_Uncacheable) then
    return Memory_Type.Memory_Type_Strong_Uncacheable
  if (mtrr == Memory_Type.Memory_Type_Write_Combining) then
    if (pat == Memory_Type.Memory_Type_Uncacheable or pat == Memory_Type.Memory_Type_Write_Back) then
      return Memory_Type.Memory_Type_Write_Combining
    return Memory_Type.Memory_Type_Strong_Uncacheable
  if (pat == Memory_Type.Memory_Type_Uncacheable) then
    if (mtrr == Memory_Type.Memory_Type_Write_Protected) then
      return Memory_Type.Memory_Type_Write_Combining
    return Memory_Type.Memory_Type_Strong_Uncacheable
  if (pat == Memory_Type.Memory_Type_Write_Back) then
    return mtrr
  return pat

-- Normal-caching PAT/MTRR selection, not cache-disabled or SMRR/PRMRR typing.
-- Get_Memory_Type below enforces the currently supported integration domain.
def Emulate_Memory.Normal_Type
    (config : Memory_Type_Inputs) (address : Bits 64) (pat_pcd_pwt : Bits 3) :
    Except (Runtime.Error Empty) (Memory_Type) := do
  let mtrr : Memory_Type ← Emulate_Memory.MTRR_Type config address
  if ((← config.IA32_MTRR_DEF_TYPE[11 +: 1]) == 0) then
    return Memory_Type.Memory_Type_Strong_Uncacheable
  let entry : Bits 8 ← config.IA32_PAT[Unsigned pat_pcd_pwt * 8 +: 8]
  Runtime.assert ((entry == (0 : Bits 8)) || (entry == (1 : Bits 8)) || (entry == (4 : Bits 8)) || (entry == (5 : Bits 8)) || (entry == (6 : Bits 8)) || (entry == (7 : Bits 8)))
  return (← Emulate_Memory.Combine_PAT mtrr (← Convert_To_Memory_Type (← entry[2:0])))

-- Original 32-bit SMRR interface: high physical addresses must not alias SMRAM.
def Emulate_Memory.SMRR_Matches
    (cap base mask_register address : Bits 64) :
    Except (Runtime.Error Empty) (Bool) := do
  if ((← cap[11 +: 1]) == 0 or (← mask_register[11 +: 1]) == 0) then
    return false
  if ((← address[63:32]) != 0) then
    return false
  let mask : Bits 20 ← mask_register[31:12]
  return ((BitVec.cast (by omega) (← address[31:12]) : Bits 20) and mask) == ((BitVec.cast (by omega) (← base[31:12]) : Bits 20) and mask)

-- SDM093 table 14-5 and 14.5.3 distinguish cache control from memory typing.
-- Atom CD=1 forces UC globally. Other Intel64 CD=1 typing needs the selected
-- processor's implementation policy; table 14-7 only specifies normal caching.
-- SMRR read/write suppression remains independent of this type selection.
def Emulate_Get_Memory_Type
    (config : Memory_Type_Inputs) (address : Bits 64) (pat_pcd_pwt : Bits 3) :
    Except (Runtime.Error Empty) (Memory_Type_Selection) := do
  Runtime.assert (config.CPUID_MTRR and config.CPUID_PAT)
  -- MOV CR0 checks this illegal setting; direct invalid states fail this check.
  Runtime.assert ((← config.CR0[30:29]) != 1)
  -- PRMRR/SEAMRR need separate priority and access policy implementations.
  Runtime.assert ((← config.IA32_MTRRCAP[12 +: 1]) == 0 and (← config.IA32_MTRRCAP[15 +: 1]) == 0)
  Runtime.assert (decide (config.Memory_Physical_Address_Bits ≥ 12) and decide (config.Memory_Physical_Address_Bits ≤ 52))
  let mask_value : Int := (← (2 : Int) ** config.Memory_Physical_Address_Bits) - 1
  let address_mask : Bits 64 ← mask_value[0 +: 64]
  Runtime.assert ((address and ~~~ address_mask) == 0)
  let cache_disabled : Bool := (← config.CR0[30 +: 1]) == 1
  if (cache_disabled and config.Processor_Is_Atom) then
    return (← Emulate_Memory.Known_Type Memory_Type.Memory_Type_Strong_Uncacheable)
  let smrr : Bool ← Emulate_Memory.SMRR_Matches config.IA32_MTRRCAP config.IA32_SMRR_PHYSBASE config.IA32_SMRR_PHYSMASK address
  if (smrr and not config.In_SMM) then
    return (← Emulate_Memory.Known_Type Memory_Type.Memory_Type_Strong_Uncacheable)
  if cache_disabled then
    if (not smrr and (← config.IA32_MTRR_DEF_TYPE[11 +: 1]) == 0) then
      return (← Emulate_Memory.Known_Type Memory_Type.Memory_Type_Strong_Uncacheable)
    return ({
      Requires_Binding := true,
      Known_Type := Memory_Type.Memory_Type_Unknown
    } : Memory_Type_Selection)
  if smrr then
    return (← Emulate_Memory.Known_Type (← Emulate_Memory.Supported_Type config.IA32_MTRRCAP (← Emulate_Memory.Decode_MTRR (← config.IA32_SMRR_PHYSBASE[7:0]))))
  return (← Emulate_Memory.Known_Type (← Emulate_Memory.Supported_Type config.IA32_MTRRCAP (← Emulate_Memory.Normal_Type config address pat_pcd_pwt)))

end X86.Helpers

-- Generated from a local ISA specification; do not edit.
-- Source SHA256: d23ab4aa2d7f9ef5b52359dceecf434c6dd1438607d8958aee5ba613e5b797a5
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Invalidate_All_Translation_Caches.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

def «Emulate_Memory::IA32_MTRRCAP_Address» : Int := 254

def «Emulate_Memory::IA32_SMRR_PHYSBASE_Address» : Int := 498

def «Emulate_Memory::IA32_SMRR_PHYSMASK_Address» : Int := 499

def «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address» : Int := 512

def «Emulate_Memory::IA32_MTRR_PHYSMASK9_Address» : Int := 531

def «Emulate_Memory::IA32_MTRR_FIX64K_00000_Address» : Int := 592

def «Emulate_Memory::IA32_MTRR_FIX16K_80000_Address» : Int := 600

def «Emulate_Memory::IA32_MTRR_FIX16K_A0000_Address» : Int := 601

def «Emulate_Memory::IA32_MTRR_FIX4K_C0000_Address» : Int := 616

def «Emulate_Memory::IA32_MTRR_FIX4K_F8000_Address» : Int := 623

def «Emulate_Memory::IA32_PAT_Address» : Int := 631

def «Emulate_Memory::IA32_MTRR_DEF_TYPE_Address» : Int := 767

def Emulate_Memory.Is_MSR_Address (address : Int) : Except (Runtime.Error Empty) (Bool) := do
  return ((address == «Emulate_Memory::IA32_MTRRCAP_Address») || (address == «Emulate_Memory::IA32_SMRR_PHYSBASE_Address») || (address == «Emulate_Memory::IA32_SMRR_PHYSMASK_Address») || (address == «Emulate_Memory::IA32_MTRR_FIX64K_00000_Address») || (address == «Emulate_Memory::IA32_MTRR_FIX16K_80000_Address») || (address == «Emulate_Memory::IA32_MTRR_FIX16K_A0000_Address») || (address == «Emulate_Memory::IA32_PAT_Address») || (address == «Emulate_Memory::IA32_MTRR_DEF_TYPE_Address»)) or decide (address ≥ «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address») and decide (address ≤ «Emulate_Memory::IA32_MTRR_PHYSMASK9_Address») or decide (address ≥ «Emulate_Memory::IA32_MTRR_FIX4K_C0000_Address») and decide (address ≤ «Emulate_Memory::IA32_MTRR_FIX4K_F8000_Address»)

def Emulate_Memory.Fixed_MTRR_Index (address : Int) : Except (Runtime.Error Empty) (Int) := do
  if (address == «Emulate_Memory::IA32_MTRR_FIX64K_00000_Address») then
    return 0
  if (address == «Emulate_Memory::IA32_MTRR_FIX16K_80000_Address») then
    return 1
  if (address == «Emulate_Memory::IA32_MTRR_FIX16K_A0000_Address») then
    return 2
  if (decide (address ≥ «Emulate_Memory::IA32_MTRR_FIX4K_C0000_Address») and decide (address ≤ «Emulate_Memory::IA32_MTRR_FIX4K_F8000_Address»)) then
    return address - «Emulate_Memory::IA32_MTRR_FIX4K_C0000_Address» + 3
  return - 1

def Emulate_Memory.MSR_Read_Allowed
    (cap : Bits 64) (address : Int) :
    Runtime.SpecM Empty (State σ) (Bool) := do
  if (address == «Emulate_Memory::IA32_PAT_Address») then
    return (← CPUID_PAT)
  if (not (← CPUID_MTRR)) then
    return false
  if ((address == «Emulate_Memory::IA32_MTRRCAP_Address») || (address == «Emulate_Memory::IA32_MTRR_DEF_TYPE_Address»)) then
    return true
  if ((address == «Emulate_Memory::IA32_SMRR_PHYSBASE_Address») || (address == «Emulate_Memory::IA32_SMRR_PHYSMASK_Address»)) then
    return (← cap[11 +: 1]) == 1
  if (decide ((← Emulate_Memory.Fixed_MTRR_Index address) ≥ 0)) then
    return (← cap[8 +: 1]) == 1
  if (decide (address ≥ «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address») and decide (address ≤ «Emulate_Memory::IA32_MTRR_PHYSMASK9_Address»)) then
    return decide ((← Std.Integer.Positive_Divide (address - «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address») 2) < Unsigned (← cap[7:0]))
  return false

def Emulate_Memory.Is_Valid_MTRR_Type (value : Bits 8) : Except (Runtime.Error Empty) (Bool) := do
  return ((value == (0 : Bits 8)) || (value == (1 : Bits 8)) || (value == (4 : Bits 8)) || (value == (5 : Bits 8)) || (value == (6 : Bits 8)))

def Emulate_Memory.MSR_Write_Allowed
    (cap : Bits 64) (address : Int) (value : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bool) := do
  if (not (← Emulate_Memory.MSR_Read_Allowed cap address) or address == «Emulate_Memory::IA32_MTRRCAP_Address») then
    return false
  if (address == «Emulate_Memory::IA32_PAT_Address») then
    for i in intRange (0 : Int) (7 : Int) do
      if (not (← (do
        let __check55 : Bits 8 ← value[8 * i +: 8]
        pure ((__check55 == (0 : Bits 8)) || (__check55 == (1 : Bits 8)) || (__check55 == (4 : Bits 8)) || (__check55 == (5 : Bits 8)) || (__check55 == (6 : Bits 8)) || (__check55 == (7 : Bits 8)))))) then
        return false
    return true
  if (address == «Emulate_Memory::IA32_MTRR_DEF_TYPE_Address») then
    return (value and ~~~ (3327 : Bits 64)) == 0 and (← Emulate_Memory.Is_Valid_MTRR_Type (← value[7:0]))
  if (decide ((← Emulate_Memory.Fixed_MTRR_Index address) ≥ 0)) then
    for i in intRange (0 : Int) (7 : Int) do
      if (not (← Emulate_Memory.Is_Valid_MTRR_Type (← value[8 * i +: 8]))) then
        return false
    return true
  if (address == «Emulate_Memory::IA32_SMRR_PHYSBASE_Address») then
    return (← get).«SMM::In_SMM» and (value and ~~~ (4294963455 : Bits 64)) == 0 and (← Emulate_Memory.Is_Valid_MTRR_Type (← value[7:0]))
  if (address == «Emulate_Memory::IA32_SMRR_PHYSMASK_Address») then
    return (← get).«SMM::In_SMM» and (value and ~~~ (4294965248 : Bits 64)) == 0
  let physical_width : Int ← Config.Read.Max_Physical_Address (exception := Empty)
  Runtime.assert (decide (physical_width ≥ 12) and decide (physical_width ≤ 52))
  let physical_mask_value : Int := (← (2 : Int) ** physical_width) - 1
  let physical_mask : Bits 64 := (← physical_mask_value[0 +: 64]) and 18446744073709547520
  if ((← Std.Integer.Positive_Remainder address 2) == 0) then
    return (value and ~~~ (physical_mask or 255)) == 0 and (← Emulate_Memory.Is_Valid_MTRR_Type (← value[7:0]))
  -- Discontinuous masks are discouraged, but permitted by section 14.11.2.3.
  return (value and ~~~ (physical_mask or 2048)) == 0

def Emulate_Memory.MSR_Read
    (cap : Bits 64) (address : Int) :
    Runtime.SpecM Empty (State σ) (Bits 64) := do
  Runtime.assert (← Emulate_Memory.MSR_Read_Allowed cap address)
  if (address == «Emulate_Memory::IA32_MTRRCAP_Address») then
    let undefined_bits : Bits 64 ← UNSPECIFIED (size := 64)
    return cap and 40447 or undefined_bits and ~~~ (40447 : Bits 64)
  if (address == «Emulate_Memory::IA32_PAT_Address») then
    return (← get).IA32_PAT
  if (address == «Emulate_Memory::IA32_MTRR_DEF_TYPE_Address») then
    return (← get).IA32_MTRR_DEF_TYPE
  if (address == «Emulate_Memory::IA32_SMRR_PHYSBASE_Address») then
    return (← get).IA32_SMRR_PHYSBASE
  if (address == «Emulate_Memory::IA32_SMRR_PHYSMASK_Address») then
    return (← get).IA32_SMRR_PHYSMASK
  let fixed_index : Int ← Emulate_Memory.Fixed_MTRR_Index address
  if (decide (fixed_index ≥ 0)) then
    Runtime.assert (decide (fixed_index < 11))
    Runtime.assert (decide (0 ≤ fixed_index))
    return (← MTRR_Fixed.get fixed_index)
  let index : Int ← Std.Integer.Positive_Divide (address - «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address») 2
  if ((← Std.Integer.Positive_Remainder address 2) == 0) then
    Runtime.assert (decide (index < 256))
    Runtime.assert (decide (0 ≤ index))
    return (← MTRR_Base.get index)
  Runtime.assert (decide (index < 256))
  Runtime.assert (decide (0 ≤ index))
  return (← MTRR_Mask.get index)

-- Called only after the complete WRMSR validation and behavior stages succeed.
def Emulate_Memory.MSR_Commit
    (address : Int) (value : Bits 64) :
    Runtime.SpecM Empty (State σ) Unit := do
  if (address == «Emulate_Memory::IA32_PAT_Address») then
    modify ({ · with IA32_PAT := value })
    return ()
  if (address == «Emulate_Memory::IA32_SMRR_PHYSBASE_Address») then
    modify ({ · with IA32_SMRR_PHYSBASE := value })
    return ()
  if (address == «Emulate_Memory::IA32_SMRR_PHYSMASK_Address») then
    modify ({ · with IA32_SMRR_PHYSMASK := value })
    return ()
  if (address == «Emulate_Memory::IA32_MTRR_DEF_TYPE_Address») then
    modify ({ · with IA32_MTRR_DEF_TYPE := value })
  else
    let fixed_index : Int ← Emulate_Memory.Fixed_MTRR_Index address
    if (decide (fixed_index ≥ 0)) then
      Runtime.assert (decide (fixed_index < 11))
      Runtime.assert (decide (0 ≤ fixed_index))
      MTRR_Fixed.set fixed_index value
    else
      Runtime.assert (decide (address ≥ «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address») and decide (address ≤ «Emulate_Memory::IA32_MTRR_PHYSMASK9_Address»))
      let index : Int ← Std.Integer.Positive_Divide (address - «Emulate_Memory::IA32_MTRR_PHYSBASE0_Address») 2
      if ((← Std.Integer.Positive_Remainder address 2) == 0) then
        Runtime.assert (decide (index < 256))
        Runtime.assert (decide (0 ≤ index))
        MTRR_Base.set index value
      else
        Runtime.assert (decide (index < 256))
        Runtime.assert (decide (0 ≤ index))
        MTRR_Mask.set index value
  Invalidate_All_Translation_Caches

end X86.Helpers

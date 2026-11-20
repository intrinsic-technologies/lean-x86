-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 3ad6abe1741c2012a01205da349c3166914bd48ffb289c94e138d1a145599c90
import X86.Runtime
import X86.Helpers.Emulate_Memory.Is_MSR_Address
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Other_MSR_Read_Allowed.Binding (σ : Type) where
  call (address : Int) :
    Runtime.SpecM Empty (State σ) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Other_MSR_Read_Allowed.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Other_MSR_Write_Allowed.Binding (σ : Type) where
  call (address : Int) (value : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Other_MSR_Write_Allowed.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Other_MSR_Read.Binding (σ : Type) where
  call (address : Int) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Other_MSR_Read.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Other_MSR_Write_Behavior.Binding (σ : Type) where
  call (address : Int) (value : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Other_MSR_Write_Behavior.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Other_MSR_Commit.Binding (σ : Type) where
  call (address : Int) (value : Bits 64) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Other_MSR_Commit.Binding

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Other_MSR_Commit.Binding σ]
  [X86.Helpers.Other_MSR_Read.Binding σ]
  [X86.Helpers.Other_MSR_Read_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Behavior.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.Invalidate_All_Translation_Caches.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

-- Addresses outside the local memory-register inventory use the caller's MSR
-- inventory, permissions and effects. Validation and commit order stay in WRMSR.
def Other_MSR_Read_Allowed (address : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.liftNoSourceException (Other_MSR_Read_Allowed.Binding.call address)

def Other_MSR_Write_Allowed
    (address : Int) (value : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.liftNoSourceException (Other_MSR_Write_Allowed.Binding.call address value)

def Other_MSR_Read (address : Int) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (Other_MSR_Read.Binding.call address)

def Other_MSR_Write_Behavior
    (address : Int) (value : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  try
    Other_MSR_Write_Behavior.Binding.call address value
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

def Other_MSR_Commit
    (address : Int) (value : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Other_MSR_Commit.Binding.call address value)

def Is_RDMSR_Allowed (address : Int) : Runtime.SpecM Exception (State σ) (Bool) := do
  if (← Emulate_Memory.Is_MSR_Address address) then
    return (← Runtime.liftNoSourceException (Emulate_Memory.MSR_Read_Allowed (← Runtime.liftNoSourceException (IA32_MTRRCAP)) address))
  return (← Other_MSR_Read_Allowed address)

def Is_WRMSR_Allowed
    (address : Int) (value : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if (← Emulate_Memory.Is_MSR_Address address) then
    return (← Runtime.liftNoSourceException (Emulate_Memory.MSR_Write_Allowed (← Runtime.liftNoSourceException (IA32_MTRRCAP)) address value))
  return (← Other_MSR_Write_Allowed address value)

def RDMSR_Behavior (address : Int) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  if (← Emulate_Memory.Is_MSR_Address address) then
    return (← Runtime.liftNoSourceException (Emulate_Memory.MSR_Read (← Runtime.liftNoSourceException (IA32_MTRRCAP)) address))
  return (← Other_MSR_Read address)

def WRMSR_Behavior
    (address : Int) (value : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  if (← Emulate_Memory.Is_MSR_Address address) then
    return value
  return (← Other_MSR_Write_Behavior address value)

def MSR_write (index : Int) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  if (← Emulate_Memory.Is_MSR_Address index) then
    Runtime.liftNoSourceException (Emulate_Memory.MSR_Commit index value)
  else
    Other_MSR_Commit index value

end X86.Helpers

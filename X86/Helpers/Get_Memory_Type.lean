-- Generated from a local ISA specification; do not edit.
-- Source SHA256: c5a532f2f7c802c4fc9ba1e5802e5e776f4de8ffdc43d7b44610ba6e3ab9e662
import X86.Runtime
import X86.Config
import X86.Cpuid
import X86.Helpers.Emulate_Get_Memory_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Std.External_Failure
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Get_Cache_Disabled_Memory_Type.Binding (σ : Type) where
  call (inputs : Memory_Type_Inputs) (address : Bits 64) (pat_pcd_pwt : Bits 3) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Memory_Type)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Get_Cache_Disabled_Memory_Type.Binding

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Get_Cache_Disabled_Memory_Type.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.__Implements_Processor_Type.Binding]
  [X86.Config.Value.Max_Physical_Address]

-- The generated selector delegates only unresolved cache-disabled queries.
def Get_Cache_Disabled_Memory_Type
    (inputs : Memory_Type_Inputs) (address : Bits 64) (pat_pcd_pwt : Bits 3) :
    Runtime.SpecM Empty (State σ) (Memory_Type) := do
  liftM (Get_Cache_Disabled_Memory_Type.Binding.call inputs address pat_pcd_pwt (← get))

def Resolve_Memory_Type
    (inputs : Memory_Type_Inputs) (address : Bits 64) (pat_pcd_pwt : Bits 3) :
    Runtime.SpecM Empty (State σ) (Memory_Type) := do
  let selection : Memory_Type_Selection ← Emulate_Get_Memory_Type inputs address pat_pcd_pwt
  if selection.Requires_Binding then
    let result : Memory_Type ← Get_Cache_Disabled_Memory_Type inputs address pat_pcd_pwt
    Runtime.assert (result != Memory_Type.Memory_Type_Unknown)
    return (← Emulate_Memory.Supported_Type inputs.IA32_MTRRCAP result)
  return selection.Known_Type

-- A derived view; the registers remain in State and CPUID has one external owner.
def Emulate_Memory.Read_Type_Inputs  : Runtime.SpecM Empty (State σ) (Memory_Type_Inputs) := do
  let is_atom : Bool ← __Implements_Processor_Type __Processor_Type.Atom
  let cap : Bits 64 ← IA32_MTRRCAP
  let physical_address_bits : Int ← Config.Read.Max_Physical_Address (exception := Empty)
  let mut eax : Bits 32 := 0
  let mut ebx : Bits 32 := 0
  let mut ecx : Bits 32 := 0
  let mut edx : Bits 32 := 0
  if (← CPUID_Leaf_Available 1 0) then
    let (reported_eax, reported_ebx, reported_ecx, reported_edx) ← Get_CPUID_Value 1 0
    eax := reported_eax
    ebx := reported_ebx
    ecx := reported_ecx
    edx := reported_edx
  return ({
    IA32_MTRRCAP := cap,
    IA32_MTRR_DEF_TYPE := (← get).IA32_MTRR_DEF_TYPE,
    IA32_PAT := (← get).IA32_PAT,
    MTRR_Fixed := (← get).MTRR_Fixed,
    MTRR_Base := (← get).MTRR_Base,
    MTRR_Mask := (← get).MTRR_Mask,
    Memory_Physical_Address_Bits := physical_address_bits,
    CR0 := (← get).CR0,
    Processor_Is_Atom := is_atom,
    CPUID_MTRR := (← Decode_CPUID_Feature CPUID_MTRR_Encoding eax ebx ecx edx),
    CPUID_PAT := (← Decode_CPUID_Feature CPUID_PAT_Encoding eax ebx ecx edx),
    IA32_SMRR_PHYSBASE := (← get).IA32_SMRR_PHYSBASE,
    IA32_SMRR_PHYSMASK := (← get).IA32_SMRR_PHYSMASK,
    In_SMM := (← get).«SMM::In_SMM»
  } : Memory_Type_Inputs)

def Get_Memory_Type
    (address : Bits 64) (pat_pcd_pwt : Bits 3) :
    Runtime.SpecM Empty (State σ) (Memory_Type) := do
  let current : Memory_Type_Inputs ← Emulate_Memory.Read_Type_Inputs
  if (not current.CPUID_MTRR or not current.CPUID_PAT) then
    Std.External_Failure "unsupported memory-type profile: CPUID.MTRR and CPUID.PAT are required"
  return (← Resolve_Memory_Type current address pat_pcd_pwt)

end X86.Helpers

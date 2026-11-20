-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 2a37e62120dd64e0300c1737e5e8c5e31e742dc4f91a2edf0cc82f26b5abee39
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Data_Read_Breakpoint
import X86.Helpers.Check_Read_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class Select_Compare_Memory_Order.Binding (σ : Type) where
  call (operand_size : Int) (source_segment : Segment) (source : Bits 64) (destination_segment : Segment) (destination : Bits 64) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_Compare_Memory_Order.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_Compare_Memory_Probe.Binding (σ : Type) where
  call (operand_size : Int) (first_fault : Exception_Info) (second_segment : Segment) (second : Bits 64) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_Compare_Memory_Probe.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_Compare_Memory_Fault.Binding (σ : Type) where
  call (first_fault second_fault : Exception_Info) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_Compare_Memory_Fault.Binding

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Fault.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Order.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Probe.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- SDM093 Vol. 3A 11.2.3.1 permits constituent access order choices in WB memory.
-- Vol. 3B 25.25.2 permits priority choices between real execution faults.
-- Reverse-order environments must establish the concrete WB read domain.
def Select_Compare_Memory_Order
    (operand_size : Int) (source_segment : Segment) (source : Bits 64) (destination_segment : Segment) (destination : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.liftNoSourceException (liftM (Select_Compare_Memory_Order.Binding.call operand_size source_segment source destination_segment destination (← get)))

def Select_Compare_Memory_Probe
    (operand_size : Int) (first_fault : Exception_Info) (second_segment : Segment) (second : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.assert ((first_fault).vector in {0..255})
  Runtime.liftNoSourceException (liftM (Select_Compare_Memory_Probe.Binding.call operand_size first_fault second_segment second (← get)))

def Select_Compare_Memory_Fault
    (first_fault second_fault : Exception_Info) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert ((first_fault).vector in {0..255})
  Runtime.assert ((second_fault).vector in {0..255})
  Runtime.liftNoSourceException (liftM (Select_Compare_Memory_Fault.Binding.call first_fault second_fault (← get)))

def Emulate_Compare_Memory_Check
    (operand_size : Int) (segment : Segment) (offset : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  Check_Read_Permission segment
  let logical : Address_Translation ← Create_Logical_Address segment offset operand_size
  let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Normal_Alignment (← get).CS false
  Check_Data_Read_Breakpoint linear.linear_address (← Std.Integer.Positive_Divide operand_size 8)
  let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Read

-- Only checks of the other required operand run after a fault; no data is fetched.
def Emulate_Compare_Memory_Competing_Fault
    (operand_size : Int) (first_fault : Exception_Info) (second_segment : Segment) (second : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  if (not ((first_fault.vector == PF_Exception) || (first_fault.vector == AC_Exception) || (first_fault.vector == GP_Exception) || (first_fault.vector == SS_Exception))) then
    throw (.raised (↑first_fault : Exception))
  if (not (← Select_Compare_Memory_Probe operand_size first_fault second_segment second)) then
    throw (.raised (↑first_fault : Exception))
  try
    Emulate_Compare_Memory_Check operand_size second_segment second
  catch exception =>
    match exception with
    | .raised (.Exception_Info second_fault) =>
      if (← (do if (← (do let subject := second_fault.vector; pure ((subject == PF_Exception) || (subject == AC_Exception) || (subject == GP_Exception) || (subject == SS_Exception)))) then pure (← Select_Compare_Memory_Fault first_fault second_fault) else pure false)) then
        throw (.raised (↑second_fault : Exception))
      throw (.raised (↑first_fault : Exception))
    | _ => throw exception
  throw (.raised (↑first_fault : Exception))

def Emulate_Compare_Memory_Read
    (operand_size : Int) (first_segment : Segment) (first : Bits 64) (second_segment : Segment) (second : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let result : Bits operand_size ← do
    try
      let result : Bits operand_size ← Logical_Mem_Read first_segment first operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      pure result
    catch exception =>
      match exception with
      | .raised (.Exception_Info first_fault) =>
        Emulate_Compare_Memory_Competing_Fault operand_size first_fault second_segment second
        throw (.raised (↑first_fault : Exception))
      | _ => throw exception
  return result

-- True selects the destination first; returned operands retain comparison roles.
def Emulate_Compare_Memory_Transfer
    (operand_size : Int) (source_segment : Segment) (source : Bits 64) (destination_segment : Segment) (destination : Bits 64) (reverse : Bool) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  if reverse then
    let right : Bits operand_size ← Emulate_Compare_Memory_Read operand_size destination_segment destination source_segment source
    let left : Bits operand_size ← Logical_Mem_Read source_segment source operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    return (left, right)
  let left : Bits operand_size ← Emulate_Compare_Memory_Read operand_size source_segment source destination_segment destination
  let right : Bits operand_size ← Logical_Mem_Read destination_segment destination operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  return (left, right)

def Emulate_Compare_Memory_Operands
    (operand_size : Int) (source_segment : Segment) (source : Bits 64) (destination_segment : Segment) (destination : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let reverse : Bool ← Select_Compare_Memory_Order operand_size source_segment source destination_segment destination
  return (← Emulate_Compare_Memory_Transfer operand_size source_segment source destination_segment destination reverse)

end X86.Helpers

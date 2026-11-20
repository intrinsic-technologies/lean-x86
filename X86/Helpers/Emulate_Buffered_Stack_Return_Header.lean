-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 857d4dac6ef7ee715c09ff6f2d456b31ba66543ee920cac09be81173b897ae17
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Calculate_And_Check_Descriptor_Linear_Address
import X86.Helpers.Check_Segment_Limit
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Canonical_Wrt_Position
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Pop_Stack
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

inductive Buffered_Stack_Return_Group where
  | IRET_Header
  | IRET_Stack
  deriving Repr, DecidableEq, Inhabited

inductive Stack_Return_Read_Role where
  | Return_RIP
  | Return_CS
  | Return_Flags
  | Return_RSP
  | Return_SS
  deriving Repr, DecidableEq, Inhabited

structure Stack_Return_Read_Request where
  role : Stack_Return_Read_Role
  read_size : Int
  stack_offset : Bits 64
  deriving Repr, DecidableEq, Inhabited

inductive Stack_Return_Validation_Reason where
  | Return_CS_Validation
  | Return_Target_Validation
  | Return_Stack_Validation
  deriving Repr, DecidableEq, Inhabited

-- The caller supplies a binding for this source declaration, which has no body.
class Select_Buffered_Stack_Return_Swap.Binding (σ : Type) where
  call (group : Buffered_Stack_Return_Group) (operand_size : Int) (first second : Stack_Return_Read_Request) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_Buffered_Stack_Return_Swap.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_Stack_Return_Validation_Fault.Binding (σ : Type) where
  call (group : Buffered_Stack_Return_Group) (reason : Stack_Return_Validation_Reason) (known_value : Bits 64) (read_fault validation_fault : Exception_Info) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_Stack_Return_Validation_Fault.Binding

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Select_Buffered_Stack_Return_Swap.Binding σ]
  [X86.Helpers.Select_Stack_Return_Validation_Fault.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Select_Buffered_Stack_Return_Swap
    (group : Buffered_Stack_Return_Group) (operand_size : Int) (first second : Stack_Return_Read_Request) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.assert ((first).read_size == 16 || (first).read_size == 32 || (first).read_size == 64)
  Runtime.assert ((second).read_size == 16 || (second).read_size == 32 || (second).read_size == 64)
  Runtime.liftNoSourceException (liftM (Select_Buffered_Stack_Return_Swap.Binding.call group operand_size first second (← get)))

def Select_Stack_Return_Validation_Fault
    (group : Buffered_Stack_Return_Group) (reason : Stack_Return_Validation_Reason) (known_value : Bits 64) (read_fault validation_fault : Exception_Info) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert ((read_fault).vector in {0..255})
  Runtime.assert ((validation_fault).vector in {0..255})
  Runtime.liftNoSourceException (liftM (Select_Stack_Return_Validation_Fault.Binding.call group reason known_value read_fault validation_fault (← get)))

def Emulate_Stack_Return_Order_Eligible
    (stack_segment : Segment) (old_rsp : Bits 64) (operand_size : Int) (slots : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (slots == 2 || slots == 3)

  if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← (do if (← Is_64Bit_Code_Segment (← get).CS) then pure (← Runtime.readInitialized stack_segment.is_stack) else pure false)) then pure ((← get).VMX_Operation_Mode == VMX_Operation_Type.Outside_VMX_Operation) else pure false)) then pure ((← CR0.PG) == 1) else pure false)) then pure ((← CR0.PE) == 1) else pure false)) then pure ((← CR4.PAE) == 1) else pure false)) then pure ((← get).IA32_EFER.LME == 1) else pure false)) then pure ((← CR4.LA57) == 0) else pure false)) then pure ((← CR0.CD) == 0) else pure false)) then pure ((← CR0.NW) == 0) else pure false)) then pure ((← CR4.CET) == 0) else pure false)) then pure ((← CR4.FRED) == 0) else pure false)) then pure (not (← CPUID_LAM)) else pure false)) then pure (not (← CPUID_LASS) or (← CR4.LASS) == 0) else pure false)) then
    let after_group : Bits 64 ← Std.Bits.Add_int (n := 64) old_rsp (← (do if slots == 3 then pure ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8)) else pure ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8))))
    let last_byte : Bits 64 ← Std.Bits.Subtract_int (n := 64) after_group 1
    return (← (do if (← (do if decide (Unsigned after_group ≥ Unsigned old_rsp) then pure (← Is_Canonical_Wrt_Position old_rsp 48) else pure false)) then pure (← Is_Canonical_Wrt_Position last_byte 48) else pure false))
  return false

def Emulate_Stack_Return_CS_Check
    (group : Buffered_Stack_Return_Group) (selector : Segment_Selector) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (group == Buffered_Stack_Return_Group.IRET_Header)
  if (← Is_Null_Segment_Selector selector) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  if (decide (Unsigned (Segment_Selector.RPL selector) < (← get).CPL)) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector selector))

def Emulate_Stack_Return_Validation_Fault
    (group : Buffered_Stack_Return_Group) (known_cs : Segment_Selector) (read_fault : Exception_Info) (stack_segment : Segment) (group_rsp : Bits 64) (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  if (read_fault.vector != PF_Exception) then
    throw (.raised (↑read_fault : Exception))
  if (not (← Emulate_Stack_Return_Order_Eligible stack_segment group_rsp operand_size 3)) then
    throw (.raised (↑read_fault : Exception))
  try
    Emulate_Stack_Return_CS_Check group known_cs
    let _ ← Calculate_And_Check_Descriptor_Linear_Address known_cs false false
  catch exception =>
    match exception with
    | .raised (.Exception_Info validation_fault) =>
      if (validation_fault.vector != GP_Exception) then
        throw (.raised (↑validation_fault : Exception))
      if (← Select_Stack_Return_Validation_Fault group Stack_Return_Validation_Reason.Return_CS_Validation (← Std.Bits.Zero_Extend (source_size := 16) known_cs 64) read_fault validation_fault) then
        throw (.raised (↑validation_fault : Exception))
      throw (.raised (↑read_fault : Exception))
    | _ => throw exception
  throw (.raised (↑read_fault : Exception))

def Emulate_Stack_Return_Read_After_CS
    (group : Buffered_Stack_Return_Group) (known_cs : Segment_Selector) (stack_segment : Segment) (old_rsp : Bits 64) (size pop_size : Int) (group_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits size × Bits 64) := do
  Runtime.assert (size == 16 || size == 32 || size == 64)
  Runtime.assert (pop_size == 16 || pop_size == 32 || pop_size == 64)

  let result : (Bits size × Bits 64) ← do
    try
      let result : (Bits size × Bits 64) ← Pop_Stack stack_segment old_rsp size pop_size
      pure result
    catch exception =>
      match exception with
      | .raised (.Exception_Info read_fault) =>
        Emulate_Stack_Return_Validation_Fault group known_cs read_fault stack_segment group_rsp pop_size
        throw (.raised (↑read_fault : Exception))
      | _ => throw exception
  return result

-- SDM093 Vol. 3A 11.2.3.1 permits constituent order choices within each group.
def Emulate_Buffered_Stack_Return_Pair_Plan
    (group : Buffered_Stack_Return_Group) (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.assert (group == Buffered_Stack_Return_Group.IRET_Stack)
  let mut reverse : Bool := false
  if (← Emulate_Stack_Return_Order_Eligible stack_segment old_rsp operand_size 2) then
    let wide : Stack_Return_Read_Request := ({
      role := Stack_Return_Read_Role.Return_RSP,
      read_size := operand_size,
      stack_offset := old_rsp
    } : Stack_Return_Read_Request)
    let word : Stack_Return_Read_Request := ({
      role := Stack_Return_Read_Role.Return_SS,
      read_size := 16,
      stack_offset := (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8))
    } : Stack_Return_Read_Request)
    reverse := (← Select_Buffered_Stack_Return_Swap group operand_size wide word)
  return reverse

def Emulate_Buffered_Stack_Return_Header_Plan
    (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool × Stack_Return_Read_Request × Stack_Return_Read_Request × Stack_Return_Read_Request) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mut first : Stack_Return_Read_Request := ({
    role := Stack_Return_Read_Role.Return_RIP,
    read_size := operand_size,
    stack_offset := old_rsp
  } : Stack_Return_Read_Request)
  let mut second : Stack_Return_Read_Request := ({
    role := Stack_Return_Read_Role.Return_CS,
    read_size := 16,
    stack_offset := (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8))
  } : Stack_Return_Read_Request)
  let mut third : Stack_Return_Read_Request := ({
    role := Stack_Return_Read_Role.Return_Flags,
    read_size := operand_size,
    stack_offset := (← Std.Bits.Add_int (n := 64) old_rsp ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8)))
  } : Stack_Return_Read_Request)
  if (← Emulate_Stack_Return_Order_Eligible stack_segment old_rsp operand_size 3) then
    if (← Select_Buffered_Stack_Return_Swap Buffered_Stack_Return_Group.IRET_Header operand_size first second) then
      let temporary : Stack_Return_Read_Request := first
      first := second
      second := temporary
    if (← Select_Buffered_Stack_Return_Swap Buffered_Stack_Return_Group.IRET_Header operand_size second third) then
      let temporary : Stack_Return_Read_Request := second
      second := third
      third := temporary
    if (← Select_Buffered_Stack_Return_Swap Buffered_Stack_Return_Group.IRET_Header operand_size first second) then
      let temporary : Stack_Return_Read_Request := first
      first := second
      second := temporary
  let changed : Bool := first.role != Stack_Return_Read_Role.Return_RIP or second.role != Stack_Return_Read_Role.Return_CS or third.role != Stack_Return_Read_Role.Return_Flags
  return (changed, first, second, third)

def Emulate_Buffered_Stack_Return_Header_Transfer
    (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) (first second third : Stack_Return_Read_Request) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 16 × Bits operand_size × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  if (first.role == Stack_Return_Read_Role.Return_RIP and second.role == Stack_Return_Read_Role.Return_CS and third.role == Stack_Return_Read_Role.Return_Flags) then
    let (ip, after_ip) ← Pop_Stack stack_segment old_rsp operand_size operand_size
    let (selector, after_cs) ← Pop_Stack stack_segment after_ip 16 operand_size
    let (flags_part, after_group) ← Emulate_Stack_Return_Read_After_CS Buffered_Stack_Return_Group.IRET_Header selector stack_segment after_cs operand_size operand_size old_rsp
    return (ip, selector, flags_part, after_group)
  if (first.role == Stack_Return_Read_Role.Return_RIP and second.role == Stack_Return_Read_Role.Return_Flags and third.role == Stack_Return_Read_Role.Return_CS) then
    let (ip, _) ← Pop_Stack stack_segment old_rsp operand_size operand_size
    let (flags_part, after_group) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8))) operand_size operand_size
    let (selector, _) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
    return (ip, selector, flags_part, after_group)
  if (first.role == Stack_Return_Read_Role.Return_CS and second.role == Stack_Return_Read_Role.Return_RIP and third.role == Stack_Return_Read_Role.Return_Flags) then
    let (selector, _) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
    let (ip, _) ← Emulate_Stack_Return_Read_After_CS Buffered_Stack_Return_Group.IRET_Header selector stack_segment old_rsp operand_size operand_size old_rsp
    let (flags_part, after_group) ← Emulate_Stack_Return_Read_After_CS Buffered_Stack_Return_Group.IRET_Header selector stack_segment (← Std.Bits.Add_int (n := 64) old_rsp ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8))) operand_size operand_size old_rsp
    return (ip, selector, flags_part, after_group)
  if (first.role == Stack_Return_Read_Role.Return_CS and second.role == Stack_Return_Read_Role.Return_Flags and third.role == Stack_Return_Read_Role.Return_RIP) then
    let (selector, _) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
    let (flags_part, after_group) ← Emulate_Stack_Return_Read_After_CS Buffered_Stack_Return_Group.IRET_Header selector stack_segment (← Std.Bits.Add_int (n := 64) old_rsp ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8))) operand_size operand_size old_rsp
    let (ip, _) ← Emulate_Stack_Return_Read_After_CS Buffered_Stack_Return_Group.IRET_Header selector stack_segment old_rsp operand_size operand_size old_rsp
    return (ip, selector, flags_part, after_group)
  if (first.role == Stack_Return_Read_Role.Return_Flags and second.role == Stack_Return_Read_Role.Return_RIP and third.role == Stack_Return_Read_Role.Return_CS) then
    let (flags_part, after_group) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8))) operand_size operand_size
    let (ip, _) ← Pop_Stack stack_segment old_rsp operand_size operand_size
    let (selector, _) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
    return (ip, selector, flags_part, after_group)
  if (first.role == Stack_Return_Read_Role.Return_Flags and second.role == Stack_Return_Read_Role.Return_CS and third.role == Stack_Return_Read_Role.Return_RIP) then
    let (flags_part, after_group) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp ((← Std.Integer.Positive_Divide operand_size 8) + (← Std.Integer.Positive_Divide operand_size 8))) operand_size operand_size
    let (selector, _) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
    let (ip, _) ← Emulate_Stack_Return_Read_After_CS Buffered_Stack_Return_Group.IRET_Header selector stack_segment old_rsp operand_size operand_size old_rsp
    return (ip, selector, flags_part, after_group)
  Runtime.assert false
  return ((← Std.Bits.Zero operand_size), (← Std.Bits.Zero 16), (← Std.Bits.Zero operand_size), old_rsp)

def Emulate_Buffered_Stack_Return_Header
    (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 16 × Bits operand_size × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let (_, first, second, third) ← Emulate_Buffered_Stack_Return_Header_Plan operand_size stack_segment old_rsp
  return (← Emulate_Buffered_Stack_Return_Header_Transfer operand_size stack_segment old_rsp first second third)

def Emulate_Stack_Selector_Null_Check (selector : Segment_Selector) (cpl : Int) : Result Unit := do
  Runtime.assert (cpl in {0..3})

  if (Unsigned (Segment_Selector.RPL selector) == 3 or Unsigned (Segment_Selector.RPL selector) != cpl) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

def Emulate_Stack_Selector_RPL_Check (selector : Segment_Selector) (cpl : Int) : Result Unit := do
  Runtime.assert (cpl in {0..3})

  if (Unsigned (Segment_Selector.RPL selector) != cpl) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector selector))

def Emulate_Stack_Return_SS_Fault
    (group : Buffered_Stack_Return_Group) (stack_segment : Segment) (old_rsp : Bits 64) (operand_size : Int) (new_cs : Segment) (known_ss : Segment_Selector) (read_fault : Exception_Info) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  if (read_fault.vector != PF_Exception) then
    throw (.raised (↑read_fault : Exception))
  if (← (do if not (← Emulate_Stack_Return_Order_Eligible stack_segment old_rsp operand_size 2) then pure true else pure (not (← Is_64Bit_Code_Segment new_cs)))) then
    throw (.raised (↑read_fault : Exception))
  try
    let new_cpl : Int := Unsigned (Segment_Selector.RPL new_cs.selector)
    if (← Is_Null_Segment_Selector known_ss) then
      Emulate_Stack_Selector_Null_Check known_ss new_cpl
    else
      let _ ← Calculate_And_Check_Descriptor_Linear_Address known_ss false false
      Emulate_Stack_Selector_RPL_Check known_ss new_cpl
  catch exception =>
    match exception with
    | .raised (.Exception_Info validation_fault) =>
      if (validation_fault.vector != GP_Exception) then
        throw (.raised (↑validation_fault : Exception))
      if (← Select_Stack_Return_Validation_Fault group Stack_Return_Validation_Reason.Return_Stack_Validation (← Std.Bits.Zero_Extend (source_size := 16) known_ss 64) read_fault validation_fault) then
        throw (.raised (↑validation_fault : Exception))
      throw (.raised (↑read_fault : Exception))
    | _ => throw exception
  throw (.raised (↑read_fault : Exception))

def Emulate_Stack_Return_Read_After_SS
    (group : Buffered_Stack_Return_Group) (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) (new_cs : Segment) (known_ss : Segment_Selector) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let result : (Bits operand_size × Bits 64) ← do
    try
      let result : (Bits operand_size × Bits 64) ← Pop_Stack stack_segment old_rsp operand_size operand_size
      pure result
    catch exception =>
      match exception with
      | .raised (.Exception_Info read_fault) =>
        Emulate_Stack_Return_SS_Fault group stack_segment old_rsp operand_size new_cs known_ss read_fault
        throw (.raised (↑read_fault : Exception))
      | _ => throw exception
  return result

def Emulate_Buffered_Stack_Return_Tail_Read
    (group : Buffered_Stack_Return_Group) (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) (reverse : Bool) (new_cs : Segment) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 16 × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.assert (group == Buffered_Stack_Return_Group.IRET_Stack)
  if reverse then
    let (word, after_group) ← Pop_Stack stack_segment (← Std.Bits.Add_int (n := 64) old_rsp (← Std.Integer.Positive_Divide operand_size 8)) 16 operand_size
    let (wide, _) ← Emulate_Stack_Return_Read_After_SS group operand_size stack_segment old_rsp new_cs word
    return (wide, word, after_group)
  let (wide, after_wide) ← Pop_Stack stack_segment old_rsp operand_size operand_size
  let (word, after_group) ← Pop_Stack stack_segment after_wide 16 operand_size
  return (wide, word, after_group)

def Emulate_Iret_Target_Check
    (new_cs : Segment) (new_rip : Bits 64) (new_64bit : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  if new_64bit then
    if (not (← Is_Canonical_Wrt_Position new_rip (if (← CR4.LA57) == 1 then 57 else 48))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  else
    Check_Segment_Limit new_cs new_rip 1

def Emulate_Stack_Return_Target_Fault
    (group : Buffered_Stack_Return_Group) (stack_segment : Segment) (old_rsp : Bits 64) (operand_size : Int) (new_cs : Segment) (new_rip : Bits 64) (read_fault : Exception_Info) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  if (read_fault.vector != PF_Exception) then
    throw (.raised (↑read_fault : Exception))
  if (← (do if not (← Emulate_Stack_Return_Order_Eligible stack_segment old_rsp operand_size 2) then pure true else pure (not (← Is_64Bit_Code_Segment new_cs)))) then
    throw (.raised (↑read_fault : Exception))
  try
    Emulate_Iret_Target_Check new_cs new_rip true
  catch exception =>
    match exception with
    | .raised (.Exception_Info validation_fault) =>
      if (validation_fault.vector != GP_Exception) then
        throw (.raised (↑validation_fault : Exception))
      if (← Select_Stack_Return_Validation_Fault group Stack_Return_Validation_Reason.Return_Target_Validation new_rip read_fault validation_fault) then
        throw (.raised (↑validation_fault : Exception))
      throw (.raised (↑read_fault : Exception))
    | _ => throw exception
  throw (.raised (↑read_fault : Exception))

def Emulate_Buffered_Stack_Return_Target_Transfer
    (group : Buffered_Stack_Return_Group) (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) (reverse : Bool) (new_cs : Segment) (new_rip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 16 × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.assert (group == Buffered_Stack_Return_Group.IRET_Stack)
  let result : (Bits operand_size × Bits 16 × Bits 64) ← do
    try
      let result : (Bits operand_size × Bits 16 × Bits 64) ← Emulate_Buffered_Stack_Return_Tail_Read group operand_size stack_segment old_rsp reverse new_cs
      pure result
    catch exception =>
      match exception with
      | .raised (.Exception_Info read_fault) =>
        Emulate_Stack_Return_Target_Fault group stack_segment old_rsp operand_size new_cs new_rip read_fault
        throw (.raised (↑read_fault : Exception))
      | _ => throw exception
  return result

def Emulate_Buffered_Stack_Return_Target_Pair
    (group : Buffered_Stack_Return_Group) (operand_size : Int) (stack_segment : Segment) (old_rsp : Bits 64) (new_cs : Segment) (new_rip : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 16 × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Runtime.assert (group == Buffered_Stack_Return_Group.IRET_Stack)
  let reverse : Bool ← Emulate_Buffered_Stack_Return_Pair_Plan group operand_size stack_segment old_rsp
  return (← Emulate_Buffered_Stack_Return_Target_Transfer group operand_size stack_segment old_rsp reverse new_cs new_rip)

end X86.Helpers

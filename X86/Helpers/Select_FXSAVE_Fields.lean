-- Generated from a local ISA specification; do not edit.
-- Source SHA256: ec154ecfccba193e2ee4fcfbe6768c3dd1e7c9483bc944f41ec3206bb2ba3368
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Address_Translation
import X86.Helpers.Calculate_Offset
import X86.Helpers.Check_LASS_Violation
import X86.Helpers.Check_Write_Permission
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Calculate_Abridged_Tag_Word
import X86.Helpers.FP87_Status_Type
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Aligned
import X86.Helpers.Is_Alignment_Checking_Enabled
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Is_Linear_Access_Split_Across4KB_Pages
import X86.Helpers.Is_System_Segment
import X86.Helpers.Is_Task_Segment
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_Alignment_Check_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.Helpers.Translate_Linear_To_Physical
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure FXSAVE_Write_Request where
  role : Int
  offset : Bits 64
  write_size : Int
  deriving Repr, DecidableEq, Inhabited

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_Fields.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bits 2)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_Fields.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_AC.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_AC.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_Page_Fault_Priority.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) (fault_vector : Int) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_Page_Fault_Priority.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_Reserved_Header.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bits 48)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_Reserved_Header.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_Reserved_Slot.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) (slot : Bits 3) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bits 49)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_Reserved_Slot.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_Schedule_Domain.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_Schedule_Domain.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Select_FXSAVE_Write_Swap.Binding (σ : Type) where
  call (wide : Bool) (linear_address : Bits 64) (first second : FXSAVE_Write_Request) :
    ReaderT (State σ) (Except (Runtime.Error Empty)) (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Select_FXSAVE_Write_Swap.Binding

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Select_FXSAVE_AC.Binding σ]
  [X86.Helpers.Select_FXSAVE_Fields.Binding σ]
  [X86.Helpers.Select_FXSAVE_Page_Fault_Priority.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Header.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Slot.Binding σ]
  [X86.Helpers.Select_FXSAVE_Schedule_Domain.Binding σ]
  [X86.Helpers.Select_FXSAVE_Write_Swap.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Select_FXSAVE_Fields
    (wide : Bool) (linear_address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 2) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_Fields.Binding.call wide linear_address (← get)))

def Select_FXSAVE_AC
    (wide : Bool) (linear_address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_AC.Binding.call wide linear_address (← get)))

def Select_FXSAVE_Page_Fault_Priority
    (wide : Bool) (linear_address : Bits 64) (fault_vector : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_Page_Fault_Priority.Binding.call wide linear_address fault_vector (← get)))

def Select_FXSAVE_Reserved_Header
    (wide : Bool) (linear_address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 48) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_Reserved_Header.Binding.call wide linear_address (← get)))

def Select_FXSAVE_Reserved_Slot
    (wide : Bool) (linear_address : Bits 64) (slot : Bits 3) :
    Runtime.SpecM Exception (State σ) (Bits 49) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_Reserved_Slot.Binding.call wide linear_address slot (← get)))

def Select_FXSAVE_Schedule_Domain
    (wide : Bool) (linear_address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_Schedule_Domain.Binding.call wide linear_address (← get)))

def Select_FXSAVE_Write_Swap
    (wide : Bool) (linear_address : Bits 64) (first second : FXSAVE_Write_Request) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.liftNoSourceException (liftM (Select_FXSAVE_Write_Swap.Binding.call wide linear_address first second (← get)))

-- Canonicality and LASS checks produce real faults; only paging priority is selectable.
def Emulate_FXSAVE_Linear_Address
    (logical : Address_Translation) :
    Runtime.SpecM Exception (State σ) (Address_Translation × Int) := do
  let segment : Segment := logical.segment
  let mut linear : Address_Translation := logical
  linear := { linear with linear_address := (← Compute_Linear_Address segment logical.offset (← get).CS) }
  linear := { linear with is_implicit_supervisor_mode_access := (← Is_System_Segment segment) }
  let canonical : Bool ← Is_Canonical_Wrt_Paging_Mode linear.linear_address (linear.num_bytes * 8) false
  let mut pending : Int := 0
  if (not canonical) then
    if (← Runtime.readInitialized segment.is_stack) then
      pending := SS_Exception
    else
      if (← Is_Task_Segment segment) then
        liftM (Report_Invalid_TSS (← Std.Bits.Zero 32))
      else
        pending := GP_Exception
  if canonical then
    try
      Check_LASS_Violation linear
    catch exception =>
      match exception with
      | .raised (.Exception_Info e) =>
        if ((e.vector == GP_Exception or e.vector == SS_Exception) and e.error_code == (← Std.Bits.Zero 32)) then
          pending := e.vector
        else
          throw (.raised (↑e : Exception))
      | _ => throw exception
  return (linear, pending)

-- Never page-walk a noncanonical or LASS-violating range; other fragments keep real walks.
def Emulate_FXSAVE_Canonical_Paging_Check
    (linear : Address_Translation) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (← Is_Canonical_Wrt_Paging_Mode linear.linear_address (linear.num_bytes * 8) false) then
    let mut permitted : Bool := true
    try
      Check_LASS_Violation linear
    catch exception =>
      match exception with
      | .raised (.Exception_Info e) =>
        if ((e.vector == GP_Exception or e.vector == SS_Exception) and e.error_code == (← Std.Bits.Zero 32)) then
          permitted := false
        else
          throw (.raised (↑e : Exception))
      | _ => throw exception
    if permitted then
      let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Write
  else
    if (← Is_Linear_Access_Split_Across4KB_Pages linear.linear_address linear.num_bytes) then
      let size1 : Int := 4096 - (← Std.Integer.Positive_Remainder (Unsigned linear.linear_address) 4096)
      let size2 : Int := linear.num_bytes - size1
      let first : Address_Translation := { linear with num_bytes := size1 }
      let second : Address_Translation := { { linear with linear_address := (← Std.Bits.Add_int (n := 64) linear.linear_address size1) } with num_bytes := size2 }
      if (← Is_Canonical_Wrt_Paging_Mode first.linear_address (first.num_bytes * 8) false) then
        let _ ← Translate_Linear_To_Physical.interpreted first Memory_Access_Type.Memory_Write
      if (← Is_Canonical_Wrt_Paging_Mode second.linear_address (second.num_bytes * 8) false) then
        let _ ← Translate_Linear_To_Physical.interpreted second Memory_Access_Type.Memory_Write

-- Keep the existing first-16-byte and byte-415 checks; the SDM's 512-byte area
-- description does not establish arbitrary freedom to change this footprint.
def Emulate_FXSAVE_Initial_Addresses
    (wide : Bool) (segment : Segment) (offset : Bits 64) (address_size : Int) :
    Runtime.SpecM Exception (State σ) (Address_Translation × Address_Translation) := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  Check_Write_Permission segment
  let (first, first_fault) ← Emulate_FXSAVE_Linear_Address (← Create_Logical_Address segment offset 128)
  Check_Write_Permission segment
  let (last, last_fault) ← Emulate_FXSAVE_Linear_Address (← Create_Logical_Address segment (← Calculate_Offset offset 415 address_size) 8)
  let misaligned : Bool := not (← Is_Aligned (n := 64) first.linear_address 16)
  let mut ac_pending : Bool := false
  if (misaligned and (← Is_Alignment_Checking_Enabled) and (← get).CPL == 3 and not first.is_implicit_supervisor_mode_access and first_fault == 0 and last_fault == 0) then
    ac_pending := (← Select_FXSAVE_AC wide first.linear_address)
  let pending : Int := if misaligned and not ac_pending then GP_Exception else if first_fault != 0 then first_fault else if last_fault != 0 then last_fault else 0
  if (pending != 0) then
    if (← Select_FXSAVE_Page_Fault_Priority wide first.linear_address pending) then
      Emulate_FXSAVE_Canonical_Paging_Check first
      Emulate_FXSAVE_Canonical_Paging_Check last
    if (pending == SS_Exception) then
      liftM (Report_Stack_Fault (← Std.Bits.Zero 32))
    else
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  if ac_pending then
    Emulate_FXSAVE_Canonical_Paging_Check first
    Emulate_FXSAVE_Canonical_Paging_Check last
    liftM (Report_Alignment_Check_Exception (← Std.Bits.Zero 32))
  return (first, last)

-- The finite roles retain two required checks and every mandatory field exactly once.
def Emulate_FXSAVE_Write_Request
    (index : Int) (wide : Bool) (offset : Bits 64) (address_size : Int) (reserved : Bits 48) (padding : Bits 392) :
    Except (Runtime.Error Empty) (FXSAVE_Write_Request) := do
  Runtime.assert (index in {0..35})
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let request_role : Int := index
  let mut displacement : Int := 0
  let mut size : Int := 16
  if (index == 0) then
    size := 128
  else
    if (index == 1) then
      displacement := 415
      size := 8
    else
      if (index == 2) then
        displacement := 0
      else
        if (index == 3) then
          displacement := 2
        else
          if (index == 4) then
            displacement := 4
            size := if (← reserved[47 +: 1]) == 1 then 16 else 8
          else
            if (index == 5) then
              displacement := 6
            else
              if (index == 6) then
                displacement := 8
                size := if wide then 64 else 32
              else
                if (index == 7) then
                  displacement := 16
                  size := if wide then 64 else 32
                else
                  if (index == 8) then
                    displacement := 12
                    size := if (← reserved[46 +: 1]) == 1 then 32 else 16
                  else
                    if (index == 9) then
                      displacement := 20
                      size := if (← reserved[45 +: 1]) == 1 then 32 else 16
                    else
                      if (decide (index ≤ 17)) then
                        let i : Int := index - 10
                        displacement := 32 + 16 * i
                        size := if (← padding[i * 49 + 48 +: 1]) == 1 then 128 else 80
                      else
                        if (index == 18) then
                          displacement := 28
                          size := 32
                        else
                          if (index == 19) then
                            displacement := 24
                            size := 32
                          else
                            displacement := 160 + 16 * (index - 20)
                            size := 128
  let request_offset : Bits 64 ← Calculate_Offset offset displacement address_size
  let request_write_size : Int := size
  return ({
    role := request_role,
    offset := request_offset,
    write_size := request_write_size
  } : FXSAVE_Write_Request)

def Emulate_FXSAVE_Write_Enabled
    (index : Int) (wide : Bool) (fields : Bits 2) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (index in {0..35})

  if (index == 8 or index == 9) then
    return not wide
  else
    if (index == 19) then
      return (← fields[0 +: 1]) == 1
    else
      if (decide (index ≥ 20)) then
        return (← fields[1 +: 1]) == 1
      else
        return true

def Emulate_FXSAVE_Source_Order  : Except (Runtime.Error Empty) (Bits 216) := do
  let mut order : Bits 216 ← Std.Bits.Zero 216
  for i in intRange (0 : Int) (35 : Int) do
    Runtime.assert (decide (i * 6 + 6 ≤ 216))
    Runtime.assert (decide (0 ≤ i * 6))
    order := (← setSliceChecked order (i * (6 : Int)) 6 (← i[0 +: 6]))
  return order

-- Adjacent swaps produce a bounded permutation, retaining request count and checks.
def Emulate_FXSAVE_Write_Order
    (wide : Bool) (linear_address offset : Bits 64) (address_size : Int) (reserved : Bits 48) (padding : Bits 392) :
    Runtime.SpecM Exception (State σ) (Bits 216) := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let mut order : Bits 216 ← Emulate_FXSAVE_Source_Order
  if (← Select_FXSAVE_Schedule_Domain wide linear_address) then
    for i in intRange (1 : Int) (35 : Int) do
      for k in intRange (0 : Int) (i - 1) do
        let j : Int := i - 1 - k
        let a : Int := Unsigned (← order[j * 6 +: 6])
        let b : Int := Unsigned (← order[(j + 1) * 6 +: 6])
        Runtime.assert (decide (a ≤ 35) and decide (b ≤ 35))
        let first : FXSAVE_Write_Request ← Emulate_FXSAVE_Write_Request a wide offset address_size reserved padding
        let second : FXSAVE_Write_Request ← Emulate_FXSAVE_Write_Request b wide offset address_size reserved padding
        if (← Select_FXSAVE_Write_Swap wide linear_address first second) then
          let saved : Bits 6 ← order[j * 6 +: 6]
          Runtime.assert (decide (j * 6 + 6 ≤ 216))
          Runtime.assert (decide (0 ≤ j * 6))
          order := (← setSliceChecked order (j * (6 : Int)) 6 (← order[(j + 1) * 6 +: 6]))
          Runtime.assert (decide ((j + 1) * 6 + 6 ≤ 216))
          Runtime.assert (decide (0 ≤ (j + 1) * 6))
          order := (← setSliceChecked order ((j + (1 : Int)) * (6 : Int)) 6 saved)
  return order

def Emulate_FXSAVE_Write_Plan
    (wide : Bool) (segment : Segment) (offset : Bits 64) (address_size : Int) :
    Runtime.SpecM Exception (State σ) (Address_Translation × Address_Translation × Bits 48 × Bits 392 × Bits 2 × Bits 216) := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  Runtime.assert (← In_64Bit_Mode)
  let (first, last) ← Emulate_FXSAVE_Initial_Addresses wide segment offset address_size
  let reserved : Bits 48 ← Select_FXSAVE_Reserved_Header wide first.linear_address
  let mut padding : Bits 392 ← Std.Bits.Zero 392
  for i in intRange (0 : Int) (7 : Int) do
    Runtime.assert (decide (i * 49 + 49 ≤ 392))
    Runtime.assert (decide (0 ≤ i * 49))
    padding := (← setSliceChecked padding (i * (49 : Int)) 49 (← Select_FXSAVE_Reserved_Slot wide first.linear_address (← i[0 +: 3])))
  let fields : Bits 2 ← do
    if (← CR4.OSFXSR) == 1 then
      pure 3
    else
      Select_FXSAVE_Fields wide first.linear_address
  let order : Bits 216 ← Emulate_FXSAVE_Write_Order wide first.linear_address offset address_size reserved padding
  return (first, last, reserved, padding, fields, order)

def Emulate_FXSAVE_Write_Transfer
    (wide : Bool) (segment : Segment) (offset : Bits 64) (address_size : Int) (first last : Address_Translation) (reserved : Bits 48) (padding : Bits 392) (fields : Bits 2) (order : Bits 216) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  for position in intRange (0 : Int) (35 : Int) do
    let index : Int := Unsigned (← order[position * 6 +: 6])
    Runtime.assert (decide (index ≤ 35))
    if (← Emulate_FXSAVE_Write_Enabled index wide fields) then
      let request : FXSAVE_Write_Request ← Emulate_FXSAVE_Write_Request index wide offset address_size reserved padding
      if (index == 0) then
        let _ ← Translate_Linear_To_Physical.interpreted first Memory_Access_Type.Memory_Write
      else
        if (index == 1) then
          let _ ← Translate_Linear_To_Physical.interpreted last Memory_Access_Type.Memory_Write
        else
          if (index == 2) then
            Logical_Mem_Write (size := 16) segment request.offset (← get).FP87_Control Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
          else
            if (index == 3) then
              Logical_Mem_Write (size := 16) segment request.offset (← get).FP87_Status Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
            else
              if (index == 4) then
                let tag : Bits 8 ← FP87.Calculate_Abridged_Tag_Word
                if ((← reserved[47 +: 1]) == 1) then
                  Logical_Mem_Write (size := 16) segment request.offset (← concatBits (leftSize := 8) (rightSize := 8) (← reserved[44:37]) tag) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                else
                  Logical_Mem_Write (size := 8) segment request.offset tag Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
              else
                if (index == 5) then
                  Logical_Mem_Write (size := 16) segment request.offset (← concatBits (leftSize := 5) (rightSize := 11) (← reserved[36:32]) (← get).FP87_FOP) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                else
                  if (index == 6) then
                    if wide then
                      Logical_Mem_Write (size := 64) segment request.offset (← get).FP87_FIP Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                    else
                      Logical_Mem_Write (size := 32) segment request.offset (← sliceInclusive (← get).FP87_FIP 31 0) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                  else
                    if (index == 7) then
                      if wide then
                        Logical_Mem_Write (size := 64) segment request.offset (← get).FP87_FDP Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                      else
                        Logical_Mem_Write (size := 32) segment request.offset (← sliceInclusive (← get).FP87_FDP 31 0) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                    else
                      if (index == 8) then
                        let fcs : Bits 16 ← do
                          if (← CPUID_FCS_FDS_DEPRECATION) then
                            Std.Bits.Zero 16
                          else
                            pure (← get).FP87_FCS
                        if ((← reserved[46 +: 1]) == 1) then
                          Logical_Mem_Write (size := 32) segment request.offset (← concatBits (leftSize := 16) (rightSize := 16) (← reserved[31:16]) fcs) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                        else
                          Logical_Mem_Write (size := 16) segment request.offset fcs Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                      else
                        if (index == 9) then
                          let fds : Bits 16 ← do
                            if (← CPUID_FCS_FDS_DEPRECATION) then
                              Std.Bits.Zero 16
                            else
                              pure (← get).FP87_FDS
                          if ((← reserved[45 +: 1]) == 1) then
                            Logical_Mem_Write (size := 32) segment request.offset (← concatBits (leftSize := 16) (rightSize := 16) (← reserved[15:0]) fds) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                          else
                            Logical_Mem_Write (size := 16) segment request.offset fds Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                        else
                          if (decide (index ≤ 17)) then
                            let i : Int := index - 10
                            let physical : Int := Unsigned (← Std.Bits.Add_int (n := 3) (← FP87_Status.TOP) i)
                            let extra : Bits 49 ← padding[i * 49 +: 49]
                            let payload : F80_Type ← do
                              Runtime.assert (decide (physical < 8))
                              Runtime.assert (decide (0 ≤ physical))
                              pure (← FP87.get physical)
                            if ((← extra[48 +: 1]) == 1) then
                              Logical_Mem_Write (size := 128) segment request.offset (← concatBits (leftSize := 48) (rightSize := 80) (← extra[47:0]) payload) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                            else
                              Logical_Mem_Write (size := 80) segment request.offset payload Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                          else
                            if (index == 18) then
                              Logical_Mem_Write (size := 32) segment request.offset (← get).FXSAVE_MXCSR_Mask Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                            else
                              if (index == 19) then
                                Logical_Mem_Write (size := 32) segment request.offset (← get).MXCSR Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
                              else
                                Logical_Mem_Write (size := 128) segment request.offset (← sliceInclusive (← (do Runtime.assert (decide (index - 20 < 32)); Runtime.assert (decide (0 ≤ index - 20)); pure (← ZMM.get (index - 20)))) 127 0) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86.Helpers

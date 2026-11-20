-- Generated from data/definitions.xml.gz: FP87::Atan; do not edit.
-- Source SHA256: 514df68fe775b0a581149276df8e8834f4274f90c4d01332ab83ec32b81b27cb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AAtan)
import X86.Runtime
import X86.Helpers.Emulate_F2XM1
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Get_NAN_Result
import X86.Helpers.FP87.Get_Rounding_Mode
import X86.Helpers.FP87.Pi
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Three_Quarter_Pi
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Emulate_FPATAN.Binding σ]

def FP87.Atan
    (x y : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← FP87.Classify y

  match (x_class, y_class) with
  | (FP87_Class_Type.FP87_Class_Unsupported, _) | (_, FP87_Class_Type.FP87_Class_Unsupported) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  -- Not-a-Number (NaN)
  | (FP87_Class_Type.FP87_Class_QNaN, FP87_Class_Type.FP87_Class_QNaN) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Get_NAN_Result x y)

  | (FP87_Class_Type.FP87_Class_QNaN, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue x

  | (FP87_Class_Type.FP87_Class_SNaN, FP87_Class_Type.FP87_Class_QNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue y

  | (FP87_Class_Type.FP87_Class_SNaN, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Get_NAN_Result x y)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN (← Runtime.InitializedBits.read result))

  | (FP87_Class_Type.FP87_Class_QNaN, _) => do
    result := Runtime.InitializedBits.ofValue x
  | (_, FP87_Class_Type.FP87_Class_QNaN) => do
    result := Runtime.InitializedBits.ofValue y

  | (FP87_Class_Type.FP87_Class_SNaN, _) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)
  | (_, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN y)

  -- Infinity
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign x == 0) then
      result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (FP87.Pi))
      result := (← F80_Type.setExponent.partial result ((BitVec.cast (by omega) (← F80_Type.Exponent.partial result) : Bits 15) - (← Std.Bits.Zero_Extend (source_size := 4) 2 15)))
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Three_Quarter_Pi)

    result := (← F80_Type.setSign.partial result (F80_Type.Sign y))
    exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
    rounded_up := (← (do
      let __check88 : Rounding_Mode ← Runtime.liftTotal (FP87.Get_Rounding_Mode)
      pure ((__check88 == Rounding_Mode.Rounding_Mode_RNE) || (__check88 == Rounding_Mode.Rounding_Mode_RTP))))
  | (FP87_Class_Type.FP87_Class_Infinity, _) => do
    if (y_class == FP87_Class_Type.FP87_Class_Denormal) then
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

    if (F80_Type.Sign x == 0) then
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign y))
    else
      result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (FP87.Pi))
      result := (← F80_Type.setSign.partial result (F80_Type.Sign y))
      exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      rounded_up := (← (do
        let __check89 : Rounding_Mode ← Runtime.liftTotal (FP87.Get_Rounding_Mode)
        pure ((__check89 == Rounding_Mode.Rounding_Mode_RNE) || (__check89 == Rounding_Mode.Rounding_Mode_RTP))))
  | (_, FP87_Class_Type.FP87_Class_Infinity) => do
    if (x_class == FP87_Class_Type.FP87_Class_Denormal) then
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

    result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (FP87.Pi))
    result := (← F80_Type.setExponent.partial result ((BitVec.cast (by omega) (← F80_Type.Exponent.partial result) : Bits 15) - (← Std.Bits.Zero_Extend (source_size := 4) 1 15)))
    result := (← F80_Type.setSign.partial result (F80_Type.Sign y))
    exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
    rounded_up := (← (do
      let __check90 : Rounding_Mode ← Runtime.liftTotal (FP87.Get_Rounding_Mode)
      pure ((__check90 == Rounding_Mode.Rounding_Mode_RNE) || (__check90 == Rounding_Mode.Rounding_Mode_RTP))))

  -- Zero
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Zero) => do
    if (F80_Type.Sign x == 0) then
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign y))
    else
      result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (FP87.Pi))
      result := (← F80_Type.setSign.partial result (F80_Type.Sign y))
      exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      rounded_up := (← (do
        let __check91 : Rounding_Mode ← Runtime.liftTotal (FP87.Get_Rounding_Mode)
        pure ((__check91 == Rounding_Mode.Rounding_Mode_RNE) || (__check91 == Rounding_Mode.Rounding_Mode_RTP))))
  | (FP87_Class_Type.FP87_Class_Zero, _) => do
    if (y_class == FP87_Class_Type.FP87_Class_Denormal) then
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

    result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (FP87.Pi))
    result := (← F80_Type.setExponent.partial result ((BitVec.cast (by omega) (← F80_Type.Exponent.partial result) : Bits 15) - (← Std.Bits.Zero_Extend (source_size := 4) 1 15)))
    result := (← F80_Type.setSign.partial result (F80_Type.Sign y))
    exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
    rounded_up := (← (do
      let __check92 : Rounding_Mode ← Runtime.liftTotal (FP87.Get_Rounding_Mode)
      pure ((__check92 == Rounding_Mode.Rounding_Mode_RNE) || (__check92 == Rounding_Mode.Rounding_Mode_RTP))))
  | (_, FP87_Class_Type.FP87_Class_Zero) => do
    if (x_class == FP87_Class_Type.FP87_Class_Denormal) then
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

    if (F80_Type.Sign x == 0) then
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign y))
    else
      result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (FP87.Pi))
      result := (← F80_Type.setSign.partial result (F80_Type.Sign y))
      exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      rounded_up := (← (do
        let __check93 : Rounding_Mode ← Runtime.liftTotal (FP87.Get_Rounding_Mode)
        pure ((__check93 == Rounding_Mode.Rounding_Mode_RNE) || (__check93 == Rounding_Mode.Rounding_Mode_RTP))))

  -- Denormal
  | (FP87_Class_Type.FP87_Class_Denormal, _) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    -- between pi and -pi
    let (result_1, rounded_up_1, exceptions_1) ← Emulate_FPATAN x y
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    exceptions := exceptions_1

  -- Normal
  | (FP87_Class_Type.FP87_Class_Normal, _) => do
    -- between pi and -pi
    let (result_2, rounded_up_2, exceptions_2) ← Emulate_FPATAN x y
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers

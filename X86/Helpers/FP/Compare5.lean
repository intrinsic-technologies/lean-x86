-- Generated from data/definitions.xml.gz: FP::Compare5; do not edit.
-- Source SHA256: 0797bc733a36fd202b5f125efc22afb7d84ee430c766c2a3abe32ba7188aad9b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3ACompare5)
import X86.Runtime
import X86.Helpers.FP.Comparison_Predicates
import X86.Helpers.FP.Unpack
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatOrdered
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Compare5 {N : Int}
    (x y : Bits N) (op : Bits 5) (denormals_are_zeros : Bool) :
    Runtime.SpecM Exception (State σ) (Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)) || (N == (64 : Int)))
  let E : Int := if N == 16 then 5 else if N == 32 then 8 else 11
  let ux : UFloat E N ← FP.Unpack (size := N) x E denormals_are_zeros
  let uy : UFloat E N ← FP.Unpack (size := N) y E denormals_are_zeros

  let mut r : Bool ←
    do
      if ((op == EQ_OQ) || (op == EQ_OS)) then
        pure ((← UFloatEqual (E := E) (N := N) ux uy) and (← UFloatOrdered (E := E) (N := N) ux uy))
      else
        if ((op == EQ_UQ) || (op == EQ_US)) then
          pure ((← UFloatEqual (E := E) (N := N) ux uy) or not (← UFloatOrdered (E := E) (N := N) ux uy))
        else
          if ((op == NEQ_UQ) || (op == NEQ_US)) then
            pure ((← UFloatNotEqual (E := E) (N := N) ux uy) or not (← UFloatOrdered (E := E) (N := N) ux uy))
          else
            if ((op == NEQ_OQ) || (op == NEQ_OS)) then
              pure ((← UFloatNotEqual (E := E) (N := N) ux uy) and (← UFloatOrdered (E := E) (N := N) ux uy))
            else
              if ((op == LT_OQ) || (op == LT_OS)) then
                pure ((← UFloatLessThan (E := E) (N := N) ux uy) and (← UFloatOrdered (E := E) (N := N) ux uy))
              else
                if ((op == NLT_UQ) || (op == NLT_US)) then
                  pure (not (← UFloatLessThan (E := E) (N := N) ux uy) or not (← UFloatOrdered (E := E) (N := N) ux uy))
                else
                  if ((op == LE_OQ) || (op == LE_OS)) then
                    pure ((← UFloatLessEqual (E := E) (N := N) ux uy) and (← UFloatOrdered (E := E) (N := N) ux uy))
                  else
                    if ((op == NLE_UQ) || (op == NLE_US)) then
                      pure (not (← UFloatLessEqual (E := E) (N := N) ux uy) or not (← UFloatOrdered (E := E) (N := N) ux uy))
                    else
                      if ((op == GE_OQ) || (op == GE_OS)) then
                        pure ((← UFloatGreaterEqual (E := E) (N := N) ux uy) and (← UFloatOrdered (E := E) (N := N) ux uy))
                      else
                        if ((op == NGE_UQ) || (op == NGE_US)) then
                          pure ((← UFloatLessThan (E := E) (N := N) ux uy) or not (← UFloatOrdered (E := E) (N := N) ux uy))
                        else
                          if ((op == GT_OQ) || (op == GT_OS)) then
                            pure ((← UFloatGreaterThan (E := E) (N := N) ux uy) and (← UFloatOrdered (E := E) (N := N) ux uy))
                          else
                            if ((op == NGT_UQ) || (op == NGT_US)) then
                              pure ((← UFloatLessEqual (E := E) (N := N) ux uy) or not (← UFloatOrdered (E := E) (N := N) ux uy))
                            else
                              if ((op == ORD_Q) || (op == ORD_S)) then
                                pure (← UFloatOrdered (E := E) (N := N) ux uy)
                              else
                                if ((op == UNORD_Q) || (op == UNORD_S)) then
                                  pure (not (← UFloatOrdered (E := E) (N := N) ux uy))
                                else
                                  if ((op == TRUE_UQ) || (op == TRUE_US)) then
                                    pure true
                                  else
                                    if ((op == FALSE_OQ) || (op == FALSE_OS)) then
                                      pure false
                                    else
                                      match Unsigned op with
                                      | _ => throw .unmatchedCase

  let signalling : Bool := ((op == LT_OS) || (op == LE_OS) || (op == NLT_US) || (op == NLE_US) || (op == NGE_US) || (op == NGT_US) || (op == GE_OS) || (op == GT_OS) || (op == EQ_OS) || (op == UNORD_S) || (op == NEQ_US) || (op == ORD_S) || (op == EQ_US) || (op == FALSE_OS) || (op == NEQ_OS) || (op == TRUE_US))

  let exceptions_bits_0_0 : Runtime.Bit ← do
    if signalling then
      Bit ((← UFloatIsNaN (E := E) (N := N) ux) or (← UFloatIsNaN (E := E) (N := N) uy))
    else
      Bit ((← UFloatIsSNaN (E := E) (N := N) ux) or (← UFloatIsSNaN (E := E) (N := N) uy))
  let exceptions_bits_1_1 : Runtime.Bit ← Bit ((← UFloatIsSubnormal (E := E) (N := N) ux) and not (← UFloatIsNaN (E := E) (N := N) uy) or (← UFloatIsSubnormal (E := E) (N := N) uy) and not (← UFloatIsNaN (E := E) (N := N) ux))
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 4) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 3) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 2) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 1) exceptions_bits_1_1 exceptions_bits_0_0))))

  return (r, exceptions)

end X86.Helpers

-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: f469cc9e68ed09073f2bf86d6ea34e5e8b9890cc78061ccec7376531c959c69d
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Handle_Multiple_Exceptions
import X86.Helpers.Handle_Vectored_Event
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Ended
import X86.Helpers.Set_Canonical_Wrt_Paging_Mode
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]

def Handle_Exception
    (vector : Int) (linear_address : Bits 64) (error_code : Bits 32) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  Runtime.assert (vector in {0..255})

  if (vector == PF_Exception) then
    Runtime.liftTotal (CR2.assign (← (do if (← Runtime.liftTotal (CPUID_LAM)) and (← Runtime.liftTotal (In_64Bit_Mode)) then pure (← Runtime.liftTotal (Set_Canonical_Wrt_Paging_Mode linear_address)) else pure linear_address)))

  try
    if (← get).Concurrent_Exception.valid then
      Runtime.liftTotal (Handle_Multiple_Exceptions (← get).Concurrent_Exception.vector vector)

    if (vector == DF_Exception) then
      Runtime.liftTotal (Double_Fault_Contributory_Exception.assign (← get).Concurrent_Exception.vector)
    else
      if (vector == DB_Exception) then
        Runtime.liftTotal (DR7.setGD 0)
        Runtime.liftTotal (IA32_DEBUGCTL.setLBR 0)
        Runtime.liftTotal (IA32_DEBUGCTL.setBTF 0)

    Runtime.liftTotal (Handle_Vectored_Event.interpreted Vectored_Event_Type.Hardware_Exception vector error_code (← get).RIP)
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      Runtime.liftTotal (Concurrent_Exception.setvector vector)
      Runtime.liftTotal (Concurrent_Exception.setvalid true)

      -- Selector and alignment-check error codes carry EXT.
      let new_error_code : Bits 32 ← do
        if (← (do let subject := e.vector; pure ((subject == TS_Exception) || (subject == NP_Exception) || (subject == SS_Exception) || (subject == GP_Exception) || (subject == AC_Exception)))) then
          pure (← concatBits (leftSize := 31) (rightSize := 1) (← e.error_code[31:1]) (1 : Runtime.Bit))
        else
          pure e.error_code

      Handle_Exception e.vector e.linear_address new_error_code
    | .raised (.Instruction_Ended _) =>
      pure ()
    | _ => throw exception

  Runtime.liftTotal (Concurrent_Exception.setvalid false)

partial_fixpoint

end X86.Helpers

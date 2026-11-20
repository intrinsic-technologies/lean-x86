-- Generated from data/definitions.xml.gz: Report_Control_Protection_Exception; do not edit.
-- Source SHA256: e3a49caac782a4bfff15673c8dcb8b3e28842517e59a4847582b6f18f0f4b6cb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Control_Protection_Exception)
import X86.Runtime
import X86.Helpers.CP_Error_Code
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Report_Control_Protection_Exception (error : CP_Error_Code) : Result Unit := do
  let mut error_code : Runtime.InitializedBits 32 := Runtime.InitializedBits.empty 32
  match error with
  | CP_Error_Code.NEAR_RET => do
    error_code := (← Runtime.InitializedBits.writeSlice error_code 0 15 (← (1 : Int)[14:0]))
  | CP_Error_Code.FAR_RET_or_IRET => do
    error_code := (← Runtime.InitializedBits.writeSlice error_code 0 15 (← (2 : Int)[14:0]))
  | CP_Error_Code.ENDBRANCH => do
    error_code := (← Runtime.InitializedBits.writeSlice error_code 0 15 (← (3 : Int)[14:0]))
  | CP_Error_Code.RSTORSSP => do
    error_code := (← Runtime.InitializedBits.writeSlice error_code 0 15 (← (4 : Int)[14:0]))
  | CP_Error_Code.SETSSBSY => do
    error_code := (← Runtime.InitializedBits.writeSlice error_code 0 15 (← (5 : Int)[14:0]))

  -- TODO: when SGX is supported set "ENCL" bit (Bit[15]) to 0b1 if #CP occurred during enclave execution
  error_code := (← Runtime.InitializedBits.writeSlice error_code 15 1 (0 : Runtime.Bit))

  error_code := (← Runtime.InitializedBits.writeSlice error_code 16 16 (← Std.Bits.Zero 16))
  throw (.raised (↑({
    vector := CP_Exception,
    linear_address := (← Std.Bits.Zero 64),
    error_code := (← Runtime.InitializedBits.read error_code)
  } : Exception_Info) : Exception))

end X86.Helpers

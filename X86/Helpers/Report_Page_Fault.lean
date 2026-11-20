-- Generated from data/definitions.xml.gz: Report_Page_Fault; do not edit.
-- Source SHA256: 8be2ade3e4abbe376e2c5b4a40cb1ad2bfb34c45a0f94e664e3d6d735f6954cc
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Report_Page_Fault)
import X86.Runtime
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Page_Fault_Error_Code
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- This procedure never returns normally; its result type is unrestricted.
def Report_Page_Fault {α : Type}
    (error_code : Page_Fault_Error_Code) (linear_address : Bits 64) :
    Result α := do
  throw (.raised (↑({
    vector := PF_Exception,
    linear_address := linear_address,
    error_code := error_code
  } : Exception_Info) : Exception))

end X86.Helpers

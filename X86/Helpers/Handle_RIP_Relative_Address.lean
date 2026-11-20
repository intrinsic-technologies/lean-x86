-- Generated from data/definitions.xml.gz: Handle_RIP_Relative_Address; do not edit.
-- Source SHA256: 4c748d46bd9421c7f0e0a63ece9793773373f17c5c43aa26915b9557a9a266cc
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Handle_RIP_Relative_Address)
import X86.Runtime
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Handle_RIP_Relative_Address
    (address_size : Int) (is_rip_relative : Bool) (ea_offset next_ip : Bits 64) :
    Except (Runtime.Error Empty) (Bits 64) := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let effective_address : Bits 64 := if is_rip_relative then ea_offset + next_ip else ea_offset
  return (← Std.Bits.Zero_Extend (source_size := address_size) (← effective_address[0 +: address_size]) 64)

end X86.Helpers

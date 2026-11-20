-- Generated from data/definitions.xml.gz: Branch_Far; do not edit.
-- Source SHA256: d40c58f33bc3f95685e0fbec4cdcfded197330ed9abbcbe8c12285dee86f0379
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Branch_Far)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Branch_Far
    (new_cs : Segment) (new_rip : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with CS := new_cs })
  modify ({ · with RIP := new_rip })
  modify ({ · with Branch_Taken := true })

  match (← Current_Mode) with
  | Execution_Mode.Real_Address_Mode => do
    modify ({ · with CPL := (0 : Int) })
  | Execution_Mode.Virtual_8086_Mode => do
    modify ({ · with CPL := (3 : Int) })
  | _ => do
    CPL.assign (Unsigned (Segment_Selector.RPL (← get).CS.selector))

end X86.Helpers

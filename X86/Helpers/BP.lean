-- Generated from data/definitions.xml.gz: BP; do not edit.
-- Source SHA256: 88114617afba34cf49f5528dd291cf309736696bf40022c753efa6f8733ec380
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=BP)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def BP_InstructionExecution : Bits 2 := 0

def BP_DataWrite : Runtime.Bit := 1

def BP_IOReadOrWrite : Bits 2 := 2

def BP_DataReadOrWrite : Bits 2 := 3

end X86.Helpers

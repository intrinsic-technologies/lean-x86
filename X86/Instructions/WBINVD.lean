-- Generated from data/instruction/WBINVD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 4be336249ae854fe436cde69d9c5d2eaae57371600f9ee802ef59eb56930b70d
-- Description: data/sdm/WBINVD.docbook
-- Writes back all modified cache lines in the processor’s internal cache to main memory and
-- invalidates (flushes) the internal caches.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=WBINVD)
import X86.Runtime
import X86.Helpers.Cache.Writeback
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Cache.Writeback.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]

def Instructions.Operations.WBINVD  : Runtime.SpecM Exception (State σ) Unit := do
  Cache.Writeback true

-- WBINVD_1: 0F 09
def Instructions.WBINVD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).WBINVD_Exiting == 1) then
      VM_Exit VMX_EXIT_WBINVD

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.WBINVD

end X86

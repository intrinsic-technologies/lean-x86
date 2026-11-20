-- Generated from data/instruction/RDTSC.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c718ff96b845ec3e0ad20470abca9f6d041c0b438748a2ab95041aa61b94d75c
-- Description: data/sdm/RDTSC.docbook
-- Reads the current value of the processor’s time-stamp counter (a 64-bit MSR) into the EDX:EAX
-- registers.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=RDTSC)
import X86.Runtime
import X86.Helpers.EAX
import X86.Helpers.EDX
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_Time_Stamp_Counter
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
  [X86.Helpers.Read_Time_Stamp_Counter.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]

def Instructions.Operations.RDTSC  : Runtime.SpecM Exception (State σ) Unit := do
  let result : Bits 64 ← Read_Time_Stamp_Counter
  EAX_write (← result[31:0])
  EDX_write (← result[63:32])

-- RDTSC: 0F 31
def Instructions.RDTSC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.TSD) == 1 and (← get).CPL != 0 and (← CR0.PE) == 1) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).RDTSC_Exiting == 1) then
      VM_Exit VMX_EXIT_RDTSC

  modify ({ · with Next_IP := ip })

  Instructions.Operations.RDTSC

end X86

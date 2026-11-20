-- Generated from data/instruction/INTn-INTO-INT3-INT1.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 01382ef545a69cc6efd681dec51cbd2176bb9a606a19027fd8289ce6caebd7f9
-- Description: data/sdm/INTn-INTO-INT3-INT1.docbook
-- Call to Interrupt Procedure
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=INTn%2FINTO%2FINT3%2FINT1)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Take_Interrupt
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.INT (src : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode and (← CR4.VME) == 0 and (← RFLAGS.IOPL) != 3) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  Take_Interrupt Vectored_Event_Type.Software_Interrupt_INTn (Unsigned src) (← get).Next_IP

def Instructions.Operations.INT3  : Runtime.SpecM Exception (State σ) Unit := do
  Take_Interrupt Vectored_Event_Type.Software_Exception_INT3_Or_INTO 3 (← get).Next_IP

def Instructions.Operations.INTO  : Runtime.SpecM Exception (State σ) Unit := do
  if ((← RFLAGS.OF) == 1) then
    Take_Interrupt Vectored_Event_Type.Software_Exception_INT3_Or_INTO 4 (← get).Next_IP

def Instructions.Operations.INT1  : Runtime.SpecM Exception (State σ) Unit := do
  Take_Interrupt Vectored_Event_Type.Privileged_Software_Exception_INT1 1 (← get).Next_IP

-- INT_IMMb: CD ib
def Instructions.INT_IMMb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.INT src

-- INT3: CC
def Instructions.INT3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.INT3

-- INTO: CE
def Instructions.INTO
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.INTO

-- INT1: F1
def Instructions.INT1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.INT1

end X86

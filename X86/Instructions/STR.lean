-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5f621c2fd510e513fd0e6c28e703fbdccbabd579b131a470ecc155d8ca13d1d4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=STR)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- The executable XML omits STR. SDM Vol. 2, STR stores the task-register selector.
-- Register destinations are zero-extended; memory destinations are always 16 bits.
-- The VM-exit interface remains explicit, as in the supplied SLDT implementation.
def Instructions.Operations.STR
    (width : Int) :
    Runtime.SpecM Exception (State σ) (Bits width) := do
  Runtime.assert (width == 16 || width == 32 || width == 64)

  return (← Std.Bits.Zero_Extend (source_size := 16) (← get).TR.selector width)

def Check_STR (context : Instruction_Context) : Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  if (← (do
    let __check450 : Execution_Mode ← Current_Mode
    pure ((__check450 == Execution_Mode.Real_Address_Mode) || (__check450 == Execution_Mode.Virtual_8086_Mode)))) then
    liftM (Report_Invalid_Opcode)
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_LDTR_TR
  if ((← CR4.UMIP) == 1 and (← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

def Instructions.STR_GPRv
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  Check_STR context
  modify ({ · with Next_IP := ip })
  let result : Bits context.operand_size ← Instructions.Operations.STR context.operand_size
  Write_GPR (size := context.operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

def Instructions.STR_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (offset, segment, next_ip, relative, _) ← Effective_Address context.address_size context mod rm 1 ip
  let address : Bits 64 ← Handle_RIP_Relative_Address context.address_size relative offset next_ip
  Check_STR context
  modify ({ · with Next_IP := next_ip })
  Logical_Mem_Write (size := 16) segment address (← Instructions.Operations.STR 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86

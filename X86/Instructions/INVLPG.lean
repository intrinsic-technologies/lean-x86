-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 8d4a9e0fd3861a45d24940d3805698d5f860c4c39003eb30a28f7820ab14cda9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=INVLPG)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Canonical_Wrt_Position
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
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
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.Invalidate_Translation_Caches.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- Intel SDM Vol. 2, INVLPG. The executable XML omits the instruction body.
-- The operand supplies an address, not a memory value. The caller's TLB binding
-- invalidates the current PCID's page, all global mappings for that page,
-- and all paging-structure-cache entries for the current PCID.
def Instructions.Operations.INVLPG
    (segment : Segment) (offset : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).INVLPG_Exiting == 1) then
      VM_Exit VMX_EXIT_INVLPG
  let linear : Bits 64 := (← Get_Segment_Base segment) + offset
  if (← (do if (← In_64Bit_Mode) then pure (not (← Is_Canonical_Wrt_Position linear (if (← CR4.LA57) == 1 then 57 else 48))) else pure false)) then
    return ()
  let pcid : Bits 12 ← do
    if (← CR4.PCIDE) == 1 then
      sliceInclusive (← get).CR3 11 0
    else
      Std.Bits.Zero 12
  Invalidate_Translation_Caches pcid linear

def Instructions.INVLPG_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (offset, segment, next_ip, relative, _) ← Effective_Address context.address_size context mod rm 1 ip
  let address : Bits 64 ← Handle_RIP_Relative_Address context.address_size relative offset next_ip
  if (context.lock_prefix_present or mod == 3) then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.INVLPG segment address

end X86

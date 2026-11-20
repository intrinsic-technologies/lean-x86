-- Generated from data/definitions.xml.gz: Store_Old_TSS; do not edit.
-- Source SHA256: 3fe4bd2b3729f85dc46773a91048a38eea465fdbac897da82d620d0f0ae18d4a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Store_Old_TSS)
import X86.Runtime
import X86.Helpers.Is_16Bit_Task
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Registers
import X86.Helpers.Task_State_Segment
import X86.Helpers.Task_Switch_Initiator
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Store_Old_TSS
    (return_ip : Bits 64) (initiator : Task_Switch_Initiator) (old_tss_flags : RFLAGS_Type) :
    Runtime.SpecM Exception (State σ) Unit := do

  -- In the process of saving the state of the current task, if a fault occurs and
  -- the fault handler uses a task gate, do not attempt to save the task state again.
  -- This prevents generation of nested exceptions leading to a triple fault.
  if (← get).Saving_Task_State_During_Task_Switch then
    return ()

  modify ({ · with Saving_Task_State_During_Task_Switch := true })

  let mut rflags : RFLAGS_Type := old_tss_flags
  -- 11. If the task switch was initiated with an IRET instruction, the processor clears the NT flag in a temporarily saved
  --     image of the EFLAGS register; if initiated with a CALL or JMP instruction, an exception, or an interrupt, the NT
  --     flag is left unchanged in the saved EFLAGS image.
  if (initiator == Task_Switch_Initiator.Task_Switch_Iret) then
    rflags := RFLAGS_Type.setNT rflags (0 : Runtime.Bit)

  if (not (← Is_16Bit_Task (← get).TR)) then
    -- 32-bit TSS
    Logical_Mem_Write (size := 32) (← get).TR TSS_EIP_OFFSET (← return_ip[0 +: 32]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_EFLAGS_OFFSET (← rflags[0 +: 32]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

    -- GPRs
    Logical_Mem_Write (size := 32) (← get).TR TSS_EAX_OFFSET (← Runtime.CheckedSlice.read (← RAX) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_ECX_OFFSET (← Runtime.CheckedSlice.read (← RCX) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_EDX_OFFSET (← Runtime.CheckedSlice.read (← RDX) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_EBX_OFFSET (← Runtime.CheckedSlice.read (← RBX) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_ESP_OFFSET (← Runtime.CheckedSlice.read (← RSP) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_EBP_OFFSET (← Runtime.CheckedSlice.read (← RBP) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_ESI_OFFSET (← Runtime.CheckedSlice.read (← RSI) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 32) (← get).TR TSS_EDI_OFFSET (← Runtime.CheckedSlice.read (← RDI) 0 32) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

    -- segment selectors
    Logical_Mem_Write (size := 16) (← get).TR TSS_ES_OFFSET (← get).ES.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_CS_OFFSET (← get).CS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_SS_OFFSET (← get).SS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_DS_OFFSET (← get).DS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    -- Atom processors store FS/GS as 16-bit values
    Logical_Mem_Write (size := 16) (← get).TR TSS_FS_OFFSET (← get).FS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_GS_OFFSET (← get).GS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  else
    -- 16-bit TSS
    Logical_Mem_Write (size := 16) (← get).TR TSS_IP_OFFSET (← return_ip[0 +: 16]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_FLAGS_OFFSET (← rflags[0 +: 16]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

    -- GPRs
    Logical_Mem_Write (size := 16) (← get).TR TSS_AX_OFFSET (← Runtime.CheckedSlice.read (← RAX) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_CX_OFFSET (← Runtime.CheckedSlice.read (← RCX) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_DX_OFFSET (← Runtime.CheckedSlice.read (← RDX) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_BX_OFFSET (← Runtime.CheckedSlice.read (← RBX) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_SP_OFFSET (← Runtime.CheckedSlice.read (← RSP) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_BP_OFFSET (← Runtime.CheckedSlice.read (← RBP) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_SI_OFFSET (← Runtime.CheckedSlice.read (← RSI) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_DI_OFFSET (← Runtime.CheckedSlice.read (← RDI) 0 16) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

    -- segment selectors
    Logical_Mem_Write (size := 16) (← get).TR TSS_ES_OFFSET_16 (← get).ES.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_CS_OFFSET_16 (← get).CS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_SS_OFFSET_16 (← get).SS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) (← get).TR TSS_DS_OFFSET_16 (← get).DS.selector Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

  modify ({ · with Saving_Task_State_During_Task_Switch := false })

end X86.Helpers

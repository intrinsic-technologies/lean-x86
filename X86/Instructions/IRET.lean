-- Generated from data/instruction/IRET-IRETD-IRETQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c8e2b9284cc1eac4aacc0128a167efa663d59c9f1f9510242042f514758a4210
-- Description: data/sdm/IRET-IRETD-IRETQ.docbook
-- Returns program control from an exception or interrupt handler to a program or procedure that
-- was interrupted by an exception, an external interrupt, or a software-generated interrupt.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=IRET%2FIRETD%2FIRETQ)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.Check_New_RIP
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Instruction_Context
import X86.Helpers.Iret_Pop_RIP_CS_Flags
import X86.Helpers.Iret_To_Virtual_8086_Mode
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Serialize_Instructions
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Task_Return
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Check_New_TSS.Binding σ]
  [X86.Helpers.Load_New_TSS.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Select_Buffered_Stack_Return_Swap.Binding σ]
  [X86.Helpers.Select_Stack_Return_Validation_Fault.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.IRET
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Serialize_Instructions

  let mode : Execution_Mode ← Current_Mode
  let mut new_rip : Bits 64 ← Std.Bits.Zero 64
  let mut new_rsp : Bits 64 ← Std.Bits.Zero 64
  let mut new_cs_selector : Runtime.InitializedBits 16 := Runtime.InitializedBits.empty 16
  let mut new_flags : RFLAGS_Type := (← get).RFLAGS

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← get).«VMCS::Pin_Based_VM_Exec_Controls».NMI_Exiting == 0) then
      Event_Blocked.setNMI_BLOCKED false
    else
      if ((← get).«VMCS::Pin_Based_VM_Exec_Controls».Virtual_NMIs == 1) then
        Event_Blocked.setVIRT_NMI_BLOCKED false
  else
    Event_Blocked.setNMI_BLOCKED false

  match mode with
  | Execution_Mode.Real_Address_Mode => do
    let (new_rip_1, new_cs_selector_1, new_flags_1, new_rsp_1) ← Iret_Pop_RIP_CS_Flags operand_size
    new_rip := new_rip_1
    new_cs_selector := Runtime.InitializedBits.ofValue new_cs_selector_1
    new_flags := new_flags_1
    new_rsp := new_rsp_1

    if (operand_size == 32) then
      new_flags := RFLAGS_Type.setVM new_flags (← RFLAGS.VM)
      new_flags := RFLAGS_Type.setVIP new_flags (← RFLAGS.VIP)
      new_flags := RFLAGS_Type.setVIF new_flags (← RFLAGS.VIF)

    let new_cs : Segment ← Load_Real_Or_VM86_Segment Execution_Mode.Real_Address_Mode (← Runtime.InitializedBits.read new_cs_selector) (← get).CS
    Check_New_RIP new_cs new_rip
    modify ({ · with RFLAGS := new_flags })
    RSP_write new_rsp
    Branch_Far new_cs new_rip

  | Execution_Mode.Virtual_8086_Mode => do
    if ((← RFLAGS.IOPL) != 3) then
      if ((← CR4.VME) == 0 or operand_size == 32) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    let (new_rip_2, new_cs_selector_2, new_flags_2, new_rsp_2) ← Iret_Pop_RIP_CS_Flags operand_size
    new_rip := new_rip_2
    new_cs_selector := Runtime.InitializedBits.ofValue new_cs_selector_2
    new_flags := new_flags_2
    new_rsp := new_rsp_2

    let new_cs : Segment ← Load_Real_Or_VM86_Segment Execution_Mode.Virtual_8086_Mode (← Runtime.InitializedBits.read new_cs_selector) (← get).CS
    Check_New_RIP new_cs new_rip

    if ((← RFLAGS.IOPL) != 3) then
      if (RFLAGS_Type.TF new_flags == 1 or (← RFLAGS.VIP) == 1 and RFLAGS_Type.IF new_flags == 1) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

      -- transfer new IF to VIF
      RFLAGS.setVIF (RFLAGS_Type.IF new_flags)

      -- IF and TF not modified by popped value
      new_flags := RFLAGS_Type.setIF new_flags (← RFLAGS.IF)
      new_flags := RFLAGS_Type.setTF new_flags (← RFLAGS.TF)

    -- IOPL not modified by popped value
    new_flags := RFLAGS_Type.setIOPL new_flags (← RFLAGS.IOPL)

    if (operand_size == 32) then
      -- VM, VIF and VIP not modified by popped value
      new_flags := RFLAGS_Type.setVM new_flags (← RFLAGS.VM)
      new_flags := RFLAGS_Type.setVIF new_flags (← RFLAGS.VIF)
      new_flags := RFLAGS_Type.setVIP new_flags (← RFLAGS.VIP)
      modify ({ · with RFLAGS := new_flags })
    else
      RFLAGS.setSlice 0 16 (← new_flags[0 +: 16])

    RSP_write new_rsp
    Branch_Far new_cs new_rip

  | Execution_Mode.Protected_Mode => do
    if ((← RFLAGS.NT) == 1) then
      Task_Return (← get).Next_IP
    else
      let (new_rip_3, new_cs_selector_3, new_flags_3, new_rsp_3) ← Iret_Pop_RIP_CS_Flags operand_size
      new_rip := new_rip_3
      new_cs_selector := Runtime.InitializedBits.ofValue new_cs_selector_3
      new_flags := new_flags_3
      new_rsp := new_rsp_3

      if (RFLAGS_Type.VM new_flags == 1 and (← get).CPL == 0) then
        Iret_To_Virtual_8086_Mode operand_size (← Runtime.InitializedBits.read new_cs_selector) new_flags new_rip new_rsp
      else
        Iret_Protected_Or_IA32e_Mode operand_size (← Runtime.InitializedBits.read new_cs_selector) new_rip new_flags new_rsp
  | Execution_Mode.IA32e_Mode => do
    if ((← RFLAGS.NT) == 1) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    let (new_rip_4, new_cs_selector_4, new_flags_4, new_rsp_4) ← Iret_Pop_RIP_CS_Flags operand_size
    new_rip := new_rip_4
    new_cs_selector := Runtime.InitializedBits.ofValue new_cs_selector_4
    new_flags := new_flags_4
    new_rsp := new_rsp_4

    if ((← CR4.FRED) == 1 and decide (Unsigned (← Segment_Selector.RPL.partial new_cs_selector) > (← get).CPL)) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector (← Runtime.InitializedBits.read new_cs_selector)))

    Iret_Protected_Or_IA32e_Mode operand_size (← Runtime.InitializedBits.read new_cs_selector) new_rip new_flags new_rsp
  | _ => throw .unmatchedCase

-- IRETD_0: CF
def Instructions.IRETD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

-- IRETD_1: CF
def Instructions.IRETD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

-- IRETD_2: CF
def Instructions.IRETD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

-- IRETQ: CF
-- CPUID group: LONGMODE
def Instructions.IRETQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

-- IRET_0: CF
def Instructions.IRET_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

-- IRET_1: CF
def Instructions.IRET_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

-- IRET_2: CF
def Instructions.IRET_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.IRET operand_size

end X86

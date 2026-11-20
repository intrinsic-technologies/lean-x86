-- Generated from data/instruction/LLDT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: a98db65a5704c52c4ae9f6c3698ed46a0e0d64f038ca2e777537bf0181758c0d
-- Description: data/sdm/LLDT.docbook
-- Loads the source operand into the segment selector field of the local descriptor table register
-- (LDTR).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LLDT)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Descriptor_High
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Canonical_Wrt_Max_Size
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Load_Segment_Descriptor_High
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Read_GPR
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Std.Bits.Is_Zero
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Max_Linear_Address]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.LLDT
    (segment_selector : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  let ldtr_selector : Segment_Selector := segment_selector

  if (← Is_Local_Segment_Selector ldtr_selector) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector ldtr_selector))

  if (← Is_Null_Segment_Selector ldtr_selector) then
    LDTR.assign (← Null_Segment (← get).LDTR)
    LDTR.setselector ldtr_selector
  else
    let mut new_ldtr : Segment ← Load_Segment_Descriptor ldtr_selector (← get).LDTR false

    if ((← Get_Segment_Type new_ldtr) != Segment_Type.System_LDT) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector ldtr_selector))

    if ((← Segment_Descriptor.P.partial new_ldtr.descriptor) == 0) then
      liftM (Report_Segment_Not_Present (← Get_Error_Code_From_Selector ldtr_selector))

    if (← In_64Bit_Mode) then
      new_ldtr := { new_ldtr with descriptor_high := Runtime.InitializedBits.ofValue (← Load_Segment_Descriptor_High ldtr_selector) }

      if (not (← Is_Canonical_Wrt_Max_Size (← Get_Segment_Base new_ldtr)) or not (← Std.Bits.Is_Zero (size := 5) (← Descriptor_High.Type2.partial new_ldtr.descriptor_high))) then
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector ldtr_selector))

    modify ({ · with LDTR := new_ldtr })

-- LLDT_GPR16: 0F 00 /2
def Instructions.LLDT_GPR16
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let segment_selector : Bits 16 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_LDTR_TR

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.LLDT segment_selector

-- LLDT_MEMw: 0F 00 /2
def Instructions.LLDT_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_LDTR_TR

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let segment_selector : Bits 16 ← Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.LLDT segment_selector

end X86

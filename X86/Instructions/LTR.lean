-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 61d933ed1f86303542c7f15eb328b8536cce659c6c9adb31944baf3ff6039e24
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LTR)
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
import X86.Helpers.Read_GPR
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Store_Segment_Descriptor
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
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

-- Local LTR specification: validate and load an available TSS descriptor.
-- In 64-bit mode the upper descriptor's type field must be zero
-- (SDM Vol. 2A, LTR, Protected Mode Exceptions; Vol. 3A, 8.2.3).
-- Form checks enforce the instruction's privilege and mode requirements.
def Instructions.Operations.LTR (src : Bits 16) : Runtime.SpecM Exception (State σ) Unit := do
  let mut new_tr : Segment := ({
    selector := src,
    descriptor := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64),
    descriptor_high := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64),
    descriptor_valid := some false,
    is_stack := some false,
    is_code := some false,
    is_64bit_mode_data_segment := some false
  } : Segment)

  if (← Is_Null_Segment_Selector new_tr.selector) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if (← Is_Local_Segment_Selector new_tr.selector) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_tr.selector))

  new_tr := (← Load_Segment_Descriptor new_tr.selector (← get).TR false)
  if (← In_64Bit_Mode) then
    new_tr := { new_tr with descriptor_high := Runtime.InitializedBits.ofValue (← Load_Segment_Descriptor_High new_tr.selector) }

    if (not (← Is_Canonical_Wrt_Max_Size (← Get_Segment_Base new_tr)) or not (← Std.Bits.Is_Zero (size := 5) (← Descriptor_High.Type2.partial new_tr.descriptor_high))) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_tr.selector))

  let seg_type : Segment_Type ← Get_Segment_Type new_tr
  let available : Bool ← do
    if (← Current_Mode) == Execution_Mode.IA32e_Mode then
      pure (seg_type == Segment_Type.System_TSS_Available)
    else
      pure (seg_type == Segment_Type.System_16Bit_TSS_Available or seg_type == Segment_Type.System_TSS_Available)
  if (not available) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_tr.selector))

  if ((← Segment_Descriptor.P.partial new_tr.descriptor) == 0) then
    liftM (Report_Segment_Not_Present (← Get_Error_Code_From_Selector new_tr.selector))

  -- todo: Locked read-modify-write operation on the entire descriptor when setting busy flag
  let _ ← Load_Segment_Descriptor new_tr.selector (← get).TR false
  new_tr := { new_tr with descriptor := (← Segment_Descriptor.setR.partial new_tr.descriptor (1 : Runtime.Bit)) }
  Store_Segment_Descriptor new_tr false

  modify ({ · with TR := new_tr })

def Check_LTR (context : Instruction_Context) : Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  if (← (do
    let __check451 : Execution_Mode ← Current_Mode
    pure ((__check451 == Execution_Mode.Real_Address_Mode) || (__check451 == Execution_Mode.Virtual_8086_Mode)))) then
    liftM (Report_Invalid_Opcode)
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls2).Descriptor_Table_Exiting == 1) then
      VM_Exit VMX_EXIT_LDTR_TR
  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

def Instructions.LTR_GPR16
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src : Bits 16 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 16
  Check_LTR context
  modify ({ · with Next_IP := ip })
  Instructions.Operations.LTR src

def Instructions.LTR_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let (offset, segment, next_ip, relative, _) ← Effective_Address context.address_size context mod rm 1 ip
  let address : Bits 64 ← Handle_RIP_Relative_Address context.address_size relative offset next_ip
  Check_LTR context
  let src : Bits 16 ← Logical_Mem_Read segment address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip })
  Instructions.Operations.LTR src

end X86

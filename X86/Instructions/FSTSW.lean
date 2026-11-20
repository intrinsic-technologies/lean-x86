-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 6d44445459979ec47f00a80641f8f8f66a7c154047aadaa91d7c6a981f473247
-- Stores the current value of the x87 FPU status word in the destination location.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FSTSW%2FFNSTSW)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Synchronize
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
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
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.FNSTSW
    (is_ax_form : Bool) :
    Runtime.SpecM Exception (State σ) (Bits 16) := do
  if is_ax_form then
    FP87.Synchronize

  let result : FP87_Status_Type := (← get).FP87_Status

  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (← UNSPECIFIED (size := 1))
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  return result

-- FNSTSW_AX: DF E0
def Instructions.FNSTSW_AX
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let is_ax_form : Bool := true

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits 16 ← Instructions.Operations.FNSTSW is_ax_form

  AX_write result

-- FNSTSW_MEMmem16: DD /7
def Instructions.FNSTSW_MEMmem16
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let is_ax_form : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  let saved_status : FP87_Status_Type := (← get).FP87_Status
  try
    modify ({ · with Next_IP := next_ip0 })

    let result : Bits 16 ← Instructions.Operations.FNSTSW is_ax_form

    Logical_Mem_Write (size := 16) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

end X86

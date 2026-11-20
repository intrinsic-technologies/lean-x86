-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f4ed6a84f38535e49b26291cb746da803cb6c471536e2f6fdc81508f6befdda8
-- Moves the contents of a control register (CR0, CR2, CR3, CR4, or CR8) to a general-purpose
-- register or the contents of a general-purpose register to a control register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOV)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_16Bit_Task
import X86.Helpers.Is_CR3_Value_Valid
import X86.Helpers.Is_CR4_Value_Valid
import X86.Helpers.Read_CR
import X86.Helpers.Read_GPR
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Serialize_Instructions
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.UFloatCompare
import X86.Helpers.Unimplemented_Feature
import X86.Helpers.VMX.Check_CR0_Fixed_Bits
import X86.Helpers.VMX.Check_CR3_Target
import X86.Helpers.VMX.Check_CR4_Fixed_Bits
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.Helpers.Write_CR
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.CR0_Guest_Host_Mask.Binding σ]
  [X86.CR0_Read_Shadow.Binding σ]
  [X86.CR3_Target_Count.Binding σ]
  [X86.CR3_Target_Value0.Binding σ]
  [X86.CR3_Target_Value1.Binding σ]
  [X86.CR3_Target_Value2.Binding σ]
  [X86.CR3_Target_Value3.Binding σ]
  [X86.CR4_Guest_Host_Mask.Binding σ]
  [X86.CR4_Read_Shadow.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

def Instructions.Operations.MOV_from_CR
    (result_size : Int) (src : Bits 64) (cr_index : Int) :
    Runtime.SpecM Exception (State σ) (Bits result_size) := do
  Runtime.assert (result_size == 32 || result_size == 64)

  Serialize_Instructions
  let mut result : Bits result_size ← src[0 +: result_size]
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (cr_index == 0) then
      let cr0_guest_host_mask : CR0_Type ← CR0_Guest_Host_Mask (← get).Current_VMCS_Pointer
      let cr0_read_shadow : CR0_Type ← CR0_Read_Shadow (← get).Current_VMCS_Pointer
      result := (← cr0_read_shadow[0 +: result_size]) and (← cr0_guest_host_mask[0 +: result_size]) or (← result[0 +: result_size]) and ~~~ (← cr0_guest_host_mask[0 +: result_size])
    else
      if (cr_index == 4) then
        let cr4_guest_host_mask : CR4_Type ← CR4_Guest_Host_Mask (← get).Current_VMCS_Pointer
        let cr4_read_shadow : CR4_Type ← CR4_Read_Shadow (← get).Current_VMCS_Pointer
        result := (← cr4_read_shadow[0 +: result_size]) and (← cr4_guest_host_mask[0 +: result_size]) or (← result[0 +: result_size]) and ~~~ (← cr4_guest_host_mask[0 +: result_size])
      else
        if (cr_index == 8) then
          if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
            if ((← VM_Exec_Controls1).Use_TPR_Shadow == 1) then
              Unimplemented_Feature "APIC VTPR" false true
  return result

def Instructions.Operations.MOV_to_CR
    (src_size : Int) (src : Bits src_size) (cr_index : Int) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (src_size == 32 || src_size == 64)

  let mut result : Bits 64 ← Std.Bits.Zero_Extend (source_size := src_size) src 64

  match cr_index with
  | 0 => do
    Serialize_Instructions
    let mut new_cr0 : CR0_Type := result

    if ((← get).VMX_Operation_Mode != VMX_Operation_Type.Outside_VMX_Operation) then
      if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
        let cr0_guest_host_mask : CR0_Type ← CR0_Guest_Host_Mask (← get).Current_VMCS_Pointer
        let cr0_read_shadow : CR0_Type ← CR0_Read_Shadow (← get).Current_VMCS_Pointer

        if (not (← Std.Bits.Is_Zero (size := 64) (cr0_guest_host_mask and (new_cr0 xor cr0_read_shadow)))) then
          VM_Exit VMX_EXIT_CR_ACCESS

        new_cr0 := (← get).CR0 and cr0_guest_host_mask or new_cr0 and ~~~ cr0_guest_host_mask

      VMX.Check_CR0_Fixed_Bits new_cr0

    if (not (← Std.Bits.Is_Zero (size := 32) (← new_cr0[63:32]))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- General Protection fault is reported if an attempt is made to
    -- write invalid bit combinations in CR0
    if (CR0_Type.PG new_cr0 == 1 and CR0_Type.PE new_cr0 == 0) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if (CR0_Type.CD new_cr0 == 0 and CR0_Type.NW new_cr0 == 1) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if ((← CR4.CET) == 1 and (← CR0.WP) == 1 and CR0_Type.WP new_cr0 == 0) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if ((← In_64Bit_Mode) and CR0_Type.PG new_cr0 == 0) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if ((← Current_Mode) == Execution_Mode.IA32e_Mode and not (← In_64Bit_Mode) and (← CR4.PCIDE) == 1 and CR0_Type.PG new_cr0 == 0) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- IA-32e mode is enabled and an attempt is made to enable paging prior to enabling
    -- physical-address extensions (PAE)
    if ((← get).IA32_EFER.LME == 1 and (← CR4.PAE) == 0 and (← CR0.PG) == 0 and CR0_Type.PG new_cr0 == 1) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- If the current CS has the L-bit set on an attempt to activate IA-32e mode
    if ((← Segment_Descriptor.L.partial (← get).CS.descriptor) == 1 and (← get).IA32_EFER.LME == 1 and (← CR0.PG) == 0 and CR0_Type.PG new_cr0 == 1) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- The TR contains a 16-bit TSS on an attempt to activate IA-32e mode
    if ((← get).IA32_EFER.LME == 1 and (← CR0.PG) == 0 and CR0_Type.PG new_cr0 == 1 and (← Is_16Bit_Task (← get).TR)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- todo: reset monitor if paging mode changes
    -- todo: reload PDPTR cache under certain conditions

    -- CR0.ET remains set after any load of CR0
    -- attempts to clear this bit have no impact
    new_cr0 := CR0_Type.setET new_cr0 (1 : Runtime.Bit)

    IA32_EFER.setLMA (← Bit (CR0_Type.PG new_cr0 == 1 and (← get).IA32_EFER.LME == 1 and (← CR4.PAE) == 1))

    -- attempts to set reserved bits in CR0 are ignored
    new_cr0 := CR0_Type.setRESERVED new_cr0 (← Std.Bits.Zero 53)
    result := new_cr0

  | 1 => do
    Serialize_Instructions

  | 2 => do
    Serialize_Instructions

  | 3 => do
    Serialize_Instructions

    if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
      VMX.Check_CR3_Target result

    -- todo: load of CR3 affect PDPTR cache

    if ((← CR4.PCIDE) == 1) then
      -- If CR4.PCIDE := 1, Bit 63 of the source operand to MOV to CR3
      -- determines whether the instruction invalidates entries in the TLBs
      -- and the paging-structure caches. The instruction does not modify
      -- bit 63 of CR3, which is reserved and always 0
      result := (← setSliceChecked result 63 1 0)

    if (not (← Is_CR3_Value_Valid result)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  | 4 => do
    Serialize_Instructions

    let mut new_cr4 : CR4_Type := result

    if ((← get).VMX_Operation_Mode != VMX_Operation_Type.Outside_VMX_Operation) then
      if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
        let cr4_guest_host_mask : CR4_Type ← CR4_Guest_Host_Mask (← get).Current_VMCS_Pointer
        let cr4_read_shadow : CR4_Type ← CR4_Read_Shadow (← get).Current_VMCS_Pointer

        if (not (← Std.Bits.Is_Zero (size := 64) (cr4_guest_host_mask and (new_cr4 xor cr4_read_shadow)))) then
          VM_Exit VMX_EXIT_CR_ACCESS

        new_cr4 := (← get).CR4 and cr4_guest_host_mask or new_cr4 and ~~~ cr4_guest_host_mask

      VMX.Check_CR4_Fixed_Bits new_cr4

    if (not (← Std.Bits.Is_Zero (size := 36) (CR4_Type.RESERVED new_cr4))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if (not (← CPUID_PAE) and CR4_Type.PAE new_cr4 == 1) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if ((← get).IA32_EFER.LMA == 1) then
      if ((← CR4.PAE) == 1 and CR4_Type.PAE new_cr4 == 0) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

      if ((← CR4.LA57) != CR4_Type.LA57 new_cr4) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

      if ((← CR4.PCIDE) == 0 and CR4_Type.PCIDE new_cr4 == 1 and not (← Std.Bits.Is_Zero (size := 12) (← sliceInclusive (← get).CR3 11 0))) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
    else
      if (CR4_Type.PCIDE new_cr4 == 1) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    if (not (← Is_CR4_Value_Valid new_cr4)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    -- CR4.CET can be set only while CR0.WP is set (SDM Vol. 3, 2.5);
    -- the CR0 arm above enforces the converse (WP cannot be cleared while CET is set)
    if (CR4_Type.CET new_cr4 == 1 and (← CR0.WP) == 0) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    IA32_EFER.setLMA (← Bit ((← CR0.PG) == 1 and (← get).IA32_EFER.LME == 1 and CR4_Type.PAE new_cr4 == 1))

    -- Attempts to enable FRED when LMA=0 are ignored
    if ((← get).IA32_EFER.LMA == 0 and CR4_Type.FRED new_cr4 == 1) then
      new_cr4 := CR4_Type.setFRED new_cr4 (0 : Runtime.Bit)

    result := new_cr4

  | 8 => do
    if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
      if ((← VM_Exec_Controls1).CR8_Load_Exiting == 1) then
        VM_Exit VMX_EXIT_CR_ACCESS

      if ((← VM_Exec_Controls1).Use_TPR_Shadow == 1) then
        Unimplemented_Feature "APIC TPR virtualization" false true

    -- MOV CR* instructions, except for MOV CR8, are serializing instructions.
    -- MOV CR8 is not architecturally defined as a serializing instruction.
    if (not (← Std.Bits.Is_Zero (size := 60) (← result[63:4]))) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  | _ => do
    liftM (Report_Invalid_Opcode)
  return result

-- MOV_CR_GPR32_CR: 0F 20 /r
def Instructions.MOV_CR_GPR32_CR
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 32
  let cr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  if (context.rex_r4 == 1 or cr_index != 0 and cr_index != 2 and cr_index != 3 and cr_index != 4 and cr_index != 8) then
    liftM (Report_Invalid_Opcode)
  let src : Bits 64 ← Read_CR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (cr_index == 3 and (← VM_Exec_Controls1).CR3_Store_Exiting == 1) then
      VM_Exit VMX_EXIT_CR_ACCESS

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (cr_index == 8 and (← VM_Exec_Controls1).CR8_Store_Exiting == 1) then
      VM_Exit VMX_EXIT_CR_ACCESS

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOV_from_CR result_size src cr_index

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- MOV_CR_GPR64_CR: 0F 20 /r
def Instructions.MOV_CR_GPR64_CR
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 64
  let cr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  if (context.rex_r4 == 1 or cr_index != 0 and cr_index != 2 and cr_index != 3 and cr_index != 4 and cr_index != 8) then
    liftM (Report_Invalid_Opcode)
  let src : Bits 64 ← Read_CR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (cr_index == 3 and (← VM_Exec_Controls1).CR3_Store_Exiting == 1) then
      VM_Exit VMX_EXIT_CR_ACCESS

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if (cr_index == 8 and (← VM_Exec_Controls1).CR8_Store_Exiting == 1) then
      VM_Exit VMX_EXIT_CR_ACCESS

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOV_from_CR result_size src cr_index

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- MOV_CR_CR_GPR32: 0F 22 /r
def Instructions.MOV_CR_CR_GPR32
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src_size : Int := 32
  let cr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  if (context.rex_r4 == 1 or cr_index != 0 and cr_index != 2 and cr_index != 3 and cr_index != 4 and cr_index != 8) then
    liftM (Report_Invalid_Opcode)
  let src : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits 64 ← Instructions.Operations.MOV_to_CR src_size src cr_index

  Write_CR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOV_CR_CR_GPR64: 0F 22 /r
def Instructions.MOV_CR_CR_GPR64
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src_size : Int := 64
  let cr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  if (context.rex_r4 == 1 or cr_index != 0 and cr_index != 2 and cr_index != 3 and cr_index != 4 and cr_index != 8) then
    liftM (Report_Invalid_Opcode)
  let src : Bits 64 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits 64 ← Instructions.Operations.MOV_to_CR src_size src cr_index

  Write_CR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86

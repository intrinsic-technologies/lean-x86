-- Generated from data/instruction/FXRSTOR.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 93d557ae00a4d01a5ef0aa95f0e957f3ecb8c4897b31b0ba95bd0289cbb09cbf
-- Description: data/sdm/FXRSTOR.docbook
-- Reloads the x87 FPU, MMX technology, XMM, and MXCSR registers from the 512-byte memory image
-- specified in the source operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FXRSTOR)
import X86.Runtime
import X86.Helpers.Calculate_Offset
import X86.Helpers.Check_Alignment
import X86.Helpers.Check_Logical_Address_Is_Readable
import X86.Helpers.Check_MXCSR_Reserved_Bits
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Expand_Abridged_Tag_Word
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Aligned
import X86.Helpers.Is_Alignment_Checking_Enabled
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Segment
import X86.Helpers.Set_Canonical_Wrt_Max_Size
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.XMM
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
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Max_Linear_Address]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.FXRSTOR
    (is_FXRSTOR64 : Bool) (segment : Segment) (effective_address : Bits 64) (address_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let linear_address : Bits 64 ← Compute_Linear_Address segment effective_address (← get).CS

  if (← Is_Alignment_Checking_Enabled) then
    Check_Alignment linear_address 16
  if (not (← Is_Aligned (n := 64) linear_address 16)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  -- check readability of the last byte
  Check_Logical_Address_Is_Readable segment (← Calculate_Offset effective_address 511 address_size) 8

  let cw_sw : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset effective_address 0 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let tag_opcode : Bits 32 ← Logical_Mem_Read segment (← Calculate_Offset effective_address 4 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let fip_fcs : Bits 64 ← Logical_Mem_Read segment (← Calculate_Offset effective_address 8 address_size) 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let fdp_fds : Bits 64 ← Logical_Mem_Read segment (← Calculate_Offset effective_address 16 address_size) 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false

  let new_mxcsr : MXCSR_Type ← Logical_Mem_Read segment (← Calculate_Offset effective_address 24 address_size) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Check_MXCSR_Reserved_Bits new_mxcsr
  modify ({ · with MXCSR := new_mxcsr })

  -- begin to commit FP state
  FP87_Control.assign (← cw_sw[0 +: 16])
  FP87_Control.setRESERVED_ONE 1
  FP87_Control.setRESERVED_ZERO (← Std.Bits.Zero 4)

  FP87_Status.assign (← cw_sw[16 +: 16])
  FP87_Status.setES 0
  FP87_Status.setB 0

  FP87_FOP.assign (← tag_opcode[16 +: 11])

  if is_FXRSTOR64 then
    FP87_FIP.assign (← Set_Canonical_Wrt_Max_Size fip_fcs)
    FP87_FCS.assign (← Std.Bits.Zero 16)
    modify ({ · with FP87_FDP := fdp_fds })
    FP87_FDS.assign (← Std.Bits.Zero 16)
  else
    FP87_FIP.assign (← Std.Bits.Zero_Extend (source_size := 32) (← fip_fcs[0 +: 32]) 64)
    FP87_FCS.assign (← fip_fcs[32 +: 16])
    FP87_FDP.assign (← Std.Bits.Zero_Extend (source_size := 32) (← fdp_fds[0 +: 32]) 64)
    FP87_FDS.assign (← fdp_fds[32 +: 16])

  FP87.Process_Exceptions (← FP87_Status.Exception_Flags)

  -- FP registers
  let fp_offset : Int := 32
  for i in intRange (0 : Int) (7 : Int) do
    ST_write i (← Logical_Mem_Read segment (← Calculate_Offset effective_address (fp_offset + i * 16) address_size) 80 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)

  -- now that FP regsister are loaded, update tag word information
  FP87_Tag_Word.assign (← FP87.Expand_Abridged_Tag_Word (← tag_opcode[0 +: 8]))

  if ((← CR4.OSFXSR) == 1) then
    -- XMM registers
    let xmm_offset : Int := 160
    let num_xmm_regs : Int ← do
      if (← In_64Bit_Mode) then
        pure 16
      else
        pure 8
    for i in intRange (0 : Int) (num_xmm_regs - 1) do
      XMM_write i (← Logical_Mem_Read segment (← Calculate_Offset effective_address (xmm_offset + i * 16) address_size) 128 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)

-- FXRSTOR64_MEMmfpxenv: NP 0F AE /1
-- CPUID group: FXSAVE64
def Instructions.FXRSTOR64_MEMmfpxenv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let is_FXRSTOR64 : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FXRSTOR is_FXRSTOR64 segment effective_address address_size

-- FXRSTOR_MEMmfpxenv: NP 0F AE /1
-- CPUID group: FXSAVE
def Instructions.FXRSTOR_MEMmfpxenv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let is_FXRSTOR64 : Bool := false

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.FXRSTOR is_FXRSTOR64 segment effective_address address_size

end X86

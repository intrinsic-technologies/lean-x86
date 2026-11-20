-- Generated from data/instruction/SCAS-SCASB-SCASW-SCASD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c79a6890fa6b7fb70c457ac66f7f80ab0cb24ac07b13cdad0a321ac03b5e78d1
-- Description: data/sdm/SCAS-SCASB-SCASW-SCASD.docbook
-- In non-64-bit modes and in default 64-bit mode: this instruction compares a byte, word,
-- doubleword or quadword specified using a memory operand with the value in AL, AX, or EAX.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SCAS%2FSCASB%2FSCASW%2FSCASD)
import X86.Runtime
import X86.Helpers.Exception_Info
import X86.Helpers.Get_Repeat_String_Stride
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Parity_Even
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Subtract
import X86.Helpers.UFloatCompare
import X86.Helpers.Write_RCX
import X86.Helpers.Write_RDI
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.SCAN_STRING
    (address_size : Int) (operand_size : Int) (_context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let effective_segment : Segment ← do
    if (← In_64Bit_Mode) then
      Null_Segment (← get).ES
    else
      pure (← get).ES
  let effective_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) 64

  let src1 : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size)
  let src2 : Bits operand_size ← Logical_Mem_Read effective_segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false

  let size_in_bytes : Int ← Std.Integer.Positive_Divide operand_size 8
  let address_increment : Int ← do
    if (← RFLAGS.DF) == 0 then
      pure size_in_bytes
    else
      pure (- size_in_bytes)
  Write_RDI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) address_increment)

  let (result, carry_out, overflow, alternative_carry) ← Subtract (size := operand_size) src1 src2

  RFLAGS.setOF overflow
  RFLAGS.setSF (← (do Runtime.assert (decide (operand_size - 1 < operand_size)); Runtime.assert (decide (0 ≤ operand_size - 1)); pure (← result[operand_size - 1 +: 1])))
  RFLAGS.setZF (← Bit (← Std.Bits.Is_Zero (size := operand_size) result))
  RFLAGS.setAF alternative_carry
  RFLAGS.setPF (← Bit (← Std.Bits.Is_Parity_Even (size := 8) (← (do Runtime.assert (decide (8 ≤ operand_size)); pure (← result[0 +: 8])))))
  RFLAGS.setCF carry_out

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASB: F2 AE
def Instructions.REPNE_SCASB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASB: F3 AE
def Instructions.REPE_SCASB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASD_0: F2 AF
def Instructions.REPNE_SCASD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASD_1: F2 AF
def Instructions.REPNE_SCASD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASD_2: F2 AF
def Instructions.REPNE_SCASD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASQ: F2 AF
-- CPUID group: LONGMODE
def Instructions.REPNE_SCASQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASW_0: F2 AF
def Instructions.REPNE_SCASW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASW_1: F2 AF
def Instructions.REPNE_SCASW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPNE_SCASW_2: F2 AF
def Instructions.REPNE_SCASW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 0))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 0))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASD_0: F3 AF
def Instructions.REPE_SCASD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASD_1: F3 AF
def Instructions.REPE_SCASD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASD_2: F3 AF
def Instructions.REPE_SCASD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASQ: F3 AF
-- CPUID group: LONGMODE
def Instructions.REPE_SCASQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASW_0: F3 AF
def Instructions.REPE_SCASW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASW_1: F3 AF
def Instructions.REPE_SCASW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

open scoped X86.Runtime.PartialSyntax in
-- REPE_SCASW_2: F3 AF
def Instructions.REPE_SCASW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let old_rflags : RFLAGS_Type := (← get).RFLAGS
  try
    let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))
    if (count == 0) then
      modify ({ · with Repeat_String_Operation := false })
    else
      let mut stride : Int ← Runtime.liftTotal (Get_Repeat_String_Stride operand_size count)
      while decide (stride > 0) do
        Runtime.liftTotal (Instructions.Operations.SCAN_STRING address_size operand_size context)
        Runtime.liftTotal (Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size))) 1))
        Runtime.liftTotal (Repeat_String_Operation.assign ((← Runtime.liftTotal (RFLAGS.ZF)) == 1))
        stride := stride - 1
        if (not (← get).Repeat_String_Operation) then
          stride := 0
    Runtime.liftTotal (Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (RCX)) 0 address_size)))) and (← Runtime.liftTotal (RFLAGS.ZF)) == 1))
    if (← get).Repeat_String_Operation then
      -- delay update of RFLAGS until the end of the repeat operation
      modify ({ · with RFLAGS := old_rflags })
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      -- Restore entry flags on faulting exits, but keep completed RCX/RDI updates.
      modify ({ · with RFLAGS := old_rflags })
      throw (.raised (↑({
        vector := e.vector,
        linear_address := e.linear_address,
        error_code := e.error_code
      } : Exception_Info) : Exception))
    | _ => throw exception

-- SCASB: NFx AE
def Instructions.SCASB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASD_0: NFx AF
def Instructions.SCASD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASQ: NFx AF
-- CPUID group: LONGMODE
def Instructions.SCASQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASW_1: NFx AF
def Instructions.SCASW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASW_2: NFx AF
def Instructions.SCASW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASD_1: NP AF
def Instructions.SCASD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASD_2: NP AF
def Instructions.SCASD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

-- SCASW_0: NP AF
def Instructions.SCASW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SCAN_STRING address_size operand_size context

end X86

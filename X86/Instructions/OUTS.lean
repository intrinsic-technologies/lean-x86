-- Generated from data/instruction/OUTS-OUTSB-OUTSW-OUTSD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 7d3783491914be2e27a625fafce9a6dd9c5832c163bb9538a68646c5811e2310
-- Description: data/sdm/OUTS-OUTSB-OUTSW-OUTSD.docbook
-- Copies data from the source operand (second operand) to the I/O port specified with the
-- destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=OUTS%2FOUTSB%2FOUTSW%2FOUTSD)
import X86.Runtime
import X86.Helpers.Check_IO_Breakpoint
import X86.Helpers.Check_IO_Permissions
import X86.Helpers.Get_Repeat_String_Stride
import X86.Helpers.IO_Write
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.VMX.Check_IO_Bitmap
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.Helpers.Write_RCX
import X86.Helpers.Write_RSI
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]
  [X86.Helpers.IO_Write.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.OUT_STRING
    (operand_size : Int) (address_size : Int) (segment : Segment) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let port : Bits 32 ← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).Use_IO_Bitmaps == 1) then
      VMX.Check_IO_Bitmap port (← Std.Integer.Positive_Divide operand_size 8)
    else
      if ((← VM_Exec_Controls1).Unconditional_IO_Exiting == 1) then
        VM_Exit VMX_EXIT_IO_INSTRUCTION

  let value : Bits operand_size ← Logical_Mem_Read segment (← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) 64) operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Check_IO_Breakpoint port (← Std.Integer.Positive_Divide operand_size 8)
  IO_Write port operand_size value
  let new_rsi : Bits address_size ← do
    if (← RFLAGS.DF) == 1 then
      Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) (← Std.Integer.Positive_Divide operand_size 8)
    else
      Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) (← Std.Integer.Positive_Divide operand_size 8)
  Write_RSI (size := address_size) new_rsi

-- REP_OUTSB_1: F2 6E
def Instructions.REP_OUTSB_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSB_0: F3 6E
def Instructions.REP_OUTSB_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_4: F2 6F
def Instructions.REP_OUTSD_4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_5: F2 6F
def Instructions.REP_OUTSD_5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_6: F2 6F
def Instructions.REP_OUTSD_6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_7: F2 6F
def Instructions.REP_OUTSD_7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSW_3: F2 6F
def Instructions.REP_OUTSW_3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSW_4: F2 6F
def Instructions.REP_OUTSW_4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSW_5: F2 6F
def Instructions.REP_OUTSW_5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_0: F3 6F
def Instructions.REP_OUTSD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_1: F3 6F
def Instructions.REP_OUTSD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_2: F3 6F
def Instructions.REP_OUTSD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSD_3: F3 6F
def Instructions.REP_OUTSD_3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSW_0: F3 6F
def Instructions.REP_OUTSW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSW_1: F3 6F
def Instructions.REP_OUTSW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_OUTSW_2: F3 6F
def Instructions.REP_OUTSW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
    -- I/O permissions get checked even for zero-size repeat
    Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  else
    let first_iteration : Bool := not (← get).Repeat_String_Operation
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    if first_iteration then
      -- Check I/O permissions on the first iteration only
      Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.OUT_STRING operand_size address_size segment
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- OUTSB: NFx 6E
def Instructions.OUTSB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSD_0: NFx 6F
def Instructions.OUTSD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSD_3: NFx 6F
def Instructions.OUTSD_3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSW_1: NFx 6F
def Instructions.OUTSW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSW_2: NFx 6F
def Instructions.OUTSW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSD_1: NP 6F
def Instructions.OUTSD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSD_2: NP 6F
def Instructions.OUTSD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

-- OUTSW_0: NP 6F
def Instructions.OUTSW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let segment : Segment := context.segment

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.OUT_STRING operand_size address_size segment

end X86

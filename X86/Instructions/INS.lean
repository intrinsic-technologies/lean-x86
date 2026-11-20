-- Generated from data/instruction/INS-INSB-INSW-INSD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 71486c1c1e12184fce4d4feca578301df6c8926097f3ee907e333c1fdd6c89b0
-- Description: data/sdm/INS-INSB-INSW-INSD.docbook
-- Copies the data from the I/O port specified with the source operand (second operand) to the
-- destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=INS%2FINSB%2FINSW%2FINSD)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Data_Write_Breakpoint
import X86.Helpers.Check_IO_Breakpoint
import X86.Helpers.Check_IO_Permissions
import X86.Helpers.Check_Write_Permission
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Get_Repeat_String_Stride
import X86.Helpers.IO_Read
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Physical_Mem_Write
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.Helpers.VMX.Check_IO_Bitmap
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
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
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]
  [X86.Helpers.IO_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.IN_STRING
    (address_size : Int) (operand_size : Int) (_context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let port : Bits 32 ← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).Use_IO_Bitmaps == 1) then
      VMX.Check_IO_Bitmap port (← Std.Integer.Positive_Divide operand_size 8)
    else
      if ((← VM_Exec_Controls1).Unconditional_IO_Exiting == 1) then
        VM_Exit VMX_EXIT_IO_INSTRUCTION

  Check_IO_Breakpoint port (← Std.Integer.Positive_Divide operand_size 8)

  -- address translation of the destination must be done before reading from
  -- the I/O port as a fault will prevent I/O access from happening
  let segment : Segment ← do
    if (← In_64Bit_Mode) then
      Null_Segment (← get).ES
    else
      pure (← get).ES
  let offset : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) 64
  Check_Write_Permission segment
  let logical : Address_Translation ← Create_Logical_Address segment offset operand_size
  let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Normal_Alignment (← get).CS false
  let size_in_bytes : Int ← Std.Integer.Positive_Divide operand_size 8
  Check_Data_Write_Breakpoint linear.linear_address size_in_bytes
  let physical : Address_Translation ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Write

  let data : Bits operand_size ← IO_Read port operand_size

  Physical_Mem_Write physical operand_size data

  let address_increment : Int ← do
    if (← RFLAGS.DF) == 0 then
      pure size_in_bytes
    else
      pure (- size_in_bytes)
  Write_RDI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) address_increment)

-- REP_INSB_1: F2 6C
def Instructions.REP_INSB_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSB_0: F3 6C
def Instructions.REP_INSB_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_4: F2 6D
def Instructions.REP_INSD_4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_5: F2 6D
def Instructions.REP_INSD_5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_6: F2 6D
def Instructions.REP_INSD_6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_7: F2 6D
def Instructions.REP_INSD_7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSW_3: F2 6D
def Instructions.REP_INSW_3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSW_4: F2 6D
def Instructions.REP_INSW_4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSW_5: F2 6D
def Instructions.REP_INSW_5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_0: F3 6D
def Instructions.REP_INSD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_1: F3 6D
def Instructions.REP_INSD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_2: F3 6D
def Instructions.REP_INSD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSD_3: F3 6D
def Instructions.REP_INSD_3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSW_0: F3 6D
def Instructions.REP_INSW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSW_1: F3 6D
def Instructions.REP_INSW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_INSW_2: F3 6D
def Instructions.REP_INSW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

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
      Instructions.Operations.IN_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- INSB: NFx 6C
def Instructions.INSB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSD_0: NFx 6D
def Instructions.INSD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSD_3: NFx 6D
def Instructions.INSD_3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSW_1: NFx 6D
def Instructions.INSW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSW_2: NFx 6D
def Instructions.INSW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSD_1: NP 6D
def Instructions.INSD_1
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

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSD_2: NP 6D
def Instructions.INSD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

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
  Instructions.Operations.IN_STRING address_size operand_size context

-- INSW_0: NP 6D
def Instructions.INSW_0
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

  Check_IO_Permissions (← Std.Bits.Zero_Extend (source_size := 16) (← DX) 32) (← Std.Integer.Positive_Divide operand_size 8)
  Instructions.Operations.IN_STRING address_size operand_size context

end X86

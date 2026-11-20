-- Generated from data/instruction/MOVS-MOVSB-MOVSW-MOVSD-MOVSQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 595e811975ce8731b9deb8f1febf8a7393183500ae7e5ab22cda26aa6df288ff
-- Description: data/sdm/MOVS-MOVSB-MOVSW-MOVSD-MOVSQ.docbook
-- Moves the byte, word, or doubleword specified with the second operand (source operand) to the
-- location specified with the first operand (destination operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOVS%2FMOVSB%2FMOVSW%2FMOVSD%2FMOVSQ)
import X86.Runtime
import X86.Helpers.Get_Repeat_String_Stride
import X86.Helpers.Instruction_Context
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Write_RCX
import X86.Instructions.MOVSD
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- REP_MOVSB_1: F2 A4
def Instructions.REP_MOVSB_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSB_0: F3 A4
def Instructions.REP_MOVSB_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSD_3: F2 A5
def Instructions.REP_MOVSD_3
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSD_4: F2 A5
def Instructions.REP_MOVSD_4
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSD_5: F2 A5
def Instructions.REP_MOVSD_5
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

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSQ_1: F2 A5
-- CPUID group: LONGMODE
def Instructions.REP_MOVSQ_1
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

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSW_3: F2 A5
def Instructions.REP_MOVSW_3
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSW_4: F2 A5
def Instructions.REP_MOVSW_4
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSW_5: F2 A5
def Instructions.REP_MOVSW_5
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

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSD_0: F3 A5
def Instructions.REP_MOVSD_0
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSD_1: F3 A5
def Instructions.REP_MOVSD_1
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSD_2: F3 A5
def Instructions.REP_MOVSD_2
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

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSQ_0: F3 A5
-- CPUID group: LONGMODE
def Instructions.REP_MOVSQ_0
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

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSW_0: F3 A5
def Instructions.REP_MOVSW_0
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSW_1: F3 A5
def Instructions.REP_MOVSW_1
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
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_MOVSW_2: F3 A5
def Instructions.REP_MOVSW_2
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

  modify ({ · with Next_IP := ip })

  let count : Int := Unsigned (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))
  if (count == 0) then
    modify ({ · with Repeat_String_Operation := false })
  else
    let stride : Int ← Get_Repeat_String_Stride operand_size count
    for _i in intRange (0 : Int) (stride - 1) do
      Instructions.Operations.MOV_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- MOVSB: NFx A4
def Instructions.MOVSB
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

  Instructions.Operations.MOV_STRING address_size operand_size context

-- MOVSD_0 is defined in MOVSD.xml.
-- MOVSQ: NFx A5
-- CPUID group: LONGMODE
def Instructions.MOVSQ
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

  Instructions.Operations.MOV_STRING address_size operand_size context

-- MOVSW_1: NFx A5
def Instructions.MOVSW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MOV_STRING address_size operand_size context

-- MOVSW_2: NFx A5
def Instructions.MOVSW_2
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

  Instructions.Operations.MOV_STRING address_size operand_size context

-- MOVSD_1 is defined in MOVSD.xml.
-- MOVSD_2 is defined in MOVSD.xml.
-- MOVSW_0: NP A5
def Instructions.MOVSW_0
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

  Instructions.Operations.MOV_STRING address_size operand_size context

end X86

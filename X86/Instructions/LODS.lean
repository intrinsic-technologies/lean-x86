-- Generated from data/instruction/LODS-LODSB-LODSW-LODSD-LODSQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5f1d80eb2e7cf8cd4755d03b2ce66587c5c9d4f1b37d69f8b3e00b5788f92849
-- Description: data/sdm/LODS-LODSB-LODSW-LODSD-LODSQ.docbook
-- Loads a byte, word, or doubleword from the source operand into the AL, AX, or EAX register,
-- respectively.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LODS%2FLODSB%2FLODSW%2FLODSD%2FLODSQ)
import X86.Runtime
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Get_Repeat_String_Stride
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
import X86.Helpers.Write_RAX
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
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.LOAD_STRING
    (address_size : Int) (operand_size : Int) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let effective_segment : Segment ← Get_Effective_Segment context (← get).DS
  let effective_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) 64
  let data : Bits operand_size ← Logical_Mem_Read effective_segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Write_RAX (size := operand_size) data

  let size_in_bytes : Int ← Std.Integer.Positive_Divide operand_size 8
  let address_increment : Int ← do
    if (← RFLAGS.DF) == 0 then
      pure size_in_bytes
    else
      pure (- size_in_bytes)
  Write_RSI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) address_increment)

-- REP_LODSB_1: F2 AC
def Instructions.REP_LODSB_1
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSB_0: F3 AC
def Instructions.REP_LODSB_0
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSD_3: F2 AD
def Instructions.REP_LODSD_3
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSD_4: F2 AD
def Instructions.REP_LODSD_4
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSD_5: F2 AD
def Instructions.REP_LODSD_5
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSQ_1: F2 AD
-- CPUID group: LONGMODE
def Instructions.REP_LODSQ_1
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSW_3: F2 AD
def Instructions.REP_LODSW_3
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSW_4: F2 AD
def Instructions.REP_LODSW_4
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSW_5: F2 AD
def Instructions.REP_LODSW_5
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSD_0: F3 AD
def Instructions.REP_LODSD_0
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSD_1: F3 AD
def Instructions.REP_LODSD_1
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSD_2: F3 AD
def Instructions.REP_LODSD_2
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSQ_0: F3 AD
-- CPUID group: LONGMODE
def Instructions.REP_LODSQ_0
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSW_0: F3 AD
def Instructions.REP_LODSW_0
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSW_1: F3 AD
def Instructions.REP_LODSW_1
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- REP_LODSW_2: F3 AD
def Instructions.REP_LODSW_2
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
      Instructions.Operations.LOAD_STRING address_size operand_size context
      Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
  Repeat_String_Operation.assign (not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))))

-- LODSB: NFx AC
def Instructions.LODSB
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

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSD_0: NFx AD
def Instructions.LODSD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSQ: NFx AD
-- CPUID group: LONGMODE
def Instructions.LODSQ
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

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSW_1: NFx AD
def Instructions.LODSW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSW_2: NFx AD
def Instructions.LODSW_2
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

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSD_1: NP AD
def Instructions.LODSD_1
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

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSD_2: NP AD
def Instructions.LODSD_2
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

  Instructions.Operations.LOAD_STRING address_size operand_size context

-- LODSW_0: NP AD
def Instructions.LODSW_0
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

  Instructions.Operations.LOAD_STRING address_size operand_size context

end X86

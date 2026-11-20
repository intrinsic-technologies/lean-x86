-- Generated from data/instruction/Jcc.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 2948fe4ca6e810a9f0305ba33253f73819f2caa200caa4dc37d9a8dc3cb414ec
-- Description: data/sdm/Jcc.docbook
-- Jump if Condition Is Met
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=Jcc)
import X86.Runtime
import X86.Helpers.Branch_Near
import X86.Helpers.Check_New_RIP
import X86.Helpers.Condition_Holds
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Registers
import X86.Helpers.Relative_Branch_Wrap
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.Jcc
    (operand_size : Int) (context : Instruction_Context) (cond : Bits 4) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  if (← Condition_Holds cond) then
    let new_rip : Bits 64 ← Relative_Branch_Wrap context.operand_size ((← get).Next_IP + (← Std.Bits.Sign_Extend (source_size := operand_size) src 64))
    Check_New_RIP (← get).CS new_rip
    Branch_Near new_rip

def Instructions.Operations.JCXZ
    (operand_size : Int) (address_size : Int) (context : Instruction_Context) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  -- the counter register (CX/ECX/RCX) is selected by the address-size attribute,
  -- not by the operand-size attribute (which here is the branch displacement size)
  if (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))) then
    let new_rip : Bits 64 ← Relative_Branch_Wrap context.operand_size ((← get).Next_IP + (← Std.Bits.Sign_Extend (source_size := operand_size) src 64))
    Check_New_RIP (← get).CS new_rip
    Branch_Near new_rip

-- JO_RELBRb_0: 70 cb
def Instructions.JO_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JO_RELBRb_1: 70 cb
def Instructions.JO_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JO_RELBRb_2: 70 cb
def Instructions.JO_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNO_RELBRb_0: 71 cb
def Instructions.JNO_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNO_RELBRb_1: 71 cb
def Instructions.JNO_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNO_RELBRb_2: 71 cb
def Instructions.JNO_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JB_RELBRb_0: 72 cb
def Instructions.JB_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JB_RELBRb_1: 72 cb
def Instructions.JB_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JB_RELBRb_2: 72 cb
def Instructions.JB_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNB_RELBRb_0: 73 cb
def Instructions.JNB_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNB_RELBRb_1: 73 cb
def Instructions.JNB_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNB_RELBRb_2: 73 cb
def Instructions.JNB_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JZ_RELBRb_0: 74 cb
def Instructions.JZ_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JZ_RELBRb_1: 74 cb
def Instructions.JZ_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JZ_RELBRb_2: 74 cb
def Instructions.JZ_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNZ_RELBRb_0: 75 cb
def Instructions.JNZ_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNZ_RELBRb_1: 75 cb
def Instructions.JNZ_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNZ_RELBRb_2: 75 cb
def Instructions.JNZ_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JBE_RELBRb_0: 76 cb
def Instructions.JBE_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JBE_RELBRb_1: 76 cb
def Instructions.JBE_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JBE_RELBRb_2: 76 cb
def Instructions.JBE_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNBE_RELBRb_0: 77 cb
def Instructions.JNBE_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNBE_RELBRb_1: 77 cb
def Instructions.JNBE_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNBE_RELBRb_2: 77 cb
def Instructions.JNBE_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JS_RELBRb_0: 78 cb
def Instructions.JS_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JS_RELBRb_1: 78 cb
def Instructions.JS_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JS_RELBRb_2: 78 cb
def Instructions.JS_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNS_RELBRb_0: 79 cb
def Instructions.JNS_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNS_RELBRb_1: 79 cb
def Instructions.JNS_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNS_RELBRb_2: 79 cb
def Instructions.JNS_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JP_RELBRb_0: 7A cb
def Instructions.JP_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JP_RELBRb_1: 7A cb
def Instructions.JP_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JP_RELBRb_2: 7A cb
def Instructions.JP_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNP_RELBRb_0: 7B cb
def Instructions.JNP_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNP_RELBRb_1: 7B cb
def Instructions.JNP_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNP_RELBRb_2: 7B cb
def Instructions.JNP_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JL_RELBRb_0: 7C cb
def Instructions.JL_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JL_RELBRb_1: 7C cb
def Instructions.JL_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JL_RELBRb_2: 7C cb
def Instructions.JL_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNL_RELBRb_0: 7D cb
def Instructions.JNL_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNL_RELBRb_1: 7D cb
def Instructions.JNL_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNL_RELBRb_2: 7D cb
def Instructions.JNL_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JLE_RELBRb_0: 7E cb
def Instructions.JLE_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JLE_RELBRb_1: 7E cb
def Instructions.JLE_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JLE_RELBRb_2: 7E cb
def Instructions.JLE_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNLE_RELBRb_0: 7F cb
def Instructions.JNLE_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNLE_RELBRb_1: 7F cb
def Instructions.JNLE_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JNLE_RELBRb_2: 7F cb
def Instructions.JNLE_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.Jcc operand_size context cond src

-- JO_RELBRd_0: 0F 80 cd
def Instructions.JO_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JO_RELBRd_1: 0F 80 cd
def Instructions.JO_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JO_RELBRz: 0F 80 ct
def Instructions.JO_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNO_RELBRd_0: 0F 81 cd
def Instructions.JNO_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNO_RELBRd_1: 0F 81 cd
def Instructions.JNO_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNO_RELBRz: 0F 81 ct
def Instructions.JNO_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JB_RELBRd_0: 0F 82 cd
def Instructions.JB_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JB_RELBRd_1: 0F 82 cd
def Instructions.JB_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JB_RELBRz: 0F 82 ct
def Instructions.JB_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNB_RELBRd_0: 0F 83 cd
def Instructions.JNB_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNB_RELBRd_1: 0F 83 cd
def Instructions.JNB_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNB_RELBRz: 0F 83 ct
def Instructions.JNB_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JZ_RELBRd_0: 0F 84 cd
def Instructions.JZ_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JZ_RELBRd_1: 0F 84 cd
def Instructions.JZ_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JZ_RELBRz: 0F 84 ct
def Instructions.JZ_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNZ_RELBRd_0: 0F 85 cd
def Instructions.JNZ_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNZ_RELBRd_1: 0F 85 cd
def Instructions.JNZ_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNZ_RELBRz: 0F 85 ct
def Instructions.JNZ_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JBE_RELBRd_0: 0F 86 cd
def Instructions.JBE_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JBE_RELBRd_1: 0F 86 cd
def Instructions.JBE_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JBE_RELBRz: 0F 86 ct
def Instructions.JBE_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNBE_RELBRd_0: 0F 87 cd
def Instructions.JNBE_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNBE_RELBRd_1: 0F 87 cd
def Instructions.JNBE_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNBE_RELBRz: 0F 87 ct
def Instructions.JNBE_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JS_RELBRd_0: 0F 88 cd
def Instructions.JS_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JS_RELBRd_1: 0F 88 cd
def Instructions.JS_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JS_RELBRz: 0F 88 ct
def Instructions.JS_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNS_RELBRd_0: 0F 89 cd
def Instructions.JNS_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNS_RELBRd_1: 0F 89 cd
def Instructions.JNS_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNS_RELBRz: 0F 89 ct
def Instructions.JNS_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JP_RELBRd_0: 0F 8A cd
def Instructions.JP_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JP_RELBRd_1: 0F 8A cd
def Instructions.JP_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JP_RELBRz: 0F 8A ct
def Instructions.JP_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNP_RELBRd_0: 0F 8B cd
def Instructions.JNP_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNP_RELBRd_1: 0F 8B cd
def Instructions.JNP_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNP_RELBRz: 0F 8B ct
def Instructions.JNP_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JL_RELBRd_0: 0F 8C cd
def Instructions.JL_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JL_RELBRd_1: 0F 8C cd
def Instructions.JL_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JL_RELBRz: 0F 8C ct
def Instructions.JL_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNL_RELBRd_0: 0F 8D cd
def Instructions.JNL_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNL_RELBRd_1: 0F 8D cd
def Instructions.JNL_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNL_RELBRz: 0F 8D ct
def Instructions.JNL_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JLE_RELBRd_0: 0F 8E cd
def Instructions.JLE_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JLE_RELBRd_1: 0F 8E cd
def Instructions.JLE_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JLE_RELBRz: 0F 8E ct
def Instructions.JLE_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JNLE_RELBRd_0: 0F 8F cd
def Instructions.JNLE_RELBRd_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNLE_RELBRd_1: 0F 8F cd
def Instructions.JNLE_RELBRd_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64
  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 32) (← Mem_Fetch ip 32) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  Instructions.Operations.Jcc operand_size context cond src

-- JNLE_RELBRz: 0F 8F ct
def Instructions.JNLE_RELBRz
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let cond : Bits 4 ← opcode[3:0]

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.Jcc operand_size context cond src

-- JCXZ_RELBRb: E3 cb
def Instructions.JCXZ_RELBRb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.JCXZ operand_size address_size context src

-- JECXZ_RELBRb_0: E3 cb
def Instructions.JECXZ_RELBRb_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.JCXZ operand_size address_size context src

-- JECXZ_RELBRb_1: E3 cb
def Instructions.JECXZ_RELBRb_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.JCXZ operand_size address_size context src

-- JRCXZ_RELBRb: E3 cb
-- CPUID group: LONGMODE
def Instructions.JRCXZ_RELBRb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.JCXZ operand_size address_size context src

end X86

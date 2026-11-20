-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ADD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ADD where
  -- ADD_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b:i8
  | ADD_AL_IMMb (imm0 : Immediate)
  -- ADD_GPR8_GPR8_00: REG0=GPR8_B():rw REG1=GPR8_R():r
  | ADD_GPR8_GPR8_00 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- ADD_GPR8_GPR8_02: REG0=GPR8_R():rw REG1=GPR8_B():r
  | ADD_GPR8_GPR8_02 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- ADD_GPR8_IMMb_80r0: REG0=GPR8_B():rw IMM0:r:b
  | ADD_GPR8_IMMb_80r0 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- ADD_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | ADD_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- ADD_GPRv_GPRv_01: REG0=GPRv_B():rw REG1=GPRv_R():r
  | ADD_GPRv_GPRv_01 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- ADD_GPRv_GPRv_03: REG0=GPRv_R():rw REG1=GPRv_B():r
  | ADD_GPRv_GPRv_03 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- ADD_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | ADD_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- ADD_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | ADD_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- ADD_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | ADD_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- ADD_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | ADD_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- ADD_LOCK_MEMb_IMMb_80r0: MEM0:rw:b IMM0:r:b:i8
  | ADD_LOCK_MEMb_IMMb_80r0 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADD_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | ADD_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- ADD_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | ADD_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADD_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | ADD_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADD_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | ADD_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- ADD_MEMb_IMMb_80r0: MEM0:rw:b IMM0:r:b:i8
  | ADD_MEMb_IMMb_80r0 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADD_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | ADD_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- ADD_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | ADD_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADD_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | ADD_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADD_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | ADD_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.ADD.xedForm : Forms.ADD → XedForm
  | .ADD_AL_IMMb _ => .ADD_AL_IMMb
  | .ADD_GPR8_GPR8_00 _ _ => .ADD_GPR8_GPR8_00
  | .ADD_GPR8_GPR8_02 _ _ => .ADD_GPR8_GPR8_02
  | .ADD_GPR8_IMMb_80r0 _ _ => .ADD_GPR8_IMMb_80r0
  | .ADD_GPR8_MEMb _ _ => .ADD_GPR8_MEMb
  | .ADD_GPRv_GPRv_01 _ _ => .ADD_GPRv_GPRv_01
  | .ADD_GPRv_GPRv_03 _ _ => .ADD_GPRv_GPRv_03
  | .ADD_GPRv_IMMb _ _ => .ADD_GPRv_IMMb
  | .ADD_GPRv_IMMz _ _ => .ADD_GPRv_IMMz
  | .ADD_GPRv_MEMv _ _ => .ADD_GPRv_MEMv
  | .ADD_LOCK_MEMb_GPR8 _ _ => .ADD_LOCK_MEMb_GPR8
  | .ADD_LOCK_MEMb_IMMb_80r0 _ _ => .ADD_LOCK_MEMb_IMMb_80r0
  | .ADD_LOCK_MEMv_GPRv _ _ => .ADD_LOCK_MEMv_GPRv
  | .ADD_LOCK_MEMv_IMMb _ _ => .ADD_LOCK_MEMv_IMMb
  | .ADD_LOCK_MEMv_IMMz _ _ => .ADD_LOCK_MEMv_IMMz
  | .ADD_MEMb_GPR8 _ _ => .ADD_MEMb_GPR8
  | .ADD_MEMb_IMMb_80r0 _ _ => .ADD_MEMb_IMMb_80r0
  | .ADD_MEMv_GPRv _ _ => .ADD_MEMv_GPRv
  | .ADD_MEMv_IMMb _ _ => .ADD_MEMv_IMMb
  | .ADD_MEMv_IMMz _ _ => .ADD_MEMv_IMMz
  | .ADD_OrAX_IMMz _ _ => .ADD_OrAX_IMMz

def Forms.ADD.encodingFits : Forms.ADD → Bool
  | .ADD_AL_IMMb imm0 => imm0.encodingFits
  | .ADD_GPR8_GPR8_00 _ _ => true
  | .ADD_GPR8_GPR8_02 _ _ => true
  | .ADD_GPR8_IMMb_80r0 _ imm0 => imm0.encodingFits
  | .ADD_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .ADD_GPRv_GPRv_01 _ _ => true
  | .ADD_GPRv_GPRv_03 _ _ => true
  | .ADD_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .ADD_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .ADD_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .ADD_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .ADD_LOCK_MEMb_IMMb_80r0 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADD_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .ADD_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADD_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADD_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .ADD_MEMb_IMMb_80r0 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADD_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .ADD_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADD_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADD_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax

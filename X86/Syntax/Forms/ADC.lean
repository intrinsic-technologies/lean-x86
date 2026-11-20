-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ADC.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ADC where
  -- ADC_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b:i8
  | ADC_AL_IMMb (imm0 : Immediate)
  -- ADC_GPR8_GPR8_10: REG0=GPR8_B():rw REG1=GPR8_R():r
  | ADC_GPR8_GPR8_10 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- ADC_GPR8_GPR8_12: REG0=GPR8_R():rw REG1=GPR8_B():r
  | ADC_GPR8_GPR8_12 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- ADC_GPR8_IMMb_80r2: REG0=GPR8_B():rw IMM0:r:b:i8
  | ADC_GPR8_IMMb_80r2 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- ADC_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | ADC_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- ADC_GPRv_GPRv_11: REG0=GPRv_B():rw REG1=GPRv_R():r
  | ADC_GPRv_GPRv_11 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- ADC_GPRv_GPRv_13: REG0=GPRv_R():rw REG1=GPRv_B():r
  | ADC_GPRv_GPRv_13 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- ADC_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | ADC_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- ADC_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | ADC_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- ADC_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | ADC_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- ADC_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | ADC_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- ADC_LOCK_MEMb_IMMb_80r2: MEM0:rw:b IMM0:r:b:i8
  | ADC_LOCK_MEMb_IMMb_80r2 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADC_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | ADC_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- ADC_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | ADC_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADC_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | ADC_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADC_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | ADC_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- ADC_MEMb_IMMb_80r2: MEM0:rw:b IMM0:r:b:i8
  | ADC_MEMb_IMMb_80r2 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADC_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | ADC_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- ADC_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | ADC_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADC_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | ADC_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- ADC_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | ADC_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.ADC.xedForm : Forms.ADC → XedForm
  | .ADC_AL_IMMb _ => .ADC_AL_IMMb
  | .ADC_GPR8_GPR8_10 _ _ => .ADC_GPR8_GPR8_10
  | .ADC_GPR8_GPR8_12 _ _ => .ADC_GPR8_GPR8_12
  | .ADC_GPR8_IMMb_80r2 _ _ => .ADC_GPR8_IMMb_80r2
  | .ADC_GPR8_MEMb _ _ => .ADC_GPR8_MEMb
  | .ADC_GPRv_GPRv_11 _ _ => .ADC_GPRv_GPRv_11
  | .ADC_GPRv_GPRv_13 _ _ => .ADC_GPRv_GPRv_13
  | .ADC_GPRv_IMMb _ _ => .ADC_GPRv_IMMb
  | .ADC_GPRv_IMMz _ _ => .ADC_GPRv_IMMz
  | .ADC_GPRv_MEMv _ _ => .ADC_GPRv_MEMv
  | .ADC_LOCK_MEMb_GPR8 _ _ => .ADC_LOCK_MEMb_GPR8
  | .ADC_LOCK_MEMb_IMMb_80r2 _ _ => .ADC_LOCK_MEMb_IMMb_80r2
  | .ADC_LOCK_MEMv_GPRv _ _ => .ADC_LOCK_MEMv_GPRv
  | .ADC_LOCK_MEMv_IMMb _ _ => .ADC_LOCK_MEMv_IMMb
  | .ADC_LOCK_MEMv_IMMz _ _ => .ADC_LOCK_MEMv_IMMz
  | .ADC_MEMb_GPR8 _ _ => .ADC_MEMb_GPR8
  | .ADC_MEMb_IMMb_80r2 _ _ => .ADC_MEMb_IMMb_80r2
  | .ADC_MEMv_GPRv _ _ => .ADC_MEMv_GPRv
  | .ADC_MEMv_IMMb _ _ => .ADC_MEMv_IMMb
  | .ADC_MEMv_IMMz _ _ => .ADC_MEMv_IMMz
  | .ADC_OrAX_IMMz _ _ => .ADC_OrAX_IMMz

def Forms.ADC.encodingFits : Forms.ADC → Bool
  | .ADC_AL_IMMb imm0 => imm0.encodingFits
  | .ADC_GPR8_GPR8_10 _ _ => true
  | .ADC_GPR8_GPR8_12 _ _ => true
  | .ADC_GPR8_IMMb_80r2 _ imm0 => imm0.encodingFits
  | .ADC_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .ADC_GPRv_GPRv_11 _ _ => true
  | .ADC_GPRv_GPRv_13 _ _ => true
  | .ADC_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .ADC_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .ADC_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .ADC_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .ADC_LOCK_MEMb_IMMb_80r2 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADC_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .ADC_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADC_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADC_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .ADC_MEMb_IMMb_80r2 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADC_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .ADC_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADC_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .ADC_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax

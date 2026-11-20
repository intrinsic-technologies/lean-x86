-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/XOR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.XOR where
  -- XOR_AL_IMMb: REG0=XED_REG_AL:rw:IMPL IMM0:r:b
  | XOR_AL_IMMb (imm0 : Immediate)
  -- XOR_GPR8_GPR8_30: REG0=GPR8_B():rw REG1=GPR8_R():r
  | XOR_GPR8_GPR8_30 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- XOR_GPR8_GPR8_32: REG0=GPR8_R():rw REG1=GPR8_B():r
  | XOR_GPR8_GPR8_32 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- XOR_GPR8_IMMb_80r6: REG0=GPR8_B():rw IMM0:r:b
  | XOR_GPR8_IMMb_80r6 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- XOR_GPR8_MEMb: REG0=GPR8_R():rw MEM0:r:b
  | XOR_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- XOR_GPRv_GPRv_31: REG0=GPRv_B():rw REG1=GPRv_R():r
  | XOR_GPRv_GPRv_31 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- XOR_GPRv_GPRv_33: REG0=GPRv_R():rw REG1=GPRv_B():r
  | XOR_GPRv_GPRv_33 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- XOR_GPRv_IMMb: REG0=GPRv_B():rw IMM0:r:b:i8
  | XOR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- XOR_GPRv_IMMz: REG0=GPRv_B():rw IMM0:r:z
  | XOR_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- XOR_GPRv_MEMv: REG0=GPRv_R():rw MEM0:r:v
  | XOR_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- XOR_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | XOR_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- XOR_LOCK_MEMb_IMMb_80r6: MEM0:rw:b IMM0:r:b
  | XOR_LOCK_MEMb_IMMb_80r6 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- XOR_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | XOR_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- XOR_LOCK_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | XOR_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- XOR_LOCK_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | XOR_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- XOR_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():r
  | XOR_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- XOR_MEMb_IMMb_80r6: MEM0:rw:b IMM0:r:b
  | XOR_MEMb_IMMb_80r6 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- XOR_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():r
  | XOR_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- XOR_MEMv_IMMb: MEM0:rw:v IMM0:r:b:i8
  | XOR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- XOR_MEMv_IMMz: MEM0:rw:v IMM0:r:z
  | XOR_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- XOR_OrAX_IMMz: REG0=OrAX():rw:IMPL IMM0:r:z
  | XOR_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.XOR.xedForm : Forms.XOR → XedForm
  | .XOR_AL_IMMb _ => .XOR_AL_IMMb
  | .XOR_GPR8_GPR8_30 _ _ => .XOR_GPR8_GPR8_30
  | .XOR_GPR8_GPR8_32 _ _ => .XOR_GPR8_GPR8_32
  | .XOR_GPR8_IMMb_80r6 _ _ => .XOR_GPR8_IMMb_80r6
  | .XOR_GPR8_MEMb _ _ => .XOR_GPR8_MEMb
  | .XOR_GPRv_GPRv_31 _ _ => .XOR_GPRv_GPRv_31
  | .XOR_GPRv_GPRv_33 _ _ => .XOR_GPRv_GPRv_33
  | .XOR_GPRv_IMMb _ _ => .XOR_GPRv_IMMb
  | .XOR_GPRv_IMMz _ _ => .XOR_GPRv_IMMz
  | .XOR_GPRv_MEMv _ _ => .XOR_GPRv_MEMv
  | .XOR_LOCK_MEMb_GPR8 _ _ => .XOR_LOCK_MEMb_GPR8
  | .XOR_LOCK_MEMb_IMMb_80r6 _ _ => .XOR_LOCK_MEMb_IMMb_80r6
  | .XOR_LOCK_MEMv_GPRv _ _ => .XOR_LOCK_MEMv_GPRv
  | .XOR_LOCK_MEMv_IMMb _ _ => .XOR_LOCK_MEMv_IMMb
  | .XOR_LOCK_MEMv_IMMz _ _ => .XOR_LOCK_MEMv_IMMz
  | .XOR_MEMb_GPR8 _ _ => .XOR_MEMb_GPR8
  | .XOR_MEMb_IMMb_80r6 _ _ => .XOR_MEMb_IMMb_80r6
  | .XOR_MEMv_GPRv _ _ => .XOR_MEMv_GPRv
  | .XOR_MEMv_IMMb _ _ => .XOR_MEMv_IMMb
  | .XOR_MEMv_IMMz _ _ => .XOR_MEMv_IMMz
  | .XOR_OrAX_IMMz _ _ => .XOR_OrAX_IMMz

def Forms.XOR.encodingFits : Forms.XOR → Bool
  | .XOR_AL_IMMb imm0 => imm0.encodingFits
  | .XOR_GPR8_GPR8_30 _ _ => true
  | .XOR_GPR8_GPR8_32 _ _ => true
  | .XOR_GPR8_IMMb_80r6 _ imm0 => imm0.encodingFits
  | .XOR_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .XOR_GPRv_GPRv_31 _ _ => true
  | .XOR_GPRv_GPRv_33 _ _ => true
  | .XOR_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .XOR_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .XOR_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .XOR_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .XOR_LOCK_MEMb_IMMb_80r6 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .XOR_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .XOR_LOCK_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .XOR_LOCK_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .XOR_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .XOR_MEMb_IMMb_80r6 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .XOR_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .XOR_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .XOR_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .XOR_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax

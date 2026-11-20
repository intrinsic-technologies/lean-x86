-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMP where
  -- CMP_AL_IMMb: REG0=XED_REG_AL:r:IMPL IMM0:r:b:i8
  | CMP_AL_IMMb (imm0 : Immediate)
  -- CMP_GPR8_GPR8_38: REG0=GPR8_B():r REG1=GPR8_R():r
  | CMP_GPR8_GPR8_38 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- CMP_GPR8_GPR8_3A: REG0=GPR8_R():r REG1=GPR8_B():r
  | CMP_GPR8_GPR8_3A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- CMP_GPR8_IMMb_80r7: REG0=GPR8_B():r IMM0:r:b:i8
  | CMP_GPR8_IMMb_80r7 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- CMP_GPR8_MEMb: REG0=GPR8_R():r MEM0:r:b
  | CMP_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- CMP_GPRv_GPRv_39: REG0=GPRv_B():r REG1=GPRv_R():r
  | CMP_GPRv_GPRv_39 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMP_GPRv_GPRv_3B: REG0=GPRv_R():r REG1=GPRv_B():r
  | CMP_GPRv_GPRv_3B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMP_GPRv_IMMb: REG0=GPRv_B():r IMM0:r:b:i8
  | CMP_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- CMP_GPRv_IMMz: REG0=GPRv_B():r IMM0:r:z
  | CMP_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- CMP_GPRv_MEMv: REG0=GPRv_R():r MEM0:r:v
  | CMP_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- CMP_MEMb_GPR8: MEM0:r:b REG0=GPR8_R():r
  | CMP_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- CMP_MEMb_IMMb_80r7: MEM0:r:b IMM0:r:b:i8
  | CMP_MEMb_IMMb_80r7 (mem0 : MemoryOperand) (imm0 : Immediate)
  -- CMP_MEMv_GPRv: MEM0:r:v REG0=GPRv_R():r
  | CMP_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- CMP_MEMv_IMMb: MEM0:r:v IMM0:r:b:i8
  | CMP_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- CMP_MEMv_IMMz: MEM0:r:v IMM0:r:z
  | CMP_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- CMP_OrAX_IMMz: REG0=OrAX():r:IMPL IMM0:r:z
  | CMP_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.CMP.xedForm : Forms.CMP → XedForm
  | .CMP_AL_IMMb _ => .CMP_AL_IMMb
  | .CMP_GPR8_GPR8_38 _ _ => .CMP_GPR8_GPR8_38
  | .CMP_GPR8_GPR8_3A _ _ => .CMP_GPR8_GPR8_3A
  | .CMP_GPR8_IMMb_80r7 _ _ => .CMP_GPR8_IMMb_80r7
  | .CMP_GPR8_MEMb _ _ => .CMP_GPR8_MEMb
  | .CMP_GPRv_GPRv_39 _ _ => .CMP_GPRv_GPRv_39
  | .CMP_GPRv_GPRv_3B _ _ => .CMP_GPRv_GPRv_3B
  | .CMP_GPRv_IMMb _ _ => .CMP_GPRv_IMMb
  | .CMP_GPRv_IMMz _ _ => .CMP_GPRv_IMMz
  | .CMP_GPRv_MEMv _ _ => .CMP_GPRv_MEMv
  | .CMP_MEMb_GPR8 _ _ => .CMP_MEMb_GPR8
  | .CMP_MEMb_IMMb_80r7 _ _ => .CMP_MEMb_IMMb_80r7
  | .CMP_MEMv_GPRv _ _ => .CMP_MEMv_GPRv
  | .CMP_MEMv_IMMb _ _ => .CMP_MEMv_IMMb
  | .CMP_MEMv_IMMz _ _ => .CMP_MEMv_IMMz
  | .CMP_OrAX_IMMz _ _ => .CMP_OrAX_IMMz

def Forms.CMP.encodingFits : Forms.CMP → Bool
  | .CMP_AL_IMMb imm0 => imm0.encodingFits
  | .CMP_GPR8_GPR8_38 _ _ => true
  | .CMP_GPR8_GPR8_3A _ _ => true
  | .CMP_GPR8_IMMb_80r7 _ imm0 => imm0.encodingFits
  | .CMP_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .CMP_GPRv_GPRv_39 _ _ => true
  | .CMP_GPRv_GPRv_3B _ _ => true
  | .CMP_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .CMP_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .CMP_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .CMP_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .CMP_MEMb_IMMb_80r7 mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .CMP_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .CMP_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .CMP_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .CMP_OrAX_IMMz _ imm0 => imm0.encodingFits

end X86.Syntax

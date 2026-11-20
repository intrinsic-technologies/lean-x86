-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BT.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BT where
  -- BT_GPRv_GPRv: REG0=GPRv_B():r REG1=GPRv_R():r
  | BT_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- BT_GPRv_IMMb: REG0=GPRv_B():r IMM0:r:b
  | BT_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- BT_MEMv_GPRv: MEM0:r:v REG0=GPRv_R():r
  | BT_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- BT_MEMv_IMMb: MEM0:r:v IMM0:r:b
  | BT_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.BT.xedForm : Forms.BT → XedForm
  | .BT_GPRv_GPRv _ _ => .BT_GPRv_GPRv
  | .BT_GPRv_IMMb _ _ => .BT_GPRv_IMMb
  | .BT_MEMv_GPRv _ _ => .BT_MEMv_GPRv
  | .BT_MEMv_IMMb _ _ => .BT_MEMv_IMMb

def Forms.BT.encodingFits : Forms.BT → Bool
  | .BT_GPRv_GPRv _ _ => true
  | .BT_GPRv_IMMb _ imm0 => imm0.encodingFits
  | .BT_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .BT_MEMv_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits

end X86.Syntax

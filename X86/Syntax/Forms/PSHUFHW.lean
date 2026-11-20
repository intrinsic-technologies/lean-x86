-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSHUFHW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSHUFHW where
  -- PSHUFHW_XMMdq_MEMdq_IMMb: REG0=XMM_R():w:dq:u16 MEM0:r:dq:u16 IMM0:r:b
  | PSHUFHW_XMMdq_MEMdq_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- PSHUFHW_XMMdq_XMMdq_IMMb: REG0=XMM_R():w:dq:u16 REG1=XMM_B():r:dq:u16 IMM0:r:b
  | PSHUFHW_XMMdq_XMMdq_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PSHUFHW.xedForm : Forms.PSHUFHW → XedForm
  | .PSHUFHW_XMMdq_MEMdq_IMMb _ _ _ => .PSHUFHW_XMMdq_MEMdq_IMMb
  | .PSHUFHW_XMMdq_XMMdq_IMMb _ _ _ => .PSHUFHW_XMMdq_XMMdq_IMMb

def Forms.PSHUFHW.encodingFits : Forms.PSHUFHW → Bool
  | .PSHUFHW_XMMdq_MEMdq_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .PSHUFHW_XMMdq_XMMdq_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax

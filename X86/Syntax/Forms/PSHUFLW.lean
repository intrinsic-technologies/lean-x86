-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSHUFLW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSHUFLW where
  -- PSHUFLW_XMMdq_MEMdq_IMMb: REG0=XMM_R():w:dq:u16 MEM0:r:dq:u16 IMM0:r:b
  | PSHUFLW_XMMdq_MEMdq_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- PSHUFLW_XMMdq_XMMdq_IMMb: REG0=XMM_R():w:dq:u16 REG1=XMM_B():r:dq:u16 IMM0:r:b
  | PSHUFLW_XMMdq_XMMdq_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PSHUFLW.xedForm : Forms.PSHUFLW → XedForm
  | .PSHUFLW_XMMdq_MEMdq_IMMb _ _ _ => .PSHUFLW_XMMdq_MEMdq_IMMb
  | .PSHUFLW_XMMdq_XMMdq_IMMb _ _ _ => .PSHUFLW_XMMdq_XMMdq_IMMb

def Forms.PSHUFLW.encodingFits : Forms.PSHUFLW → Bool
  | .PSHUFLW_XMMdq_MEMdq_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .PSHUFLW_XMMdq_XMMdq_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSRLDQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSRLDQ where
  -- PSRLDQ_XMMdq_IMMb: REG0=XMM_B():rw:dq:u128 IMM0:r:b
  | PSRLDQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PSRLDQ.xedForm : Forms.PSRLDQ → XedForm
  | .PSRLDQ_XMMdq_IMMb _ _ => .PSRLDQ_XMMdq_IMMb

def Forms.PSRLDQ.encodingFits : Forms.PSRLDQ → Bool
  | .PSRLDQ_XMMdq_IMMb _ imm0 => imm0.encodingFits

end X86.Syntax

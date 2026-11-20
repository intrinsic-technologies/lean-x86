-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PEXTRW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PEXTRW where
  -- PEXTRW_GPR32_MMXq_IMMb: REG0=GPR32_R():w REG1=MMX_B():r:q:u16 IMM0:r:b
  | PEXTRW_GPR32_MMXq_IMMb (reg0 : Registers.GPR32) (reg1 : Registers.MMX) (imm0 : Immediate)
  -- PEXTRW_GPR32_XMMdq_IMMb: REG0=GPR32_R():w REG1=XMM_B():r:dq IMM0:r:b
  | PEXTRW_GPR32_XMMdq_IMMb (reg0 : Registers.GPR32) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PEXTRW.xedForm : Forms.PEXTRW → XedForm
  | .PEXTRW_GPR32_MMXq_IMMb _ _ _ => .PEXTRW_GPR32_MMXq_IMMb
  | .PEXTRW_GPR32_XMMdq_IMMb _ _ _ => .PEXTRW_GPR32_XMMdq_IMMb

def Forms.PEXTRW.encodingFits : Forms.PEXTRW → Bool
  | .PEXTRW_GPR32_MMXq_IMMb _ _ imm0 => imm0.encodingFits
  | .PEXTRW_GPR32_XMMdq_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVMSKPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVMSKPS where
  -- MOVMSKPS_GPR32_XMMps: REG0=GPR32_R():w REG1=XMM_B():r:ps
  | MOVMSKPS_GPR32_XMMps (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVMSKPS.xedForm : Forms.MOVMSKPS → XedForm
  | .MOVMSKPS_GPR32_XMMps _ _ => .MOVMSKPS_GPR32_XMMps

def Forms.MOVMSKPS.encodingFits : Forms.MOVMSKPS → Bool
  | .MOVMSKPS_GPR32_XMMps _ _ => true

end X86.Syntax

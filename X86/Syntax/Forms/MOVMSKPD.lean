-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVMSKPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVMSKPD where
  -- MOVMSKPD_GPR32_XMMpd: REG0=GPR32_R():w REG1=XMM_B():r:pd
  | MOVMSKPD_GPR32_XMMpd (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVMSKPD.xedForm : Forms.MOVMSKPD → XedForm
  | .MOVMSKPD_GPR32_XMMpd _ _ => .MOVMSKPD_GPR32_XMMpd

def Forms.MOVMSKPD.encodingFits : Forms.MOVMSKPD → Bool
  | .MOVMSKPD_GPR32_XMMpd _ _ => true

end X86.Syntax

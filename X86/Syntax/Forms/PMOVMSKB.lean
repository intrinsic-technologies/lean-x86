-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PMOVMSKB.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PMOVMSKB where
  -- PMOVMSKB_GPR32_MMXq: REG0=GPR32_R():w REG1=MMX_B():r:q:i8
  | PMOVMSKB_GPR32_MMXq (reg0 : Registers.GPR32) (reg1 : Registers.MMX)
  -- PMOVMSKB_GPR32_XMMdq: REG0=GPR32_R():w REG1=XMM_B():r:dq:i8
  | PMOVMSKB_GPR32_XMMdq (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.PMOVMSKB.xedForm : Forms.PMOVMSKB → XedForm
  | .PMOVMSKB_GPR32_MMXq _ _ => .PMOVMSKB_GPR32_MMXq
  | .PMOVMSKB_GPR32_XMMdq _ _ => .PMOVMSKB_GPR32_XMMdq

def Forms.PMOVMSKB.encodingFits : Forms.PMOVMSKB → Bool
  | .PMOVMSKB_GPR32_MMXq _ _ => true
  | .PMOVMSKB_GPR32_XMMdq _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LAR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LAR where
  -- LAR_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | LAR_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- LAR_GPRv_MEMw: REG0=GPRv_R():cw MEM0:r:w
  | LAR_GPRv_MEMw (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LAR.xedForm : Forms.LAR → XedForm
  | .LAR_GPRv_GPRv _ _ => .LAR_GPRv_GPRv
  | .LAR_GPRv_MEMw _ _ => .LAR_GPRv_MEMw

def Forms.LAR.encodingFits : Forms.LAR → Bool
  | .LAR_GPRv_GPRv _ _ => true
  | .LAR_GPRv_MEMw _ mem0 => mem0.encodingFits

end X86.Syntax

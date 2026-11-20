-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BSR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BSR where
  -- BSR_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | BSR_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- BSR_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | BSR_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.BSR.xedForm : Forms.BSR → XedForm
  | .BSR_GPRv_GPRv _ _ => .BSR_GPRv_GPRv
  | .BSR_GPRv_MEMv _ _ => .BSR_GPRv_MEMv

def Forms.BSR.encodingFits : Forms.BSR → Bool
  | .BSR_GPRv_GPRv _ _ => true
  | .BSR_GPRv_MEMv _ mem0 => mem0.encodingFits

end X86.Syntax

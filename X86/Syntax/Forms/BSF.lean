-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BSF.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BSF where
  -- BSF_GPRv_GPRv: REG0=GPRv_R():cw REG1=GPRv_B():r
  | BSF_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- BSF_GPRv_MEMv: REG0=GPRv_R():cw MEM0:r:v
  | BSF_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.BSF.xedForm : Forms.BSF → XedForm
  | .BSF_GPRv_GPRv _ _ => .BSF_GPRv_GPRv
  | .BSF_GPRv_MEMv _ _ => .BSF_GPRv_MEMv

def Forms.BSF.encodingFits : Forms.BSF → Bool
  | .BSF_GPRv_GPRv _ _ => true
  | .BSF_GPRv_MEMv _ mem0 => mem0.encodingFits

end X86.Syntax

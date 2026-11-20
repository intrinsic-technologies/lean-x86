-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ADDSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ADDSS where
  -- ADDSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | ADDSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ADDSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | ADDSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ADDSS.xedForm : Forms.ADDSS → XedForm
  | .ADDSS_XMMss_MEMss _ _ => .ADDSS_XMMss_MEMss
  | .ADDSS_XMMss_XMMss _ _ => .ADDSS_XMMss_XMMss

def Forms.ADDSS.encodingFits : Forms.ADDSS → Bool
  | .ADDSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .ADDSS_XMMss_XMMss _ _ => true

end X86.Syntax

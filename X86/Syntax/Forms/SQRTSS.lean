-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SQRTSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SQRTSS where
  -- SQRTSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | SQRTSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SQRTSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | SQRTSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SQRTSS.xedForm : Forms.SQRTSS → XedForm
  | .SQRTSS_XMMss_MEMss _ _ => .SQRTSS_XMMss_MEMss
  | .SQRTSS_XMMss_XMMss _ _ => .SQRTSS_XMMss_XMMss

def Forms.SQRTSS.encodingFits : Forms.SQRTSS → Bool
  | .SQRTSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .SQRTSS_XMMss_XMMss _ _ => true

end X86.Syntax

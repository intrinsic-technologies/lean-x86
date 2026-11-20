-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MAXSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MAXSS where
  -- MAXSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | MAXSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MAXSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | MAXSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MAXSS.xedForm : Forms.MAXSS → XedForm
  | .MAXSS_XMMss_MEMss _ _ => .MAXSS_XMMss_MEMss
  | .MAXSS_XMMss_XMMss _ _ => .MAXSS_XMMss_XMMss

def Forms.MAXSS.encodingFits : Forms.MAXSS → Bool
  | .MAXSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .MAXSS_XMMss_XMMss _ _ => true

end X86.Syntax

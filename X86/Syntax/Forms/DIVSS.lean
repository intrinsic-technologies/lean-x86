-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/DIVSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.DIVSS where
  -- DIVSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | DIVSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- DIVSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | DIVSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.DIVSS.xedForm : Forms.DIVSS → XedForm
  | .DIVSS_XMMss_MEMss _ _ => .DIVSS_XMMss_MEMss
  | .DIVSS_XMMss_XMMss _ _ => .DIVSS_XMMss_XMMss

def Forms.DIVSS.encodingFits : Forms.DIVSS → Bool
  | .DIVSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .DIVSS_XMMss_XMMss _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RSQRTSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RSQRTSS where
  -- RSQRTSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | RSQRTSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- RSQRTSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | RSQRTSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.RSQRTSS.xedForm : Forms.RSQRTSS → XedForm
  | .RSQRTSS_XMMss_MEMss _ _ => .RSQRTSS_XMMss_MEMss
  | .RSQRTSS_XMMss_XMMss _ _ => .RSQRTSS_XMMss_XMMss

def Forms.RSQRTSS.encodingFits : Forms.RSQRTSS → Bool
  | .RSQRTSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .RSQRTSS_XMMss_XMMss _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UCOMISS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UCOMISS where
  -- UCOMISS_XMMss_MEMss: REG0=XMM_R():r:ss MEM0:r:ss
  | UCOMISS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- UCOMISS_XMMss_XMMss: REG0=XMM_R():r:ss REG1=XMM_B():r:ss
  | UCOMISS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.UCOMISS.xedForm : Forms.UCOMISS → XedForm
  | .UCOMISS_XMMss_MEMss _ _ => .UCOMISS_XMMss_MEMss
  | .UCOMISS_XMMss_XMMss _ _ => .UCOMISS_XMMss_XMMss

def Forms.UCOMISS.encodingFits : Forms.UCOMISS → Bool
  | .UCOMISS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .UCOMISS_XMMss_XMMss _ _ => true

end X86.Syntax

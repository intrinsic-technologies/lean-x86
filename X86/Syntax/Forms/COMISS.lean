-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/COMISS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.COMISS where
  -- COMISS_XMMss_MEMss: REG0=XMM_R():r:ss MEM0:r:ss
  | COMISS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- COMISS_XMMss_XMMss: REG0=XMM_R():r:ss REG1=XMM_B():r:ss
  | COMISS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.COMISS.xedForm : Forms.COMISS → XedForm
  | .COMISS_XMMss_MEMss _ _ => .COMISS_XMMss_MEMss
  | .COMISS_XMMss_XMMss _ _ => .COMISS_XMMss_XMMss

def Forms.COMISS.encodingFits : Forms.COMISS → Bool
  | .COMISS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .COMISS_XMMss_XMMss _ _ => true

end X86.Syntax

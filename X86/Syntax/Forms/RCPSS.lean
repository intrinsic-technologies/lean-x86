-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RCPSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RCPSS where
  -- RCPSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | RCPSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- RCPSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | RCPSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.RCPSS.xedForm : Forms.RCPSS → XedForm
  | .RCPSS_XMMss_MEMss _ _ => .RCPSS_XMMss_MEMss
  | .RCPSS_XMMss_XMMss _ _ => .RCPSS_XMMss_XMMss

def Forms.RCPSS.encodingFits : Forms.RCPSS → Bool
  | .RCPSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .RCPSS_XMMss_XMMss _ _ => true

end X86.Syntax

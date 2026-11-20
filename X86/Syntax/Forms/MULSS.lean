-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MULSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MULSS where
  -- MULSS_XMMss_MEMss: REG0=XMM_R():rw:ss MEM0:r:ss
  | MULSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MULSS_XMMss_XMMss: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss
  | MULSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MULSS.xedForm : Forms.MULSS → XedForm
  | .MULSS_XMMss_MEMss _ _ => .MULSS_XMMss_MEMss
  | .MULSS_XMMss_XMMss _ _ => .MULSS_XMMss_XMMss

def Forms.MULSS.encodingFits : Forms.MULSS → Bool
  | .MULSS_XMMss_MEMss _ mem0 => mem0.encodingFits
  | .MULSS_XMMss_XMMss _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SQRTPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SQRTPD where
  -- SQRTPD_XMMpd_MEMpd: REG0=XMM_R():w:pd MEM0:r:pd
  | SQRTPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SQRTPD_XMMpd_XMMpd: REG0=XMM_R():w:pd REG1=XMM_B():r:pd
  | SQRTPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SQRTPD.xedForm : Forms.SQRTPD → XedForm
  | .SQRTPD_XMMpd_MEMpd _ _ => .SQRTPD_XMMpd_MEMpd
  | .SQRTPD_XMMpd_XMMpd _ _ => .SQRTPD_XMMpd_XMMpd

def Forms.SQRTPD.encodingFits : Forms.SQRTPD → Bool
  | .SQRTPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .SQRTPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

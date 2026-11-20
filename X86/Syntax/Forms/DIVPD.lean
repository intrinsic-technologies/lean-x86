-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/DIVPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.DIVPD where
  -- DIVPD_XMMpd_MEMpd: REG0=XMM_R():rw:pd MEM0:r:pd
  | DIVPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- DIVPD_XMMpd_XMMpd: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd
  | DIVPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.DIVPD.xedForm : Forms.DIVPD → XedForm
  | .DIVPD_XMMpd_MEMpd _ _ => .DIVPD_XMMpd_MEMpd
  | .DIVPD_XMMpd_XMMpd _ _ => .DIVPD_XMMpd_XMMpd

def Forms.DIVPD.encodingFits : Forms.DIVPD → Bool
  | .DIVPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .DIVPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

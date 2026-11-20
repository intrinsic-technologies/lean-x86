-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SUBPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SUBPD where
  -- SUBPD_XMMpd_MEMpd: REG0=XMM_R():rw:pd MEM0:r:pd
  | SUBPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SUBPD_XMMpd_XMMpd: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd
  | SUBPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SUBPD.xedForm : Forms.SUBPD → XedForm
  | .SUBPD_XMMpd_MEMpd _ _ => .SUBPD_XMMpd_MEMpd
  | .SUBPD_XMMpd_XMMpd _ _ => .SUBPD_XMMpd_XMMpd

def Forms.SUBPD.encodingFits : Forms.SUBPD → Bool
  | .SUBPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .SUBPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

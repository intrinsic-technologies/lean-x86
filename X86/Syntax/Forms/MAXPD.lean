-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MAXPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MAXPD where
  -- MAXPD_XMMpd_MEMpd: REG0=XMM_R():rw:pd MEM0:r:pd
  | MAXPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MAXPD_XMMpd_XMMpd: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd
  | MAXPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MAXPD.xedForm : Forms.MAXPD → XedForm
  | .MAXPD_XMMpd_MEMpd _ _ => .MAXPD_XMMpd_MEMpd
  | .MAXPD_XMMpd_XMMpd _ _ => .MAXPD_XMMpd_XMMpd

def Forms.MAXPD.encodingFits : Forms.MAXPD → Bool
  | .MAXPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .MAXPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

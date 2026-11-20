-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MINPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MINPD where
  -- MINPD_XMMpd_MEMpd: REG0=XMM_R():rw:pd MEM0:r:pd
  | MINPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MINPD_XMMpd_XMMpd: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd
  | MINPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MINPD.xedForm : Forms.MINPD → XedForm
  | .MINPD_XMMpd_MEMpd _ _ => .MINPD_XMMpd_MEMpd
  | .MINPD_XMMpd_XMMpd _ _ => .MINPD_XMMpd_XMMpd

def Forms.MINPD.encodingFits : Forms.MINPD → Bool
  | .MINPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .MINPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

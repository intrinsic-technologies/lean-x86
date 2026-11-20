-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ADDPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ADDPD where
  -- ADDPD_XMMpd_MEMpd: REG0=XMM_R():rw:pd MEM0:r:pd
  | ADDPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ADDPD_XMMpd_XMMpd: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd
  | ADDPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ADDPD.xedForm : Forms.ADDPD → XedForm
  | .ADDPD_XMMpd_MEMpd _ _ => .ADDPD_XMMpd_MEMpd
  | .ADDPD_XMMpd_XMMpd _ _ => .ADDPD_XMMpd_XMMpd

def Forms.ADDPD.encodingFits : Forms.ADDPD → Bool
  | .ADDPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .ADDPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

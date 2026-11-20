-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MULPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MULPD where
  -- MULPD_XMMpd_MEMpd: REG0=XMM_R():rw:pd MEM0:r:pd
  | MULPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MULPD_XMMpd_XMMpd: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd
  | MULPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MULPD.xedForm : Forms.MULPD → XedForm
  | .MULPD_XMMpd_MEMpd _ _ => .MULPD_XMMpd_MEMpd
  | .MULPD_XMMpd_XMMpd _ _ => .MULPD_XMMpd_XMMpd

def Forms.MULPD.encodingFits : Forms.MULPD → Bool
  | .MULPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .MULPD_XMMpd_XMMpd _ _ => true

end X86.Syntax

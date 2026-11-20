-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UNPCKHPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UNPCKHPD where
  -- UNPCKHPD_XMMpd_MEMdq: REG0=XMM_R():rw:pd MEM0:r:dq
  | UNPCKHPD_XMMpd_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- UNPCKHPD_XMMpd_XMMq: REG0=XMM_R():rw:pd REG1=XMM_B():r:q
  | UNPCKHPD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.UNPCKHPD.xedForm : Forms.UNPCKHPD → XedForm
  | .UNPCKHPD_XMMpd_MEMdq _ _ => .UNPCKHPD_XMMpd_MEMdq
  | .UNPCKHPD_XMMpd_XMMq _ _ => .UNPCKHPD_XMMpd_XMMq

def Forms.UNPCKHPD.encodingFits : Forms.UNPCKHPD → Bool
  | .UNPCKHPD_XMMpd_MEMdq _ mem0 => mem0.encodingFits
  | .UNPCKHPD_XMMpd_XMMq _ _ => true

end X86.Syntax

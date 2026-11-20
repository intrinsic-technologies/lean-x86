-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UNPCKLPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UNPCKLPD where
  -- UNPCKLPD_XMMpd_MEMdq: REG0=XMM_R():rw:pd MEM0:r:dq
  | UNPCKLPD_XMMpd_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- UNPCKLPD_XMMpd_XMMq: REG0=XMM_R():rw:pd REG1=XMM_B():r:q
  | UNPCKLPD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.UNPCKLPD.xedForm : Forms.UNPCKLPD → XedForm
  | .UNPCKLPD_XMMpd_MEMdq _ _ => .UNPCKLPD_XMMpd_MEMdq
  | .UNPCKLPD_XMMpd_XMMq _ _ => .UNPCKLPD_XMMpd_XMMq

def Forms.UNPCKLPD.encodingFits : Forms.UNPCKLPD → Bool
  | .UNPCKLPD_XMMpd_MEMdq _ mem0 => mem0.encodingFits
  | .UNPCKLPD_XMMpd_XMMq _ _ => true

end X86.Syntax

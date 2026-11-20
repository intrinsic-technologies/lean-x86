-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UNPCKLPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UNPCKLPS where
  -- UNPCKLPS_XMMps_MEMdq: REG0=XMM_R():rw:ps MEM0:r:dq
  | UNPCKLPS_XMMps_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- UNPCKLPS_XMMps_XMMq: REG0=XMM_R():rw:ps REG1=XMM_B():r:q
  | UNPCKLPS_XMMps_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.UNPCKLPS.xedForm : Forms.UNPCKLPS → XedForm
  | .UNPCKLPS_XMMps_MEMdq _ _ => .UNPCKLPS_XMMps_MEMdq
  | .UNPCKLPS_XMMps_XMMq _ _ => .UNPCKLPS_XMMps_XMMq

def Forms.UNPCKLPS.encodingFits : Forms.UNPCKLPS → Bool
  | .UNPCKLPS_XMMps_MEMdq _ mem0 => mem0.encodingFits
  | .UNPCKLPS_XMMps_XMMq _ _ => true

end X86.Syntax

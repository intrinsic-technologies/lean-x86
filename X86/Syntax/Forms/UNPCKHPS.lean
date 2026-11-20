-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UNPCKHPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UNPCKHPS where
  -- UNPCKHPS_XMMps_MEMdq: REG0=XMM_R():rw:ps MEM0:r:dq
  | UNPCKHPS_XMMps_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- UNPCKHPS_XMMps_XMMdq: REG0=XMM_R():rw:ps REG1=XMM_B():r:dq
  | UNPCKHPS_XMMps_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.UNPCKHPS.xedForm : Forms.UNPCKHPS → XedForm
  | .UNPCKHPS_XMMps_MEMdq _ _ => .UNPCKHPS_XMMps_MEMdq
  | .UNPCKHPS_XMMps_XMMdq _ _ => .UNPCKHPS_XMMps_XMMdq

def Forms.UNPCKHPS.encodingFits : Forms.UNPCKHPS → Bool
  | .UNPCKHPS_XMMps_MEMdq _ mem0 => mem0.encodingFits
  | .UNPCKHPS_XMMps_XMMdq _ _ => true

end X86.Syntax

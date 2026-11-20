-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SUBPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SUBPS where
  -- SUBPS_XMMps_MEMps: REG0=XMM_R():rw:ps MEM0:r:ps
  | SUBPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SUBPS_XMMps_XMMps: REG0=XMM_R():rw:ps REG1=XMM_B():r:ps
  | SUBPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SUBPS.xedForm : Forms.SUBPS → XedForm
  | .SUBPS_XMMps_MEMps _ _ => .SUBPS_XMMps_MEMps
  | .SUBPS_XMMps_XMMps _ _ => .SUBPS_XMMps_XMMps

def Forms.SUBPS.encodingFits : Forms.SUBPS → Bool
  | .SUBPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .SUBPS_XMMps_XMMps _ _ => true

end X86.Syntax

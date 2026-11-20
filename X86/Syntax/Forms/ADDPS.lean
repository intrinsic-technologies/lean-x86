-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ADDPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ADDPS where
  -- ADDPS_XMMps_MEMps: REG0=XMM_R():rw:ps MEM0:r:ps
  | ADDPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ADDPS_XMMps_XMMps: REG0=XMM_R():rw:ps REG1=XMM_B():r:ps
  | ADDPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ADDPS.xedForm : Forms.ADDPS → XedForm
  | .ADDPS_XMMps_MEMps _ _ => .ADDPS_XMMps_MEMps
  | .ADDPS_XMMps_XMMps _ _ => .ADDPS_XMMps_XMMps

def Forms.ADDPS.encodingFits : Forms.ADDPS → Bool
  | .ADDPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .ADDPS_XMMps_XMMps _ _ => true

end X86.Syntax

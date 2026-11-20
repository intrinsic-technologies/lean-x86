-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/DIVPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.DIVPS where
  -- DIVPS_XMMps_MEMps: REG0=XMM_R():rw:ps MEM0:r:ps
  | DIVPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- DIVPS_XMMps_XMMps: REG0=XMM_R():rw:ps REG1=XMM_B():r:ps
  | DIVPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.DIVPS.xedForm : Forms.DIVPS → XedForm
  | .DIVPS_XMMps_MEMps _ _ => .DIVPS_XMMps_MEMps
  | .DIVPS_XMMps_XMMps _ _ => .DIVPS_XMMps_XMMps

def Forms.DIVPS.encodingFits : Forms.DIVPS → Bool
  | .DIVPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .DIVPS_XMMps_XMMps _ _ => true

end X86.Syntax

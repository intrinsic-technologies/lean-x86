-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RCPPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RCPPS where
  -- RCPPS_XMMps_MEMps: REG0=XMM_R():w:ps MEM0:r:ps
  | RCPPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- RCPPS_XMMps_XMMps: REG0=XMM_R():w:ps REG1=XMM_B():r:ps
  | RCPPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.RCPPS.xedForm : Forms.RCPPS → XedForm
  | .RCPPS_XMMps_MEMps _ _ => .RCPPS_XMMps_MEMps
  | .RCPPS_XMMps_XMMps _ _ => .RCPPS_XMMps_XMMps

def Forms.RCPPS.encodingFits : Forms.RCPPS → Bool
  | .RCPPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .RCPPS_XMMps_XMMps _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MAXPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MAXPS where
  -- MAXPS_XMMps_MEMps: REG0=XMM_R():rw:ps MEM0:r:ps
  | MAXPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MAXPS_XMMps_XMMps: REG0=XMM_R():rw:ps REG1=XMM_B():r:ps
  | MAXPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MAXPS.xedForm : Forms.MAXPS → XedForm
  | .MAXPS_XMMps_MEMps _ _ => .MAXPS_XMMps_MEMps
  | .MAXPS_XMMps_XMMps _ _ => .MAXPS_XMMps_XMMps

def Forms.MAXPS.encodingFits : Forms.MAXPS → Bool
  | .MAXPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .MAXPS_XMMps_XMMps _ _ => true

end X86.Syntax

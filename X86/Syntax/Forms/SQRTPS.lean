-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SQRTPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SQRTPS where
  -- SQRTPS_XMMps_MEMps: REG0=XMM_R():w:ps MEM0:r:ps
  | SQRTPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SQRTPS_XMMps_XMMps: REG0=XMM_R():w:ps REG1=XMM_B():r:ps
  | SQRTPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SQRTPS.xedForm : Forms.SQRTPS → XedForm
  | .SQRTPS_XMMps_MEMps _ _ => .SQRTPS_XMMps_MEMps
  | .SQRTPS_XMMps_XMMps _ _ => .SQRTPS_XMMps_XMMps

def Forms.SQRTPS.encodingFits : Forms.SQRTPS → Bool
  | .SQRTPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .SQRTPS_XMMps_XMMps _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MULPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MULPS where
  -- MULPS_XMMps_MEMps: REG0=XMM_R():rw:ps MEM0:r:ps
  | MULPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MULPS_XMMps_XMMps: REG0=XMM_R():rw:ps REG1=XMM_B():r:ps
  | MULPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MULPS.xedForm : Forms.MULPS → XedForm
  | .MULPS_XMMps_MEMps _ _ => .MULPS_XMMps_MEMps
  | .MULPS_XMMps_XMMps _ _ => .MULPS_XMMps_XMMps

def Forms.MULPS.encodingFits : Forms.MULPS → Bool
  | .MULPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .MULPS_XMMps_XMMps _ _ => true

end X86.Syntax

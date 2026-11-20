-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RSQRTPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RSQRTPS where
  -- RSQRTPS_XMMps_MEMps: REG0=XMM_R():w:ps MEM0:r:ps
  | RSQRTPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- RSQRTPS_XMMps_XMMps: REG0=XMM_R():w:ps REG1=XMM_B():r:ps
  | RSQRTPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.RSQRTPS.xedForm : Forms.RSQRTPS → XedForm
  | .RSQRTPS_XMMps_MEMps _ _ => .RSQRTPS_XMMps_MEMps
  | .RSQRTPS_XMMps_XMMps _ _ => .RSQRTPS_XMMps_XMMps

def Forms.RSQRTPS.encodingFits : Forms.RSQRTPS → Bool
  | .RSQRTPS_XMMps_MEMps _ mem0 => mem0.encodingFits
  | .RSQRTPS_XMMps_XMMps _ _ => true

end X86.Syntax

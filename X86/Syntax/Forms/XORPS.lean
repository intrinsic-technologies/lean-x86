-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/XORPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.XORPS where
  -- XORPS_XMMxud_MEMxud: REG0=XMM_R():rw:xud MEM0:r:xud
  | XORPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- XORPS_XMMxud_XMMxud: REG0=XMM_R():rw:xud REG1=XMM_B():r:xud
  | XORPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.XORPS.xedForm : Forms.XORPS → XedForm
  | .XORPS_XMMxud_MEMxud _ _ => .XORPS_XMMxud_MEMxud
  | .XORPS_XMMxud_XMMxud _ _ => .XORPS_XMMxud_XMMxud

def Forms.XORPS.encodingFits : Forms.XORPS → Bool
  | .XORPS_XMMxud_MEMxud _ mem0 => mem0.encodingFits
  | .XORPS_XMMxud_XMMxud _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ANDNPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ANDNPS where
  -- ANDNPS_XMMxud_MEMxud: REG0=XMM_R():rw:xud MEM0:r:xud
  | ANDNPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ANDNPS_XMMxud_XMMxud: REG0=XMM_R():rw:xud REG1=XMM_B():r:xud
  | ANDNPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ANDNPS.xedForm : Forms.ANDNPS → XedForm
  | .ANDNPS_XMMxud_MEMxud _ _ => .ANDNPS_XMMxud_MEMxud
  | .ANDNPS_XMMxud_XMMxud _ _ => .ANDNPS_XMMxud_XMMxud

def Forms.ANDNPS.encodingFits : Forms.ANDNPS → Bool
  | .ANDNPS_XMMxud_MEMxud _ mem0 => mem0.encodingFits
  | .ANDNPS_XMMxud_XMMxud _ _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ANDPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ANDPS where
  -- ANDPS_XMMxud_MEMxud: REG0=XMM_R():rw:xud MEM0:r:xud
  | ANDPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ANDPS_XMMxud_XMMxud: REG0=XMM_R():rw:xud REG1=XMM_B():r:xud
  | ANDPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ANDPS.xedForm : Forms.ANDPS → XedForm
  | .ANDPS_XMMxud_MEMxud _ _ => .ANDPS_XMMxud_MEMxud
  | .ANDPS_XMMxud_XMMxud _ _ => .ANDPS_XMMxud_XMMxud

def Forms.ANDPS.encodingFits : Forms.ANDPS → Bool
  | .ANDPS_XMMxud_MEMxud _ mem0 => mem0.encodingFits
  | .ANDPS_XMMxud_XMMxud _ _ => true

end X86.Syntax

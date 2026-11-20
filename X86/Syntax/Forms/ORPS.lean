-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ORPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ORPS where
  -- ORPS_XMMxud_MEMxud: REG0=XMM_R():rw:xud MEM0:r:xud
  | ORPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ORPS_XMMxud_XMMxud: REG0=XMM_R():rw:xud REG1=XMM_B():r:xud
  | ORPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ORPS.xedForm : Forms.ORPS → XedForm
  | .ORPS_XMMxud_MEMxud _ _ => .ORPS_XMMxud_MEMxud
  | .ORPS_XMMxud_XMMxud _ _ => .ORPS_XMMxud_XMMxud

def Forms.ORPS.encodingFits : Forms.ORPS → Bool
  | .ORPS_XMMxud_MEMxud _ mem0 => mem0.encodingFits
  | .ORPS_XMMxud_XMMxud _ _ => true

end X86.Syntax

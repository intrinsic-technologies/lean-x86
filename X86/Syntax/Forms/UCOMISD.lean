-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/UCOMISD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.UCOMISD where
  -- UCOMISD_XMMsd_MEMsd: REG0=XMM_R():r:sd MEM0:r:sd
  | UCOMISD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- UCOMISD_XMMsd_XMMsd: REG0=XMM_R():r:sd REG1=XMM_B():r:sd
  | UCOMISD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.UCOMISD.xedForm : Forms.UCOMISD → XedForm
  | .UCOMISD_XMMsd_MEMsd _ _ => .UCOMISD_XMMsd_MEMsd
  | .UCOMISD_XMMsd_XMMsd _ _ => .UCOMISD_XMMsd_XMMsd

def Forms.UCOMISD.encodingFits : Forms.UCOMISD → Bool
  | .UCOMISD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .UCOMISD_XMMsd_XMMsd _ _ => true

end X86.Syntax

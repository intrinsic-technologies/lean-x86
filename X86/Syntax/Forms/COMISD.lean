-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/COMISD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.COMISD where
  -- COMISD_XMMsd_MEMsd: REG0=XMM_R():r:sd MEM0:r:sd
  | COMISD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- COMISD_XMMsd_XMMsd: REG0=XMM_R():r:sd REG1=XMM_B():r:sd
  | COMISD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.COMISD.xedForm : Forms.COMISD → XedForm
  | .COMISD_XMMsd_MEMsd _ _ => .COMISD_XMMsd_MEMsd
  | .COMISD_XMMsd_XMMsd _ _ => .COMISD_XMMsd_XMMsd

def Forms.COMISD.encodingFits : Forms.COMISD → Bool
  | .COMISD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .COMISD_XMMsd_XMMsd _ _ => true

end X86.Syntax

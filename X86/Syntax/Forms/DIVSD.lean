-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/DIVSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.DIVSD where
  -- DIVSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | DIVSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- DIVSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | DIVSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.DIVSD.xedForm : Forms.DIVSD → XedForm
  | .DIVSD_XMMsd_MEMsd _ _ => .DIVSD_XMMsd_MEMsd
  | .DIVSD_XMMsd_XMMsd _ _ => .DIVSD_XMMsd_XMMsd

def Forms.DIVSD.encodingFits : Forms.DIVSD → Bool
  | .DIVSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .DIVSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

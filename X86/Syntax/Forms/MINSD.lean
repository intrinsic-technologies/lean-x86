-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MINSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MINSD where
  -- MINSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | MINSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MINSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | MINSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MINSD.xedForm : Forms.MINSD → XedForm
  | .MINSD_XMMsd_MEMsd _ _ => .MINSD_XMMsd_MEMsd
  | .MINSD_XMMsd_XMMsd _ _ => .MINSD_XMMsd_XMMsd

def Forms.MINSD.encodingFits : Forms.MINSD → Bool
  | .MINSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .MINSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

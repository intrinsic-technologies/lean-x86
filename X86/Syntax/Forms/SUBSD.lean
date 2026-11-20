-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SUBSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SUBSD where
  -- SUBSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | SUBSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SUBSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | SUBSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SUBSD.xedForm : Forms.SUBSD → XedForm
  | .SUBSD_XMMsd_MEMsd _ _ => .SUBSD_XMMsd_MEMsd
  | .SUBSD_XMMsd_XMMsd _ _ => .SUBSD_XMMsd_XMMsd

def Forms.SUBSD.encodingFits : Forms.SUBSD → Bool
  | .SUBSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .SUBSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

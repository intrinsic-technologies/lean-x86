-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SQRTSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SQRTSD where
  -- SQRTSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | SQRTSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- SQRTSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | SQRTSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.SQRTSD.xedForm : Forms.SQRTSD → XedForm
  | .SQRTSD_XMMsd_MEMsd _ _ => .SQRTSD_XMMsd_MEMsd
  | .SQRTSD_XMMsd_XMMsd _ _ => .SQRTSD_XMMsd_XMMsd

def Forms.SQRTSD.encodingFits : Forms.SQRTSD → Bool
  | .SQRTSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .SQRTSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

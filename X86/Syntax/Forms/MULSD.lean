-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MULSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MULSD where
  -- MULSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | MULSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MULSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | MULSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MULSD.xedForm : Forms.MULSD → XedForm
  | .MULSD_XMMsd_MEMsd _ _ => .MULSD_XMMsd_MEMsd
  | .MULSD_XMMsd_XMMsd _ _ => .MULSD_XMMsd_XMMsd

def Forms.MULSD.encodingFits : Forms.MULSD → Bool
  | .MULSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .MULSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

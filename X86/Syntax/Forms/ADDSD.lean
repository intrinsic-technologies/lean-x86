-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/ADDSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.ADDSD where
  -- ADDSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | ADDSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- ADDSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | ADDSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.ADDSD.xedForm : Forms.ADDSD → XedForm
  | .ADDSD_XMMsd_MEMsd _ _ => .ADDSD_XMMsd_MEMsd
  | .ADDSD_XMMsd_XMMsd _ _ => .ADDSD_XMMsd_XMMsd

def Forms.ADDSD.encodingFits : Forms.ADDSD → Bool
  | .ADDSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .ADDSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

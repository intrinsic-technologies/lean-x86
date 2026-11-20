-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MAXSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MAXSD where
  -- MAXSD_XMMsd_MEMsd: REG0=XMM_R():rw:sd MEM0:r:sd
  | MAXSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MAXSD_XMMsd_XMMsd: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd
  | MAXSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MAXSD.xedForm : Forms.MAXSD → XedForm
  | .MAXSD_XMMsd_MEMsd _ _ => .MAXSD_XMMsd_MEMsd
  | .MAXSD_XMMsd_XMMsd _ _ => .MAXSD_XMMsd_XMMsd

def Forms.MAXSD.encodingFits : Forms.MAXSD → Bool
  | .MAXSD_XMMsd_MEMsd _ mem0 => mem0.encodingFits
  | .MAXSD_XMMsd_XMMsd _ _ => true

end X86.Syntax

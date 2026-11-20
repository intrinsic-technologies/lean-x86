-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/JMP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.JMP where
  -- JMP_FAR_MEMp2: MEM0:r:p2 REG0=rIP():w:SUPP
  | JMP_FAR_MEMp2 (mem0 : MemoryOperand)
  -- JMP_GPRv: REG0=GPRv_B():r REG1=rIP():w:SUPP
  | JMP_GPRv (reg0 : Registers.GPRv)
  -- JMP_MEMv: MEM0:r:v REG0=rIP():w:SUPP
  | JMP_MEMv (mem0 : MemoryOperand)
  -- JMP_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JMP_RELBRb (relbr : RelativeOperand)
  -- JMP_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JMP_RELBRd (relbr : RelativeOperand)
  deriving Repr, BEq, Inhabited

def Forms.JMP.xedForm : Forms.JMP → XedForm
  | .JMP_FAR_MEMp2 _ => .JMP_FAR_MEMp2
  | .JMP_GPRv _ => .JMP_GPRv
  | .JMP_MEMv _ => .JMP_MEMv
  | .JMP_RELBRb _ => .JMP_RELBRb
  | .JMP_RELBRd _ => .JMP_RELBRd

def Forms.JMP.encodingFits : Forms.JMP → Bool
  | .JMP_FAR_MEMp2 mem0 => mem0.encodingFits
  | .JMP_GPRv _ => true
  | .JMP_MEMv mem0 => mem0.encodingFits
  | .JMP_RELBRb relbr => relbr.encodingFits
  | .JMP_RELBRd relbr => relbr.encodingFits

end X86.Syntax

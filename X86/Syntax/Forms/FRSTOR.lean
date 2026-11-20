-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FRSTOR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FRSTOR where
  -- FRSTOR_MEMmem108: MEM0:r:mem108 REG0=XED_REG_X87CONTROL:w:SUPP
  | FRSTOR_MEMmem108 (mem0 : MemoryOperand)
  -- FRSTOR_MEMmem94: MEM0:r:mem94 REG0=XED_REG_X87CONTROL:w:SUPP
  | FRSTOR_MEMmem94 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FRSTOR.xedForm : Forms.FRSTOR → XedForm
  | .FRSTOR_MEMmem108 _ => .FRSTOR_MEMmem108
  | .FRSTOR_MEMmem94 _ => .FRSTOR_MEMmem94

def Forms.FRSTOR.encodingFits : Forms.FRSTOR → Bool
  | .FRSTOR_MEMmem108 mem0 => mem0.encodingFits
  | .FRSTOR_MEMmem94 mem0 => mem0.encodingFits

end X86.Syntax

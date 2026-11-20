-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSAVE-FNSAVE.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSAVE where
  -- FNSAVE_MEMmem108: MEM0:w:mem108              REG0=XED_REG_X87CONTROL:rw:SUPP              REG1=XED_REG_X87TAG:rw:SUPP              REG3=XED_REG_X87STATUS:rw:SUPP
  | FNSAVE_MEMmem108 (mem0 : MemoryOperand)
  -- FNSAVE_MEMmem94: MEM0:w:mem94             REG0=XED_REG_X87CONTROL:rw:SUPP              REG1=XED_REG_X87TAG:rw:SUPP              REG3=XED_REG_X87STATUS:rw:SUPP
  | FNSAVE_MEMmem94 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FSAVE.xedForm : Forms.FSAVE → XedForm
  | .FNSAVE_MEMmem108 _ => .FNSAVE_MEMmem108
  | .FNSAVE_MEMmem94 _ => .FNSAVE_MEMmem94

def Forms.FSAVE.encodingFits : Forms.FSAVE → Bool
  | .FNSAVE_MEMmem108 mem0 => mem0.encodingFits
  | .FNSAVE_MEMmem94 mem0 => mem0.encodingFits

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSTENV-FNSTENV.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSTENV where
  -- FNSTENV_MEMmem14: MEM0:w:mem14 REG0=XED_REG_X87STATUS:w:SUPP
  | FNSTENV_MEMmem14 (mem0 : MemoryOperand)
  -- FNSTENV_MEMmem28: MEM0:w:mem28 REG0=XED_REG_X87STATUS:w:SUPP
  | FNSTENV_MEMmem28 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FSTENV.xedForm : Forms.FSTENV → XedForm
  | .FNSTENV_MEMmem14 _ => .FNSTENV_MEMmem14
  | .FNSTENV_MEMmem28 _ => .FNSTENV_MEMmem28

def Forms.FSTENV.encodingFits : Forms.FSTENV → Bool
  | .FNSTENV_MEMmem14 mem0 => mem0.encodingFits
  | .FNSTENV_MEMmem28 mem0 => mem0.encodingFits

end X86.Syntax

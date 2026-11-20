-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FLDENV.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FLDENV where
  -- FLDENV_MEMmem14: MEM0:r:mem14 REG0=XED_REG_X87STATUS:w:SUPP
  | FLDENV_MEMmem14 (mem0 : MemoryOperand)
  -- FLDENV_MEMmem28: MEM0:r:mem28 REG0=XED_REG_X87STATUS:w:SUPP
  | FLDENV_MEMmem28 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FLDENV.xedForm : Forms.FLDENV → XedForm
  | .FLDENV_MEMmem14 _ => .FLDENV_MEMmem14
  | .FLDENV_MEMmem28 _ => .FLDENV_MEMmem28

def Forms.FLDENV.encodingFits : Forms.FLDENV → Bool
  | .FLDENV_MEMmem14 mem0 => mem0.encodingFits
  | .FLDENV_MEMmem28 mem0 => mem0.encodingFits

end X86.Syntax

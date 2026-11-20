-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FLDCW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FLDCW where
  -- FLDCW_MEMmem16: MEM0:r:mem16 REG0=XED_REG_X87CONTROL:w:SUPP REG1=XED_REG_X87STATUS:w:SUPP
  | FLDCW_MEMmem16 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FLDCW.xedForm : Forms.FLDCW → XedForm
  | .FLDCW_MEMmem16 _ => .FLDCW_MEMmem16

def Forms.FLDCW.encodingFits : Forms.FLDCW → Bool
  | .FLDCW_MEMmem16 mem0 => mem0.encodingFits

end X86.Syntax

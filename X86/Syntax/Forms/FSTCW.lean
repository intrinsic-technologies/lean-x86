-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSTCW-FNSTCW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSTCW where
  -- FNSTCW_MEMmem16: MEM0:w:mem16 REG0=XED_REG_X87CONTROL:r:SUPP REG1=XED_REG_X87STATUS:w:SUPP
  | FNSTCW_MEMmem16 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FSTCW.xedForm : Forms.FSTCW → XedForm
  | .FNSTCW_MEMmem16 _ => .FNSTCW_MEMmem16

def Forms.FSTCW.encodingFits : Forms.FSTCW → Bool
  | .FNSTCW_MEMmem16 mem0 => mem0.encodingFits

end X86.Syntax

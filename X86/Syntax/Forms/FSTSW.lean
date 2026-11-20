-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSTSW-FNSTSW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSTSW where
  -- FNSTSW_AX: REG0=XED_REG_AX:w:IMPL REG1=XED_REG_X87STATUS:rw:SUPP
  | FNSTSW_AX
  -- FNSTSW_MEMmem16: MEM0:w:mem16 REG0=XED_REG_X87STATUS:rw:SUPP
  | FNSTSW_MEMmem16 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FSTSW.xedForm : Forms.FSTSW → XedForm
  | .FNSTSW_AX => .FNSTSW_AX
  | .FNSTSW_MEMmem16 _ => .FNSTSW_MEMmem16

def Forms.FSTSW.encodingFits : Forms.FSTSW → Bool
  | .FNSTSW_AX  => true
  | .FNSTSW_MEMmem16 mem0 => mem0.encodingFits

end X86.Syntax

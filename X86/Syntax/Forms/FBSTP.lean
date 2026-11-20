-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FBSTP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FBSTP where
  -- FBSTP_MEMmem80dec_ST0: MEM0:w:mem80dec REG0=XED_REG_ST0:r:IMPL:f80  REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FBSTP_MEMmem80dec_ST0 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FBSTP.xedForm : Forms.FBSTP → XedForm
  | .FBSTP_MEMmem80dec_ST0 _ => .FBSTP_MEMmem80dec_ST0

def Forms.FBSTP.encodingFits : Forms.FBSTP → Bool
  | .FBSTP_MEMmem80dec_ST0 mem0 => mem0.encodingFits

end X86.Syntax

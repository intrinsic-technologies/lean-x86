-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FIST-FISTP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FIST where
  -- FISTP_MEMm64int_ST0: MEM0:w:m64int REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FISTP_MEMm64int_ST0 (mem0 : MemoryOperand)
  -- FISTP_MEMmem16int_ST0: MEM0:w:mem16int REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FISTP_MEMmem16int_ST0 (mem0 : MemoryOperand)
  -- FISTP_MEMmem32int_ST0: MEM0:w:mem32int REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FISTP_MEMmem32int_ST0 (mem0 : MemoryOperand)
  -- FIST_MEMmem16int_ST0: MEM0:w:mem16int REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FIST_MEMmem16int_ST0 (mem0 : MemoryOperand)
  -- FIST_MEMmem32int_ST0: MEM0:w:mem32int REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87STATUS:w:SUPP
  | FIST_MEMmem32int_ST0 (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FIST.xedForm : Forms.FIST → XedForm
  | .FISTP_MEMm64int_ST0 _ => .FISTP_MEMm64int_ST0
  | .FISTP_MEMmem16int_ST0 _ => .FISTP_MEMmem16int_ST0
  | .FISTP_MEMmem32int_ST0 _ => .FISTP_MEMmem32int_ST0
  | .FIST_MEMmem16int_ST0 _ => .FIST_MEMmem16int_ST0
  | .FIST_MEMmem32int_ST0 _ => .FIST_MEMmem32int_ST0

def Forms.FIST.encodingFits : Forms.FIST → Bool
  | .FISTP_MEMm64int_ST0 mem0 => mem0.encodingFits
  | .FISTP_MEMmem16int_ST0 mem0 => mem0.encodingFits
  | .FISTP_MEMmem32int_ST0 mem0 => mem0.encodingFits
  | .FIST_MEMmem16int_ST0 mem0 => mem0.encodingFits
  | .FIST_MEMmem32int_ST0 mem0 => mem0.encodingFits

end X86.Syntax

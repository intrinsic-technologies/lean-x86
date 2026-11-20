-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSUBR-FSUBRP-FISUBR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSUBR where
  -- FISUBR_ST0_MEMmem16int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FISUBR_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FISUBR_ST0_MEMmem32int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FISUBR_ST0_MEMmem32int (mem0 : MemoryOperand)
  -- FSUBRP_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FSUBRP_X87_ST0 (reg0 : Registers.X87)
  -- FSUBR_ST0_MEMm64real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FSUBR_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FSUBR_ST0_MEMmem32real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FSUBR_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FSUBR_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FSUBR_ST0_X87 (reg1 : Registers.X87)
  -- FSUBR_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FSUBR_X87_ST0 (reg0 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FSUBR.xedForm : Forms.FSUBR → XedForm
  | .FISUBR_ST0_MEMmem16int _ => .FISUBR_ST0_MEMmem16int
  | .FISUBR_ST0_MEMmem32int _ => .FISUBR_ST0_MEMmem32int
  | .FSUBRP_X87_ST0 _ => .FSUBRP_X87_ST0
  | .FSUBR_ST0_MEMm64real _ => .FSUBR_ST0_MEMm64real
  | .FSUBR_ST0_MEMmem32real _ => .FSUBR_ST0_MEMmem32real
  | .FSUBR_ST0_X87 _ => .FSUBR_ST0_X87
  | .FSUBR_X87_ST0 _ => .FSUBR_X87_ST0

def Forms.FSUBR.encodingFits : Forms.FSUBR → Bool
  | .FISUBR_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FISUBR_ST0_MEMmem32int mem0 => mem0.encodingFits
  | .FSUBRP_X87_ST0 _ => true
  | .FSUBR_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FSUBR_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FSUBR_ST0_X87 _ => true
  | .FSUBR_X87_ST0 _ => true

end X86.Syntax

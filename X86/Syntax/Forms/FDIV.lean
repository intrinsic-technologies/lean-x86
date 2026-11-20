-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FDIV-FDIVP-FIDIV.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FDIV where
  -- FDIVP_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FDIVP_X87_ST0 (reg0 : Registers.X87)
  -- FDIV_ST0_MEMm64real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FDIV_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FDIV_ST0_MEMmem32real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FDIV_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FDIV_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FDIV_ST0_X87 (reg1 : Registers.X87)
  -- FDIV_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FDIV_X87_ST0 (reg0 : Registers.X87)
  -- FIDIV_ST0_MEMmem16int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FIDIV_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FIDIV_ST0_MEMmem32int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FIDIV_ST0_MEMmem32int (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FDIV.xedForm : Forms.FDIV → XedForm
  | .FDIVP_X87_ST0 _ => .FDIVP_X87_ST0
  | .FDIV_ST0_MEMm64real _ => .FDIV_ST0_MEMm64real
  | .FDIV_ST0_MEMmem32real _ => .FDIV_ST0_MEMmem32real
  | .FDIV_ST0_X87 _ => .FDIV_ST0_X87
  | .FDIV_X87_ST0 _ => .FDIV_X87_ST0
  | .FIDIV_ST0_MEMmem16int _ => .FIDIV_ST0_MEMmem16int
  | .FIDIV_ST0_MEMmem32int _ => .FIDIV_ST0_MEMmem32int

def Forms.FDIV.encodingFits : Forms.FDIV → Bool
  | .FDIVP_X87_ST0 _ => true
  | .FDIV_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FDIV_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FDIV_ST0_X87 _ => true
  | .FDIV_X87_ST0 _ => true
  | .FIDIV_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FIDIV_ST0_MEMmem32int mem0 => mem0.encodingFits

end X86.Syntax

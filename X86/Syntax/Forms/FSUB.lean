-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FSUB-FSUBP-FISUB.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FSUB where
  -- FISUB_ST0_MEMmem16int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FISUB_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FISUB_ST0_MEMmem32int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FISUB_ST0_MEMmem32int (mem0 : MemoryOperand)
  -- FSUBP_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FSUBP_X87_ST0 (reg0 : Registers.X87)
  -- FSUB_ST0_MEMm64real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FSUB_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FSUB_ST0_MEMmem32real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FSUB_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FSUB_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FSUB_ST0_X87 (reg1 : Registers.X87)
  -- FSUB_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FSUB_X87_ST0 (reg0 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FSUB.xedForm : Forms.FSUB → XedForm
  | .FISUB_ST0_MEMmem16int _ => .FISUB_ST0_MEMmem16int
  | .FISUB_ST0_MEMmem32int _ => .FISUB_ST0_MEMmem32int
  | .FSUBP_X87_ST0 _ => .FSUBP_X87_ST0
  | .FSUB_ST0_MEMm64real _ => .FSUB_ST0_MEMm64real
  | .FSUB_ST0_MEMmem32real _ => .FSUB_ST0_MEMmem32real
  | .FSUB_ST0_X87 _ => .FSUB_ST0_X87
  | .FSUB_X87_ST0 _ => .FSUB_X87_ST0

def Forms.FSUB.encodingFits : Forms.FSUB → Bool
  | .FISUB_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FISUB_ST0_MEMmem32int mem0 => mem0.encodingFits
  | .FSUBP_X87_ST0 _ => true
  | .FSUB_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FSUB_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FSUB_ST0_X87 _ => true
  | .FSUB_X87_ST0 _ => true

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FDIVR-FDIVRP-FIDIVR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FDIVR where
  -- FDIVRP_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FDIVRP_X87_ST0 (reg0 : Registers.X87)
  -- FDIVR_ST0_MEMm64real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FDIVR_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FDIVR_ST0_MEMmem32real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FDIVR_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FDIVR_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FDIVR_ST0_X87 (reg1 : Registers.X87)
  -- FDIVR_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FDIVR_X87_ST0 (reg0 : Registers.X87)
  -- FIDIVR_ST0_MEMmem16int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FIDIVR_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FIDIVR_ST0_MEMmem32int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FIDIVR_ST0_MEMmem32int (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FDIVR.xedForm : Forms.FDIVR → XedForm
  | .FDIVRP_X87_ST0 _ => .FDIVRP_X87_ST0
  | .FDIVR_ST0_MEMm64real _ => .FDIVR_ST0_MEMm64real
  | .FDIVR_ST0_MEMmem32real _ => .FDIVR_ST0_MEMmem32real
  | .FDIVR_ST0_X87 _ => .FDIVR_ST0_X87
  | .FDIVR_X87_ST0 _ => .FDIVR_X87_ST0
  | .FIDIVR_ST0_MEMmem16int _ => .FIDIVR_ST0_MEMmem16int
  | .FIDIVR_ST0_MEMmem32int _ => .FIDIVR_ST0_MEMmem32int

def Forms.FDIVR.encodingFits : Forms.FDIVR → Bool
  | .FDIVRP_X87_ST0 _ => true
  | .FDIVR_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FDIVR_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FDIVR_ST0_X87 _ => true
  | .FDIVR_X87_ST0 _ => true
  | .FIDIVR_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FIDIVR_ST0_MEMmem32int mem0 => mem0.encodingFits

end X86.Syntax

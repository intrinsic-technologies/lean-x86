-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FST-FSTP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FST where
  -- FSTPNCE_X87_ST0: REG0=X87():w:f80 REG1=XED_REG_ST0:r:IMPL:f80  REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FSTPNCE_X87_ST0 (reg0 : Registers.X87)
  -- FSTP_MEMm64real_ST0: MEM0:w:m64real REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FSTP_MEMm64real_ST0 (mem0 : MemoryOperand)
  -- FSTP_MEMmem32real_ST0: MEM0:w:mem32real REG0=XED_REG_ST0:r:IMPL:f80  REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FSTP_MEMmem32real_ST0 (mem0 : MemoryOperand)
  -- FSTP_MEMmem80real_ST0: MEM0:w:mem80real   REG0=XED_REG_ST0:r:IMPL:f80 REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FSTP_MEMmem80real_ST0 (mem0 : MemoryOperand)
  -- FSTP_X87_ST0: REG0=X87():w:f80 REG1=XED_REG_ST0:r:IMPL:f80  REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FSTP_X87_ST0 (reg0 : Registers.X87)
  -- FSTP_X87_ST0_DFD0: REG0=X87():w:f80 REG1=XED_REG_ST0:r:IMPL:f80  REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FSTP_X87_ST0_DFD0 (reg0 : Registers.X87)
  -- FSTP_X87_ST0_DFD1: REG0=X87():w:f80 REG1=XED_REG_ST0:r:IMPL:f80  REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FSTP_X87_ST0_DFD1 (reg0 : Registers.X87)
  -- FST_MEMm64real_ST0: MEM0:w:m64real REG0=XED_REG_ST0:r:IMPL:f80  REG1=XED_REG_X87STATUS:w:SUPP
  | FST_MEMm64real_ST0 (mem0 : MemoryOperand)
  -- FST_MEMmem32real_ST0: MEM0:w:mem32real REG0=XED_REG_ST0:r:IMPL:f80  REG1=XED_REG_X87STATUS:w:SUPP
  | FST_MEMmem32real_ST0 (mem0 : MemoryOperand)
  -- FST_X87_ST0: REG0=X87():w:f80 REG1=XED_REG_ST0:r:IMPL:f80  REG2=XED_REG_X87STATUS:w:SUPP
  | FST_X87_ST0 (reg0 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FST.xedForm : Forms.FST → XedForm
  | .FSTPNCE_X87_ST0 _ => .FSTPNCE_X87_ST0
  | .FSTP_MEMm64real_ST0 _ => .FSTP_MEMm64real_ST0
  | .FSTP_MEMmem32real_ST0 _ => .FSTP_MEMmem32real_ST0
  | .FSTP_MEMmem80real_ST0 _ => .FSTP_MEMmem80real_ST0
  | .FSTP_X87_ST0 _ => .FSTP_X87_ST0
  | .FSTP_X87_ST0_DFD0 _ => .FSTP_X87_ST0_DFD0
  | .FSTP_X87_ST0_DFD1 _ => .FSTP_X87_ST0_DFD1
  | .FST_MEMm64real_ST0 _ => .FST_MEMm64real_ST0
  | .FST_MEMmem32real_ST0 _ => .FST_MEMmem32real_ST0
  | .FST_X87_ST0 _ => .FST_X87_ST0

def Forms.FST.encodingFits : Forms.FST → Bool
  | .FSTPNCE_X87_ST0 _ => true
  | .FSTP_MEMm64real_ST0 mem0 => mem0.encodingFits
  | .FSTP_MEMmem32real_ST0 mem0 => mem0.encodingFits
  | .FSTP_MEMmem80real_ST0 mem0 => mem0.encodingFits
  | .FSTP_X87_ST0 _ => true
  | .FSTP_X87_ST0_DFD0 _ => true
  | .FSTP_X87_ST0_DFD1 _ => true
  | .FST_MEMm64real_ST0 mem0 => mem0.encodingFits
  | .FST_MEMmem32real_ST0 mem0 => mem0.encodingFits
  | .FST_X87_ST0 _ => true

end X86.Syntax

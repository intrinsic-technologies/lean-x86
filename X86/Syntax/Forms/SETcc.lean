-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SETcc.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SETcc where
  -- SETBE_GPR8: REG0=GPR8_B():w
  | SETBE_GPR8 (reg0 : Registers.GPR8)
  -- SETBE_MEMb: MEM0:w:b
  | SETBE_MEMb (mem0 : MemoryOperand)
  -- SETB_GPR8: REG0=GPR8_B():w
  | SETB_GPR8 (reg0 : Registers.GPR8)
  -- SETB_MEMb: MEM0:w:b
  | SETB_MEMb (mem0 : MemoryOperand)
  -- SETLE_GPR8: REG0=GPR8_B():w
  | SETLE_GPR8 (reg0 : Registers.GPR8)
  -- SETLE_MEMb: MEM0:w:b
  | SETLE_MEMb (mem0 : MemoryOperand)
  -- SETL_GPR8: REG0=GPR8_B():w
  | SETL_GPR8 (reg0 : Registers.GPR8)
  -- SETL_MEMb: MEM0:w:b
  | SETL_MEMb (mem0 : MemoryOperand)
  -- SETNBE_GPR8: REG0=GPR8_B():w
  | SETNBE_GPR8 (reg0 : Registers.GPR8)
  -- SETNBE_MEMb: MEM0:w:b
  | SETNBE_MEMb (mem0 : MemoryOperand)
  -- SETNB_GPR8: REG0=GPR8_B():w
  | SETNB_GPR8 (reg0 : Registers.GPR8)
  -- SETNB_MEMb: MEM0:w:b
  | SETNB_MEMb (mem0 : MemoryOperand)
  -- SETNLE_GPR8: REG0=GPR8_B():w
  | SETNLE_GPR8 (reg0 : Registers.GPR8)
  -- SETNLE_MEMb: MEM0:w:b
  | SETNLE_MEMb (mem0 : MemoryOperand)
  -- SETNL_GPR8: REG0=GPR8_B():w
  | SETNL_GPR8 (reg0 : Registers.GPR8)
  -- SETNL_MEMb: MEM0:w:b
  | SETNL_MEMb (mem0 : MemoryOperand)
  -- SETNO_GPR8: REG0=GPR8_B():w
  | SETNO_GPR8 (reg0 : Registers.GPR8)
  -- SETNO_MEMb: MEM0:w:b
  | SETNO_MEMb (mem0 : MemoryOperand)
  -- SETNP_GPR8: REG0=GPR8_B():w
  | SETNP_GPR8 (reg0 : Registers.GPR8)
  -- SETNP_MEMb: MEM0:w:b
  | SETNP_MEMb (mem0 : MemoryOperand)
  -- SETNS_GPR8: REG0=GPR8_B():w
  | SETNS_GPR8 (reg0 : Registers.GPR8)
  -- SETNS_MEMb: MEM0:w:b
  | SETNS_MEMb (mem0 : MemoryOperand)
  -- SETNZ_GPR8: REG0=GPR8_B():w
  | SETNZ_GPR8 (reg0 : Registers.GPR8)
  -- SETNZ_MEMb: MEM0:w:b
  | SETNZ_MEMb (mem0 : MemoryOperand)
  -- SETO_GPR8: REG0=GPR8_B():w
  | SETO_GPR8 (reg0 : Registers.GPR8)
  -- SETO_MEMb: MEM0:w:b
  | SETO_MEMb (mem0 : MemoryOperand)
  -- SETP_GPR8: REG0=GPR8_B():w
  | SETP_GPR8 (reg0 : Registers.GPR8)
  -- SETP_MEMb: MEM0:w:b
  | SETP_MEMb (mem0 : MemoryOperand)
  -- SETS_GPR8: REG0=GPR8_B():w
  | SETS_GPR8 (reg0 : Registers.GPR8)
  -- SETS_MEMb: MEM0:w:b
  | SETS_MEMb (mem0 : MemoryOperand)
  -- SETZ_GPR8: REG0=GPR8_B():w
  | SETZ_GPR8 (reg0 : Registers.GPR8)
  -- SETZ_MEMb: MEM0:w:b
  | SETZ_MEMb (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.SETcc.xedForm : Forms.SETcc → XedForm
  | .SETBE_GPR8 _ => .SETBE_GPR8
  | .SETBE_MEMb _ => .SETBE_MEMb
  | .SETB_GPR8 _ => .SETB_GPR8
  | .SETB_MEMb _ => .SETB_MEMb
  | .SETLE_GPR8 _ => .SETLE_GPR8
  | .SETLE_MEMb _ => .SETLE_MEMb
  | .SETL_GPR8 _ => .SETL_GPR8
  | .SETL_MEMb _ => .SETL_MEMb
  | .SETNBE_GPR8 _ => .SETNBE_GPR8
  | .SETNBE_MEMb _ => .SETNBE_MEMb
  | .SETNB_GPR8 _ => .SETNB_GPR8
  | .SETNB_MEMb _ => .SETNB_MEMb
  | .SETNLE_GPR8 _ => .SETNLE_GPR8
  | .SETNLE_MEMb _ => .SETNLE_MEMb
  | .SETNL_GPR8 _ => .SETNL_GPR8
  | .SETNL_MEMb _ => .SETNL_MEMb
  | .SETNO_GPR8 _ => .SETNO_GPR8
  | .SETNO_MEMb _ => .SETNO_MEMb
  | .SETNP_GPR8 _ => .SETNP_GPR8
  | .SETNP_MEMb _ => .SETNP_MEMb
  | .SETNS_GPR8 _ => .SETNS_GPR8
  | .SETNS_MEMb _ => .SETNS_MEMb
  | .SETNZ_GPR8 _ => .SETNZ_GPR8
  | .SETNZ_MEMb _ => .SETNZ_MEMb
  | .SETO_GPR8 _ => .SETO_GPR8
  | .SETO_MEMb _ => .SETO_MEMb
  | .SETP_GPR8 _ => .SETP_GPR8
  | .SETP_MEMb _ => .SETP_MEMb
  | .SETS_GPR8 _ => .SETS_GPR8
  | .SETS_MEMb _ => .SETS_MEMb
  | .SETZ_GPR8 _ => .SETZ_GPR8
  | .SETZ_MEMb _ => .SETZ_MEMb

def Forms.SETcc.encodingFits : Forms.SETcc → Bool
  | .SETBE_GPR8 _ => true
  | .SETBE_MEMb mem0 => mem0.encodingFits
  | .SETB_GPR8 _ => true
  | .SETB_MEMb mem0 => mem0.encodingFits
  | .SETLE_GPR8 _ => true
  | .SETLE_MEMb mem0 => mem0.encodingFits
  | .SETL_GPR8 _ => true
  | .SETL_MEMb mem0 => mem0.encodingFits
  | .SETNBE_GPR8 _ => true
  | .SETNBE_MEMb mem0 => mem0.encodingFits
  | .SETNB_GPR8 _ => true
  | .SETNB_MEMb mem0 => mem0.encodingFits
  | .SETNLE_GPR8 _ => true
  | .SETNLE_MEMb mem0 => mem0.encodingFits
  | .SETNL_GPR8 _ => true
  | .SETNL_MEMb mem0 => mem0.encodingFits
  | .SETNO_GPR8 _ => true
  | .SETNO_MEMb mem0 => mem0.encodingFits
  | .SETNP_GPR8 _ => true
  | .SETNP_MEMb mem0 => mem0.encodingFits
  | .SETNS_GPR8 _ => true
  | .SETNS_MEMb mem0 => mem0.encodingFits
  | .SETNZ_GPR8 _ => true
  | .SETNZ_MEMb mem0 => mem0.encodingFits
  | .SETO_GPR8 _ => true
  | .SETO_MEMb mem0 => mem0.encodingFits
  | .SETP_GPR8 _ => true
  | .SETP_MEMb mem0 => mem0.encodingFits
  | .SETS_GPR8 _ => true
  | .SETS_MEMb mem0 => mem0.encodingFits
  | .SETZ_GPR8 _ => true
  | .SETZ_MEMb mem0 => mem0.encodingFits

end X86.Syntax

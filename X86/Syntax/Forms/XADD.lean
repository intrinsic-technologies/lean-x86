-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/XADD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.XADD where
  -- XADD_GPR8_GPR8: REG0=GPR8_B():rw REG1=GPR8_R():rw
  | XADD_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- XADD_GPRv_GPRv: REG0=GPRv_B():rw REG1=GPRv_R():rw
  | XADD_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- XADD_LOCK_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():rw
  | XADD_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- XADD_LOCK_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():rw
  | XADD_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- XADD_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():rw
  | XADD_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- XADD_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():rw
  | XADD_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  deriving Repr, BEq, Inhabited

def Forms.XADD.xedForm : Forms.XADD → XedForm
  | .XADD_GPR8_GPR8 _ _ => .XADD_GPR8_GPR8
  | .XADD_GPRv_GPRv _ _ => .XADD_GPRv_GPRv
  | .XADD_LOCK_MEMb_GPR8 _ _ => .XADD_LOCK_MEMb_GPR8
  | .XADD_LOCK_MEMv_GPRv _ _ => .XADD_LOCK_MEMv_GPRv
  | .XADD_MEMb_GPR8 _ _ => .XADD_MEMb_GPR8
  | .XADD_MEMv_GPRv _ _ => .XADD_MEMv_GPRv

def Forms.XADD.encodingFits : Forms.XADD → Bool
  | .XADD_GPR8_GPR8 _ _ => true
  | .XADD_GPRv_GPRv _ _ => true
  | .XADD_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .XADD_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .XADD_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .XADD_MEMv_GPRv mem0 _ => mem0.encodingFits

end X86.Syntax

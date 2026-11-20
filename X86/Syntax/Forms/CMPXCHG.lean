-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMPXCHG.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMPXCHG where
  -- CMPXCHG_GPR8_GPR8: REG0=GPR8_B():rcw REG1=GPR8_R():r REG2=XED_REG_AL:rcw:SUPP
  | CMPXCHG_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- CMPXCHG_GPRv_GPRv: REG0=GPRv_B():rcw REG1=GPRv_R():r REG2=OrAX():rcw:SUPP
  | CMPXCHG_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- CMPXCHG_LOCK_MEMb_GPR8: MEM0:rcw:b REG0=GPR8_R():r REG1=XED_REG_AL:rcw:SUPP
  | CMPXCHG_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- CMPXCHG_LOCK_MEMv_GPRv: MEM0:rcw:v REG0=GPRv_R():r REG1=OrAX():rcw:SUPP
  | CMPXCHG_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- CMPXCHG_MEMb_GPR8: MEM0:rcw:b REG0=GPR8_R():r REG1=XED_REG_AL:rcw:SUPP
  | CMPXCHG_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- CMPXCHG_MEMv_GPRv: MEM0:rcw:v REG0=GPRv_R():r REG1=OrAX():rcw:SUPP
  | CMPXCHG_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  deriving Repr, BEq, Inhabited

def Forms.CMPXCHG.xedForm : Forms.CMPXCHG → XedForm
  | .CMPXCHG_GPR8_GPR8 _ _ => .CMPXCHG_GPR8_GPR8
  | .CMPXCHG_GPRv_GPRv _ _ => .CMPXCHG_GPRv_GPRv
  | .CMPXCHG_LOCK_MEMb_GPR8 _ _ => .CMPXCHG_LOCK_MEMb_GPR8
  | .CMPXCHG_LOCK_MEMv_GPRv _ _ => .CMPXCHG_LOCK_MEMv_GPRv
  | .CMPXCHG_MEMb_GPR8 _ _ => .CMPXCHG_MEMb_GPR8
  | .CMPXCHG_MEMv_GPRv _ _ => .CMPXCHG_MEMv_GPRv

def Forms.CMPXCHG.encodingFits : Forms.CMPXCHG → Bool
  | .CMPXCHG_GPR8_GPR8 _ _ => true
  | .CMPXCHG_GPRv_GPRv _ _ => true
  | .CMPXCHG_LOCK_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .CMPXCHG_LOCK_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .CMPXCHG_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .CMPXCHG_MEMv_GPRv mem0 _ => mem0.encodingFits

end X86.Syntax

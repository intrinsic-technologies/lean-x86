-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/XCHG.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.XCHG where
  -- XCHG_GPR8_GPR8: REG0=GPR8_B():rw REG1=GPR8_R():rw
  | XCHG_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- XCHG_GPRv_GPRv: REG0=GPRv_B():rw REG1=GPRv_R():rw
  | XCHG_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- XCHG_GPRv_OrAX: REG0=GPRv_SB():rw REG1=OrAX():rw:IMPL
  | XCHG_GPRv_OrAX (reg0 : Registers.GPRv) (reg1 : Registers.OrAX)
  -- XCHG_MEMb_GPR8: MEM0:rw:b REG0=GPR8_R():rw
  | XCHG_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- XCHG_MEMv_GPRv: MEM0:rw:v REG0=GPRv_R():rw
  | XCHG_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  deriving Repr, BEq, Inhabited

def Forms.XCHG.xedForm : Forms.XCHG → XedForm
  | .XCHG_GPR8_GPR8 _ _ => .XCHG_GPR8_GPR8
  | .XCHG_GPRv_GPRv _ _ => .XCHG_GPRv_GPRv
  | .XCHG_GPRv_OrAX _ _ => .XCHG_GPRv_OrAX
  | .XCHG_MEMb_GPR8 _ _ => .XCHG_MEMb_GPR8
  | .XCHG_MEMv_GPRv _ _ => .XCHG_MEMv_GPRv

def Forms.XCHG.encodingFits : Forms.XCHG → Bool
  | .XCHG_GPR8_GPR8 _ _ => true
  | .XCHG_GPRv_GPRv _ _ => true
  | .XCHG_GPRv_OrAX _ _ => true
  | .XCHG_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .XCHG_MEMv_GPRv mem0 _ => mem0.encodingFits

end X86.Syntax

-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PUSH.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PUSH where
  -- PUSH_FS: REG0=XED_REG_FS:r:IMPL REG1=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_FS
  -- PUSH_GPRv_50: REG0=GPRv_SB():r REG1=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_GPRv_50 (reg0 : Registers.GPRv)
  -- PUSH_GPRv_FFr6: REG0=GPRv_B():r REG1=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_GPRv_FFr6 (reg0 : Registers.GPRv)
  -- PUSH_GS: REG0=XED_REG_GS:r:IMPL REG1=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_GS
  -- PUSH_IMMb: IMM0:r:b:i8 REG0=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_IMMb (imm0 : Immediate)
  -- PUSH_IMMz: IMM0:r:z REG0=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_IMMz (imm0 : Immediate)
  -- PUSH_MEMv: MEM0:r:v REG0=XED_REG_STACKPUSH:rw:spw:SUPP
  | PUSH_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.PUSH.xedForm : Forms.PUSH → XedForm
  | .PUSH_FS => .PUSH_FS
  | .PUSH_GPRv_50 _ => .PUSH_GPRv_50
  | .PUSH_GPRv_FFr6 _ => .PUSH_GPRv_FFr6
  | .PUSH_GS => .PUSH_GS
  | .PUSH_IMMb _ => .PUSH_IMMb
  | .PUSH_IMMz _ => .PUSH_IMMz
  | .PUSH_MEMv _ => .PUSH_MEMv

def Forms.PUSH.encodingFits : Forms.PUSH → Bool
  | .PUSH_FS  => true
  | .PUSH_GPRv_50 _ => true
  | .PUSH_GPRv_FFr6 _ => true
  | .PUSH_GS  => true
  | .PUSH_IMMb imm0 => imm0.encodingFits
  | .PUSH_IMMz imm0 => imm0.encodingFits
  | .PUSH_MEMv mem0 => mem0.encodingFits

end X86.Syntax

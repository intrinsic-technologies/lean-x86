-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOV.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOV where
  -- MOV_AL_MEMb: REG0=XED_REG_AL:w:IMPL MEM0:r:b SEG0=FINAL_DSEG():r:SUPP BASE0=XED_REG_INVALID:r:ECOND INDEX=XED_REG_INVALID:r:ECOND
  | MOV_AL_MEMb (mem0 : MemoryOperand)
  -- MOV_GPR8_GPR8_88: REG0=GPR8_B():w REG1=GPR8_R():r
  | MOV_GPR8_GPR8_88 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- MOV_GPR8_GPR8_8A: REG0=GPR8_R():w REG1=GPR8_B():r
  | MOV_GPR8_GPR8_8A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8)
  -- MOV_GPR8_IMMb_B0: REG0=GPR8_SB():w IMM0:r:b
  | MOV_GPR8_IMMb_B0 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- MOV_GPR8_IMMb_C6r0: REG0=GPR8_B():w IMM0:r:b
  | MOV_GPR8_IMMb_C6r0 (reg0 : Registers.GPR8) (imm0 : Immediate)
  -- MOV_GPR8_MEMb: REG0=GPR8_R():w MEM0:r:b
  | MOV_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand)
  -- MOV_GPRv_GPRv_89: REG0=GPRv_B():w REG1=GPRv_R():r
  | MOV_GPRv_GPRv_89 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- MOV_GPRv_GPRv_8B: REG0=GPRv_R():w REG1=GPRv_B():r
  | MOV_GPRv_GPRv_8B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- MOV_GPRv_IMMv: REG0=GPRv_SB():w IMM0:r:v
  | MOV_GPRv_IMMv (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- MOV_GPRv_IMMz: REG0=GPRv_B():w IMM0:r:z
  | MOV_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate)
  -- MOV_GPRv_MEMv: REG0=GPRv_R():w MEM0:r:v
  | MOV_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand)
  -- MOV_GPRv_SEG: REG0=GPRv_B():w REG1=SEG():r
  | MOV_GPRv_SEG (reg0 : Registers.GPRv) (reg1 : Registers.SEG)
  -- MOV_MEMb_AL: MEM0:w:b REG0=XED_REG_AL:r:IMPL SEG0=FINAL_DSEG():r:SUPP BASE0=XED_REG_INVALID:r:ECOND INDEX=XED_REG_INVALID:r:ECOND
  | MOV_MEMb_AL (mem0 : MemoryOperand)
  -- MOV_MEMb_GPR8: MEM0:w:b REG0=GPR8_R():r
  | MOV_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8)
  -- MOV_MEMb_IMMb: MEM0:w:b IMM0:r:b
  | MOV_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate)
  -- MOV_MEMv_GPRv: MEM0:w:v REG0=GPRv_R():r
  | MOV_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- MOV_MEMv_IMMz: MEM0:w:v IMM0:r:z
  | MOV_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate)
  -- MOV_MEMv_OrAX: MEM0:w:v REG0=OrAX():r:IMPL  SEG0=FINAL_DSEG():r:SUPP BASE0=XED_REG_INVALID:r:ECOND INDEX=XED_REG_INVALID:r:ECOND
  | MOV_MEMv_OrAX (mem0 : MemoryOperand) (reg0 : Registers.OrAX)
  -- MOV_MEMw_SEG: MEM0:w:w REG0=SEG():r
  | MOV_MEMw_SEG (mem0 : MemoryOperand) (reg0 : Registers.SEG)
  -- MOV_OrAX_MEMv: REG0=OrAX():w:IMPL MEM0:r:v SEG0=FINAL_DSEG():r:SUPP BASE0=XED_REG_INVALID:r:ECOND INDEX=XED_REG_INVALID:r:ECOND
  | MOV_OrAX_MEMv (reg0 : Registers.OrAX) (mem0 : MemoryOperand)
  -- MOV_SEG_GPR16: REG0=SEG_MOV():w REG1=GPR16_B():r
  | MOV_SEG_GPR16 (reg0 : Registers.SEG_MOV) (reg1 : Registers.GPR16)
  -- MOV_SEG_MEMw: REG0=SEG_MOV():w MEM0:r:w
  | MOV_SEG_MEMw (reg0 : Registers.SEG_MOV) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOV.xedForm : Forms.MOV → XedForm
  | .MOV_AL_MEMb _ => .MOV_AL_MEMb
  | .MOV_GPR8_GPR8_88 _ _ => .MOV_GPR8_GPR8_88
  | .MOV_GPR8_GPR8_8A _ _ => .MOV_GPR8_GPR8_8A
  | .MOV_GPR8_IMMb_B0 _ _ => .MOV_GPR8_IMMb_B0
  | .MOV_GPR8_IMMb_C6r0 _ _ => .MOV_GPR8_IMMb_C6r0
  | .MOV_GPR8_MEMb _ _ => .MOV_GPR8_MEMb
  | .MOV_GPRv_GPRv_89 _ _ => .MOV_GPRv_GPRv_89
  | .MOV_GPRv_GPRv_8B _ _ => .MOV_GPRv_GPRv_8B
  | .MOV_GPRv_IMMv _ _ => .MOV_GPRv_IMMv
  | .MOV_GPRv_IMMz _ _ => .MOV_GPRv_IMMz
  | .MOV_GPRv_MEMv _ _ => .MOV_GPRv_MEMv
  | .MOV_GPRv_SEG _ _ => .MOV_GPRv_SEG
  | .MOV_MEMb_AL _ => .MOV_MEMb_AL
  | .MOV_MEMb_GPR8 _ _ => .MOV_MEMb_GPR8
  | .MOV_MEMb_IMMb _ _ => .MOV_MEMb_IMMb
  | .MOV_MEMv_GPRv _ _ => .MOV_MEMv_GPRv
  | .MOV_MEMv_IMMz _ _ => .MOV_MEMv_IMMz
  | .MOV_MEMv_OrAX _ _ => .MOV_MEMv_OrAX
  | .MOV_MEMw_SEG _ _ => .MOV_MEMw_SEG
  | .MOV_OrAX_MEMv _ _ => .MOV_OrAX_MEMv
  | .MOV_SEG_GPR16 _ _ => .MOV_SEG_GPR16
  | .MOV_SEG_MEMw _ _ => .MOV_SEG_MEMw

def Forms.MOV.encodingFits : Forms.MOV → Bool
  | .MOV_AL_MEMb mem0 => mem0.encodingFits
  | .MOV_GPR8_GPR8_88 _ _ => true
  | .MOV_GPR8_GPR8_8A _ _ => true
  | .MOV_GPR8_IMMb_B0 _ imm0 => imm0.encodingFits
  | .MOV_GPR8_IMMb_C6r0 _ imm0 => imm0.encodingFits
  | .MOV_GPR8_MEMb _ mem0 => mem0.encodingFits
  | .MOV_GPRv_GPRv_89 _ _ => true
  | .MOV_GPRv_GPRv_8B _ _ => true
  | .MOV_GPRv_IMMv _ imm0 => imm0.encodingFits
  | .MOV_GPRv_IMMz _ imm0 => imm0.encodingFits
  | .MOV_GPRv_MEMv _ mem0 => mem0.encodingFits
  | .MOV_GPRv_SEG _ _ => true
  | .MOV_MEMb_AL mem0 => mem0.encodingFits
  | .MOV_MEMb_GPR8 mem0 _ => mem0.encodingFits
  | .MOV_MEMb_IMMb mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .MOV_MEMv_GPRv mem0 _ => mem0.encodingFits
  | .MOV_MEMv_IMMz mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .MOV_MEMv_OrAX mem0 _ => mem0.encodingFits
  | .MOV_MEMw_SEG mem0 _ => mem0.encodingFits
  | .MOV_OrAX_MEMv _ mem0 => mem0.encodingFits
  | .MOV_SEG_GPR16 _ _ => true
  | .MOV_SEG_MEMw _ mem0 => mem0.encodingFits

end X86.Syntax

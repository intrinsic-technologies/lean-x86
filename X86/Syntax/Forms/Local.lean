-- Generated from pinned Intel XED operand tables and selected SDM forms; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.Local where
  -- CMPSB: MEM0:r:SUPP:b BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:r:SUPP:b BASE1=ArDI():rw:SUPP SEG1=FINAL_ESEG1():r:SUPP
  | CMPSB
  -- CMPSD: MEM0:r:SUPP:d BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:r:SUPP:d BASE1=ArDI():rw:SUPP SEG1=FINAL_ESEG1():r:SUPP
  | CMPSD
  -- CMPSQ: MEM0:r:SUPP:q BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:r:SUPP:q BASE1=ArDI():rw:SUPP SEG1=FINAL_ESEG1():r:SUPP
  | CMPSQ
  -- CMPSW: MEM0:r:SUPP:w BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:r:SUPP:w BASE1=ArDI():rw:SUPP SEG1=FINAL_ESEG1():r:SUPP
  | CMPSW
  -- FDISI8087_NOP
  | FDISI8087_NOP
  -- FENI8087_NOP
  | FENI8087_NOP
  -- FSETPM287_NOP
  | FSETPM287_NOP
  -- FXRSTOR64_MEMmfpxenv: MEM0:r:mfpxenv REG0=XED_REG_X87CONTROL:w:SUPP
  | FXRSTOR64_MEMmfpxenv (mem0 : MemoryOperand)
  -- FXRSTOR_MEMmfpxenv: MEM0:r:mfpxenv REG0=XED_REG_X87CONTROL:w:SUPP
  | FXRSTOR_MEMmfpxenv (mem0 : MemoryOperand)
  -- FXSAVE64_MEMmfpxenv: MEM0:w:mfpxenv REG0=XED_REG_X87CONTROL:r:SUPP
  | FXSAVE64_MEMmfpxenv (mem0 : MemoryOperand)
  -- FXSAVE_MEMmfpxenv: MEM0:w:mfpxenv REG0=XED_REG_X87CONTROL:r:SUPP
  | FXSAVE_MEMmfpxenv (mem0 : MemoryOperand)
  -- INVLPG_MEMb: MEM0:r:b
  | INVLPG_MEMb (mem0 : MemoryOperand)
  -- IN_AL_DX: REG0=XED_REG_AL:w:IMPL REG1=XED_REG_DX:r:IMPL
  | IN_AL_DX
  -- IN_AL_IMMb: REG0=XED_REG_AL:w:IMPL IMM0:r:b
  | IN_AL_IMMb (imm0 : Immediate)
  -- IN_OeAX_DX: REG0=OeAX():w:IMPL REG1=XED_REG_DX:r:IMPL
  | IN_OeAX_DX (reg0 : Registers.OeAX)
  -- IN_OeAX_IMMb: REG0=OeAX():w:IMPL IMM0:r:b
  | IN_OeAX_IMMb (reg0 : Registers.OeAX) (imm0 : Immediate)
  -- LTR_GPR16: REG0=GPR16_B():r REG1=XED_REG_TR:w:SUPP
  | LTR_GPR16 (reg0 : Registers.GPR16)
  -- LTR_MEMw: MEM0:r:w REG0=XED_REG_TR:w:SUPP
  | LTR_MEMw (mem0 : MemoryOperand)
  -- NOP_90
  | NOP_90
  -- NOP_GPRv_0F18r0: REG0=GPRv_B():r
  | NOP_GPRv_0F18r0 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r1: REG0=GPRv_B():r
  | NOP_GPRv_0F18r1 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r2: REG0=GPRv_B():r
  | NOP_GPRv_0F18r2 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r3: REG0=GPRv_B():r
  | NOP_GPRv_0F18r3 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r4: REG0=GPRv_B():r
  | NOP_GPRv_0F18r4 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r5: REG0=GPRv_B():r
  | NOP_GPRv_0F18r5 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r6: REG0=GPRv_B():r
  | NOP_GPRv_0F18r6 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F18r7: REG0=GPRv_B():r
  | NOP_GPRv_0F18r7 (reg0 : Registers.GPRv)
  -- NOP_GPRv_0F1F: REG0=GPRv_B():r
  | NOP_GPRv_0F1F (reg0 : Registers.GPRv)
  -- NOP_GPRv_GPRv_0F19: REG0=GPRv_B():r REG1=GPRv_R():r
  | NOP_GPRv_GPRv_0F19 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- NOP_GPRv_GPRv_0F1A: REG0=GPRv_B():r REG1=GPRv_R():r
  | NOP_GPRv_GPRv_0F1A (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- NOP_GPRv_GPRv_0F1B: REG0=GPRv_B():r REG1=GPRv_R():r
  | NOP_GPRv_GPRv_0F1B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- NOP_GPRv_GPRv_0F1C: REG0=GPRv_B():r REG1=GPRv_R():r
  | NOP_GPRv_GPRv_0F1C (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- NOP_GPRv_GPRv_0F1D: REG0=GPRv_B():r REG1=GPRv_R():r
  | NOP_GPRv_GPRv_0F1D (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- NOP_GPRv_GPRv_0F1E: REG0=GPRv_B():r REG1=GPRv_R():r
  | NOP_GPRv_GPRv_0F1E (reg0 : Registers.GPRv) (reg1 : Registers.GPRv)
  -- NOP_MEMv_0F18r4: MEM0:r:v
  | NOP_MEMv_0F18r4 (mem0 : MemoryOperand)
  -- NOP_MEMv_0F18r5: MEM0:r:v
  | NOP_MEMv_0F18r5 (mem0 : MemoryOperand)
  -- NOP_MEMv_0F18r6: MEM0:r:v
  | NOP_MEMv_0F18r6 (mem0 : MemoryOperand)
  -- NOP_MEMv_0F18r7: MEM0:r:v
  | NOP_MEMv_0F18r7 (mem0 : MemoryOperand)
  -- NOP_MEMv_0F1F: MEM0:r:v
  | NOP_MEMv_0F1F (mem0 : MemoryOperand)
  -- NOP_MEMv_GPRv_0F19: MEM0:r:v REG0=GPRv_R():r
  | NOP_MEMv_GPRv_0F19 (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- NOP_MEMv_GPRv_0F1A: MEM0:r:v REG0=GPRv_R():r
  | NOP_MEMv_GPRv_0F1A (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- NOP_MEMv_GPRv_0F1B: MEM0:r:v REG0=GPRv_R():r
  | NOP_MEMv_GPRv_0F1B (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- NOP_MEMv_GPRv_0F1C: MEM0:r:v REG0=GPRv_R():r
  | NOP_MEMv_GPRv_0F1C (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- NOP_MEMv_GPRv_0F1D: MEM0:r:v REG0=GPRv_R():r
  | NOP_MEMv_GPRv_0F1D (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- NOP_MEMv_GPRv_0F1E: MEM0:r:v REG0=GPRv_R():r
  | NOP_MEMv_GPRv_0F1E (mem0 : MemoryOperand) (reg0 : Registers.GPRv)
  -- OUT_DX_AL: REG0=XED_REG_DX:r:IMPL REG1=XED_REG_AL:r:IMPL
  | OUT_DX_AL
  -- OUT_DX_OeAX: REG0=XED_REG_DX:r:IMPL REG1=OeAX():r:IMPL
  | OUT_DX_OeAX (reg1 : Registers.OeAX)
  -- OUT_IMMb_AL: IMM0:r:b REG0=XED_REG_AL:r:IMPL
  | OUT_IMMb_AL (imm0 : Immediate)
  -- OUT_IMMb_OeAX: IMM0:r:b REG0=OeAX():r:IMPL
  | OUT_IMMb_OeAX (imm0 : Immediate) (reg0 : Registers.OeAX)
  -- PAUSE
  | PAUSE
  -- POPF: REG0=XED_REG_STACKPOP:rw:w:SUPP REG1=XED_REG_RFLAGS:rw:SUPP:w:u16
  | POPF
  -- POPFQ: REG0=XED_REG_STACKPOP:rw:q:SUPP REG1=XED_REG_RFLAGS:rw:SUPP:q:u64
  | POPFQ
  -- REPE_CMPSB: MEM0:cr:SUPP:b BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:b BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPE_CMPSB
  -- REPE_CMPSD: MEM0:cr:SUPP:d BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:d BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPE_CMPSD
  -- REPE_CMPSQ: MEM0:cr:SUPP:q BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:q BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPE_CMPSQ
  -- REPE_CMPSW: MEM0:cr:SUPP:w BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:w BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPE_CMPSW
  -- REPNE_CMPSB: MEM0:cr:SUPP:b BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:b BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPNE_CMPSB
  -- REPNE_CMPSD: MEM0:cr:SUPP:d BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:d BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPNE_CMPSD
  -- REPNE_CMPSQ: MEM0:cr:SUPP:q BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:q BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPNE_CMPSQ
  -- REPNE_CMPSW: MEM0:cr:SUPP:w BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP MEM1:cr:SUPP:w BASE1=ArDI():rcw:SUPP SEG1=FINAL_ESEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REPNE_CMPSW
  -- STR_GPRv: REG0=GPRv_B():w REG1=XED_REG_TR:r:SUPP
  | STR_GPRv (reg0 : Registers.GPRv)
  -- STR_MEMw: MEM0:w:w REG0=XED_REG_TR:r:SUPP
  | STR_MEMw (mem0 : MemoryOperand)
  -- SYSRET: REG0=XED_REG_EIP:w:SUPP  REG1=XED_REG_ECX:r:SUPP
  | SYSRET
  -- SYSRET64: REG0=XED_REG_RIP:w:SUPP  REG1=XED_REG_RCX:r:SUPP  REG2=XED_REG_R11:r:SUPP
  | SYSRET64
  deriving Repr, BEq, Inhabited

def Forms.Local.xedForm : Forms.Local → XedForm
  | .CMPSB => .CMPSB
  | .CMPSD => .CMPSD
  | .CMPSQ => .CMPSQ
  | .CMPSW => .CMPSW
  | .FDISI8087_NOP => .FDISI8087_NOP
  | .FENI8087_NOP => .FENI8087_NOP
  | .FSETPM287_NOP => .FSETPM287_NOP
  | .FXRSTOR64_MEMmfpxenv _ => .FXRSTOR64_MEMmfpxenv
  | .FXRSTOR_MEMmfpxenv _ => .FXRSTOR_MEMmfpxenv
  | .FXSAVE64_MEMmfpxenv _ => .FXSAVE64_MEMmfpxenv
  | .FXSAVE_MEMmfpxenv _ => .FXSAVE_MEMmfpxenv
  | .INVLPG_MEMb _ => .INVLPG_MEMb
  | .IN_AL_DX => .IN_AL_DX
  | .IN_AL_IMMb _ => .IN_AL_IMMb
  | .IN_OeAX_DX _ => .IN_OeAX_DX
  | .IN_OeAX_IMMb _ _ => .IN_OeAX_IMMb
  | .LTR_GPR16 _ => .LTR_GPR16
  | .LTR_MEMw _ => .LTR_MEMw
  | .NOP_90 => .NOP_90
  | .NOP_GPRv_0F18r0 _ => .NOP_GPRv_0F18r0
  | .NOP_GPRv_0F18r1 _ => .NOP_GPRv_0F18r1
  | .NOP_GPRv_0F18r2 _ => .NOP_GPRv_0F18r2
  | .NOP_GPRv_0F18r3 _ => .NOP_GPRv_0F18r3
  | .NOP_GPRv_0F18r4 _ => .NOP_GPRv_0F18r4
  | .NOP_GPRv_0F18r5 _ => .NOP_GPRv_0F18r5
  | .NOP_GPRv_0F18r6 _ => .NOP_GPRv_0F18r6
  | .NOP_GPRv_0F18r7 _ => .NOP_GPRv_0F18r7
  | .NOP_GPRv_0F1F _ => .NOP_GPRv_0F1F
  | .NOP_GPRv_GPRv_0F19 _ _ => .NOP_GPRv_GPRv_0F19
  | .NOP_GPRv_GPRv_0F1A _ _ => .NOP_GPRv_GPRv_0F1A
  | .NOP_GPRv_GPRv_0F1B _ _ => .NOP_GPRv_GPRv_0F1B
  | .NOP_GPRv_GPRv_0F1C _ _ => .NOP_GPRv_GPRv_0F1C
  | .NOP_GPRv_GPRv_0F1D _ _ => .NOP_GPRv_GPRv_0F1D
  | .NOP_GPRv_GPRv_0F1E _ _ => .NOP_GPRv_GPRv_0F1E
  | .NOP_MEMv_0F18r4 _ => .NOP_MEMv_0F18r4
  | .NOP_MEMv_0F18r5 _ => .NOP_MEMv_0F18r5
  | .NOP_MEMv_0F18r6 _ => .NOP_MEMv_0F18r6
  | .NOP_MEMv_0F18r7 _ => .NOP_MEMv_0F18r7
  | .NOP_MEMv_0F1F _ => .NOP_MEMv_0F1F
  | .NOP_MEMv_GPRv_0F19 _ _ => .NOP_MEMv_GPRv_0F19
  | .NOP_MEMv_GPRv_0F1A _ _ => .NOP_MEMv_GPRv_0F1A
  | .NOP_MEMv_GPRv_0F1B _ _ => .NOP_MEMv_GPRv_0F1B
  | .NOP_MEMv_GPRv_0F1C _ _ => .NOP_MEMv_GPRv_0F1C
  | .NOP_MEMv_GPRv_0F1D _ _ => .NOP_MEMv_GPRv_0F1D
  | .NOP_MEMv_GPRv_0F1E _ _ => .NOP_MEMv_GPRv_0F1E
  | .OUT_DX_AL => .OUT_DX_AL
  | .OUT_DX_OeAX _ => .OUT_DX_OeAX
  | .OUT_IMMb_AL _ => .OUT_IMMb_AL
  | .OUT_IMMb_OeAX _ _ => .OUT_IMMb_OeAX
  | .PAUSE => .PAUSE
  | .POPF => .POPF
  | .POPFQ => .POPFQ
  | .REPE_CMPSB => .REPE_CMPSB
  | .REPE_CMPSD => .REPE_CMPSD
  | .REPE_CMPSQ => .REPE_CMPSQ
  | .REPE_CMPSW => .REPE_CMPSW
  | .REPNE_CMPSB => .REPNE_CMPSB
  | .REPNE_CMPSD => .REPNE_CMPSD
  | .REPNE_CMPSQ => .REPNE_CMPSQ
  | .REPNE_CMPSW => .REPNE_CMPSW
  | .STR_GPRv _ => .STR_GPRv
  | .STR_MEMw _ => .STR_MEMw
  | .SYSRET => .SYSRET
  | .SYSRET64 => .SYSRET64

def Forms.Local.encodingFits : Forms.Local → Bool
  | .CMPSB  => true
  | .CMPSD  => true
  | .CMPSQ  => true
  | .CMPSW  => true
  | .FDISI8087_NOP  => true
  | .FENI8087_NOP  => true
  | .FSETPM287_NOP  => true
  | .FXRSTOR64_MEMmfpxenv mem0 => mem0.encodingFits
  | .FXRSTOR_MEMmfpxenv mem0 => mem0.encodingFits
  | .FXSAVE64_MEMmfpxenv mem0 => mem0.encodingFits
  | .FXSAVE_MEMmfpxenv mem0 => mem0.encodingFits
  | .INVLPG_MEMb mem0 => mem0.encodingFits
  | .IN_AL_DX  => true
  | .IN_AL_IMMb imm0 => imm0.encodingFits
  | .IN_OeAX_DX _ => true
  | .IN_OeAX_IMMb _ imm0 => imm0.encodingFits
  | .LTR_GPR16 _ => true
  | .LTR_MEMw mem0 => mem0.encodingFits
  | .NOP_90  => true
  | .NOP_GPRv_0F18r0 _ => true
  | .NOP_GPRv_0F18r1 _ => true
  | .NOP_GPRv_0F18r2 _ => true
  | .NOP_GPRv_0F18r3 _ => true
  | .NOP_GPRv_0F18r4 _ => true
  | .NOP_GPRv_0F18r5 _ => true
  | .NOP_GPRv_0F18r6 _ => true
  | .NOP_GPRv_0F18r7 _ => true
  | .NOP_GPRv_0F1F _ => true
  | .NOP_GPRv_GPRv_0F19 _ _ => true
  | .NOP_GPRv_GPRv_0F1A _ _ => true
  | .NOP_GPRv_GPRv_0F1B _ _ => true
  | .NOP_GPRv_GPRv_0F1C _ _ => true
  | .NOP_GPRv_GPRv_0F1D _ _ => true
  | .NOP_GPRv_GPRv_0F1E _ _ => true
  | .NOP_MEMv_0F18r4 mem0 => mem0.encodingFits
  | .NOP_MEMv_0F18r5 mem0 => mem0.encodingFits
  | .NOP_MEMv_0F18r6 mem0 => mem0.encodingFits
  | .NOP_MEMv_0F18r7 mem0 => mem0.encodingFits
  | .NOP_MEMv_0F1F mem0 => mem0.encodingFits
  | .NOP_MEMv_GPRv_0F19 mem0 _ => mem0.encodingFits
  | .NOP_MEMv_GPRv_0F1A mem0 _ => mem0.encodingFits
  | .NOP_MEMv_GPRv_0F1B mem0 _ => mem0.encodingFits
  | .NOP_MEMv_GPRv_0F1C mem0 _ => mem0.encodingFits
  | .NOP_MEMv_GPRv_0F1D mem0 _ => mem0.encodingFits
  | .NOP_MEMv_GPRv_0F1E mem0 _ => mem0.encodingFits
  | .OUT_DX_AL  => true
  | .OUT_DX_OeAX _ => true
  | .OUT_IMMb_AL imm0 => imm0.encodingFits
  | .OUT_IMMb_OeAX imm0 _ => imm0.encodingFits
  | .PAUSE  => true
  | .POPF  => true
  | .POPFQ  => true
  | .REPE_CMPSB  => true
  | .REPE_CMPSD  => true
  | .REPE_CMPSQ  => true
  | .REPE_CMPSW  => true
  | .REPNE_CMPSB  => true
  | .REPNE_CMPSD  => true
  | .REPNE_CMPSQ  => true
  | .REPNE_CMPSW  => true
  | .STR_GPRv _ => true
  | .STR_MEMw mem0 => mem0.encodingFits
  | .SYSRET  => true
  | .SYSRET64  => true

end X86.Syntax

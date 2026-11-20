-- Generated from pinned Intel XED operand tables and selected SDM forms; do not edit.
import X86.Syntax.Forms.ADC
import X86.Syntax.Forms.ADD
import X86.Syntax.Forms.ADDPD
import X86.Syntax.Forms.ADDPS
import X86.Syntax.Forms.ADDSD
import X86.Syntax.Forms.ADDSS
import X86.Syntax.Forms.AND
import X86.Syntax.Forms.ANDNPD
import X86.Syntax.Forms.ANDNPS
import X86.Syntax.Forms.ANDPD
import X86.Syntax.Forms.ANDPS
import X86.Syntax.Forms.BSF
import X86.Syntax.Forms.BSR
import X86.Syntax.Forms.BSWAP
import X86.Syntax.Forms.BT
import X86.Syntax.Forms.BTC
import X86.Syntax.Forms.BTR
import X86.Syntax.Forms.BTS
import X86.Syntax.Forms.CALL
import X86.Syntax.Forms.CBW
import X86.Syntax.Forms.CLC
import X86.Syntax.Forms.CLD
import X86.Syntax.Forms.CLFLUSH
import X86.Syntax.Forms.CLI
import X86.Syntax.Forms.CLTS
import X86.Syntax.Forms.CMC
import X86.Syntax.Forms.CMOVcc
import X86.Syntax.Forms.CMP
import X86.Syntax.Forms.CMPPD
import X86.Syntax.Forms.CMPPS
import X86.Syntax.Forms.CMPSD
import X86.Syntax.Forms.CMPSS
import X86.Syntax.Forms.CMPXCHG
import X86.Syntax.Forms.CMPXCHG8B
import X86.Syntax.Forms.COMISD
import X86.Syntax.Forms.COMISS
import X86.Syntax.Forms.CPUID
import X86.Syntax.Forms.CVTDQ2PD
import X86.Syntax.Forms.CVTDQ2PS
import X86.Syntax.Forms.CVTPD2DQ
import X86.Syntax.Forms.CVTPD2PI
import X86.Syntax.Forms.CVTPD2PS
import X86.Syntax.Forms.CVTPI2PD
import X86.Syntax.Forms.CVTPI2PS
import X86.Syntax.Forms.CVTPS2DQ
import X86.Syntax.Forms.CVTPS2PD
import X86.Syntax.Forms.CVTPS2PI
import X86.Syntax.Forms.CVTSD2SI
import X86.Syntax.Forms.CVTSD2SS
import X86.Syntax.Forms.CVTSI2SD
import X86.Syntax.Forms.CVTSI2SS
import X86.Syntax.Forms.CVTSS2SD
import X86.Syntax.Forms.CVTSS2SI
import X86.Syntax.Forms.CVTTPD2DQ
import X86.Syntax.Forms.CVTTPD2PI
import X86.Syntax.Forms.CVTTPS2DQ
import X86.Syntax.Forms.CVTTPS2PI
import X86.Syntax.Forms.CVTTSD2SI
import X86.Syntax.Forms.CVTTSS2SI
import X86.Syntax.Forms.CWD
import X86.Syntax.Forms.DEC
import X86.Syntax.Forms.DIV
import X86.Syntax.Forms.DIVPD
import X86.Syntax.Forms.DIVPS
import X86.Syntax.Forms.DIVSD
import X86.Syntax.Forms.DIVSS
import X86.Syntax.Forms.EMMS
import X86.Syntax.Forms.ENDBR64
import X86.Syntax.Forms.ENTER
import X86.Syntax.Forms.F2XM1
import X86.Syntax.Forms.FABS
import X86.Syntax.Forms.FADD
import X86.Syntax.Forms.FBLD
import X86.Syntax.Forms.FBSTP
import X86.Syntax.Forms.FCHS
import X86.Syntax.Forms.FCLEX
import X86.Syntax.Forms.FCMOVcc
import X86.Syntax.Forms.FCOM
import X86.Syntax.Forms.FCOMI
import X86.Syntax.Forms.FCOS
import X86.Syntax.Forms.FDECSTP
import X86.Syntax.Forms.FDIV
import X86.Syntax.Forms.FDIVR
import X86.Syntax.Forms.FFREE
import X86.Syntax.Forms.FICOM
import X86.Syntax.Forms.FILD
import X86.Syntax.Forms.FINCSTP
import X86.Syntax.Forms.FINIT
import X86.Syntax.Forms.FIST
import X86.Syntax.Forms.FLD
import X86.Syntax.Forms.FLD1
import X86.Syntax.Forms.FLDCW
import X86.Syntax.Forms.FLDENV
import X86.Syntax.Forms.FMUL
import X86.Syntax.Forms.FNOP
import X86.Syntax.Forms.FPATAN
import X86.Syntax.Forms.FPREM
import X86.Syntax.Forms.FPREM1
import X86.Syntax.Forms.FPTAN
import X86.Syntax.Forms.FRNDINT
import X86.Syntax.Forms.FRSTOR
import X86.Syntax.Forms.FSAVE
import X86.Syntax.Forms.FSCALE
import X86.Syntax.Forms.FSIN
import X86.Syntax.Forms.FSINCOS
import X86.Syntax.Forms.FSQRT
import X86.Syntax.Forms.FST
import X86.Syntax.Forms.FSTCW
import X86.Syntax.Forms.FSTENV
import X86.Syntax.Forms.FSTSW
import X86.Syntax.Forms.FSUB
import X86.Syntax.Forms.FSUBR
import X86.Syntax.Forms.FTST
import X86.Syntax.Forms.FUCOM
import X86.Syntax.Forms.FXAM
import X86.Syntax.Forms.FXCH
import X86.Syntax.Forms.FXTRACT
import X86.Syntax.Forms.FYL2X
import X86.Syntax.Forms.FYL2XP1
import X86.Syntax.Forms.HLT
import X86.Syntax.Forms.IDIV
import X86.Syntax.Forms.IMUL
import X86.Syntax.Forms.INC
import X86.Syntax.Forms.INS
import X86.Syntax.Forms.INTn
import X86.Syntax.Forms.INVD
import X86.Syntax.Forms.IRET
import X86.Syntax.Forms.JMP
import X86.Syntax.Forms.Jcc
import X86.Syntax.Forms.LAR
import X86.Syntax.Forms.LDMXCSR
import X86.Syntax.Forms.LDS
import X86.Syntax.Forms.LEA
import X86.Syntax.Forms.LEAVE
import X86.Syntax.Forms.LFENCE
import X86.Syntax.Forms.LGDT
import X86.Syntax.Forms.LLDT
import X86.Syntax.Forms.LMSW
import X86.Syntax.Forms.LODS
import X86.Syntax.Forms.LOOP
import X86.Syntax.Forms.LSL
import X86.Syntax.Forms.LZCNT
import X86.Syntax.Forms.Local
import X86.Syntax.Forms.MASKMOVDQU
import X86.Syntax.Forms.MASKMOVQ
import X86.Syntax.Forms.MAXPD
import X86.Syntax.Forms.MAXPS
import X86.Syntax.Forms.MAXSD
import X86.Syntax.Forms.MAXSS
import X86.Syntax.Forms.MFENCE
import X86.Syntax.Forms.MINPD
import X86.Syntax.Forms.MINPS
import X86.Syntax.Forms.MINSD
import X86.Syntax.Forms.MINSS
import X86.Syntax.Forms.MOV
import X86.Syntax.Forms.MOVAPD
import X86.Syntax.Forms.MOVAPS
import X86.Syntax.Forms.MOVD
import X86.Syntax.Forms.MOVDQ2Q
import X86.Syntax.Forms.MOVDQA
import X86.Syntax.Forms.MOVDQU
import X86.Syntax.Forms.MOVHLPS
import X86.Syntax.Forms.MOVHPD
import X86.Syntax.Forms.MOVHPS
import X86.Syntax.Forms.MOVLHPS
import X86.Syntax.Forms.MOVLPD
import X86.Syntax.Forms.MOVLPS
import X86.Syntax.Forms.MOVMSKPD
import X86.Syntax.Forms.MOVMSKPS
import X86.Syntax.Forms.MOVNTDQ
import X86.Syntax.Forms.MOVNTI
import X86.Syntax.Forms.MOVNTPD
import X86.Syntax.Forms.MOVNTPS
import X86.Syntax.Forms.MOVNTQ
import X86.Syntax.Forms.MOVQ
import X86.Syntax.Forms.MOVQ2DQ
import X86.Syntax.Forms.MOVS
import X86.Syntax.Forms.MOVSD
import X86.Syntax.Forms.MOVSS
import X86.Syntax.Forms.MOVSX
import X86.Syntax.Forms.MOVUPD
import X86.Syntax.Forms.MOVUPS
import X86.Syntax.Forms.MOVZX
import X86.Syntax.Forms.MOV_CR
import X86.Syntax.Forms.MOV_DR
import X86.Syntax.Forms.MUL
import X86.Syntax.Forms.MULPD
import X86.Syntax.Forms.MULPS
import X86.Syntax.Forms.MULSD
import X86.Syntax.Forms.MULSS
import X86.Syntax.Forms.NEG
import X86.Syntax.Forms.NOT
import X86.Syntax.Forms.OR
import X86.Syntax.Forms.ORPD
import X86.Syntax.Forms.ORPS
import X86.Syntax.Forms.OUTS
import X86.Syntax.Forms.PACKSSWB
import X86.Syntax.Forms.PACKUSWB
import X86.Syntax.Forms.PADDB
import X86.Syntax.Forms.PADDSB
import X86.Syntax.Forms.PADDUSB
import X86.Syntax.Forms.PAND
import X86.Syntax.Forms.PANDN
import X86.Syntax.Forms.PAVGB
import X86.Syntax.Forms.PCMPEQB
import X86.Syntax.Forms.PCMPGTB
import X86.Syntax.Forms.PEXTRW
import X86.Syntax.Forms.PINSRW
import X86.Syntax.Forms.PMADDWD
import X86.Syntax.Forms.PMAXSB
import X86.Syntax.Forms.PMAXUB
import X86.Syntax.Forms.PMINSB
import X86.Syntax.Forms.PMINUB
import X86.Syntax.Forms.PMOVMSKB
import X86.Syntax.Forms.PMULHUW
import X86.Syntax.Forms.PMULHW
import X86.Syntax.Forms.PMULLW
import X86.Syntax.Forms.PMULUDQ
import X86.Syntax.Forms.POP
import X86.Syntax.Forms.POR
import X86.Syntax.Forms.PREFETCHW
import X86.Syntax.Forms.PREFETCHh
import X86.Syntax.Forms.PSADBW
import X86.Syntax.Forms.PSHUFD
import X86.Syntax.Forms.PSHUFHW
import X86.Syntax.Forms.PSHUFLW
import X86.Syntax.Forms.PSHUFW
import X86.Syntax.Forms.PSLLDQ
import X86.Syntax.Forms.PSLLW
import X86.Syntax.Forms.PSRAW
import X86.Syntax.Forms.PSRLDQ
import X86.Syntax.Forms.PSRLW
import X86.Syntax.Forms.PSUBB
import X86.Syntax.Forms.PSUBQ
import X86.Syntax.Forms.PSUBSB
import X86.Syntax.Forms.PSUBUSB
import X86.Syntax.Forms.PUNPCKHBW
import X86.Syntax.Forms.PUNPCKLBW
import X86.Syntax.Forms.PUSH
import X86.Syntax.Forms.PUSHF
import X86.Syntax.Forms.PXOR
import X86.Syntax.Forms.RCL
import X86.Syntax.Forms.RCPPS
import X86.Syntax.Forms.RCPSS
import X86.Syntax.Forms.RDMSR
import X86.Syntax.Forms.RDTSC
import X86.Syntax.Forms.RET
import X86.Syntax.Forms.RSQRTPS
import X86.Syntax.Forms.RSQRTSS
import X86.Syntax.Forms.SAL
import X86.Syntax.Forms.SBB
import X86.Syntax.Forms.SCAS
import X86.Syntax.Forms.SETcc
import X86.Syntax.Forms.SFENCE
import X86.Syntax.Forms.SGDT
import X86.Syntax.Forms.SHLD
import X86.Syntax.Forms.SHRD
import X86.Syntax.Forms.SHUFPD
import X86.Syntax.Forms.SHUFPS
import X86.Syntax.Forms.SIDT
import X86.Syntax.Forms.SLDT
import X86.Syntax.Forms.SMSW
import X86.Syntax.Forms.SQRTPD
import X86.Syntax.Forms.SQRTPS
import X86.Syntax.Forms.SQRTSD
import X86.Syntax.Forms.SQRTSS
import X86.Syntax.Forms.STC
import X86.Syntax.Forms.STD
import X86.Syntax.Forms.STI
import X86.Syntax.Forms.STMXCSR
import X86.Syntax.Forms.STOS
import X86.Syntax.Forms.SUB
import X86.Syntax.Forms.SUBPD
import X86.Syntax.Forms.SUBPS
import X86.Syntax.Forms.SUBSD
import X86.Syntax.Forms.SUBSS
import X86.Syntax.Forms.SWAPGS
import X86.Syntax.Forms.SYSCALL
import X86.Syntax.Forms.TEST
import X86.Syntax.Forms.UCOMISD
import X86.Syntax.Forms.UCOMISS
import X86.Syntax.Forms.UD
import X86.Syntax.Forms.UNPCKHPD
import X86.Syntax.Forms.UNPCKHPS
import X86.Syntax.Forms.UNPCKLPD
import X86.Syntax.Forms.UNPCKLPS
import X86.Syntax.Forms.VERR
import X86.Syntax.Forms.WAIT
import X86.Syntax.Forms.WBINVD
import X86.Syntax.Forms.WRMSR
import X86.Syntax.Forms.XADD
import X86.Syntax.Forms.XCHG
import X86.Syntax.Forms.XLAT
import X86.Syntax.Forms.XOR
import X86.Syntax.Forms.XORPD
import X86.Syntax.Forms.XORPS

namespace X86.Syntax

-- Groups keep payload constructor tags within Lean's runtime limit.
-- Each page still owns its typed instruction operands.
inductive Instruction.Group0 where
  | ADC (operands : Forms.ADC)
  | ADD (operands : Forms.ADD)
  | ADDPD (operands : Forms.ADDPD)
  | ADDPS (operands : Forms.ADDPS)
  | ADDSD (operands : Forms.ADDSD)
  | ADDSS (operands : Forms.ADDSS)
  | AND (operands : Forms.AND)
  | ANDNPD (operands : Forms.ANDNPD)
  | ANDNPS (operands : Forms.ANDNPS)
  | ANDPD (operands : Forms.ANDPD)
  | ANDPS (operands : Forms.ANDPS)
  | BSF (operands : Forms.BSF)
  | BSR (operands : Forms.BSR)
  | BSWAP (operands : Forms.BSWAP)
  | BT (operands : Forms.BT)
  | BTC (operands : Forms.BTC)
  | BTR (operands : Forms.BTR)
  | BTS (operands : Forms.BTS)
  | CALL (operands : Forms.CALL)
  | CBW (operands : Forms.CBW)
  | CLC (operands : Forms.CLC)
  | CLD (operands : Forms.CLD)
  | CLFLUSH (operands : Forms.CLFLUSH)
  | CLI (operands : Forms.CLI)
  | CLTS (operands : Forms.CLTS)
  | CMC (operands : Forms.CMC)
  | CMOVcc (operands : Forms.CMOVcc)
  | CMP (operands : Forms.CMP)
  | CMPPD (operands : Forms.CMPPD)
  | CMPPS (operands : Forms.CMPPS)
  | CMPSD (operands : Forms.CMPSD)
  | CMPSS (operands : Forms.CMPSS)
  | CMPXCHG (operands : Forms.CMPXCHG)
  | CMPXCHG8B (operands : Forms.CMPXCHG8B)
  | COMISD (operands : Forms.COMISD)
  | COMISS (operands : Forms.COMISS)
  | CPUID (operands : Forms.CPUID)
  | CVTDQ2PD (operands : Forms.CVTDQ2PD)
  | CVTDQ2PS (operands : Forms.CVTDQ2PS)
  | CVTPD2DQ (operands : Forms.CVTPD2DQ)
  | CVTPD2PI (operands : Forms.CVTPD2PI)
  | CVTPD2PS (operands : Forms.CVTPD2PS)
  | CVTPI2PD (operands : Forms.CVTPI2PD)
  | CVTPI2PS (operands : Forms.CVTPI2PS)
  | CVTPS2DQ (operands : Forms.CVTPS2DQ)
  | CVTPS2PD (operands : Forms.CVTPS2PD)
  | CVTPS2PI (operands : Forms.CVTPS2PI)
  | CVTSD2SI (operands : Forms.CVTSD2SI)
  | CVTSD2SS (operands : Forms.CVTSD2SS)
  | CVTSI2SD (operands : Forms.CVTSI2SD)
  | CVTSI2SS (operands : Forms.CVTSI2SS)
  | CVTSS2SD (operands : Forms.CVTSS2SD)
  | CVTSS2SI (operands : Forms.CVTSS2SI)
  | CVTTPD2DQ (operands : Forms.CVTTPD2DQ)
  | CVTTPD2PI (operands : Forms.CVTTPD2PI)
  | CVTTPS2DQ (operands : Forms.CVTTPS2DQ)
  | CVTTPS2PI (operands : Forms.CVTTPS2PI)
  | CVTTSD2SI (operands : Forms.CVTTSD2SI)
  | CVTTSS2SI (operands : Forms.CVTTSS2SI)
  | CWD (operands : Forms.CWD)
  | DEC (operands : Forms.DEC)
  | DIV (operands : Forms.DIV)
  | DIVPD (operands : Forms.DIVPD)
  | DIVPS (operands : Forms.DIVPS)
  | DIVSD (operands : Forms.DIVSD)
  | DIVSS (operands : Forms.DIVSS)
  | EMMS (operands : Forms.EMMS)
  | ENDBR64 (operands : Forms.ENDBR64)
  | ENTER (operands : Forms.ENTER)
  | F2XM1 (operands : Forms.F2XM1)
  | FABS (operands : Forms.FABS)
  | FADD (operands : Forms.FADD)
  | FBLD (operands : Forms.FBLD)
  | FBSTP (operands : Forms.FBSTP)
  | FCHS (operands : Forms.FCHS)
  | FCLEX (operands : Forms.FCLEX)
  | FCMOVcc (operands : Forms.FCMOVcc)
  | FCOM (operands : Forms.FCOM)
  | FCOMI (operands : Forms.FCOMI)
  | FCOS (operands : Forms.FCOS)
  | FDECSTP (operands : Forms.FDECSTP)
  | FDIV (operands : Forms.FDIV)
  | FDIVR (operands : Forms.FDIVR)
  | FFREE (operands : Forms.FFREE)
  | FICOM (operands : Forms.FICOM)
  | FILD (operands : Forms.FILD)
  | FINCSTP (operands : Forms.FINCSTP)
  | FINIT (operands : Forms.FINIT)
  | FIST (operands : Forms.FIST)
  | FLD (operands : Forms.FLD)
  | FLD1 (operands : Forms.FLD1)
  | FLDCW (operands : Forms.FLDCW)
  | FLDENV (operands : Forms.FLDENV)
  | FMUL (operands : Forms.FMUL)
  | FNOP (operands : Forms.FNOP)
  | FPATAN (operands : Forms.FPATAN)
  | FPREM (operands : Forms.FPREM)
  | FPREM1 (operands : Forms.FPREM1)
  | FPTAN (operands : Forms.FPTAN)
  | FRNDINT (operands : Forms.FRNDINT)
  | FRSTOR (operands : Forms.FRSTOR)
  | FSAVE (operands : Forms.FSAVE)
  | FSCALE (operands : Forms.FSCALE)
  | FSIN (operands : Forms.FSIN)
  | FSINCOS (operands : Forms.FSINCOS)
  | FSQRT (operands : Forms.FSQRT)
  | FST (operands : Forms.FST)
  | FSTCW (operands : Forms.FSTCW)
  | FSTENV (operands : Forms.FSTENV)
  | FSTSW (operands : Forms.FSTSW)
  | FSUB (operands : Forms.FSUB)
  | FSUBR (operands : Forms.FSUBR)
  | FTST (operands : Forms.FTST)
  | FUCOM (operands : Forms.FUCOM)
  | FXAM (operands : Forms.FXAM)
  | FXCH (operands : Forms.FXCH)
  | FXTRACT (operands : Forms.FXTRACT)
  | FYL2X (operands : Forms.FYL2X)
  | FYL2XP1 (operands : Forms.FYL2XP1)
  | HLT (operands : Forms.HLT)
  | IDIV (operands : Forms.IDIV)
  | IMUL (operands : Forms.IMUL)
  | INC (operands : Forms.INC)
  | INS (operands : Forms.INS)
  | INTn (operands : Forms.INTn)
  | INVD (operands : Forms.INVD)
  | IRET (operands : Forms.IRET)
  | JMP (operands : Forms.JMP)
  deriving Repr, BEq, Inhabited

def Instruction.Group0.xedForm : Instruction.Group0 → XedForm
  | .ADC operands => operands.xedForm
  | .ADD operands => operands.xedForm
  | .ADDPD operands => operands.xedForm
  | .ADDPS operands => operands.xedForm
  | .ADDSD operands => operands.xedForm
  | .ADDSS operands => operands.xedForm
  | .AND operands => operands.xedForm
  | .ANDNPD operands => operands.xedForm
  | .ANDNPS operands => operands.xedForm
  | .ANDPD operands => operands.xedForm
  | .ANDPS operands => operands.xedForm
  | .BSF operands => operands.xedForm
  | .BSR operands => operands.xedForm
  | .BSWAP operands => operands.xedForm
  | .BT operands => operands.xedForm
  | .BTC operands => operands.xedForm
  | .BTR operands => operands.xedForm
  | .BTS operands => operands.xedForm
  | .CALL operands => operands.xedForm
  | .CBW operands => operands.xedForm
  | .CLC operands => operands.xedForm
  | .CLD operands => operands.xedForm
  | .CLFLUSH operands => operands.xedForm
  | .CLI operands => operands.xedForm
  | .CLTS operands => operands.xedForm
  | .CMC operands => operands.xedForm
  | .CMOVcc operands => operands.xedForm
  | .CMP operands => operands.xedForm
  | .CMPPD operands => operands.xedForm
  | .CMPPS operands => operands.xedForm
  | .CMPSD operands => operands.xedForm
  | .CMPSS operands => operands.xedForm
  | .CMPXCHG operands => operands.xedForm
  | .CMPXCHG8B operands => operands.xedForm
  | .COMISD operands => operands.xedForm
  | .COMISS operands => operands.xedForm
  | .CPUID operands => operands.xedForm
  | .CVTDQ2PD operands => operands.xedForm
  | .CVTDQ2PS operands => operands.xedForm
  | .CVTPD2DQ operands => operands.xedForm
  | .CVTPD2PI operands => operands.xedForm
  | .CVTPD2PS operands => operands.xedForm
  | .CVTPI2PD operands => operands.xedForm
  | .CVTPI2PS operands => operands.xedForm
  | .CVTPS2DQ operands => operands.xedForm
  | .CVTPS2PD operands => operands.xedForm
  | .CVTPS2PI operands => operands.xedForm
  | .CVTSD2SI operands => operands.xedForm
  | .CVTSD2SS operands => operands.xedForm
  | .CVTSI2SD operands => operands.xedForm
  | .CVTSI2SS operands => operands.xedForm
  | .CVTSS2SD operands => operands.xedForm
  | .CVTSS2SI operands => operands.xedForm
  | .CVTTPD2DQ operands => operands.xedForm
  | .CVTTPD2PI operands => operands.xedForm
  | .CVTTPS2DQ operands => operands.xedForm
  | .CVTTPS2PI operands => operands.xedForm
  | .CVTTSD2SI operands => operands.xedForm
  | .CVTTSS2SI operands => operands.xedForm
  | .CWD operands => operands.xedForm
  | .DEC operands => operands.xedForm
  | .DIV operands => operands.xedForm
  | .DIVPD operands => operands.xedForm
  | .DIVPS operands => operands.xedForm
  | .DIVSD operands => operands.xedForm
  | .DIVSS operands => operands.xedForm
  | .EMMS operands => operands.xedForm
  | .ENDBR64 operands => operands.xedForm
  | .ENTER operands => operands.xedForm
  | .F2XM1 operands => operands.xedForm
  | .FABS operands => operands.xedForm
  | .FADD operands => operands.xedForm
  | .FBLD operands => operands.xedForm
  | .FBSTP operands => operands.xedForm
  | .FCHS operands => operands.xedForm
  | .FCLEX operands => operands.xedForm
  | .FCMOVcc operands => operands.xedForm
  | .FCOM operands => operands.xedForm
  | .FCOMI operands => operands.xedForm
  | .FCOS operands => operands.xedForm
  | .FDECSTP operands => operands.xedForm
  | .FDIV operands => operands.xedForm
  | .FDIVR operands => operands.xedForm
  | .FFREE operands => operands.xedForm
  | .FICOM operands => operands.xedForm
  | .FILD operands => operands.xedForm
  | .FINCSTP operands => operands.xedForm
  | .FINIT operands => operands.xedForm
  | .FIST operands => operands.xedForm
  | .FLD operands => operands.xedForm
  | .FLD1 operands => operands.xedForm
  | .FLDCW operands => operands.xedForm
  | .FLDENV operands => operands.xedForm
  | .FMUL operands => operands.xedForm
  | .FNOP operands => operands.xedForm
  | .FPATAN operands => operands.xedForm
  | .FPREM operands => operands.xedForm
  | .FPREM1 operands => operands.xedForm
  | .FPTAN operands => operands.xedForm
  | .FRNDINT operands => operands.xedForm
  | .FRSTOR operands => operands.xedForm
  | .FSAVE operands => operands.xedForm
  | .FSCALE operands => operands.xedForm
  | .FSIN operands => operands.xedForm
  | .FSINCOS operands => operands.xedForm
  | .FSQRT operands => operands.xedForm
  | .FST operands => operands.xedForm
  | .FSTCW operands => operands.xedForm
  | .FSTENV operands => operands.xedForm
  | .FSTSW operands => operands.xedForm
  | .FSUB operands => operands.xedForm
  | .FSUBR operands => operands.xedForm
  | .FTST operands => operands.xedForm
  | .FUCOM operands => operands.xedForm
  | .FXAM operands => operands.xedForm
  | .FXCH operands => operands.xedForm
  | .FXTRACT operands => operands.xedForm
  | .FYL2X operands => operands.xedForm
  | .FYL2XP1 operands => operands.xedForm
  | .HLT operands => operands.xedForm
  | .IDIV operands => operands.xedForm
  | .IMUL operands => operands.xedForm
  | .INC operands => operands.xedForm
  | .INS operands => operands.xedForm
  | .INTn operands => operands.xedForm
  | .INVD operands => operands.xedForm
  | .IRET operands => operands.xedForm
  | .JMP operands => operands.xedForm

def Instruction.Group0.encodingFits : Instruction.Group0 → Bool
  | .ADC operands => operands.encodingFits
  | .ADD operands => operands.encodingFits
  | .ADDPD operands => operands.encodingFits
  | .ADDPS operands => operands.encodingFits
  | .ADDSD operands => operands.encodingFits
  | .ADDSS operands => operands.encodingFits
  | .AND operands => operands.encodingFits
  | .ANDNPD operands => operands.encodingFits
  | .ANDNPS operands => operands.encodingFits
  | .ANDPD operands => operands.encodingFits
  | .ANDPS operands => operands.encodingFits
  | .BSF operands => operands.encodingFits
  | .BSR operands => operands.encodingFits
  | .BSWAP operands => operands.encodingFits
  | .BT operands => operands.encodingFits
  | .BTC operands => operands.encodingFits
  | .BTR operands => operands.encodingFits
  | .BTS operands => operands.encodingFits
  | .CALL operands => operands.encodingFits
  | .CBW operands => operands.encodingFits
  | .CLC operands => operands.encodingFits
  | .CLD operands => operands.encodingFits
  | .CLFLUSH operands => operands.encodingFits
  | .CLI operands => operands.encodingFits
  | .CLTS operands => operands.encodingFits
  | .CMC operands => operands.encodingFits
  | .CMOVcc operands => operands.encodingFits
  | .CMP operands => operands.encodingFits
  | .CMPPD operands => operands.encodingFits
  | .CMPPS operands => operands.encodingFits
  | .CMPSD operands => operands.encodingFits
  | .CMPSS operands => operands.encodingFits
  | .CMPXCHG operands => operands.encodingFits
  | .CMPXCHG8B operands => operands.encodingFits
  | .COMISD operands => operands.encodingFits
  | .COMISS operands => operands.encodingFits
  | .CPUID operands => operands.encodingFits
  | .CVTDQ2PD operands => operands.encodingFits
  | .CVTDQ2PS operands => operands.encodingFits
  | .CVTPD2DQ operands => operands.encodingFits
  | .CVTPD2PI operands => operands.encodingFits
  | .CVTPD2PS operands => operands.encodingFits
  | .CVTPI2PD operands => operands.encodingFits
  | .CVTPI2PS operands => operands.encodingFits
  | .CVTPS2DQ operands => operands.encodingFits
  | .CVTPS2PD operands => operands.encodingFits
  | .CVTPS2PI operands => operands.encodingFits
  | .CVTSD2SI operands => operands.encodingFits
  | .CVTSD2SS operands => operands.encodingFits
  | .CVTSI2SD operands => operands.encodingFits
  | .CVTSI2SS operands => operands.encodingFits
  | .CVTSS2SD operands => operands.encodingFits
  | .CVTSS2SI operands => operands.encodingFits
  | .CVTTPD2DQ operands => operands.encodingFits
  | .CVTTPD2PI operands => operands.encodingFits
  | .CVTTPS2DQ operands => operands.encodingFits
  | .CVTTPS2PI operands => operands.encodingFits
  | .CVTTSD2SI operands => operands.encodingFits
  | .CVTTSS2SI operands => operands.encodingFits
  | .CWD operands => operands.encodingFits
  | .DEC operands => operands.encodingFits
  | .DIV operands => operands.encodingFits
  | .DIVPD operands => operands.encodingFits
  | .DIVPS operands => operands.encodingFits
  | .DIVSD operands => operands.encodingFits
  | .DIVSS operands => operands.encodingFits
  | .EMMS operands => operands.encodingFits
  | .ENDBR64 operands => operands.encodingFits
  | .ENTER operands => operands.encodingFits
  | .F2XM1 operands => operands.encodingFits
  | .FABS operands => operands.encodingFits
  | .FADD operands => operands.encodingFits
  | .FBLD operands => operands.encodingFits
  | .FBSTP operands => operands.encodingFits
  | .FCHS operands => operands.encodingFits
  | .FCLEX operands => operands.encodingFits
  | .FCMOVcc operands => operands.encodingFits
  | .FCOM operands => operands.encodingFits
  | .FCOMI operands => operands.encodingFits
  | .FCOS operands => operands.encodingFits
  | .FDECSTP operands => operands.encodingFits
  | .FDIV operands => operands.encodingFits
  | .FDIVR operands => operands.encodingFits
  | .FFREE operands => operands.encodingFits
  | .FICOM operands => operands.encodingFits
  | .FILD operands => operands.encodingFits
  | .FINCSTP operands => operands.encodingFits
  | .FINIT operands => operands.encodingFits
  | .FIST operands => operands.encodingFits
  | .FLD operands => operands.encodingFits
  | .FLD1 operands => operands.encodingFits
  | .FLDCW operands => operands.encodingFits
  | .FLDENV operands => operands.encodingFits
  | .FMUL operands => operands.encodingFits
  | .FNOP operands => operands.encodingFits
  | .FPATAN operands => operands.encodingFits
  | .FPREM operands => operands.encodingFits
  | .FPREM1 operands => operands.encodingFits
  | .FPTAN operands => operands.encodingFits
  | .FRNDINT operands => operands.encodingFits
  | .FRSTOR operands => operands.encodingFits
  | .FSAVE operands => operands.encodingFits
  | .FSCALE operands => operands.encodingFits
  | .FSIN operands => operands.encodingFits
  | .FSINCOS operands => operands.encodingFits
  | .FSQRT operands => operands.encodingFits
  | .FST operands => operands.encodingFits
  | .FSTCW operands => operands.encodingFits
  | .FSTENV operands => operands.encodingFits
  | .FSTSW operands => operands.encodingFits
  | .FSUB operands => operands.encodingFits
  | .FSUBR operands => operands.encodingFits
  | .FTST operands => operands.encodingFits
  | .FUCOM operands => operands.encodingFits
  | .FXAM operands => operands.encodingFits
  | .FXCH operands => operands.encodingFits
  | .FXTRACT operands => operands.encodingFits
  | .FYL2X operands => operands.encodingFits
  | .FYL2XP1 operands => operands.encodingFits
  | .HLT operands => operands.encodingFits
  | .IDIV operands => operands.encodingFits
  | .IMUL operands => operands.encodingFits
  | .INC operands => operands.encodingFits
  | .INS operands => operands.encodingFits
  | .INTn operands => operands.encodingFits
  | .INVD operands => operands.encodingFits
  | .IRET operands => operands.encodingFits
  | .JMP operands => operands.encodingFits

inductive Instruction.Group1 where
  | Jcc (operands : Forms.Jcc)
  | LAR (operands : Forms.LAR)
  | LDMXCSR (operands : Forms.LDMXCSR)
  | LDS (operands : Forms.LDS)
  | LEA (operands : Forms.LEA)
  | LEAVE (operands : Forms.LEAVE)
  | LFENCE (operands : Forms.LFENCE)
  | LGDT (operands : Forms.LGDT)
  | LLDT (operands : Forms.LLDT)
  | LMSW (operands : Forms.LMSW)
  | LODS (operands : Forms.LODS)
  | LOOP (operands : Forms.LOOP)
  | LSL (operands : Forms.LSL)
  | LZCNT (operands : Forms.LZCNT)
  | Local (operands : Forms.Local)
  | MASKMOVDQU (operands : Forms.MASKMOVDQU)
  | MASKMOVQ (operands : Forms.MASKMOVQ)
  | MAXPD (operands : Forms.MAXPD)
  | MAXPS (operands : Forms.MAXPS)
  | MAXSD (operands : Forms.MAXSD)
  | MAXSS (operands : Forms.MAXSS)
  | MFENCE (operands : Forms.MFENCE)
  | MINPD (operands : Forms.MINPD)
  | MINPS (operands : Forms.MINPS)
  | MINSD (operands : Forms.MINSD)
  | MINSS (operands : Forms.MINSS)
  | MOV (operands : Forms.MOV)
  | MOVAPD (operands : Forms.MOVAPD)
  | MOVAPS (operands : Forms.MOVAPS)
  | MOVD (operands : Forms.MOVD)
  | MOVDQ2Q (operands : Forms.MOVDQ2Q)
  | MOVDQA (operands : Forms.MOVDQA)
  | MOVDQU (operands : Forms.MOVDQU)
  | MOVHLPS (operands : Forms.MOVHLPS)
  | MOVHPD (operands : Forms.MOVHPD)
  | MOVHPS (operands : Forms.MOVHPS)
  | MOVLHPS (operands : Forms.MOVLHPS)
  | MOVLPD (operands : Forms.MOVLPD)
  | MOVLPS (operands : Forms.MOVLPS)
  | MOVMSKPD (operands : Forms.MOVMSKPD)
  | MOVMSKPS (operands : Forms.MOVMSKPS)
  | MOVNTDQ (operands : Forms.MOVNTDQ)
  | MOVNTI (operands : Forms.MOVNTI)
  | MOVNTPD (operands : Forms.MOVNTPD)
  | MOVNTPS (operands : Forms.MOVNTPS)
  | MOVNTQ (operands : Forms.MOVNTQ)
  | MOVQ (operands : Forms.MOVQ)
  | MOVQ2DQ (operands : Forms.MOVQ2DQ)
  | MOVS (operands : Forms.MOVS)
  | MOVSD (operands : Forms.MOVSD)
  | MOVSS (operands : Forms.MOVSS)
  | MOVSX (operands : Forms.MOVSX)
  | MOVUPD (operands : Forms.MOVUPD)
  | MOVUPS (operands : Forms.MOVUPS)
  | MOVZX (operands : Forms.MOVZX)
  | MOV_CR (operands : Forms.MOV_CR)
  | MOV_DR (operands : Forms.MOV_DR)
  | MUL (operands : Forms.MUL)
  | MULPD (operands : Forms.MULPD)
  | MULPS (operands : Forms.MULPS)
  | MULSD (operands : Forms.MULSD)
  | MULSS (operands : Forms.MULSS)
  | NEG (operands : Forms.NEG)
  | NOT (operands : Forms.NOT)
  | OR (operands : Forms.OR)
  | ORPD (operands : Forms.ORPD)
  | ORPS (operands : Forms.ORPS)
  | OUTS (operands : Forms.OUTS)
  | PACKSSWB (operands : Forms.PACKSSWB)
  | PACKUSWB (operands : Forms.PACKUSWB)
  | PADDB (operands : Forms.PADDB)
  | PADDSB (operands : Forms.PADDSB)
  | PADDUSB (operands : Forms.PADDUSB)
  | PAND (operands : Forms.PAND)
  | PANDN (operands : Forms.PANDN)
  | PAVGB (operands : Forms.PAVGB)
  | PCMPEQB (operands : Forms.PCMPEQB)
  | PCMPGTB (operands : Forms.PCMPGTB)
  | PEXTRW (operands : Forms.PEXTRW)
  | PINSRW (operands : Forms.PINSRW)
  | PMADDWD (operands : Forms.PMADDWD)
  | PMAXSB (operands : Forms.PMAXSB)
  | PMAXUB (operands : Forms.PMAXUB)
  | PMINSB (operands : Forms.PMINSB)
  | PMINUB (operands : Forms.PMINUB)
  | PMOVMSKB (operands : Forms.PMOVMSKB)
  | PMULHUW (operands : Forms.PMULHUW)
  | PMULHW (operands : Forms.PMULHW)
  | PMULLW (operands : Forms.PMULLW)
  | PMULUDQ (operands : Forms.PMULUDQ)
  | POP (operands : Forms.POP)
  | POR (operands : Forms.POR)
  | PREFETCHW (operands : Forms.PREFETCHW)
  | PREFETCHh (operands : Forms.PREFETCHh)
  | PSADBW (operands : Forms.PSADBW)
  | PSHUFD (operands : Forms.PSHUFD)
  | PSHUFHW (operands : Forms.PSHUFHW)
  | PSHUFLW (operands : Forms.PSHUFLW)
  | PSHUFW (operands : Forms.PSHUFW)
  | PSLLDQ (operands : Forms.PSLLDQ)
  | PSLLW (operands : Forms.PSLLW)
  | PSRAW (operands : Forms.PSRAW)
  | PSRLDQ (operands : Forms.PSRLDQ)
  | PSRLW (operands : Forms.PSRLW)
  | PSUBB (operands : Forms.PSUBB)
  | PSUBQ (operands : Forms.PSUBQ)
  | PSUBSB (operands : Forms.PSUBSB)
  | PSUBUSB (operands : Forms.PSUBUSB)
  | PUNPCKHBW (operands : Forms.PUNPCKHBW)
  | PUNPCKLBW (operands : Forms.PUNPCKLBW)
  | PUSH (operands : Forms.PUSH)
  | PUSHF (operands : Forms.PUSHF)
  | PXOR (operands : Forms.PXOR)
  | RCL (operands : Forms.RCL)
  | RCPPS (operands : Forms.RCPPS)
  | RCPSS (operands : Forms.RCPSS)
  | RDMSR (operands : Forms.RDMSR)
  | RDTSC (operands : Forms.RDTSC)
  | RET (operands : Forms.RET)
  | RSQRTPS (operands : Forms.RSQRTPS)
  | RSQRTSS (operands : Forms.RSQRTSS)
  | SAL (operands : Forms.SAL)
  | SBB (operands : Forms.SBB)
  | SCAS (operands : Forms.SCAS)
  | SETcc (operands : Forms.SETcc)
  | SFENCE (operands : Forms.SFENCE)
  | SGDT (operands : Forms.SGDT)
  | SHLD (operands : Forms.SHLD)
  deriving Repr, BEq, Inhabited

def Instruction.Group1.xedForm : Instruction.Group1 → XedForm
  | .Jcc operands => operands.xedForm
  | .LAR operands => operands.xedForm
  | .LDMXCSR operands => operands.xedForm
  | .LDS operands => operands.xedForm
  | .LEA operands => operands.xedForm
  | .LEAVE operands => operands.xedForm
  | .LFENCE operands => operands.xedForm
  | .LGDT operands => operands.xedForm
  | .LLDT operands => operands.xedForm
  | .LMSW operands => operands.xedForm
  | .LODS operands => operands.xedForm
  | .LOOP operands => operands.xedForm
  | .LSL operands => operands.xedForm
  | .LZCNT operands => operands.xedForm
  | .Local operands => operands.xedForm
  | .MASKMOVDQU operands => operands.xedForm
  | .MASKMOVQ operands => operands.xedForm
  | .MAXPD operands => operands.xedForm
  | .MAXPS operands => operands.xedForm
  | .MAXSD operands => operands.xedForm
  | .MAXSS operands => operands.xedForm
  | .MFENCE operands => operands.xedForm
  | .MINPD operands => operands.xedForm
  | .MINPS operands => operands.xedForm
  | .MINSD operands => operands.xedForm
  | .MINSS operands => operands.xedForm
  | .MOV operands => operands.xedForm
  | .MOVAPD operands => operands.xedForm
  | .MOVAPS operands => operands.xedForm
  | .MOVD operands => operands.xedForm
  | .MOVDQ2Q operands => operands.xedForm
  | .MOVDQA operands => operands.xedForm
  | .MOVDQU operands => operands.xedForm
  | .MOVHLPS operands => operands.xedForm
  | .MOVHPD operands => operands.xedForm
  | .MOVHPS operands => operands.xedForm
  | .MOVLHPS operands => operands.xedForm
  | .MOVLPD operands => operands.xedForm
  | .MOVLPS operands => operands.xedForm
  | .MOVMSKPD operands => operands.xedForm
  | .MOVMSKPS operands => operands.xedForm
  | .MOVNTDQ operands => operands.xedForm
  | .MOVNTI operands => operands.xedForm
  | .MOVNTPD operands => operands.xedForm
  | .MOVNTPS operands => operands.xedForm
  | .MOVNTQ operands => operands.xedForm
  | .MOVQ operands => operands.xedForm
  | .MOVQ2DQ operands => operands.xedForm
  | .MOVS operands => operands.xedForm
  | .MOVSD operands => operands.xedForm
  | .MOVSS operands => operands.xedForm
  | .MOVSX operands => operands.xedForm
  | .MOVUPD operands => operands.xedForm
  | .MOVUPS operands => operands.xedForm
  | .MOVZX operands => operands.xedForm
  | .MOV_CR operands => operands.xedForm
  | .MOV_DR operands => operands.xedForm
  | .MUL operands => operands.xedForm
  | .MULPD operands => operands.xedForm
  | .MULPS operands => operands.xedForm
  | .MULSD operands => operands.xedForm
  | .MULSS operands => operands.xedForm
  | .NEG operands => operands.xedForm
  | .NOT operands => operands.xedForm
  | .OR operands => operands.xedForm
  | .ORPD operands => operands.xedForm
  | .ORPS operands => operands.xedForm
  | .OUTS operands => operands.xedForm
  | .PACKSSWB operands => operands.xedForm
  | .PACKUSWB operands => operands.xedForm
  | .PADDB operands => operands.xedForm
  | .PADDSB operands => operands.xedForm
  | .PADDUSB operands => operands.xedForm
  | .PAND operands => operands.xedForm
  | .PANDN operands => operands.xedForm
  | .PAVGB operands => operands.xedForm
  | .PCMPEQB operands => operands.xedForm
  | .PCMPGTB operands => operands.xedForm
  | .PEXTRW operands => operands.xedForm
  | .PINSRW operands => operands.xedForm
  | .PMADDWD operands => operands.xedForm
  | .PMAXSB operands => operands.xedForm
  | .PMAXUB operands => operands.xedForm
  | .PMINSB operands => operands.xedForm
  | .PMINUB operands => operands.xedForm
  | .PMOVMSKB operands => operands.xedForm
  | .PMULHUW operands => operands.xedForm
  | .PMULHW operands => operands.xedForm
  | .PMULLW operands => operands.xedForm
  | .PMULUDQ operands => operands.xedForm
  | .POP operands => operands.xedForm
  | .POR operands => operands.xedForm
  | .PREFETCHW operands => operands.xedForm
  | .PREFETCHh operands => operands.xedForm
  | .PSADBW operands => operands.xedForm
  | .PSHUFD operands => operands.xedForm
  | .PSHUFHW operands => operands.xedForm
  | .PSHUFLW operands => operands.xedForm
  | .PSHUFW operands => operands.xedForm
  | .PSLLDQ operands => operands.xedForm
  | .PSLLW operands => operands.xedForm
  | .PSRAW operands => operands.xedForm
  | .PSRLDQ operands => operands.xedForm
  | .PSRLW operands => operands.xedForm
  | .PSUBB operands => operands.xedForm
  | .PSUBQ operands => operands.xedForm
  | .PSUBSB operands => operands.xedForm
  | .PSUBUSB operands => operands.xedForm
  | .PUNPCKHBW operands => operands.xedForm
  | .PUNPCKLBW operands => operands.xedForm
  | .PUSH operands => operands.xedForm
  | .PUSHF operands => operands.xedForm
  | .PXOR operands => operands.xedForm
  | .RCL operands => operands.xedForm
  | .RCPPS operands => operands.xedForm
  | .RCPSS operands => operands.xedForm
  | .RDMSR operands => operands.xedForm
  | .RDTSC operands => operands.xedForm
  | .RET operands => operands.xedForm
  | .RSQRTPS operands => operands.xedForm
  | .RSQRTSS operands => operands.xedForm
  | .SAL operands => operands.xedForm
  | .SBB operands => operands.xedForm
  | .SCAS operands => operands.xedForm
  | .SETcc operands => operands.xedForm
  | .SFENCE operands => operands.xedForm
  | .SGDT operands => operands.xedForm
  | .SHLD operands => operands.xedForm

def Instruction.Group1.encodingFits : Instruction.Group1 → Bool
  | .Jcc operands => operands.encodingFits
  | .LAR operands => operands.encodingFits
  | .LDMXCSR operands => operands.encodingFits
  | .LDS operands => operands.encodingFits
  | .LEA operands => operands.encodingFits
  | .LEAVE operands => operands.encodingFits
  | .LFENCE operands => operands.encodingFits
  | .LGDT operands => operands.encodingFits
  | .LLDT operands => operands.encodingFits
  | .LMSW operands => operands.encodingFits
  | .LODS operands => operands.encodingFits
  | .LOOP operands => operands.encodingFits
  | .LSL operands => operands.encodingFits
  | .LZCNT operands => operands.encodingFits
  | .Local operands => operands.encodingFits
  | .MASKMOVDQU operands => operands.encodingFits
  | .MASKMOVQ operands => operands.encodingFits
  | .MAXPD operands => operands.encodingFits
  | .MAXPS operands => operands.encodingFits
  | .MAXSD operands => operands.encodingFits
  | .MAXSS operands => operands.encodingFits
  | .MFENCE operands => operands.encodingFits
  | .MINPD operands => operands.encodingFits
  | .MINPS operands => operands.encodingFits
  | .MINSD operands => operands.encodingFits
  | .MINSS operands => operands.encodingFits
  | .MOV operands => operands.encodingFits
  | .MOVAPD operands => operands.encodingFits
  | .MOVAPS operands => operands.encodingFits
  | .MOVD operands => operands.encodingFits
  | .MOVDQ2Q operands => operands.encodingFits
  | .MOVDQA operands => operands.encodingFits
  | .MOVDQU operands => operands.encodingFits
  | .MOVHLPS operands => operands.encodingFits
  | .MOVHPD operands => operands.encodingFits
  | .MOVHPS operands => operands.encodingFits
  | .MOVLHPS operands => operands.encodingFits
  | .MOVLPD operands => operands.encodingFits
  | .MOVLPS operands => operands.encodingFits
  | .MOVMSKPD operands => operands.encodingFits
  | .MOVMSKPS operands => operands.encodingFits
  | .MOVNTDQ operands => operands.encodingFits
  | .MOVNTI operands => operands.encodingFits
  | .MOVNTPD operands => operands.encodingFits
  | .MOVNTPS operands => operands.encodingFits
  | .MOVNTQ operands => operands.encodingFits
  | .MOVQ operands => operands.encodingFits
  | .MOVQ2DQ operands => operands.encodingFits
  | .MOVS operands => operands.encodingFits
  | .MOVSD operands => operands.encodingFits
  | .MOVSS operands => operands.encodingFits
  | .MOVSX operands => operands.encodingFits
  | .MOVUPD operands => operands.encodingFits
  | .MOVUPS operands => operands.encodingFits
  | .MOVZX operands => operands.encodingFits
  | .MOV_CR operands => operands.encodingFits
  | .MOV_DR operands => operands.encodingFits
  | .MUL operands => operands.encodingFits
  | .MULPD operands => operands.encodingFits
  | .MULPS operands => operands.encodingFits
  | .MULSD operands => operands.encodingFits
  | .MULSS operands => operands.encodingFits
  | .NEG operands => operands.encodingFits
  | .NOT operands => operands.encodingFits
  | .OR operands => operands.encodingFits
  | .ORPD operands => operands.encodingFits
  | .ORPS operands => operands.encodingFits
  | .OUTS operands => operands.encodingFits
  | .PACKSSWB operands => operands.encodingFits
  | .PACKUSWB operands => operands.encodingFits
  | .PADDB operands => operands.encodingFits
  | .PADDSB operands => operands.encodingFits
  | .PADDUSB operands => operands.encodingFits
  | .PAND operands => operands.encodingFits
  | .PANDN operands => operands.encodingFits
  | .PAVGB operands => operands.encodingFits
  | .PCMPEQB operands => operands.encodingFits
  | .PCMPGTB operands => operands.encodingFits
  | .PEXTRW operands => operands.encodingFits
  | .PINSRW operands => operands.encodingFits
  | .PMADDWD operands => operands.encodingFits
  | .PMAXSB operands => operands.encodingFits
  | .PMAXUB operands => operands.encodingFits
  | .PMINSB operands => operands.encodingFits
  | .PMINUB operands => operands.encodingFits
  | .PMOVMSKB operands => operands.encodingFits
  | .PMULHUW operands => operands.encodingFits
  | .PMULHW operands => operands.encodingFits
  | .PMULLW operands => operands.encodingFits
  | .PMULUDQ operands => operands.encodingFits
  | .POP operands => operands.encodingFits
  | .POR operands => operands.encodingFits
  | .PREFETCHW operands => operands.encodingFits
  | .PREFETCHh operands => operands.encodingFits
  | .PSADBW operands => operands.encodingFits
  | .PSHUFD operands => operands.encodingFits
  | .PSHUFHW operands => operands.encodingFits
  | .PSHUFLW operands => operands.encodingFits
  | .PSHUFW operands => operands.encodingFits
  | .PSLLDQ operands => operands.encodingFits
  | .PSLLW operands => operands.encodingFits
  | .PSRAW operands => operands.encodingFits
  | .PSRLDQ operands => operands.encodingFits
  | .PSRLW operands => operands.encodingFits
  | .PSUBB operands => operands.encodingFits
  | .PSUBQ operands => operands.encodingFits
  | .PSUBSB operands => operands.encodingFits
  | .PSUBUSB operands => operands.encodingFits
  | .PUNPCKHBW operands => operands.encodingFits
  | .PUNPCKLBW operands => operands.encodingFits
  | .PUSH operands => operands.encodingFits
  | .PUSHF operands => operands.encodingFits
  | .PXOR operands => operands.encodingFits
  | .RCL operands => operands.encodingFits
  | .RCPPS operands => operands.encodingFits
  | .RCPSS operands => operands.encodingFits
  | .RDMSR operands => operands.encodingFits
  | .RDTSC operands => operands.encodingFits
  | .RET operands => operands.encodingFits
  | .RSQRTPS operands => operands.encodingFits
  | .RSQRTSS operands => operands.encodingFits
  | .SAL operands => operands.encodingFits
  | .SBB operands => operands.encodingFits
  | .SCAS operands => operands.encodingFits
  | .SETcc operands => operands.encodingFits
  | .SFENCE operands => operands.encodingFits
  | .SGDT operands => operands.encodingFits
  | .SHLD operands => operands.encodingFits

inductive Instruction.Group2 where
  | SHRD (operands : Forms.SHRD)
  | SHUFPD (operands : Forms.SHUFPD)
  | SHUFPS (operands : Forms.SHUFPS)
  | SIDT (operands : Forms.SIDT)
  | SLDT (operands : Forms.SLDT)
  | SMSW (operands : Forms.SMSW)
  | SQRTPD (operands : Forms.SQRTPD)
  | SQRTPS (operands : Forms.SQRTPS)
  | SQRTSD (operands : Forms.SQRTSD)
  | SQRTSS (operands : Forms.SQRTSS)
  | STC (operands : Forms.STC)
  | STD (operands : Forms.STD)
  | STI (operands : Forms.STI)
  | STMXCSR (operands : Forms.STMXCSR)
  | STOS (operands : Forms.STOS)
  | SUB (operands : Forms.SUB)
  | SUBPD (operands : Forms.SUBPD)
  | SUBPS (operands : Forms.SUBPS)
  | SUBSD (operands : Forms.SUBSD)
  | SUBSS (operands : Forms.SUBSS)
  | SWAPGS (operands : Forms.SWAPGS)
  | SYSCALL (operands : Forms.SYSCALL)
  | TEST (operands : Forms.TEST)
  | UCOMISD (operands : Forms.UCOMISD)
  | UCOMISS (operands : Forms.UCOMISS)
  | UD (operands : Forms.UD)
  | UNPCKHPD (operands : Forms.UNPCKHPD)
  | UNPCKHPS (operands : Forms.UNPCKHPS)
  | UNPCKLPD (operands : Forms.UNPCKLPD)
  | UNPCKLPS (operands : Forms.UNPCKLPS)
  | VERR (operands : Forms.VERR)
  | WAIT (operands : Forms.WAIT)
  | WBINVD (operands : Forms.WBINVD)
  | WRMSR (operands : Forms.WRMSR)
  | XADD (operands : Forms.XADD)
  | XCHG (operands : Forms.XCHG)
  | XLAT (operands : Forms.XLAT)
  | XOR (operands : Forms.XOR)
  | XORPD (operands : Forms.XORPD)
  | XORPS (operands : Forms.XORPS)
  deriving Repr, BEq, Inhabited

def Instruction.Group2.xedForm : Instruction.Group2 → XedForm
  | .SHRD operands => operands.xedForm
  | .SHUFPD operands => operands.xedForm
  | .SHUFPS operands => operands.xedForm
  | .SIDT operands => operands.xedForm
  | .SLDT operands => operands.xedForm
  | .SMSW operands => operands.xedForm
  | .SQRTPD operands => operands.xedForm
  | .SQRTPS operands => operands.xedForm
  | .SQRTSD operands => operands.xedForm
  | .SQRTSS operands => operands.xedForm
  | .STC operands => operands.xedForm
  | .STD operands => operands.xedForm
  | .STI operands => operands.xedForm
  | .STMXCSR operands => operands.xedForm
  | .STOS operands => operands.xedForm
  | .SUB operands => operands.xedForm
  | .SUBPD operands => operands.xedForm
  | .SUBPS operands => operands.xedForm
  | .SUBSD operands => operands.xedForm
  | .SUBSS operands => operands.xedForm
  | .SWAPGS operands => operands.xedForm
  | .SYSCALL operands => operands.xedForm
  | .TEST operands => operands.xedForm
  | .UCOMISD operands => operands.xedForm
  | .UCOMISS operands => operands.xedForm
  | .UD operands => operands.xedForm
  | .UNPCKHPD operands => operands.xedForm
  | .UNPCKHPS operands => operands.xedForm
  | .UNPCKLPD operands => operands.xedForm
  | .UNPCKLPS operands => operands.xedForm
  | .VERR operands => operands.xedForm
  | .WAIT operands => operands.xedForm
  | .WBINVD operands => operands.xedForm
  | .WRMSR operands => operands.xedForm
  | .XADD operands => operands.xedForm
  | .XCHG operands => operands.xedForm
  | .XLAT operands => operands.xedForm
  | .XOR operands => operands.xedForm
  | .XORPD operands => operands.xedForm
  | .XORPS operands => operands.xedForm

def Instruction.Group2.encodingFits : Instruction.Group2 → Bool
  | .SHRD operands => operands.encodingFits
  | .SHUFPD operands => operands.encodingFits
  | .SHUFPS operands => operands.encodingFits
  | .SIDT operands => operands.encodingFits
  | .SLDT operands => operands.encodingFits
  | .SMSW operands => operands.encodingFits
  | .SQRTPD operands => operands.encodingFits
  | .SQRTPS operands => operands.encodingFits
  | .SQRTSD operands => operands.encodingFits
  | .SQRTSS operands => operands.encodingFits
  | .STC operands => operands.encodingFits
  | .STD operands => operands.encodingFits
  | .STI operands => operands.encodingFits
  | .STMXCSR operands => operands.encodingFits
  | .STOS operands => operands.encodingFits
  | .SUB operands => operands.encodingFits
  | .SUBPD operands => operands.encodingFits
  | .SUBPS operands => operands.encodingFits
  | .SUBSD operands => operands.encodingFits
  | .SUBSS operands => operands.encodingFits
  | .SWAPGS operands => operands.encodingFits
  | .SYSCALL operands => operands.encodingFits
  | .TEST operands => operands.encodingFits
  | .UCOMISD operands => operands.encodingFits
  | .UCOMISS operands => operands.encodingFits
  | .UD operands => operands.encodingFits
  | .UNPCKHPD operands => operands.encodingFits
  | .UNPCKHPS operands => operands.encodingFits
  | .UNPCKLPD operands => operands.encodingFits
  | .UNPCKLPS operands => operands.encodingFits
  | .VERR operands => operands.encodingFits
  | .WAIT operands => operands.encodingFits
  | .WBINVD operands => operands.encodingFits
  | .WRMSR operands => operands.encodingFits
  | .XADD operands => operands.encodingFits
  | .XCHG operands => operands.encodingFits
  | .XLAT operands => operands.encodingFits
  | .XOR operands => operands.encodingFits
  | .XORPD operands => operands.encodingFits
  | .XORPS operands => operands.encodingFits

inductive Instruction where
  | group0 (instruction : Instruction.Group0)
  | group1 (instruction : Instruction.Group1)
  | group2 (instruction : Instruction.Group2)
  deriving Repr, BEq, Inhabited

def Instruction.xedForm : Instruction → XedForm
  | .group0 instruction => instruction.xedForm
  | .group1 instruction => instruction.xedForm
  | .group2 instruction => instruction.xedForm

def Instruction.encodingFits : Instruction → Bool
  | .group0 instruction => instruction.encodingFits
  | .group1 instruction => instruction.encodingFits
  | .group2 instruction => instruction.encodingFits

-- Constructor functions give exporters one entry point per XED form.
-- These patterns hide runtime groups while retaining typed operands.
@[match_pattern] def Instruction.ADC_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_AL_IMMb imm0))
@[match_pattern] def Instruction.ADC_GPR8_GPR8_10 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.ADC (.ADC_GPR8_GPR8_10 reg0 reg1))
@[match_pattern] def Instruction.ADC_GPR8_GPR8_12 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.ADC (.ADC_GPR8_GPR8_12 reg0 reg1))
@[match_pattern] def Instruction.ADC_GPR8_IMMb_80r2 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_GPR8_IMMb_80r2 reg0 imm0))
@[match_pattern] def Instruction.ADC_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADC (.ADC_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.ADC_GPRv_GPRv_11 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.ADC (.ADC_GPRv_GPRv_11 reg0 reg1))
@[match_pattern] def Instruction.ADC_GPRv_GPRv_13 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.ADC (.ADC_GPRv_GPRv_13 reg0 reg1))
@[match_pattern] def Instruction.ADC_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.ADC_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.ADC_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADC (.ADC_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.ADC_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.ADC (.ADC_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.ADC_LOCK_MEMb_IMMb_80r2 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_LOCK_MEMb_IMMb_80r2 mem0 imm0))
@[match_pattern] def Instruction.ADC_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.ADC (.ADC_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.ADC_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.ADC_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.ADC_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.ADC (.ADC_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.ADC_MEMb_IMMb_80r2 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_MEMb_IMMb_80r2 mem0 imm0))
@[match_pattern] def Instruction.ADC_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.ADC (.ADC_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.ADC_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.ADC_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.ADC_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group0 (.ADC (.ADC_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.ADDPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADDPD (.ADDPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.ADDPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ADDPD (.ADDPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.ADDPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADDPS (.ADDPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.ADDPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ADDPS (.ADDPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.ADDSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADDSD (.ADDSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.ADDSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ADDSD (.ADDSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.ADDSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADDSS (.ADDSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.ADDSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ADDSS (.ADDSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.ADD_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_AL_IMMb imm0))
@[match_pattern] def Instruction.ADD_GPR8_GPR8_00 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.ADD (.ADD_GPR8_GPR8_00 reg0 reg1))
@[match_pattern] def Instruction.ADD_GPR8_GPR8_02 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.ADD (.ADD_GPR8_GPR8_02 reg0 reg1))
@[match_pattern] def Instruction.ADD_GPR8_IMMb_80r0 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_GPR8_IMMb_80r0 reg0 imm0))
@[match_pattern] def Instruction.ADD_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADD (.ADD_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.ADD_GPRv_GPRv_01 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.ADD (.ADD_GPRv_GPRv_01 reg0 reg1))
@[match_pattern] def Instruction.ADD_GPRv_GPRv_03 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.ADD (.ADD_GPRv_GPRv_03 reg0 reg1))
@[match_pattern] def Instruction.ADD_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.ADD_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.ADD_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ADD (.ADD_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.ADD_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.ADD (.ADD_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.ADD_LOCK_MEMb_IMMb_80r0 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_LOCK_MEMb_IMMb_80r0 mem0 imm0))
@[match_pattern] def Instruction.ADD_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.ADD (.ADD_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.ADD_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.ADD_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.ADD_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.ADD (.ADD_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.ADD_MEMb_IMMb_80r0 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_MEMb_IMMb_80r0 mem0 imm0))
@[match_pattern] def Instruction.ADD_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.ADD (.ADD_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.ADD_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.ADD_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.ADD_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group0 (.ADD (.ADD_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.ANDNPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ANDNPD (.ANDNPD_XMMxuq_MEMxuq reg0 mem0))
@[match_pattern] def Instruction.ANDNPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ANDNPD (.ANDNPD_XMMxuq_XMMxuq reg0 reg1))
@[match_pattern] def Instruction.ANDNPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ANDNPS (.ANDNPS_XMMxud_MEMxud reg0 mem0))
@[match_pattern] def Instruction.ANDNPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ANDNPS (.ANDNPS_XMMxud_XMMxud reg0 reg1))
@[match_pattern] def Instruction.ANDPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ANDPD (.ANDPD_XMMxuq_MEMxuq reg0 mem0))
@[match_pattern] def Instruction.ANDPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ANDPD (.ANDPD_XMMxuq_XMMxuq reg0 reg1))
@[match_pattern] def Instruction.ANDPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.ANDPS (.ANDPS_XMMxud_MEMxud reg0 mem0))
@[match_pattern] def Instruction.ANDPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.ANDPS (.ANDPS_XMMxud_XMMxud reg0 reg1))
@[match_pattern] def Instruction.AND_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_AL_IMMb imm0))
@[match_pattern] def Instruction.AND_GPR8_GPR8_20 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.AND (.AND_GPR8_GPR8_20 reg0 reg1))
@[match_pattern] def Instruction.AND_GPR8_GPR8_22 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.AND (.AND_GPR8_GPR8_22 reg0 reg1))
@[match_pattern] def Instruction.AND_GPR8_IMMb_80r4 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_GPR8_IMMb_80r4 reg0 imm0))
@[match_pattern] def Instruction.AND_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.AND (.AND_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.AND_GPRv_GPRv_21 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.AND (.AND_GPRv_GPRv_21 reg0 reg1))
@[match_pattern] def Instruction.AND_GPRv_GPRv_23 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.AND (.AND_GPRv_GPRv_23 reg0 reg1))
@[match_pattern] def Instruction.AND_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.AND_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.AND_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.AND (.AND_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.AND_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.AND (.AND_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.AND_LOCK_MEMb_IMMb_80r4 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_LOCK_MEMb_IMMb_80r4 mem0 imm0))
@[match_pattern] def Instruction.AND_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.AND (.AND_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.AND_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.AND_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.AND_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.AND (.AND_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.AND_MEMb_IMMb_80r4 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_MEMb_IMMb_80r4 mem0 imm0))
@[match_pattern] def Instruction.AND_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.AND (.AND_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.AND_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.AND_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.AND_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group0 (.AND (.AND_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.BSF_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.BSF (.BSF_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.BSF_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.BSF (.BSF_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.BSR_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.BSR (.BSR_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.BSR_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.BSR (.BSR_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.BSWAP_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BSWAP (.BSWAP_GPRv reg0))
@[match_pattern] def Instruction.BTC_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.BTC (.BTC_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.BTC_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.BTC (.BTC_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.BTC_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BTC (.BTC_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BTC_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BTC (.BTC_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.BTC_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BTC (.BTC_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BTC_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BTC (.BTC_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.BTR_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.BTR (.BTR_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.BTR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.BTR (.BTR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.BTR_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BTR (.BTR_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BTR_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BTR (.BTR_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.BTR_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BTR (.BTR_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BTR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BTR (.BTR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.BTS_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.BTS (.BTS_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.BTS_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.BTS (.BTS_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.BTS_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BTS (.BTS_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BTS_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BTS (.BTS_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.BTS_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BTS (.BTS_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BTS_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BTS (.BTS_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.BT_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.BT (.BT_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.BT_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.BT (.BT_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.BT_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.BT (.BT_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.BT_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.BT (.BT_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.CALL_FAR_MEMp2 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CALL (.CALL_FAR_MEMp2 mem0))
@[match_pattern] def Instruction.CALL_NEAR_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.CALL (.CALL_NEAR_GPRv reg0))
@[match_pattern] def Instruction.CALL_NEAR_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CALL (.CALL_NEAR_MEMv mem0))
@[match_pattern] def Instruction.CALL_NEAR_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group0 (.CALL (.CALL_NEAR_RELBRd relbr))
@[match_pattern] def Instruction.CBW : Instruction :=
  .group0 (.CBW (.CBW ))
@[match_pattern] def Instruction.CDQ : Instruction :=
  .group0 (.CWD (.CDQ ))
@[match_pattern] def Instruction.CDQE : Instruction :=
  .group0 (.CBW (.CDQE ))
@[match_pattern] def Instruction.CLC : Instruction :=
  .group0 (.CLC (.CLC ))
@[match_pattern] def Instruction.CLD : Instruction :=
  .group0 (.CLD (.CLD ))
@[match_pattern] def Instruction.CLFLUSH_MEMmprefetch (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CLFLUSH (.CLFLUSH_MEMmprefetch mem0))
@[match_pattern] def Instruction.CLI : Instruction :=
  .group0 (.CLI (.CLI ))
@[match_pattern] def Instruction.CLTS : Instruction :=
  .group0 (.CLTS (.CLTS ))
@[match_pattern] def Instruction.CMC : Instruction :=
  .group0 (.CMC (.CMC ))
@[match_pattern] def Instruction.CMOVBE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVBE_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVBE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVBE_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVB_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVB_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVB_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVLE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVLE_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVLE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVLE_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVL_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVL_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVL_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVL_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNBE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNBE_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNBE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNBE_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNB_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNB_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNB_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNLE_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNLE_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNLE_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNLE_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNL_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNL_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNL_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNL_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNO_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNO_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNO_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNO_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNP_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNP_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNP_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNP_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNS_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNS_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNS_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNS_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVNZ_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVNZ_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVNZ_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVNZ_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVO_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVO_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVO_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVO_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVP_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVP_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVP_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVP_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVS_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVS_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVS_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVS_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMOVZ_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMOVcc (.CMOVZ_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMOVZ_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMOVcc (.CMOVZ_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMPPD_XMMpd_MEMpd_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPPD (.CMPPD_XMMpd_MEMpd_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.CMPPD_XMMpd_XMMpd_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPPD (.CMPPD_XMMpd_XMMpd_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.CMPPS_XMMps_MEMps_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPPS (.CMPPS_XMMps_MEMps_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.CMPPS_XMMps_XMMps_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPPS (.CMPPS_XMMps_XMMps_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.CMPSB : Instruction :=
  .group1 (.Local (.CMPSB ))
@[match_pattern] def Instruction.CMPSD : Instruction :=
  .group1 (.Local (.CMPSD ))
@[match_pattern] def Instruction.CMPSD_XMM_XMMsd_MEMsd_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPSD (.CMPSD_XMM_XMMsd_MEMsd_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.CMPSD_XMM_XMMsd_XMMsd_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPSD (.CMPSD_XMM_XMMsd_XMMsd_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.CMPSQ : Instruction :=
  .group1 (.Local (.CMPSQ ))
@[match_pattern] def Instruction.CMPSS_XMMss_MEMss_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPSS (.CMPSS_XMMss_MEMss_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.CMPSS_XMMss_XMMss_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group0 (.CMPSS (.CMPSS_XMMss_XMMss_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.CMPSW : Instruction :=
  .group1 (.Local (.CMPSW ))
@[match_pattern] def Instruction.CMPXCHG16B_LOCK_MEMdq (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMPXCHG8B (.CMPXCHG16B_LOCK_MEMdq mem0))
@[match_pattern] def Instruction.CMPXCHG16B_MEMdq (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMPXCHG8B (.CMPXCHG16B_MEMdq mem0))
@[match_pattern] def Instruction.CMPXCHG8B_LOCK_MEMq (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMPXCHG8B (.CMPXCHG8B_LOCK_MEMq mem0))
@[match_pattern] def Instruction.CMPXCHG8B_MEMq (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMPXCHG8B (.CMPXCHG8B_MEMq mem0))
@[match_pattern] def Instruction.CMPXCHG_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.CMPXCHG (.CMPXCHG_GPR8_GPR8 reg0 reg1))
@[match_pattern] def Instruction.CMPXCHG_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMPXCHG (.CMPXCHG_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.CMPXCHG_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.CMPXCHG (.CMPXCHG_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.CMPXCHG_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.CMPXCHG (.CMPXCHG_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.CMPXCHG_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.CMPXCHG (.CMPXCHG_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.CMPXCHG_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.CMPXCHG (.CMPXCHG_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.CMP_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_AL_IMMb imm0))
@[match_pattern] def Instruction.CMP_GPR8_GPR8_38 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.CMP (.CMP_GPR8_GPR8_38 reg0 reg1))
@[match_pattern] def Instruction.CMP_GPR8_GPR8_3A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group0 (.CMP (.CMP_GPR8_GPR8_3A reg0 reg1))
@[match_pattern] def Instruction.CMP_GPR8_IMMb_80r7 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_GPR8_IMMb_80r7 reg0 imm0))
@[match_pattern] def Instruction.CMP_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMP (.CMP_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.CMP_GPRv_GPRv_39 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMP (.CMP_GPRv_GPRv_39 reg0 reg1))
@[match_pattern] def Instruction.CMP_GPRv_GPRv_3B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.CMP (.CMP_GPRv_GPRv_3B reg0 reg1))
@[match_pattern] def Instruction.CMP_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.CMP_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.CMP_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CMP (.CMP_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.CMP_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.CMP (.CMP_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.CMP_MEMb_IMMb_80r7 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_MEMb_IMMb_80r7 mem0 imm0))
@[match_pattern] def Instruction.CMP_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.CMP (.CMP_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.CMP_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.CMP_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.CMP_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group0 (.CMP (.CMP_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.COMISD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.COMISD (.COMISD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.COMISD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.COMISD (.COMISD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.COMISS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.COMISS (.COMISS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.COMISS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.COMISS (.COMISS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.CPUID : Instruction :=
  .group0 (.CPUID (.CPUID ))
@[match_pattern] def Instruction.CQO : Instruction :=
  .group0 (.CWD (.CQO ))
@[match_pattern] def Instruction.CVTDQ2PD_XMMpd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTDQ2PD (.CVTDQ2PD_XMMpd_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTDQ2PD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTDQ2PD (.CVTDQ2PD_XMMpd_XMMq reg0 reg1))
@[match_pattern] def Instruction.CVTDQ2PS_XMMps_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTDQ2PS (.CVTDQ2PS_XMMps_MEMdq reg0 mem0))
@[match_pattern] def Instruction.CVTDQ2PS_XMMps_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTDQ2PS (.CVTDQ2PS_XMMps_XMMdq reg0 reg1))
@[match_pattern] def Instruction.CVTPD2DQ_XMMdq_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPD2DQ (.CVTPD2DQ_XMMdq_MEMpd reg0 mem0))
@[match_pattern] def Instruction.CVTPD2DQ_XMMdq_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTPD2DQ (.CVTPD2DQ_XMMdq_XMMpd reg0 reg1))
@[match_pattern] def Instruction.CVTPD2PI_MMXq_MEMpd (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPD2PI (.CVTPD2PI_MMXq_MEMpd reg0 mem0))
@[match_pattern] def Instruction.CVTPD2PI_MMXq_XMMpd (reg0 : Registers.MMX) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTPD2PI (.CVTPD2PI_MMXq_XMMpd reg0 reg1))
@[match_pattern] def Instruction.CVTPD2PS_XMMps_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPD2PS (.CVTPD2PS_XMMps_MEMpd reg0 mem0))
@[match_pattern] def Instruction.CVTPD2PS_XMMps_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTPD2PS (.CVTPD2PS_XMMps_XMMpd reg0 reg1))
@[match_pattern] def Instruction.CVTPI2PD_XMMpd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPI2PD (.CVTPI2PD_XMMpd_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTPI2PD_XMMpd_MMXq (reg0 : Registers.XMM) (reg1 : Registers.MMX) : Instruction :=
  .group0 (.CVTPI2PD (.CVTPI2PD_XMMpd_MMXq reg0 reg1))
@[match_pattern] def Instruction.CVTPI2PS_XMMq_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPI2PS (.CVTPI2PS_XMMq_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTPI2PS_XMMq_MMXq (reg0 : Registers.XMM) (reg1 : Registers.MMX) : Instruction :=
  .group0 (.CVTPI2PS (.CVTPI2PS_XMMq_MMXq reg0 reg1))
@[match_pattern] def Instruction.CVTPS2DQ_XMMdq_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPS2DQ (.CVTPS2DQ_XMMdq_MEMps reg0 mem0))
@[match_pattern] def Instruction.CVTPS2DQ_XMMdq_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTPS2DQ (.CVTPS2DQ_XMMdq_XMMps reg0 reg1))
@[match_pattern] def Instruction.CVTPS2PD_XMMpd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPS2PD (.CVTPS2PD_XMMpd_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTPS2PD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTPS2PD (.CVTPS2PD_XMMpd_XMMq reg0 reg1))
@[match_pattern] def Instruction.CVTPS2PI_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTPS2PI (.CVTPS2PI_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTPS2PI_MMXq_XMMq (reg0 : Registers.MMX) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTPS2PI (.CVTPS2PI_MMXq_XMMq reg0 reg1))
@[match_pattern] def Instruction.CVTSD2SI_GPR32d_MEMsd (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSD2SI (.CVTSD2SI_GPR32d_MEMsd reg0 mem0))
@[match_pattern] def Instruction.CVTSD2SI_GPR32d_XMMsd (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTSD2SI (.CVTSD2SI_GPR32d_XMMsd reg0 reg1))
@[match_pattern] def Instruction.CVTSD2SI_GPR64q_MEMsd (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSD2SI (.CVTSD2SI_GPR64q_MEMsd reg0 mem0))
@[match_pattern] def Instruction.CVTSD2SI_GPR64q_XMMsd (reg0 : Registers.GPR64) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTSD2SI (.CVTSD2SI_GPR64q_XMMsd reg0 reg1))
@[match_pattern] def Instruction.CVTSD2SS_XMMss_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSD2SS (.CVTSD2SS_XMMss_MEMsd reg0 mem0))
@[match_pattern] def Instruction.CVTSD2SS_XMMss_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTSD2SS (.CVTSD2SS_XMMss_XMMsd reg0 reg1))
@[match_pattern] def Instruction.CVTSI2SD_XMMsd_GPR32d (reg0 : Registers.XMM) (reg1 : Registers.GPR32) : Instruction :=
  .group0 (.CVTSI2SD (.CVTSI2SD_XMMsd_GPR32d reg0 reg1))
@[match_pattern] def Instruction.CVTSI2SD_XMMsd_GPR64q (reg0 : Registers.XMM) (reg1 : Registers.GPR64) : Instruction :=
  .group0 (.CVTSI2SD (.CVTSI2SD_XMMsd_GPR64q reg0 reg1))
@[match_pattern] def Instruction.CVTSI2SD_XMMsd_MEMd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSI2SD (.CVTSI2SD_XMMsd_MEMd reg0 mem0))
@[match_pattern] def Instruction.CVTSI2SD_XMMsd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSI2SD (.CVTSI2SD_XMMsd_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTSI2SS_XMMss_GPR32d (reg0 : Registers.XMM) (reg1 : Registers.GPR32) : Instruction :=
  .group0 (.CVTSI2SS (.CVTSI2SS_XMMss_GPR32d reg0 reg1))
@[match_pattern] def Instruction.CVTSI2SS_XMMss_GPR64q (reg0 : Registers.XMM) (reg1 : Registers.GPR64) : Instruction :=
  .group0 (.CVTSI2SS (.CVTSI2SS_XMMss_GPR64q reg0 reg1))
@[match_pattern] def Instruction.CVTSI2SS_XMMss_MEMd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSI2SS (.CVTSI2SS_XMMss_MEMd reg0 mem0))
@[match_pattern] def Instruction.CVTSI2SS_XMMss_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSI2SS (.CVTSI2SS_XMMss_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTSS2SD_XMMsd_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSS2SD (.CVTSS2SD_XMMsd_MEMss reg0 mem0))
@[match_pattern] def Instruction.CVTSS2SD_XMMsd_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTSS2SD (.CVTSS2SD_XMMsd_XMMss reg0 reg1))
@[match_pattern] def Instruction.CVTSS2SI_GPR32d_MEMss (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSS2SI (.CVTSS2SI_GPR32d_MEMss reg0 mem0))
@[match_pattern] def Instruction.CVTSS2SI_GPR32d_XMMss (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTSS2SI (.CVTSS2SI_GPR32d_XMMss reg0 reg1))
@[match_pattern] def Instruction.CVTSS2SI_GPR64q_MEMss (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTSS2SI (.CVTSS2SI_GPR64q_MEMss reg0 mem0))
@[match_pattern] def Instruction.CVTSS2SI_GPR64q_XMMss (reg0 : Registers.GPR64) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTSS2SI (.CVTSS2SI_GPR64q_XMMss reg0 reg1))
@[match_pattern] def Instruction.CVTTPD2DQ_XMMdq_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTPD2DQ (.CVTTPD2DQ_XMMdq_MEMpd reg0 mem0))
@[match_pattern] def Instruction.CVTTPD2DQ_XMMdq_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTPD2DQ (.CVTTPD2DQ_XMMdq_XMMpd reg0 reg1))
@[match_pattern] def Instruction.CVTTPD2PI_MMXq_MEMpd (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTPD2PI (.CVTTPD2PI_MMXq_MEMpd reg0 mem0))
@[match_pattern] def Instruction.CVTTPD2PI_MMXq_XMMpd (reg0 : Registers.MMX) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTPD2PI (.CVTTPD2PI_MMXq_XMMpd reg0 reg1))
@[match_pattern] def Instruction.CVTTPS2DQ_XMMdq_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTPS2DQ (.CVTTPS2DQ_XMMdq_MEMps reg0 mem0))
@[match_pattern] def Instruction.CVTTPS2DQ_XMMdq_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTPS2DQ (.CVTTPS2DQ_XMMdq_XMMps reg0 reg1))
@[match_pattern] def Instruction.CVTTPS2PI_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTPS2PI (.CVTTPS2PI_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.CVTTPS2PI_MMXq_XMMq (reg0 : Registers.MMX) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTPS2PI (.CVTTPS2PI_MMXq_XMMq reg0 reg1))
@[match_pattern] def Instruction.CVTTSD2SI_GPR32d_MEMsd (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTSD2SI (.CVTTSD2SI_GPR32d_MEMsd reg0 mem0))
@[match_pattern] def Instruction.CVTTSD2SI_GPR32d_XMMsd (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTSD2SI (.CVTTSD2SI_GPR32d_XMMsd reg0 reg1))
@[match_pattern] def Instruction.CVTTSD2SI_GPR64q_MEMsd (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTSD2SI (.CVTTSD2SI_GPR64q_MEMsd reg0 mem0))
@[match_pattern] def Instruction.CVTTSD2SI_GPR64q_XMMsd (reg0 : Registers.GPR64) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTSD2SI (.CVTTSD2SI_GPR64q_XMMsd reg0 reg1))
@[match_pattern] def Instruction.CVTTSS2SI_GPR32d_MEMss (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTSS2SI (.CVTTSS2SI_GPR32d_MEMss reg0 mem0))
@[match_pattern] def Instruction.CVTTSS2SI_GPR32d_XMMss (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTSS2SI (.CVTTSS2SI_GPR32d_XMMss reg0 reg1))
@[match_pattern] def Instruction.CVTTSS2SI_GPR64q_MEMss (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.CVTTSS2SI (.CVTTSS2SI_GPR64q_MEMss reg0 mem0))
@[match_pattern] def Instruction.CVTTSS2SI_GPR64q_XMMss (reg0 : Registers.GPR64) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.CVTTSS2SI (.CVTTSS2SI_GPR64q_XMMss reg0 reg1))
@[match_pattern] def Instruction.CWD : Instruction :=
  .group0 (.CWD (.CWD ))
@[match_pattern] def Instruction.CWDE : Instruction :=
  .group0 (.CBW (.CWDE ))
@[match_pattern] def Instruction.DEC_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.DEC (.DEC_GPR8 reg0))
@[match_pattern] def Instruction.DEC_GPRv_FFr1 (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.DEC (.DEC_GPRv_FFr1 reg0))
@[match_pattern] def Instruction.DEC_LOCK_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DEC (.DEC_LOCK_MEMb mem0))
@[match_pattern] def Instruction.DEC_LOCK_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DEC (.DEC_LOCK_MEMv mem0))
@[match_pattern] def Instruction.DEC_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DEC (.DEC_MEMb mem0))
@[match_pattern] def Instruction.DEC_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DEC (.DEC_MEMv mem0))
@[match_pattern] def Instruction.DIVPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DIVPD (.DIVPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.DIVPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.DIVPD (.DIVPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.DIVPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DIVPS (.DIVPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.DIVPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.DIVPS (.DIVPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.DIVSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DIVSD (.DIVSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.DIVSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.DIVSD (.DIVSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.DIVSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DIVSS (.DIVSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.DIVSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group0 (.DIVSS (.DIVSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.DIV_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.DIV (.DIV_GPR8 reg0))
@[match_pattern] def Instruction.DIV_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.DIV (.DIV_GPRv reg0))
@[match_pattern] def Instruction.DIV_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DIV (.DIV_MEMb mem0))
@[match_pattern] def Instruction.DIV_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.DIV (.DIV_MEMv mem0))
@[match_pattern] def Instruction.EMMS : Instruction :=
  .group0 (.EMMS (.EMMS ))
@[match_pattern] def Instruction.ENDBR64 : Instruction :=
  .group0 (.ENDBR64 (.ENDBR64 ))
@[match_pattern] def Instruction.ENTER_IMMw_IMMb (imm0 : Immediate) (imm1 : Immediate) : Instruction :=
  .group0 (.ENTER (.ENTER_IMMw_IMMb imm0 imm1))
@[match_pattern] def Instruction.F2XM1 : Instruction :=
  .group0 (.F2XM1 (.F2XM1 ))
@[match_pattern] def Instruction.FABS : Instruction :=
  .group0 (.FABS (.FABS ))
@[match_pattern] def Instruction.FADDP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FADD (.FADDP_X87_ST0 reg0))
@[match_pattern] def Instruction.FADD_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FADD (.FADD_MEMm64real mem0))
@[match_pattern] def Instruction.FADD_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FADD (.FADD_MEMmem32real mem0))
@[match_pattern] def Instruction.FADD_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FADD (.FADD_ST0_X87 reg1))
@[match_pattern] def Instruction.FADD_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FADD (.FADD_X87_ST0 reg0))
@[match_pattern] def Instruction.FBLD_ST0_MEMmem80dec (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FBLD (.FBLD_ST0_MEMmem80dec mem0))
@[match_pattern] def Instruction.FBSTP_MEMmem80dec_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FBSTP (.FBSTP_MEMmem80dec_ST0 mem0))
@[match_pattern] def Instruction.FCHS : Instruction :=
  .group0 (.FCHS (.FCHS ))
@[match_pattern] def Instruction.FCMOVBE_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVBE_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVB_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVB_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVE_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVE_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVNBE_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVNBE_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVNB_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVNB_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVNE_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVNE_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVNU_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVNU_ST0_X87 reg1))
@[match_pattern] def Instruction.FCMOVU_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCMOVcc (.FCMOVU_ST0_X87 reg1))
@[match_pattern] def Instruction.FCOMIP_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOMI (.FCOMIP_ST0_X87 reg1))
@[match_pattern] def Instruction.FCOMI_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOMI (.FCOMI_ST0_X87 reg1))
@[match_pattern] def Instruction.FCOMPP : Instruction :=
  .group0 (.FCOM (.FCOMPP ))
@[match_pattern] def Instruction.FCOMP_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FCOM (.FCOMP_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FCOMP_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FCOM (.FCOMP_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FCOMP_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOM (.FCOMP_ST0_X87 reg1))
@[match_pattern] def Instruction.FCOMP_ST0_X87_DCD1 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOM (.FCOMP_ST0_X87_DCD1 reg1))
@[match_pattern] def Instruction.FCOMP_ST0_X87_DED0 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOM (.FCOMP_ST0_X87_DED0 reg1))
@[match_pattern] def Instruction.FCOM_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FCOM (.FCOM_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FCOM_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FCOM (.FCOM_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FCOM_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOM (.FCOM_ST0_X87 reg1))
@[match_pattern] def Instruction.FCOM_ST0_X87_DCD0 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOM (.FCOM_ST0_X87_DCD0 reg1))
@[match_pattern] def Instruction.FCOS : Instruction :=
  .group0 (.FCOS (.FCOS ))
@[match_pattern] def Instruction.FDECSTP : Instruction :=
  .group0 (.FDECSTP (.FDECSTP ))
@[match_pattern] def Instruction.FDISI8087_NOP : Instruction :=
  .group1 (.Local (.FDISI8087_NOP ))
@[match_pattern] def Instruction.FDIVP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FDIV (.FDIVP_X87_ST0 reg0))
@[match_pattern] def Instruction.FDIVRP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FDIVR (.FDIVRP_X87_ST0 reg0))
@[match_pattern] def Instruction.FDIVR_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIVR (.FDIVR_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FDIVR_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIVR (.FDIVR_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FDIVR_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FDIVR (.FDIVR_ST0_X87 reg1))
@[match_pattern] def Instruction.FDIVR_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FDIVR (.FDIVR_X87_ST0 reg0))
@[match_pattern] def Instruction.FDIV_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIV (.FDIV_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FDIV_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIV (.FDIV_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FDIV_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FDIV (.FDIV_ST0_X87 reg1))
@[match_pattern] def Instruction.FDIV_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FDIV (.FDIV_X87_ST0 reg0))
@[match_pattern] def Instruction.FENI8087_NOP : Instruction :=
  .group1 (.Local (.FENI8087_NOP ))
@[match_pattern] def Instruction.FFREEP_X87 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FFREE (.FFREEP_X87 reg0))
@[match_pattern] def Instruction.FFREE_X87 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FFREE (.FFREE_X87 reg0))
@[match_pattern] def Instruction.FIADD_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FADD (.FIADD_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FIADD_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FADD (.FIADD_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FICOMP_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FICOM (.FICOMP_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FICOMP_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FICOM (.FICOMP_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FICOM_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FICOM (.FICOM_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FICOM_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FICOM (.FICOM_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FIDIVR_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIVR (.FIDIVR_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FIDIVR_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIVR (.FIDIVR_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FIDIV_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIV (.FIDIV_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FIDIV_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FDIV (.FIDIV_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FILD_ST0_MEMm64int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FILD (.FILD_ST0_MEMm64int mem0))
@[match_pattern] def Instruction.FILD_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FILD (.FILD_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FILD_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FILD (.FILD_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FIMUL_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FMUL (.FIMUL_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FIMUL_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FMUL (.FIMUL_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FINCSTP : Instruction :=
  .group0 (.FINCSTP (.FINCSTP ))
@[match_pattern] def Instruction.FISTP_MEMm64int_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FIST (.FISTP_MEMm64int_ST0 mem0))
@[match_pattern] def Instruction.FISTP_MEMmem16int_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FIST (.FISTP_MEMmem16int_ST0 mem0))
@[match_pattern] def Instruction.FISTP_MEMmem32int_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FIST (.FISTP_MEMmem32int_ST0 mem0))
@[match_pattern] def Instruction.FIST_MEMmem16int_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FIST (.FIST_MEMmem16int_ST0 mem0))
@[match_pattern] def Instruction.FIST_MEMmem32int_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FIST (.FIST_MEMmem32int_ST0 mem0))
@[match_pattern] def Instruction.FISUBR_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUBR (.FISUBR_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FISUBR_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUBR (.FISUBR_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FISUB_ST0_MEMmem16int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUB (.FISUB_ST0_MEMmem16int mem0))
@[match_pattern] def Instruction.FISUB_ST0_MEMmem32int (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUB (.FISUB_ST0_MEMmem32int mem0))
@[match_pattern] def Instruction.FLD1 : Instruction :=
  .group0 (.FLD1 (.FLD1 ))
@[match_pattern] def Instruction.FLDCW_MEMmem16 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FLDCW (.FLDCW_MEMmem16 mem0))
@[match_pattern] def Instruction.FLDENV_MEMmem14 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FLDENV (.FLDENV_MEMmem14 mem0))
@[match_pattern] def Instruction.FLDENV_MEMmem28 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FLDENV (.FLDENV_MEMmem28 mem0))
@[match_pattern] def Instruction.FLDL2E : Instruction :=
  .group0 (.FLD1 (.FLDL2E ))
@[match_pattern] def Instruction.FLDL2T : Instruction :=
  .group0 (.FLD1 (.FLDL2T ))
@[match_pattern] def Instruction.FLDLG2 : Instruction :=
  .group0 (.FLD1 (.FLDLG2 ))
@[match_pattern] def Instruction.FLDLN2 : Instruction :=
  .group0 (.FLD1 (.FLDLN2 ))
@[match_pattern] def Instruction.FLDPI : Instruction :=
  .group0 (.FLD1 (.FLDPI ))
@[match_pattern] def Instruction.FLDZ : Instruction :=
  .group0 (.FLD1 (.FLDZ ))
@[match_pattern] def Instruction.FLD_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FLD (.FLD_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FLD_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FLD (.FLD_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FLD_ST0_MEMmem80real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FLD (.FLD_ST0_MEMmem80real mem0))
@[match_pattern] def Instruction.FLD_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FLD (.FLD_ST0_X87 reg1))
@[match_pattern] def Instruction.FMULP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FMUL (.FMULP_X87_ST0 reg0))
@[match_pattern] def Instruction.FMUL_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FMUL (.FMUL_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FMUL_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FMUL (.FMUL_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FMUL_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FMUL (.FMUL_ST0_X87 reg1))
@[match_pattern] def Instruction.FMUL_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FMUL (.FMUL_X87_ST0 reg0))
@[match_pattern] def Instruction.FNCLEX : Instruction :=
  .group0 (.FCLEX (.FNCLEX ))
@[match_pattern] def Instruction.FNINIT : Instruction :=
  .group0 (.FINIT (.FNINIT ))
@[match_pattern] def Instruction.FNOP : Instruction :=
  .group0 (.FNOP (.FNOP ))
@[match_pattern] def Instruction.FNSAVE_MEMmem108 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSAVE (.FNSAVE_MEMmem108 mem0))
@[match_pattern] def Instruction.FNSAVE_MEMmem94 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSAVE (.FNSAVE_MEMmem94 mem0))
@[match_pattern] def Instruction.FNSTCW_MEMmem16 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSTCW (.FNSTCW_MEMmem16 mem0))
@[match_pattern] def Instruction.FNSTENV_MEMmem14 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSTENV (.FNSTENV_MEMmem14 mem0))
@[match_pattern] def Instruction.FNSTENV_MEMmem28 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSTENV (.FNSTENV_MEMmem28 mem0))
@[match_pattern] def Instruction.FNSTSW_AX : Instruction :=
  .group0 (.FSTSW (.FNSTSW_AX ))
@[match_pattern] def Instruction.FNSTSW_MEMmem16 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSTSW (.FNSTSW_MEMmem16 mem0))
@[match_pattern] def Instruction.FPATAN : Instruction :=
  .group0 (.FPATAN (.FPATAN ))
@[match_pattern] def Instruction.FPREM : Instruction :=
  .group0 (.FPREM (.FPREM ))
@[match_pattern] def Instruction.FPREM1 : Instruction :=
  .group0 (.FPREM1 (.FPREM1 ))
@[match_pattern] def Instruction.FPTAN : Instruction :=
  .group0 (.FPTAN (.FPTAN ))
@[match_pattern] def Instruction.FRNDINT : Instruction :=
  .group0 (.FRNDINT (.FRNDINT ))
@[match_pattern] def Instruction.FRSTOR_MEMmem108 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FRSTOR (.FRSTOR_MEMmem108 mem0))
@[match_pattern] def Instruction.FRSTOR_MEMmem94 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FRSTOR (.FRSTOR_MEMmem94 mem0))
@[match_pattern] def Instruction.FSCALE : Instruction :=
  .group0 (.FSCALE (.FSCALE ))
@[match_pattern] def Instruction.FSETPM287_NOP : Instruction :=
  .group1 (.Local (.FSETPM287_NOP ))
@[match_pattern] def Instruction.FSIN : Instruction :=
  .group0 (.FSIN (.FSIN ))
@[match_pattern] def Instruction.FSINCOS : Instruction :=
  .group0 (.FSINCOS (.FSINCOS ))
@[match_pattern] def Instruction.FSQRT : Instruction :=
  .group0 (.FSQRT (.FSQRT ))
@[match_pattern] def Instruction.FSTPNCE_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FST (.FSTPNCE_X87_ST0 reg0))
@[match_pattern] def Instruction.FSTP_MEMm64real_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FST (.FSTP_MEMm64real_ST0 mem0))
@[match_pattern] def Instruction.FSTP_MEMmem32real_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FST (.FSTP_MEMmem32real_ST0 mem0))
@[match_pattern] def Instruction.FSTP_MEMmem80real_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FST (.FSTP_MEMmem80real_ST0 mem0))
@[match_pattern] def Instruction.FSTP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FST (.FSTP_X87_ST0 reg0))
@[match_pattern] def Instruction.FSTP_X87_ST0_DFD0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FST (.FSTP_X87_ST0_DFD0 reg0))
@[match_pattern] def Instruction.FSTP_X87_ST0_DFD1 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FST (.FSTP_X87_ST0_DFD1 reg0))
@[match_pattern] def Instruction.FST_MEMm64real_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FST (.FST_MEMm64real_ST0 mem0))
@[match_pattern] def Instruction.FST_MEMmem32real_ST0 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FST (.FST_MEMmem32real_ST0 mem0))
@[match_pattern] def Instruction.FST_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FST (.FST_X87_ST0 reg0))
@[match_pattern] def Instruction.FSUBP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FSUB (.FSUBP_X87_ST0 reg0))
@[match_pattern] def Instruction.FSUBRP_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FSUBR (.FSUBRP_X87_ST0 reg0))
@[match_pattern] def Instruction.FSUBR_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUBR (.FSUBR_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FSUBR_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUBR (.FSUBR_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FSUBR_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FSUBR (.FSUBR_ST0_X87 reg1))
@[match_pattern] def Instruction.FSUBR_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FSUBR (.FSUBR_X87_ST0 reg0))
@[match_pattern] def Instruction.FSUB_ST0_MEMm64real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUB (.FSUB_ST0_MEMm64real mem0))
@[match_pattern] def Instruction.FSUB_ST0_MEMmem32real (mem0 : MemoryOperand) : Instruction :=
  .group0 (.FSUB (.FSUB_ST0_MEMmem32real mem0))
@[match_pattern] def Instruction.FSUB_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FSUB (.FSUB_ST0_X87 reg1))
@[match_pattern] def Instruction.FSUB_X87_ST0 (reg0 : Registers.X87) : Instruction :=
  .group0 (.FSUB (.FSUB_X87_ST0 reg0))
@[match_pattern] def Instruction.FTST : Instruction :=
  .group0 (.FTST (.FTST ))
@[match_pattern] def Instruction.FUCOMIP_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOMI (.FUCOMIP_ST0_X87 reg1))
@[match_pattern] def Instruction.FUCOMI_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FCOMI (.FUCOMI_ST0_X87 reg1))
@[match_pattern] def Instruction.FUCOMPP : Instruction :=
  .group0 (.FUCOM (.FUCOMPP ))
@[match_pattern] def Instruction.FUCOMP_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FUCOM (.FUCOMP_ST0_X87 reg1))
@[match_pattern] def Instruction.FUCOM_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FUCOM (.FUCOM_ST0_X87 reg1))
@[match_pattern] def Instruction.FWAIT : Instruction :=
  .group2 (.WAIT (.FWAIT ))
@[match_pattern] def Instruction.FXAM : Instruction :=
  .group0 (.FXAM (.FXAM ))
@[match_pattern] def Instruction.FXCH_ST0_X87 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FXCH (.FXCH_ST0_X87 reg1))
@[match_pattern] def Instruction.FXCH_ST0_X87_DDC1 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FXCH (.FXCH_ST0_X87_DDC1 reg1))
@[match_pattern] def Instruction.FXCH_ST0_X87_DFC1 (reg1 : Registers.X87) : Instruction :=
  .group0 (.FXCH (.FXCH_ST0_X87_DFC1 reg1))
@[match_pattern] def Instruction.FXRSTOR64_MEMmfpxenv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.FXRSTOR64_MEMmfpxenv mem0))
@[match_pattern] def Instruction.FXRSTOR_MEMmfpxenv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.FXRSTOR_MEMmfpxenv mem0))
@[match_pattern] def Instruction.FXSAVE64_MEMmfpxenv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.FXSAVE64_MEMmfpxenv mem0))
@[match_pattern] def Instruction.FXSAVE_MEMmfpxenv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.FXSAVE_MEMmfpxenv mem0))
@[match_pattern] def Instruction.FXTRACT : Instruction :=
  .group0 (.FXTRACT (.FXTRACT ))
@[match_pattern] def Instruction.FYL2X : Instruction :=
  .group0 (.FYL2X (.FYL2X ))
@[match_pattern] def Instruction.FYL2XP1 : Instruction :=
  .group0 (.FYL2XP1 (.FYL2XP1 ))
@[match_pattern] def Instruction.HLT : Instruction :=
  .group0 (.HLT (.HLT ))
@[match_pattern] def Instruction.IDIV_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.IDIV (.IDIV_GPR8 reg0))
@[match_pattern] def Instruction.IDIV_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.IDIV (.IDIV_GPRv reg0))
@[match_pattern] def Instruction.IDIV_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.IDIV (.IDIV_MEMb mem0))
@[match_pattern] def Instruction.IDIV_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.IDIV (.IDIV_MEMv mem0))
@[match_pattern] def Instruction.IMUL_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.IMUL (.IMUL_GPR8 reg0))
@[match_pattern] def Instruction.IMUL_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv reg0))
@[match_pattern] def Instruction.IMUL_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.IMUL_GPRv_GPRv_IMMb (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv_GPRv_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.IMUL_GPRv_GPRv_IMMz (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv_GPRv_IMMz reg0 reg1 imm0))
@[match_pattern] def Instruction.IMUL_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.IMUL_GPRv_MEMv_IMMb (reg0 : Registers.GPRv) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv_MEMv_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.IMUL_GPRv_MEMv_IMMz (reg0 : Registers.GPRv) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group0 (.IMUL (.IMUL_GPRv_MEMv_IMMz reg0 mem0 imm0))
@[match_pattern] def Instruction.IMUL_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.IMUL (.IMUL_MEMb mem0))
@[match_pattern] def Instruction.IMUL_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.IMUL (.IMUL_MEMv mem0))
@[match_pattern] def Instruction.INC_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group0 (.INC (.INC_GPR8 reg0))
@[match_pattern] def Instruction.INC_GPRv_FFr0 (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.INC (.INC_GPRv_FFr0 reg0))
@[match_pattern] def Instruction.INC_LOCK_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.INC (.INC_LOCK_MEMb mem0))
@[match_pattern] def Instruction.INC_LOCK_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.INC (.INC_LOCK_MEMv mem0))
@[match_pattern] def Instruction.INC_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group0 (.INC (.INC_MEMb mem0))
@[match_pattern] def Instruction.INC_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.INC (.INC_MEMv mem0))
@[match_pattern] def Instruction.INSB : Instruction :=
  .group0 (.INS (.INSB ))
@[match_pattern] def Instruction.INSD : Instruction :=
  .group0 (.INS (.INSD ))
@[match_pattern] def Instruction.INSW : Instruction :=
  .group0 (.INS (.INSW ))
@[match_pattern] def Instruction.INT1 : Instruction :=
  .group0 (.INTn (.INT1 ))
@[match_pattern] def Instruction.INT3 : Instruction :=
  .group0 (.INTn (.INT3 ))
@[match_pattern] def Instruction.INT_IMMb (imm0 : Immediate) : Instruction :=
  .group0 (.INTn (.INT_IMMb imm0))
@[match_pattern] def Instruction.INVD : Instruction :=
  .group0 (.INVD (.INVD ))
@[match_pattern] def Instruction.INVLPG_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.INVLPG_MEMb mem0))
@[match_pattern] def Instruction.IN_AL_DX : Instruction :=
  .group1 (.Local (.IN_AL_DX ))
@[match_pattern] def Instruction.IN_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group1 (.Local (.IN_AL_IMMb imm0))
@[match_pattern] def Instruction.IN_OeAX_DX (reg0 : Registers.OeAX) : Instruction :=
  .group1 (.Local (.IN_OeAX_DX reg0))
@[match_pattern] def Instruction.IN_OeAX_IMMb (reg0 : Registers.OeAX) (imm0 : Immediate) : Instruction :=
  .group1 (.Local (.IN_OeAX_IMMb reg0 imm0))
@[match_pattern] def Instruction.IRET : Instruction :=
  .group0 (.IRET (.IRET ))
@[match_pattern] def Instruction.IRETD : Instruction :=
  .group0 (.IRET (.IRETD ))
@[match_pattern] def Instruction.IRETQ : Instruction :=
  .group0 (.IRET (.IRETQ ))
@[match_pattern] def Instruction.JBE_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JBE_RELBRb relbr))
@[match_pattern] def Instruction.JBE_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JBE_RELBRd relbr))
@[match_pattern] def Instruction.JB_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JB_RELBRb relbr))
@[match_pattern] def Instruction.JB_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JB_RELBRd relbr))
@[match_pattern] def Instruction.JCXZ_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JCXZ_RELBRb relbr))
@[match_pattern] def Instruction.JECXZ_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JECXZ_RELBRb relbr))
@[match_pattern] def Instruction.JLE_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JLE_RELBRb relbr))
@[match_pattern] def Instruction.JLE_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JLE_RELBRd relbr))
@[match_pattern] def Instruction.JL_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JL_RELBRb relbr))
@[match_pattern] def Instruction.JL_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JL_RELBRd relbr))
@[match_pattern] def Instruction.JMP_FAR_MEMp2 (mem0 : MemoryOperand) : Instruction :=
  .group0 (.JMP (.JMP_FAR_MEMp2 mem0))
@[match_pattern] def Instruction.JMP_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group0 (.JMP (.JMP_GPRv reg0))
@[match_pattern] def Instruction.JMP_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group0 (.JMP (.JMP_MEMv mem0))
@[match_pattern] def Instruction.JMP_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group0 (.JMP (.JMP_RELBRb relbr))
@[match_pattern] def Instruction.JMP_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group0 (.JMP (.JMP_RELBRd relbr))
@[match_pattern] def Instruction.JNBE_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNBE_RELBRb relbr))
@[match_pattern] def Instruction.JNBE_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNBE_RELBRd relbr))
@[match_pattern] def Instruction.JNB_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNB_RELBRb relbr))
@[match_pattern] def Instruction.JNB_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNB_RELBRd relbr))
@[match_pattern] def Instruction.JNLE_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNLE_RELBRb relbr))
@[match_pattern] def Instruction.JNLE_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNLE_RELBRd relbr))
@[match_pattern] def Instruction.JNL_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNL_RELBRb relbr))
@[match_pattern] def Instruction.JNL_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNL_RELBRd relbr))
@[match_pattern] def Instruction.JNO_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNO_RELBRb relbr))
@[match_pattern] def Instruction.JNO_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNO_RELBRd relbr))
@[match_pattern] def Instruction.JNP_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNP_RELBRb relbr))
@[match_pattern] def Instruction.JNP_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNP_RELBRd relbr))
@[match_pattern] def Instruction.JNS_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNS_RELBRb relbr))
@[match_pattern] def Instruction.JNS_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNS_RELBRd relbr))
@[match_pattern] def Instruction.JNZ_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNZ_RELBRb relbr))
@[match_pattern] def Instruction.JNZ_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JNZ_RELBRd relbr))
@[match_pattern] def Instruction.JO_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JO_RELBRb relbr))
@[match_pattern] def Instruction.JO_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JO_RELBRd relbr))
@[match_pattern] def Instruction.JP_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JP_RELBRb relbr))
@[match_pattern] def Instruction.JP_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JP_RELBRd relbr))
@[match_pattern] def Instruction.JRCXZ_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JRCXZ_RELBRb relbr))
@[match_pattern] def Instruction.JS_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JS_RELBRb relbr))
@[match_pattern] def Instruction.JS_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JS_RELBRd relbr))
@[match_pattern] def Instruction.JZ_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JZ_RELBRb relbr))
@[match_pattern] def Instruction.JZ_RELBRd (relbr : RelativeOperand) : Instruction :=
  .group1 (.Jcc (.JZ_RELBRd relbr))
@[match_pattern] def Instruction.LAR_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.LAR (.LAR_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.LAR_GPRv_MEMw (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LAR (.LAR_GPRv_MEMw reg0 mem0))
@[match_pattern] def Instruction.LDMXCSR_MEMd (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LDMXCSR (.LDMXCSR_MEMd mem0))
@[match_pattern] def Instruction.LEAVE : Instruction :=
  .group1 (.LEAVE (.LEAVE ))
@[match_pattern] def Instruction.LEA_GPRv_AGEN (reg0 : Registers.GPRv) (agen : MemoryOperand) : Instruction :=
  .group1 (.LEA (.LEA_GPRv_AGEN reg0 agen))
@[match_pattern] def Instruction.LFENCE : Instruction :=
  .group1 (.LFENCE (.LFENCE ))
@[match_pattern] def Instruction.LFS_GPRv_MEMp2 (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LDS (.LFS_GPRv_MEMp2 reg0 mem0))
@[match_pattern] def Instruction.LGDT_MEMs64 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LGDT (.LGDT_MEMs64 mem0))
@[match_pattern] def Instruction.LGS_GPRv_MEMp2 (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LDS (.LGS_GPRv_MEMp2 reg0 mem0))
@[match_pattern] def Instruction.LIDT_MEMs64 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LGDT (.LIDT_MEMs64 mem0))
@[match_pattern] def Instruction.LLDT_GPR16 (reg0 : Registers.GPR16) : Instruction :=
  .group1 (.LLDT (.LLDT_GPR16 reg0))
@[match_pattern] def Instruction.LLDT_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LLDT (.LLDT_MEMw mem0))
@[match_pattern] def Instruction.LMSW_GPR16 (reg0 : Registers.GPR16) : Instruction :=
  .group1 (.LMSW (.LMSW_GPR16 reg0))
@[match_pattern] def Instruction.LMSW_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LMSW (.LMSW_MEMw mem0))
@[match_pattern] def Instruction.LODSB : Instruction :=
  .group1 (.LODS (.LODSB ))
@[match_pattern] def Instruction.LODSD : Instruction :=
  .group1 (.LODS (.LODSD ))
@[match_pattern] def Instruction.LODSQ : Instruction :=
  .group1 (.LODS (.LODSQ ))
@[match_pattern] def Instruction.LODSW : Instruction :=
  .group1 (.LODS (.LODSW ))
@[match_pattern] def Instruction.LOOPE_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.LOOP (.LOOPE_RELBRb relbr))
@[match_pattern] def Instruction.LOOPNE_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.LOOP (.LOOPNE_RELBRb relbr))
@[match_pattern] def Instruction.LOOP_RELBRb (relbr : RelativeOperand) : Instruction :=
  .group1 (.LOOP (.LOOP_RELBRb relbr))
@[match_pattern] def Instruction.LSL_GPRv_GPRz (reg0 : Registers.GPRv) (reg1 : Registers.GPRz) : Instruction :=
  .group1 (.LSL (.LSL_GPRv_GPRz reg0 reg1))
@[match_pattern] def Instruction.LSL_GPRv_MEMw (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LSL (.LSL_GPRv_MEMw reg0 mem0))
@[match_pattern] def Instruction.LSS_GPRv_MEMp2 (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LDS (.LSS_GPRv_MEMp2 reg0 mem0))
@[match_pattern] def Instruction.LTR_GPR16 (reg0 : Registers.GPR16) : Instruction :=
  .group1 (.Local (.LTR_GPR16 reg0))
@[match_pattern] def Instruction.LTR_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.LTR_MEMw mem0))
@[match_pattern] def Instruction.LZCNT_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.LZCNT (.LZCNT_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.LZCNT_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.LZCNT (.LZCNT_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.MASKMOVDQU_XMMxub_XMMxub (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MASKMOVDQU (.MASKMOVDQU_XMMxub_XMMxub reg0 reg1))
@[match_pattern] def Instruction.MASKMOVQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.MASKMOVQ (.MASKMOVQ_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.MAXPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MAXPD (.MAXPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.MAXPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MAXPD (.MAXPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.MAXPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MAXPS (.MAXPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.MAXPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MAXPS (.MAXPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.MAXSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MAXSD (.MAXSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.MAXSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MAXSD (.MAXSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.MAXSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MAXSS (.MAXSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.MAXSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MAXSS (.MAXSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.MFENCE : Instruction :=
  .group1 (.MFENCE (.MFENCE ))
@[match_pattern] def Instruction.MINPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MINPD (.MINPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.MINPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MINPD (.MINPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.MINPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MINPS (.MINPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.MINPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MINPS (.MINPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.MINSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MINSD (.MINSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.MINSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MINSD (.MINSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.MINSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MINSS (.MINSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.MINSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MINSS (.MINSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.MOVAPD_MEMpd_XMMpd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVAPD (.MOVAPD_MEMpd_XMMpd mem0 reg0))
@[match_pattern] def Instruction.MOVAPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVAPD (.MOVAPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.MOVAPD_XMMpd_XMMpd_0F28 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVAPD (.MOVAPD_XMMpd_XMMpd_0F28 reg0 reg1))
@[match_pattern] def Instruction.MOVAPD_XMMpd_XMMpd_0F29 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVAPD (.MOVAPD_XMMpd_XMMpd_0F29 reg0 reg1))
@[match_pattern] def Instruction.MOVAPS_MEMps_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVAPS (.MOVAPS_MEMps_XMMps mem0 reg0))
@[match_pattern] def Instruction.MOVAPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVAPS (.MOVAPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.MOVAPS_XMMps_XMMps_0F28 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVAPS (.MOVAPS_XMMps_XMMps_0F28 reg0 reg1))
@[match_pattern] def Instruction.MOVAPS_XMMps_XMMps_0F29 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVAPS (.MOVAPS_XMMps_XMMps_0F29 reg0 reg1))
@[match_pattern] def Instruction.MOVDQ2Q_MMXq_XMMq (reg0 : Registers.MMX) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQ2Q (.MOVDQ2Q_MMXq_XMMq reg0 reg1))
@[match_pattern] def Instruction.MOVDQA_MEMdq_XMMdq (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQA (.MOVDQA_MEMdq_XMMdq mem0 reg0))
@[match_pattern] def Instruction.MOVDQA_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVDQA (.MOVDQA_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.MOVDQA_XMMdq_XMMdq_0F6F (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQA (.MOVDQA_XMMdq_XMMdq_0F6F reg0 reg1))
@[match_pattern] def Instruction.MOVDQA_XMMdq_XMMdq_0F7F (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQA (.MOVDQA_XMMdq_XMMdq_0F7F reg0 reg1))
@[match_pattern] def Instruction.MOVDQU_MEMdq_XMMdq (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQU (.MOVDQU_MEMdq_XMMdq mem0 reg0))
@[match_pattern] def Instruction.MOVDQU_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVDQU (.MOVDQU_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.MOVDQU_XMMdq_XMMdq_0F6F (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQU (.MOVDQU_XMMdq_XMMdq_0F6F reg0 reg1))
@[match_pattern] def Instruction.MOVDQU_XMMdq_XMMdq_0F7F (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVDQU (.MOVDQU_XMMdq_XMMdq_0F7F reg0 reg1))
@[match_pattern] def Instruction.MOVD_GPR32_MMXd (reg0 : Registers.GPR32) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.MOVD (.MOVD_GPR32_MMXd reg0 reg1))
@[match_pattern] def Instruction.MOVD_GPR32_XMMd (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVD (.MOVD_GPR32_XMMd reg0 reg1))
@[match_pattern] def Instruction.MOVD_MEMd_MMXd (mem0 : MemoryOperand) (reg0 : Registers.MMX) : Instruction :=
  .group1 (.MOVD (.MOVD_MEMd_MMXd mem0 reg0))
@[match_pattern] def Instruction.MOVD_MEMd_XMMd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVD (.MOVD_MEMd_XMMd mem0 reg0))
@[match_pattern] def Instruction.MOVD_MMXq_GPR32 (reg0 : Registers.MMX) (reg1 : Registers.GPR32) : Instruction :=
  .group1 (.MOVD (.MOVD_MMXq_GPR32 reg0 reg1))
@[match_pattern] def Instruction.MOVD_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVD (.MOVD_MMXq_MEMd reg0 mem0))
@[match_pattern] def Instruction.MOVD_XMMdq_GPR32 (reg0 : Registers.XMM) (reg1 : Registers.GPR32) : Instruction :=
  .group1 (.MOVD (.MOVD_XMMdq_GPR32 reg0 reg1))
@[match_pattern] def Instruction.MOVD_XMMdq_MEMd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVD (.MOVD_XMMdq_MEMd reg0 mem0))
@[match_pattern] def Instruction.MOVHLPS_XMMq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVHLPS (.MOVHLPS_XMMq_XMMq reg0 reg1))
@[match_pattern] def Instruction.MOVHPD_MEMq_XMMsd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVHPD (.MOVHPD_MEMq_XMMsd mem0 reg0))
@[match_pattern] def Instruction.MOVHPD_XMMsd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVHPD (.MOVHPD_XMMsd_MEMq reg0 mem0))
@[match_pattern] def Instruction.MOVHPS_MEMq_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVHPS (.MOVHPS_MEMq_XMMps mem0 reg0))
@[match_pattern] def Instruction.MOVHPS_XMMq_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVHPS (.MOVHPS_XMMq_MEMq reg0 mem0))
@[match_pattern] def Instruction.MOVLHPS_XMMq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVLHPS (.MOVLHPS_XMMq_XMMq reg0 reg1))
@[match_pattern] def Instruction.MOVLPD_MEMq_XMMsd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVLPD (.MOVLPD_MEMq_XMMsd mem0 reg0))
@[match_pattern] def Instruction.MOVLPD_XMMsd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVLPD (.MOVLPD_XMMsd_MEMq reg0 mem0))
@[match_pattern] def Instruction.MOVLPS_MEMq_XMMq (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVLPS (.MOVLPS_MEMq_XMMq mem0 reg0))
@[match_pattern] def Instruction.MOVLPS_XMMq_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVLPS (.MOVLPS_XMMq_MEMq reg0 mem0))
@[match_pattern] def Instruction.MOVMSKPD_GPR32_XMMpd (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVMSKPD (.MOVMSKPD_GPR32_XMMpd reg0 reg1))
@[match_pattern] def Instruction.MOVMSKPS_GPR32_XMMps (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVMSKPS (.MOVMSKPS_GPR32_XMMps reg0 reg1))
@[match_pattern] def Instruction.MOVNTDQ_MEMdq_XMMdq (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVNTDQ (.MOVNTDQ_MEMdq_XMMdq mem0 reg0))
@[match_pattern] def Instruction.MOVNTI_MEMd_GPR32 (mem0 : MemoryOperand) (reg0 : Registers.GPR32) : Instruction :=
  .group1 (.MOVNTI (.MOVNTI_MEMd_GPR32 mem0 reg0))
@[match_pattern] def Instruction.MOVNTI_MEMq_GPR64 (mem0 : MemoryOperand) (reg0 : Registers.GPR64) : Instruction :=
  .group1 (.MOVNTI (.MOVNTI_MEMq_GPR64 mem0 reg0))
@[match_pattern] def Instruction.MOVNTPD_MEMdq_XMMpd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVNTPD (.MOVNTPD_MEMdq_XMMpd mem0 reg0))
@[match_pattern] def Instruction.MOVNTPS_MEMdq_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVNTPS (.MOVNTPS_MEMdq_XMMps mem0 reg0))
@[match_pattern] def Instruction.MOVNTQ_MEMq_MMXq (mem0 : MemoryOperand) (reg0 : Registers.MMX) : Instruction :=
  .group1 (.MOVNTQ (.MOVNTQ_MEMq_MMXq mem0 reg0))
@[match_pattern] def Instruction.MOVQ2DQ_XMMdq_MMXq (reg0 : Registers.XMM) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.MOVQ2DQ (.MOVQ2DQ_XMMdq_MMXq reg0 reg1))
@[match_pattern] def Instruction.MOVQ_GPR64_MMXq (reg0 : Registers.GPR64) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.MOVQ (.MOVQ_GPR64_MMXq reg0 reg1))
@[match_pattern] def Instruction.MOVQ_GPR64_XMMq (reg0 : Registers.GPR64) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVQ (.MOVQ_GPR64_XMMq reg0 reg1))
@[match_pattern] def Instruction.MOVQ_MEMq_MMXq_0F7E (mem0 : MemoryOperand) (reg0 : Registers.MMX) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MEMq_MMXq_0F7E mem0 reg0))
@[match_pattern] def Instruction.MOVQ_MEMq_MMXq_0F7F (mem0 : MemoryOperand) (reg0 : Registers.MMX) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MEMq_MMXq_0F7F mem0 reg0))
@[match_pattern] def Instruction.MOVQ_MEMq_XMMq_0F7E (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MEMq_XMMq_0F7E mem0 reg0))
@[match_pattern] def Instruction.MOVQ_MEMq_XMMq_0FD6 (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MEMq_XMMq_0FD6 mem0 reg0))
@[match_pattern] def Instruction.MOVQ_MMXq_GPR64 (reg0 : Registers.MMX) (reg1 : Registers.GPR64) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MMXq_GPR64 reg0 reg1))
@[match_pattern] def Instruction.MOVQ_MMXq_MEMq_0F6E (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MMXq_MEMq_0F6E reg0 mem0))
@[match_pattern] def Instruction.MOVQ_MMXq_MEMq_0F6F (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MMXq_MEMq_0F6F reg0 mem0))
@[match_pattern] def Instruction.MOVQ_MMXq_MMXq_0F6F (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MMXq_MMXq_0F6F reg0 reg1))
@[match_pattern] def Instruction.MOVQ_MMXq_MMXq_0F7F (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.MOVQ (.MOVQ_MMXq_MMXq_0F7F reg0 reg1))
@[match_pattern] def Instruction.MOVQ_XMMdq_GPR64 (reg0 : Registers.XMM) (reg1 : Registers.GPR64) : Instruction :=
  .group1 (.MOVQ (.MOVQ_XMMdq_GPR64 reg0 reg1))
@[match_pattern] def Instruction.MOVQ_XMMdq_MEMq_0F6E (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVQ (.MOVQ_XMMdq_MEMq_0F6E reg0 mem0))
@[match_pattern] def Instruction.MOVQ_XMMdq_MEMq_0F7E (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVQ (.MOVQ_XMMdq_MEMq_0F7E reg0 mem0))
@[match_pattern] def Instruction.MOVQ_XMMdq_XMMq_0F7E (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVQ (.MOVQ_XMMdq_XMMq_0F7E reg0 reg1))
@[match_pattern] def Instruction.MOVQ_XMMdq_XMMq_0FD6 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVQ (.MOVQ_XMMdq_XMMq_0FD6 reg0 reg1))
@[match_pattern] def Instruction.MOVSB : Instruction :=
  .group1 (.MOVS (.MOVSB ))
@[match_pattern] def Instruction.MOVSD : Instruction :=
  .group1 (.MOVS (.MOVSD ))
@[match_pattern] def Instruction.MOVSD_XMM_MEMsd_XMMsd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVSD (.MOVSD_XMM_MEMsd_XMMsd mem0 reg0))
@[match_pattern] def Instruction.MOVSD_XMM_XMMdq_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSD (.MOVSD_XMM_XMMdq_MEMsd reg0 mem0))
@[match_pattern] def Instruction.MOVSD_XMM_XMMsd_XMMsd_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVSD (.MOVSD_XMM_XMMsd_XMMsd_0F10 reg0 reg1))
@[match_pattern] def Instruction.MOVSD_XMM_XMMsd_XMMsd_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVSD (.MOVSD_XMM_XMMsd_XMMsd_0F11 reg0 reg1))
@[match_pattern] def Instruction.MOVSQ : Instruction :=
  .group1 (.MOVS (.MOVSQ ))
@[match_pattern] def Instruction.MOVSS_MEMss_XMMss (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVSS (.MOVSS_MEMss_XMMss mem0 reg0))
@[match_pattern] def Instruction.MOVSS_XMMdq_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSS (.MOVSS_XMMdq_MEMss reg0 mem0))
@[match_pattern] def Instruction.MOVSS_XMMss_XMMss_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVSS (.MOVSS_XMMss_XMMss_0F10 reg0 reg1))
@[match_pattern] def Instruction.MOVSS_XMMss_XMMss_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVSS (.MOVSS_XMMss_XMMss_0F11 reg0 reg1))
@[match_pattern] def Instruction.MOVSW : Instruction :=
  .group1 (.MOVS (.MOVSW ))
@[match_pattern] def Instruction.MOVSXD_GPR64_MEMd (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSX (.MOVSXD_GPR64_MEMd reg0 mem0))
@[match_pattern] def Instruction.MOVSXD_GPRv_GPRz (reg0 : Registers.GPRv) (reg1 : Registers.GPRz) : Instruction :=
  .group1 (.MOVSX (.MOVSXD_GPRv_GPRz reg0 reg1))
@[match_pattern] def Instruction.MOVSXD_GPRz_MEMz (reg0 : Registers.GPRz) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSX (.MOVSXD_GPRz_MEMz reg0 mem0))
@[match_pattern] def Instruction.MOVSX_GPR16_MEMw (reg0 : Registers.GPR16) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSX (.MOVSX_GPR16_MEMw reg0 mem0))
@[match_pattern] def Instruction.MOVSX_GPR32_MEMw (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSX (.MOVSX_GPR32_MEMw reg0 mem0))
@[match_pattern] def Instruction.MOVSX_GPR64_MEMw (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSX (.MOVSX_GPR64_MEMw reg0 mem0))
@[match_pattern] def Instruction.MOVSX_GPRv_GPR16 (reg0 : Registers.GPRv) (reg1 : Registers.GPR16) : Instruction :=
  .group1 (.MOVSX (.MOVSX_GPRv_GPR16 reg0 reg1))
@[match_pattern] def Instruction.MOVSX_GPRv_GPR8 (reg0 : Registers.GPRv) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.MOVSX (.MOVSX_GPRv_GPR8 reg0 reg1))
@[match_pattern] def Instruction.MOVSX_GPRv_MEMb (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVSX (.MOVSX_GPRv_MEMb reg0 mem0))
@[match_pattern] def Instruction.MOVUPD_MEMpd_XMMpd (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVUPD (.MOVUPD_MEMpd_XMMpd mem0 reg0))
@[match_pattern] def Instruction.MOVUPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVUPD (.MOVUPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.MOVUPD_XMMpd_XMMpd_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVUPD (.MOVUPD_XMMpd_XMMpd_0F10 reg0 reg1))
@[match_pattern] def Instruction.MOVUPD_XMMpd_XMMpd_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVUPD (.MOVUPD_XMMpd_XMMpd_0F11 reg0 reg1))
@[match_pattern] def Instruction.MOVUPS_MEMps_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM) : Instruction :=
  .group1 (.MOVUPS (.MOVUPS_MEMps_XMMps mem0 reg0))
@[match_pattern] def Instruction.MOVUPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVUPS (.MOVUPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.MOVUPS_XMMps_XMMps_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVUPS (.MOVUPS_XMMps_XMMps_0F10 reg0 reg1))
@[match_pattern] def Instruction.MOVUPS_XMMps_XMMps_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MOVUPS (.MOVUPS_XMMps_XMMps_0F11 reg0 reg1))
@[match_pattern] def Instruction.MOVZX_GPR16_MEMw (reg0 : Registers.GPR16) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVZX (.MOVZX_GPR16_MEMw reg0 mem0))
@[match_pattern] def Instruction.MOVZX_GPR32_MEMw (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVZX (.MOVZX_GPR32_MEMw reg0 mem0))
@[match_pattern] def Instruction.MOVZX_GPR64_MEMw (reg0 : Registers.GPR64) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVZX (.MOVZX_GPR64_MEMw reg0 mem0))
@[match_pattern] def Instruction.MOVZX_GPRv_GPR16 (reg0 : Registers.GPRv) (reg1 : Registers.GPR16) : Instruction :=
  .group1 (.MOVZX (.MOVZX_GPRv_GPR16 reg0 reg1))
@[match_pattern] def Instruction.MOVZX_GPRv_GPR8 (reg0 : Registers.GPRv) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.MOVZX (.MOVZX_GPRv_GPR8 reg0 reg1))
@[match_pattern] def Instruction.MOVZX_GPRv_MEMb (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOVZX (.MOVZX_GPRv_MEMb reg0 mem0))
@[match_pattern] def Instruction.MOV_AL_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOV (.MOV_AL_MEMb mem0))
@[match_pattern] def Instruction.MOV_CR_CR_GPR64 (reg0 : Registers.CR) (reg1 : Registers.GPR64) : Instruction :=
  .group1 (.MOV_CR (.MOV_CR_CR_GPR64 reg0 reg1))
@[match_pattern] def Instruction.MOV_CR_GPR64_CR (reg0 : Registers.GPR64) (reg1 : Registers.CR) : Instruction :=
  .group1 (.MOV_CR (.MOV_CR_GPR64_CR reg0 reg1))
@[match_pattern] def Instruction.MOV_DR_DR_GPR64 (reg0 : Registers.DR) (reg1 : Registers.GPR64) : Instruction :=
  .group1 (.MOV_DR (.MOV_DR_DR_GPR64 reg0 reg1))
@[match_pattern] def Instruction.MOV_DR_GPR64_DR (reg0 : Registers.GPR64) (reg1 : Registers.DR) : Instruction :=
  .group1 (.MOV_DR (.MOV_DR_GPR64_DR reg0 reg1))
@[match_pattern] def Instruction.MOV_GPR8_GPR8_88 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.MOV (.MOV_GPR8_GPR8_88 reg0 reg1))
@[match_pattern] def Instruction.MOV_GPR8_GPR8_8A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.MOV (.MOV_GPR8_GPR8_8A reg0 reg1))
@[match_pattern] def Instruction.MOV_GPR8_IMMb_B0 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.MOV (.MOV_GPR8_IMMb_B0 reg0 imm0))
@[match_pattern] def Instruction.MOV_GPR8_IMMb_C6r0 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.MOV (.MOV_GPR8_IMMb_C6r0 reg0 imm0))
@[match_pattern] def Instruction.MOV_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOV (.MOV_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.MOV_GPRv_GPRv_89 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.MOV (.MOV_GPRv_GPRv_89 reg0 reg1))
@[match_pattern] def Instruction.MOV_GPRv_GPRv_8B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.MOV (.MOV_GPRv_GPRv_8B reg0 reg1))
@[match_pattern] def Instruction.MOV_GPRv_IMMv (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.MOV (.MOV_GPRv_IMMv reg0 imm0))
@[match_pattern] def Instruction.MOV_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.MOV (.MOV_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.MOV_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOV (.MOV_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.MOV_GPRv_SEG (reg0 : Registers.GPRv) (reg1 : Registers.SEG) : Instruction :=
  .group1 (.MOV (.MOV_GPRv_SEG reg0 reg1))
@[match_pattern] def Instruction.MOV_MEMb_AL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOV (.MOV_MEMb_AL mem0))
@[match_pattern] def Instruction.MOV_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.MOV (.MOV_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.MOV_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.MOV (.MOV_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.MOV_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.MOV (.MOV_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.MOV_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.MOV (.MOV_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.MOV_MEMv_OrAX (mem0 : MemoryOperand) (reg0 : Registers.OrAX) : Instruction :=
  .group1 (.MOV (.MOV_MEMv_OrAX mem0 reg0))
@[match_pattern] def Instruction.MOV_MEMw_SEG (mem0 : MemoryOperand) (reg0 : Registers.SEG) : Instruction :=
  .group1 (.MOV (.MOV_MEMw_SEG mem0 reg0))
@[match_pattern] def Instruction.MOV_OrAX_MEMv (reg0 : Registers.OrAX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOV (.MOV_OrAX_MEMv reg0 mem0))
@[match_pattern] def Instruction.MOV_SEG_GPR16 (reg0 : Registers.SEG_MOV) (reg1 : Registers.GPR16) : Instruction :=
  .group1 (.MOV (.MOV_SEG_GPR16 reg0 reg1))
@[match_pattern] def Instruction.MOV_SEG_MEMw (reg0 : Registers.SEG_MOV) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MOV (.MOV_SEG_MEMw reg0 mem0))
@[match_pattern] def Instruction.MULPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MULPD (.MULPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.MULPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MULPD (.MULPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.MULPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MULPS (.MULPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.MULPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MULPS (.MULPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.MULSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MULSD (.MULSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.MULSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MULSD (.MULSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.MULSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MULSS (.MULSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.MULSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.MULSS (.MULSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.MUL_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.MUL (.MUL_GPR8 reg0))
@[match_pattern] def Instruction.MUL_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.MUL (.MUL_GPRv reg0))
@[match_pattern] def Instruction.MUL_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MUL (.MUL_MEMb mem0))
@[match_pattern] def Instruction.MUL_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.MUL (.MUL_MEMv mem0))
@[match_pattern] def Instruction.NEG_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.NEG (.NEG_GPR8 reg0))
@[match_pattern] def Instruction.NEG_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.NEG (.NEG_GPRv reg0))
@[match_pattern] def Instruction.NEG_LOCK_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NEG (.NEG_LOCK_MEMb mem0))
@[match_pattern] def Instruction.NEG_LOCK_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NEG (.NEG_LOCK_MEMv mem0))
@[match_pattern] def Instruction.NEG_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NEG (.NEG_MEMb mem0))
@[match_pattern] def Instruction.NEG_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NEG (.NEG_MEMv mem0))
@[match_pattern] def Instruction.NOP_90 : Instruction :=
  .group1 (.Local (.NOP_90 ))
@[match_pattern] def Instruction.NOP_GPRv_0F18r0 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r0 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r1 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r1 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r2 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r2 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r3 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r3 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r4 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r4 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r5 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r5 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r6 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r6 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F18r7 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F18r7 reg0))
@[match_pattern] def Instruction.NOP_GPRv_0F1F (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_0F1F reg0))
@[match_pattern] def Instruction.NOP_GPRv_GPRv_0F19 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_GPRv_0F19 reg0 reg1))
@[match_pattern] def Instruction.NOP_GPRv_GPRv_0F1A (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_GPRv_0F1A reg0 reg1))
@[match_pattern] def Instruction.NOP_GPRv_GPRv_0F1B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_GPRv_0F1B reg0 reg1))
@[match_pattern] def Instruction.NOP_GPRv_GPRv_0F1C (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_GPRv_0F1C reg0 reg1))
@[match_pattern] def Instruction.NOP_GPRv_GPRv_0F1D (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_GPRv_0F1D reg0 reg1))
@[match_pattern] def Instruction.NOP_GPRv_GPRv_0F1E (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_GPRv_GPRv_0F1E reg0 reg1))
@[match_pattern] def Instruction.NOP_MEMv_0F18r4 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.NOP_MEMv_0F18r4 mem0))
@[match_pattern] def Instruction.NOP_MEMv_0F18r5 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.NOP_MEMv_0F18r5 mem0))
@[match_pattern] def Instruction.NOP_MEMv_0F18r6 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.NOP_MEMv_0F18r6 mem0))
@[match_pattern] def Instruction.NOP_MEMv_0F18r7 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.NOP_MEMv_0F18r7 mem0))
@[match_pattern] def Instruction.NOP_MEMv_0F1F (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.NOP_MEMv_0F1F mem0))
@[match_pattern] def Instruction.NOP_MEMv_GPRv_0F19 (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_MEMv_GPRv_0F19 mem0 reg0))
@[match_pattern] def Instruction.NOP_MEMv_GPRv_0F1A (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_MEMv_GPRv_0F1A mem0 reg0))
@[match_pattern] def Instruction.NOP_MEMv_GPRv_0F1B (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_MEMv_GPRv_0F1B mem0 reg0))
@[match_pattern] def Instruction.NOP_MEMv_GPRv_0F1C (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_MEMv_GPRv_0F1C mem0 reg0))
@[match_pattern] def Instruction.NOP_MEMv_GPRv_0F1D (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_MEMv_GPRv_0F1D mem0 reg0))
@[match_pattern] def Instruction.NOP_MEMv_GPRv_0F1E (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.NOP_MEMv_GPRv_0F1E mem0 reg0))
@[match_pattern] def Instruction.NOT_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.NOT (.NOT_GPR8 reg0))
@[match_pattern] def Instruction.NOT_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.NOT (.NOT_GPRv reg0))
@[match_pattern] def Instruction.NOT_LOCK_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NOT (.NOT_LOCK_MEMb mem0))
@[match_pattern] def Instruction.NOT_LOCK_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NOT (.NOT_LOCK_MEMv mem0))
@[match_pattern] def Instruction.NOT_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NOT (.NOT_MEMb mem0))
@[match_pattern] def Instruction.NOT_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.NOT (.NOT_MEMv mem0))
@[match_pattern] def Instruction.ORPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.ORPD (.ORPD_XMMxuq_MEMxuq reg0 mem0))
@[match_pattern] def Instruction.ORPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.ORPD (.ORPD_XMMxuq_XMMxuq reg0 reg1))
@[match_pattern] def Instruction.ORPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.ORPS (.ORPS_XMMxud_MEMxud reg0 mem0))
@[match_pattern] def Instruction.ORPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.ORPS (.ORPS_XMMxud_XMMxud reg0 reg1))
@[match_pattern] def Instruction.OR_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_AL_IMMb imm0))
@[match_pattern] def Instruction.OR_GPR8_GPR8_08 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.OR (.OR_GPR8_GPR8_08 reg0 reg1))
@[match_pattern] def Instruction.OR_GPR8_GPR8_0A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.OR (.OR_GPR8_GPR8_0A reg0 reg1))
@[match_pattern] def Instruction.OR_GPR8_IMMb_80r1 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_GPR8_IMMb_80r1 reg0 imm0))
@[match_pattern] def Instruction.OR_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.OR (.OR_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.OR_GPRv_GPRv_09 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.OR (.OR_GPRv_GPRv_09 reg0 reg1))
@[match_pattern] def Instruction.OR_GPRv_GPRv_0B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.OR (.OR_GPRv_GPRv_0B reg0 reg1))
@[match_pattern] def Instruction.OR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.OR_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.OR_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.OR (.OR_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.OR_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.OR (.OR_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.OR_LOCK_MEMb_IMMb_80r1 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_LOCK_MEMb_IMMb_80r1 mem0 imm0))
@[match_pattern] def Instruction.OR_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.OR (.OR_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.OR_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.OR_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.OR_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.OR (.OR_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.OR_MEMb_IMMb_80r1 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_MEMb_IMMb_80r1 mem0 imm0))
@[match_pattern] def Instruction.OR_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.OR (.OR_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.OR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.OR_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.OR_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group1 (.OR (.OR_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.OUTSB : Instruction :=
  .group1 (.OUTS (.OUTSB ))
@[match_pattern] def Instruction.OUTSD : Instruction :=
  .group1 (.OUTS (.OUTSD ))
@[match_pattern] def Instruction.OUTSW : Instruction :=
  .group1 (.OUTS (.OUTSW ))
@[match_pattern] def Instruction.OUT_DX_AL : Instruction :=
  .group1 (.Local (.OUT_DX_AL ))
@[match_pattern] def Instruction.OUT_DX_OeAX (reg1 : Registers.OeAX) : Instruction :=
  .group1 (.Local (.OUT_DX_OeAX reg1))
@[match_pattern] def Instruction.OUT_IMMb_AL (imm0 : Immediate) : Instruction :=
  .group1 (.Local (.OUT_IMMb_AL imm0))
@[match_pattern] def Instruction.OUT_IMMb_OeAX (imm0 : Immediate) (reg0 : Registers.OeAX) : Instruction :=
  .group1 (.Local (.OUT_IMMb_OeAX imm0 reg0))
@[match_pattern] def Instruction.PACKSSDW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSDW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PACKSSDW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSDW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PACKSSDW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSDW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PACKSSDW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSDW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PACKSSWB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSWB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PACKSSWB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSWB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PACKSSWB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSWB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PACKSSWB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PACKSSWB (.PACKSSWB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PACKUSWB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PACKUSWB (.PACKUSWB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PACKUSWB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PACKUSWB (.PACKUSWB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PACKUSWB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PACKUSWB (.PACKUSWB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PACKUSWB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PACKUSWB (.PACKUSWB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDB (.PADDB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDB (.PADDB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDB (.PADDD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDB (.PADDD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDQ_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDB (.PADDQ_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDB (.PADDQ_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDSB (.PADDSB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDSB (.PADDSB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDSB (.PADDSB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDSB (.PADDSB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDSB (.PADDSW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDSB (.PADDSW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDSB (.PADDSW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDSB (.PADDSW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDUSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDUSB (.PADDUSB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDUSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDUSB (.PADDUSB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDUSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDUSB (.PADDUSB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDUSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDUSB (.PADDUSB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDUSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDUSB (.PADDUSW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDUSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDUSB (.PADDUSW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDUSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDUSB (.PADDUSW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDUSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDUSB (.PADDUSW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PADDW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PADDW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PADDB (.PADDW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PADDW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PADDB (.PADDW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PADDW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PADDB (.PADDW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PANDN_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PANDN (.PANDN_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PANDN_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PANDN (.PANDN_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PANDN_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PANDN (.PANDN_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PANDN_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PANDN (.PANDN_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PAND_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PAND (.PAND_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PAND_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PAND (.PAND_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PAND_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PAND (.PAND_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PAND_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PAND (.PAND_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PAUSE : Instruction :=
  .group1 (.Local (.PAUSE ))
@[match_pattern] def Instruction.PAVGB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PAVGB (.PAVGB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PAVGB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PAVGB (.PAVGB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PAVGB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PAVGB (.PAVGB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PAVGB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PAVGB (.PAVGB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PAVGW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PAVGB (.PAVGW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PAVGW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PAVGB (.PAVGW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PAVGW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PAVGB (.PAVGW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PAVGW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PAVGB (.PAVGW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PCMPEQB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PCMPEQB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PCMPEQB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PCMPEQB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PCMPEQD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PCMPEQD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PCMPEQD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PCMPEQD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PCMPEQW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PCMPEQW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PCMPEQW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PCMPEQW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PCMPEQB (.PCMPEQW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PCMPGTB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PCMPGTB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PCMPGTB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PCMPGTB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PCMPGTD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PCMPGTD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PCMPGTD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PCMPGTD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PCMPGTW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PCMPGTW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PCMPGTW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PCMPGTW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PCMPGTB (.PCMPGTW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PEXTRW_GPR32_MMXq_IMMb (reg0 : Registers.GPR32) (reg1 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PEXTRW (.PEXTRW_GPR32_MMXq_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PEXTRW_GPR32_XMMdq_IMMb (reg0 : Registers.GPR32) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PEXTRW (.PEXTRW_GPR32_XMMdq_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PINSRW_MMXq_GPR32_IMMb (reg0 : Registers.MMX) (reg1 : Registers.GPR32) (imm0 : Immediate) : Instruction :=
  .group1 (.PINSRW (.PINSRW_MMXq_GPR32_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PINSRW_MMXq_MEMw_IMMb (reg0 : Registers.MMX) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.PINSRW (.PINSRW_MMXq_MEMw_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.PINSRW_XMMdq_GPR32_IMMb (reg0 : Registers.XMM) (reg1 : Registers.GPR32) (imm0 : Immediate) : Instruction :=
  .group1 (.PINSRW (.PINSRW_XMMdq_GPR32_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PINSRW_XMMdq_MEMw_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.PINSRW (.PINSRW_XMMdq_MEMw_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.PMADDWD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMADDWD (.PMADDWD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMADDWD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMADDWD (.PMADDWD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMADDWD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMADDWD (.PMADDWD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMADDWD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMADDWD (.PMADDWD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMAXSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMAXSB (.PMAXSW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMAXSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMAXSB (.PMAXSW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMAXSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMAXSB (.PMAXSW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMAXSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMAXSB (.PMAXSW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMAXUB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMAXUB (.PMAXUB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMAXUB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMAXUB (.PMAXUB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMAXUB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMAXUB (.PMAXUB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMAXUB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMAXUB (.PMAXUB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMINSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMINSB (.PMINSW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMINSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMINSB (.PMINSW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMINSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMINSB (.PMINSW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMINSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMINSB (.PMINSW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMINUB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMINUB (.PMINUB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMINUB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMINUB (.PMINUB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMINUB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMINUB (.PMINUB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMINUB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMINUB (.PMINUB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMOVMSKB_GPR32_MMXq (reg0 : Registers.GPR32) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMOVMSKB (.PMOVMSKB_GPR32_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMOVMSKB_GPR32_XMMdq (reg0 : Registers.GPR32) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMOVMSKB (.PMOVMSKB_GPR32_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMULHUW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULHUW (.PMULHUW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMULHUW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMULHUW (.PMULHUW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMULHUW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULHUW (.PMULHUW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMULHUW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMULHUW (.PMULHUW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMULHW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULHW (.PMULHW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMULHW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMULHW (.PMULHW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMULHW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULHW (.PMULHW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMULHW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMULHW (.PMULHW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMULLW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULLW (.PMULLW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMULLW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMULLW (.PMULLW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMULLW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULLW (.PMULLW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMULLW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMULLW (.PMULLW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PMULUDQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULUDQ (.PMULUDQ_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PMULUDQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PMULUDQ (.PMULUDQ_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PMULUDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PMULUDQ (.PMULUDQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PMULUDQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PMULUDQ (.PMULUDQ_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.POPF : Instruction :=
  .group1 (.Local (.POPF ))
@[match_pattern] def Instruction.POPFQ : Instruction :=
  .group1 (.Local (.POPFQ ))
@[match_pattern] def Instruction.POP_FS : Instruction :=
  .group1 (.POP (.POP_FS ))
@[match_pattern] def Instruction.POP_GPRv_58 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.POP (.POP_GPRv_58 reg0))
@[match_pattern] def Instruction.POP_GPRv_8F (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.POP (.POP_GPRv_8F reg0))
@[match_pattern] def Instruction.POP_GS : Instruction :=
  .group1 (.POP (.POP_GS ))
@[match_pattern] def Instruction.POP_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.POP (.POP_MEMv mem0))
@[match_pattern] def Instruction.POR_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.POR (.POR_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.POR_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.POR (.POR_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.POR_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.POR (.POR_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.POR_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.POR (.POR_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PREFETCHNTA_MEMmprefetch (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PREFETCHh (.PREFETCHNTA_MEMmprefetch mem0))
@[match_pattern] def Instruction.PREFETCHT0_MEMmprefetch (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PREFETCHh (.PREFETCHT0_MEMmprefetch mem0))
@[match_pattern] def Instruction.PREFETCHT1_MEMmprefetch (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PREFETCHh (.PREFETCHT1_MEMmprefetch mem0))
@[match_pattern] def Instruction.PREFETCHT2_MEMmprefetch (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PREFETCHh (.PREFETCHT2_MEMmprefetch mem0))
@[match_pattern] def Instruction.PREFETCHW_0F0Dr1 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PREFETCHW (.PREFETCHW_0F0Dr1 mem0))
@[match_pattern] def Instruction.PREFETCHW_0F0Dr3 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PREFETCHW (.PREFETCHW_0F0Dr3 mem0))
@[match_pattern] def Instruction.PSADBW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSADBW (.PSADBW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSADBW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSADBW (.PSADBW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSADBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSADBW (.PSADBW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSADBW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSADBW (.PSADBW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSHUFD_XMMdq_MEMdq_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFD (.PSHUFD_XMMdq_MEMdq_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.PSHUFD_XMMdq_XMMdq_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFD (.PSHUFD_XMMdq_XMMdq_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PSHUFHW_XMMdq_MEMdq_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFHW (.PSHUFHW_XMMdq_MEMdq_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.PSHUFHW_XMMdq_XMMdq_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFHW (.PSHUFHW_XMMdq_XMMdq_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PSHUFLW_XMMdq_MEMdq_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFLW (.PSHUFLW_XMMdq_MEMdq_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.PSHUFLW_XMMdq_XMMdq_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFLW (.PSHUFLW_XMMdq_XMMdq_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PSHUFW_MMXq_MEMq_IMMb (reg0 : Registers.MMX) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFW (.PSHUFW_MMXq_MEMq_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.PSHUFW_MMXq_MMXq_IMMb (reg0 : Registers.MMX) (reg1 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSHUFW (.PSHUFW_MMXq_MMXq_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.PSLLDQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLDQ (.PSLLDQ_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLD_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLW (.PSLLD_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSLLW (.PSLLD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSLLD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSLLW (.PSLLD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSLLD_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLW (.PSLLD_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSLLW (.PSLLD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSLLD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSLLW (.PSLLD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSLLQ_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLW (.PSLLQ_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSLLW (.PSLLQ_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSLLQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSLLW (.PSLLQ_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSLLQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLW (.PSLLQ_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSLLW (.PSLLQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSLLQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSLLW (.PSLLQ_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSLLW_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLW (.PSLLW_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSLLW (.PSLLW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSLLW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSLLW (.PSLLW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSLLW_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSLLW (.PSLLW_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSLLW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSLLW (.PSLLW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSLLW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSLLW (.PSLLW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSRAD_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRAW (.PSRAD_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRAD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRAW (.PSRAD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSRAD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSRAW (.PSRAD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSRAD_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRAW (.PSRAD_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRAD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRAW (.PSRAD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSRAD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSRAW (.PSRAD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSRAW_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRAW (.PSRAW_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRAW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRAW (.PSRAW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSRAW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSRAW (.PSRAW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSRAW_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRAW (.PSRAW_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRAW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRAW (.PSRAW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSRAW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSRAW (.PSRAW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSRLDQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLDQ (.PSRLDQ_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLD_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLW (.PSRLD_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRLW (.PSRLD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSRLD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSRLW (.PSRLD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSRLD_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLW (.PSRLD_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRLW (.PSRLD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSRLD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSRLW (.PSRLD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSRLQ_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLW (.PSRLQ_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRLW (.PSRLQ_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSRLQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSRLW (.PSRLQ_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSRLQ_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLW (.PSRLQ_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRLW (.PSRLQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSRLQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSRLW (.PSRLQ_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSRLW_MMXq_IMMb (reg0 : Registers.MMX) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLW (.PSRLW_MMXq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRLW (.PSRLW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSRLW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSRLW (.PSRLW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSRLW_XMMdq_IMMb (reg0 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group1 (.PSRLW (.PSRLW_XMMdq_IMMb reg0 imm0))
@[match_pattern] def Instruction.PSRLW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSRLW (.PSRLW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSRLW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSRLW (.PSRLW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBB (.PSUBB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBB (.PSUBB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBB (.PSUBB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBB (.PSUBB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBB (.PSUBD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBD_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBB (.PSUBD_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBB (.PSUBD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBD_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBB (.PSUBD_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBQ (.PSUBQ_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBQ_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBQ (.PSUBQ_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBQ (.PSUBQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBQ_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBQ (.PSUBQ_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBSB (.PSUBSB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBSB (.PSUBSB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBSB (.PSUBSB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBSB (.PSUBSB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBSB (.PSUBSW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBSB (.PSUBSW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBSB (.PSUBSW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBSB (.PSUBSW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBUSB_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSB_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBUSB_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSB_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBUSB_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSB_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBUSB_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSB_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBUSW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBUSW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBUSW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBUSW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBUSB (.PSUBUSW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PSUBW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBB (.PSUBW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PSUBW_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PSUBB (.PSUBW_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PSUBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PSUBB (.PSUBW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PSUBW_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PSUBB (.PSUBW_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHBW_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHBW_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHBW_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHBW_MMXq_MMXd reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHBW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHBW_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHBW_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHDQ_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHDQ_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHDQ_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHDQ_MMXq_MMXd reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHDQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHDQ_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHQDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHQDQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHQDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHQDQ_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHWD_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHWD_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHWD_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHWD_MMXq_MMXd reg0 reg1))
@[match_pattern] def Instruction.PUNPCKHWD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHWD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKHWD_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKHBW (.PUNPCKHWD_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLBW_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLBW_MMXq_MEMd reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLBW_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLBW_MMXq_MMXd reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLBW_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLBW_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLBW_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLBW_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLDQ_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLDQ_MMXq_MEMd reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLDQ_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLDQ_MMXq_MMXd reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLDQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLDQ_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLQDQ_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLQDQ_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLQDQ_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLQDQ_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLWD_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLWD_MMXq_MEMd reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLWD_MMXq_MMXd (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLWD_MMXq_MMXd reg0 reg1))
@[match_pattern] def Instruction.PUNPCKLWD_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLWD_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PUNPCKLWD_XMMdq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PUNPCKLBW (.PUNPCKLWD_XMMdq_XMMq reg0 reg1))
@[match_pattern] def Instruction.PUSHF : Instruction :=
  .group1 (.PUSHF (.PUSHF ))
@[match_pattern] def Instruction.PUSHFQ : Instruction :=
  .group1 (.PUSHF (.PUSHFQ ))
@[match_pattern] def Instruction.PUSH_FS : Instruction :=
  .group1 (.PUSH (.PUSH_FS ))
@[match_pattern] def Instruction.PUSH_GPRv_50 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.PUSH (.PUSH_GPRv_50 reg0))
@[match_pattern] def Instruction.PUSH_GPRv_FFr6 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.PUSH (.PUSH_GPRv_FFr6 reg0))
@[match_pattern] def Instruction.PUSH_GS : Instruction :=
  .group1 (.PUSH (.PUSH_GS ))
@[match_pattern] def Instruction.PUSH_IMMb (imm0 : Immediate) : Instruction :=
  .group1 (.PUSH (.PUSH_IMMb imm0))
@[match_pattern] def Instruction.PUSH_IMMz (imm0 : Immediate) : Instruction :=
  .group1 (.PUSH (.PUSH_IMMz imm0))
@[match_pattern] def Instruction.PUSH_MEMv (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PUSH (.PUSH_MEMv mem0))
@[match_pattern] def Instruction.PXOR_MMXq_MEMq (reg0 : Registers.MMX) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PXOR (.PXOR_MMXq_MEMq reg0 mem0))
@[match_pattern] def Instruction.PXOR_MMXq_MMXq (reg0 : Registers.MMX) (reg1 : Registers.MMX) : Instruction :=
  .group1 (.PXOR (.PXOR_MMXq_MMXq reg0 reg1))
@[match_pattern] def Instruction.PXOR_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.PXOR (.PXOR_XMMdq_MEMdq reg0 mem0))
@[match_pattern] def Instruction.PXOR_XMMdq_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.PXOR (.PXOR_XMMdq_XMMdq reg0 reg1))
@[match_pattern] def Instruction.RCL_GPR8_CL (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.RCL_GPR8_CL reg0))
@[match_pattern] def Instruction.RCL_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCL_GPR8_IMMb reg0 imm0))
@[match_pattern] def Instruction.RCL_GPR8_ONE (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.RCL_GPR8_ONE reg0))
@[match_pattern] def Instruction.RCL_GPRv_CL (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.RCL_GPRv_CL reg0))
@[match_pattern] def Instruction.RCL_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCL_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.RCL_GPRv_ONE (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.RCL_GPRv_ONE reg0))
@[match_pattern] def Instruction.RCL_MEMb_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCL_MEMb_CL mem0))
@[match_pattern] def Instruction.RCL_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCL_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.RCL_MEMb_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCL_MEMb_ONE mem0))
@[match_pattern] def Instruction.RCL_MEMv_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCL_MEMv_CL mem0))
@[match_pattern] def Instruction.RCL_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCL_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.RCL_MEMv_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCL_MEMv_ONE mem0))
@[match_pattern] def Instruction.RCPPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCPPS (.RCPPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.RCPPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.RCPPS (.RCPPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.RCPSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCPSS (.RCPSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.RCPSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.RCPSS (.RCPSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.RCR_GPR8_CL (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.RCR_GPR8_CL reg0))
@[match_pattern] def Instruction.RCR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCR_GPR8_IMMb reg0 imm0))
@[match_pattern] def Instruction.RCR_GPR8_ONE (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.RCR_GPR8_ONE reg0))
@[match_pattern] def Instruction.RCR_GPRv_CL (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.RCR_GPRv_CL reg0))
@[match_pattern] def Instruction.RCR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.RCR_GPRv_ONE (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.RCR_GPRv_ONE reg0))
@[match_pattern] def Instruction.RCR_MEMb_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCR_MEMb_CL mem0))
@[match_pattern] def Instruction.RCR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCR_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.RCR_MEMb_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCR_MEMb_ONE mem0))
@[match_pattern] def Instruction.RCR_MEMv_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCR_MEMv_CL mem0))
@[match_pattern] def Instruction.RCR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.RCR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.RCR_MEMv_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.RCR_MEMv_ONE mem0))
@[match_pattern] def Instruction.RDMSR : Instruction :=
  .group1 (.RDMSR (.RDMSR ))
@[match_pattern] def Instruction.RDTSC : Instruction :=
  .group1 (.RDTSC (.RDTSC ))
@[match_pattern] def Instruction.REPE_CMPSB : Instruction :=
  .group1 (.Local (.REPE_CMPSB ))
@[match_pattern] def Instruction.REPE_CMPSD : Instruction :=
  .group1 (.Local (.REPE_CMPSD ))
@[match_pattern] def Instruction.REPE_CMPSQ : Instruction :=
  .group1 (.Local (.REPE_CMPSQ ))
@[match_pattern] def Instruction.REPE_CMPSW : Instruction :=
  .group1 (.Local (.REPE_CMPSW ))
@[match_pattern] def Instruction.REPE_SCASB : Instruction :=
  .group1 (.SCAS (.REPE_SCASB ))
@[match_pattern] def Instruction.REPE_SCASD : Instruction :=
  .group1 (.SCAS (.REPE_SCASD ))
@[match_pattern] def Instruction.REPE_SCASQ : Instruction :=
  .group1 (.SCAS (.REPE_SCASQ ))
@[match_pattern] def Instruction.REPE_SCASW : Instruction :=
  .group1 (.SCAS (.REPE_SCASW ))
@[match_pattern] def Instruction.REPNE_CMPSB : Instruction :=
  .group1 (.Local (.REPNE_CMPSB ))
@[match_pattern] def Instruction.REPNE_CMPSD : Instruction :=
  .group1 (.Local (.REPNE_CMPSD ))
@[match_pattern] def Instruction.REPNE_CMPSQ : Instruction :=
  .group1 (.Local (.REPNE_CMPSQ ))
@[match_pattern] def Instruction.REPNE_CMPSW : Instruction :=
  .group1 (.Local (.REPNE_CMPSW ))
@[match_pattern] def Instruction.REPNE_SCASB : Instruction :=
  .group1 (.SCAS (.REPNE_SCASB ))
@[match_pattern] def Instruction.REPNE_SCASD : Instruction :=
  .group1 (.SCAS (.REPNE_SCASD ))
@[match_pattern] def Instruction.REPNE_SCASQ : Instruction :=
  .group1 (.SCAS (.REPNE_SCASQ ))
@[match_pattern] def Instruction.REPNE_SCASW : Instruction :=
  .group1 (.SCAS (.REPNE_SCASW ))
@[match_pattern] def Instruction.REP_INSB : Instruction :=
  .group0 (.INS (.REP_INSB ))
@[match_pattern] def Instruction.REP_INSD : Instruction :=
  .group0 (.INS (.REP_INSD ))
@[match_pattern] def Instruction.REP_INSW : Instruction :=
  .group0 (.INS (.REP_INSW ))
@[match_pattern] def Instruction.REP_LODSB : Instruction :=
  .group1 (.LODS (.REP_LODSB ))
@[match_pattern] def Instruction.REP_LODSD : Instruction :=
  .group1 (.LODS (.REP_LODSD ))
@[match_pattern] def Instruction.REP_LODSQ : Instruction :=
  .group1 (.LODS (.REP_LODSQ ))
@[match_pattern] def Instruction.REP_LODSW : Instruction :=
  .group1 (.LODS (.REP_LODSW ))
@[match_pattern] def Instruction.REP_MOVSB : Instruction :=
  .group1 (.MOVS (.REP_MOVSB ))
@[match_pattern] def Instruction.REP_MOVSD : Instruction :=
  .group1 (.MOVS (.REP_MOVSD ))
@[match_pattern] def Instruction.REP_MOVSQ : Instruction :=
  .group1 (.MOVS (.REP_MOVSQ ))
@[match_pattern] def Instruction.REP_MOVSW : Instruction :=
  .group1 (.MOVS (.REP_MOVSW ))
@[match_pattern] def Instruction.REP_OUTSB : Instruction :=
  .group1 (.OUTS (.REP_OUTSB ))
@[match_pattern] def Instruction.REP_OUTSD : Instruction :=
  .group1 (.OUTS (.REP_OUTSD ))
@[match_pattern] def Instruction.REP_OUTSW : Instruction :=
  .group1 (.OUTS (.REP_OUTSW ))
@[match_pattern] def Instruction.REP_STOSB : Instruction :=
  .group2 (.STOS (.REP_STOSB ))
@[match_pattern] def Instruction.REP_STOSD : Instruction :=
  .group2 (.STOS (.REP_STOSD ))
@[match_pattern] def Instruction.REP_STOSQ : Instruction :=
  .group2 (.STOS (.REP_STOSQ ))
@[match_pattern] def Instruction.REP_STOSW : Instruction :=
  .group2 (.STOS (.REP_STOSW ))
@[match_pattern] def Instruction.RET_FAR : Instruction :=
  .group1 (.RET (.RET_FAR ))
@[match_pattern] def Instruction.RET_FAR_IMMw (imm0 : Immediate) : Instruction :=
  .group1 (.RET (.RET_FAR_IMMw imm0))
@[match_pattern] def Instruction.RET_NEAR : Instruction :=
  .group1 (.RET (.RET_NEAR ))
@[match_pattern] def Instruction.RET_NEAR_IMMw (imm0 : Immediate) : Instruction :=
  .group1 (.RET (.RET_NEAR_IMMw imm0))
@[match_pattern] def Instruction.ROL_GPR8_CL (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.ROL_GPR8_CL reg0))
@[match_pattern] def Instruction.ROL_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROL_GPR8_IMMb reg0 imm0))
@[match_pattern] def Instruction.ROL_GPR8_ONE (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.ROL_GPR8_ONE reg0))
@[match_pattern] def Instruction.ROL_GPRv_CL (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.ROL_GPRv_CL reg0))
@[match_pattern] def Instruction.ROL_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROL_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.ROL_GPRv_ONE (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.ROL_GPRv_ONE reg0))
@[match_pattern] def Instruction.ROL_MEMb_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROL_MEMb_CL mem0))
@[match_pattern] def Instruction.ROL_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROL_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.ROL_MEMb_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROL_MEMb_ONE mem0))
@[match_pattern] def Instruction.ROL_MEMv_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROL_MEMv_CL mem0))
@[match_pattern] def Instruction.ROL_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROL_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.ROL_MEMv_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROL_MEMv_ONE mem0))
@[match_pattern] def Instruction.ROR_GPR8_CL (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.ROR_GPR8_CL reg0))
@[match_pattern] def Instruction.ROR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROR_GPR8_IMMb reg0 imm0))
@[match_pattern] def Instruction.ROR_GPR8_ONE (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.RCL (.ROR_GPR8_ONE reg0))
@[match_pattern] def Instruction.ROR_GPRv_CL (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.ROR_GPRv_CL reg0))
@[match_pattern] def Instruction.ROR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.ROR_GPRv_ONE (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.RCL (.ROR_GPRv_ONE reg0))
@[match_pattern] def Instruction.ROR_MEMb_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROR_MEMb_CL mem0))
@[match_pattern] def Instruction.ROR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROR_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.ROR_MEMb_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROR_MEMb_ONE mem0))
@[match_pattern] def Instruction.ROR_MEMv_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROR_MEMv_CL mem0))
@[match_pattern] def Instruction.ROR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.RCL (.ROR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.ROR_MEMv_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RCL (.ROR_MEMv_ONE mem0))
@[match_pattern] def Instruction.RSQRTPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RSQRTPS (.RSQRTPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.RSQRTPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.RSQRTPS (.RSQRTPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.RSQRTSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.RSQRTSS (.RSQRTSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.RSQRTSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group1 (.RSQRTSS (.RSQRTSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.SAR_GPR8_CL (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SAR_GPR8_CL reg0))
@[match_pattern] def Instruction.SAR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SAR_GPR8_IMMb reg0 imm0))
@[match_pattern] def Instruction.SAR_GPR8_ONE (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SAR_GPR8_ONE reg0))
@[match_pattern] def Instruction.SAR_GPRv_CL (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SAR_GPRv_CL reg0))
@[match_pattern] def Instruction.SAR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SAR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.SAR_GPRv_ONE (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SAR_GPRv_ONE reg0))
@[match_pattern] def Instruction.SAR_MEMb_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SAR_MEMb_CL mem0))
@[match_pattern] def Instruction.SAR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SAR_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.SAR_MEMb_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SAR_MEMb_ONE mem0))
@[match_pattern] def Instruction.SAR_MEMv_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SAR_MEMv_CL mem0))
@[match_pattern] def Instruction.SAR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SAR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.SAR_MEMv_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SAR_MEMv_ONE mem0))
@[match_pattern] def Instruction.SBB_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_AL_IMMb imm0))
@[match_pattern] def Instruction.SBB_GPR8_GPR8_18 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.SBB (.SBB_GPR8_GPR8_18 reg0 reg1))
@[match_pattern] def Instruction.SBB_GPR8_GPR8_1A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group1 (.SBB (.SBB_GPR8_GPR8_1A reg0 reg1))
@[match_pattern] def Instruction.SBB_GPR8_IMMb_80r3 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_GPR8_IMMb_80r3 reg0 imm0))
@[match_pattern] def Instruction.SBB_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SBB (.SBB_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.SBB_GPRv_GPRv_19 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.SBB (.SBB_GPRv_GPRv_19 reg0 reg1))
@[match_pattern] def Instruction.SBB_GPRv_GPRv_1B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.SBB (.SBB_GPRv_GPRv_1B reg0 reg1))
@[match_pattern] def Instruction.SBB_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.SBB_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.SBB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SBB (.SBB_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.SBB_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SBB (.SBB_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.SBB_LOCK_MEMb_IMMb_80r3 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_LOCK_MEMb_IMMb_80r3 mem0 imm0))
@[match_pattern] def Instruction.SBB_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SBB (.SBB_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.SBB_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.SBB_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.SBB_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SBB (.SBB_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.SBB_MEMb_IMMb_80r3 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_MEMb_IMMb_80r3 mem0 imm0))
@[match_pattern] def Instruction.SBB_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SBB (.SBB_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.SBB_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.SBB_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.SBB_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group1 (.SBB (.SBB_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.SCASB : Instruction :=
  .group1 (.SCAS (.SCASB ))
@[match_pattern] def Instruction.SCASD : Instruction :=
  .group1 (.SCAS (.SCASD ))
@[match_pattern] def Instruction.SCASQ : Instruction :=
  .group1 (.SCAS (.SCASQ ))
@[match_pattern] def Instruction.SCASW : Instruction :=
  .group1 (.SCAS (.SCASW ))
@[match_pattern] def Instruction.SETBE_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETBE_GPR8 reg0))
@[match_pattern] def Instruction.SETBE_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETBE_MEMb mem0))
@[match_pattern] def Instruction.SETB_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETB_GPR8 reg0))
@[match_pattern] def Instruction.SETB_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETB_MEMb mem0))
@[match_pattern] def Instruction.SETLE_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETLE_GPR8 reg0))
@[match_pattern] def Instruction.SETLE_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETLE_MEMb mem0))
@[match_pattern] def Instruction.SETL_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETL_GPR8 reg0))
@[match_pattern] def Instruction.SETL_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETL_MEMb mem0))
@[match_pattern] def Instruction.SETNBE_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNBE_GPR8 reg0))
@[match_pattern] def Instruction.SETNBE_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNBE_MEMb mem0))
@[match_pattern] def Instruction.SETNB_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNB_GPR8 reg0))
@[match_pattern] def Instruction.SETNB_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNB_MEMb mem0))
@[match_pattern] def Instruction.SETNLE_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNLE_GPR8 reg0))
@[match_pattern] def Instruction.SETNLE_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNLE_MEMb mem0))
@[match_pattern] def Instruction.SETNL_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNL_GPR8 reg0))
@[match_pattern] def Instruction.SETNL_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNL_MEMb mem0))
@[match_pattern] def Instruction.SETNO_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNO_GPR8 reg0))
@[match_pattern] def Instruction.SETNO_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNO_MEMb mem0))
@[match_pattern] def Instruction.SETNP_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNP_GPR8 reg0))
@[match_pattern] def Instruction.SETNP_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNP_MEMb mem0))
@[match_pattern] def Instruction.SETNS_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNS_GPR8 reg0))
@[match_pattern] def Instruction.SETNS_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNS_MEMb mem0))
@[match_pattern] def Instruction.SETNZ_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETNZ_GPR8 reg0))
@[match_pattern] def Instruction.SETNZ_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETNZ_MEMb mem0))
@[match_pattern] def Instruction.SETO_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETO_GPR8 reg0))
@[match_pattern] def Instruction.SETO_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETO_MEMb mem0))
@[match_pattern] def Instruction.SETP_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETP_GPR8 reg0))
@[match_pattern] def Instruction.SETP_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETP_MEMb mem0))
@[match_pattern] def Instruction.SETS_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETS_GPR8 reg0))
@[match_pattern] def Instruction.SETS_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETS_MEMb mem0))
@[match_pattern] def Instruction.SETZ_GPR8 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SETcc (.SETZ_GPR8 reg0))
@[match_pattern] def Instruction.SETZ_MEMb (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SETcc (.SETZ_MEMb mem0))
@[match_pattern] def Instruction.SFENCE : Instruction :=
  .group1 (.SFENCE (.SFENCE ))
@[match_pattern] def Instruction.SGDT_MEMs64 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SGDT (.SGDT_MEMs64 mem0))
@[match_pattern] def Instruction.SHLD_GPRv_GPRv_CL (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group1 (.SHLD (.SHLD_GPRv_GPRv_CL reg0 reg1))
@[match_pattern] def Instruction.SHLD_GPRv_GPRv_IMMb (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SHLD (.SHLD_GPRv_GPRv_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.SHLD_MEMv_GPRv_CL (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SHLD (.SHLD_MEMv_GPRv_CL mem0 reg0))
@[match_pattern] def Instruction.SHLD_MEMv_GPRv_IMMb (mem0 : MemoryOperand) (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SHLD (.SHLD_MEMv_GPRv_IMMb mem0 reg0 imm0))
@[match_pattern] def Instruction.SHL_GPR8_CL_D2r4 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SHL_GPR8_CL_D2r4 reg0))
@[match_pattern] def Instruction.SHL_GPR8_CL_D2r6 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SHL_GPR8_CL_D2r6 reg0))
@[match_pattern] def Instruction.SHL_GPR8_IMMb_C0r4 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_GPR8_IMMb_C0r4 reg0 imm0))
@[match_pattern] def Instruction.SHL_GPR8_IMMb_C0r6 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_GPR8_IMMb_C0r6 reg0 imm0))
@[match_pattern] def Instruction.SHL_GPR8_ONE_D0r4 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SHL_GPR8_ONE_D0r4 reg0))
@[match_pattern] def Instruction.SHL_GPR8_ONE_D0r6 (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SHL_GPR8_ONE_D0r6 reg0))
@[match_pattern] def Instruction.SHL_GPRv_CL_D3r4 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SHL_GPRv_CL_D3r4 reg0))
@[match_pattern] def Instruction.SHL_GPRv_CL_D3r6 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SHL_GPRv_CL_D3r6 reg0))
@[match_pattern] def Instruction.SHL_GPRv_IMMb_C1r4 (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_GPRv_IMMb_C1r4 reg0 imm0))
@[match_pattern] def Instruction.SHL_GPRv_IMMb_C1r6 (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_GPRv_IMMb_C1r6 reg0 imm0))
@[match_pattern] def Instruction.SHL_GPRv_ONE_D1r4 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SHL_GPRv_ONE_D1r4 reg0))
@[match_pattern] def Instruction.SHL_GPRv_ONE_D1r6 (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SHL_GPRv_ONE_D1r6 reg0))
@[match_pattern] def Instruction.SHL_MEMb_CL_D2r4 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMb_CL_D2r4 mem0))
@[match_pattern] def Instruction.SHL_MEMb_CL_D2r6 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMb_CL_D2r6 mem0))
@[match_pattern] def Instruction.SHL_MEMb_IMMb_C0r4 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_MEMb_IMMb_C0r4 mem0 imm0))
@[match_pattern] def Instruction.SHL_MEMb_IMMb_C0r6 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_MEMb_IMMb_C0r6 mem0 imm0))
@[match_pattern] def Instruction.SHL_MEMb_ONE_D0r4 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMb_ONE_D0r4 mem0))
@[match_pattern] def Instruction.SHL_MEMb_ONE_D0r6 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMb_ONE_D0r6 mem0))
@[match_pattern] def Instruction.SHL_MEMv_CL_D3r4 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMv_CL_D3r4 mem0))
@[match_pattern] def Instruction.SHL_MEMv_CL_D3r6 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMv_CL_D3r6 mem0))
@[match_pattern] def Instruction.SHL_MEMv_IMMb_C1r4 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_MEMv_IMMb_C1r4 mem0 imm0))
@[match_pattern] def Instruction.SHL_MEMv_IMMb_C1r6 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHL_MEMv_IMMb_C1r6 mem0 imm0))
@[match_pattern] def Instruction.SHL_MEMv_ONE_D1r4 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMv_ONE_D1r4 mem0))
@[match_pattern] def Instruction.SHL_MEMv_ONE_D1r6 (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHL_MEMv_ONE_D1r6 mem0))
@[match_pattern] def Instruction.SHRD_GPRv_GPRv_CL (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.SHRD (.SHRD_GPRv_GPRv_CL reg0 reg1))
@[match_pattern] def Instruction.SHRD_GPRv_GPRv_IMMb (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.SHRD (.SHRD_GPRv_GPRv_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.SHRD_MEMv_GPRv_CL (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.SHRD (.SHRD_MEMv_GPRv_CL mem0 reg0))
@[match_pattern] def Instruction.SHRD_MEMv_GPRv_IMMb (mem0 : MemoryOperand) (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.SHRD (.SHRD_MEMv_GPRv_IMMb mem0 reg0 imm0))
@[match_pattern] def Instruction.SHR_GPR8_CL (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SHR_GPR8_CL reg0))
@[match_pattern] def Instruction.SHR_GPR8_IMMb (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHR_GPR8_IMMb reg0 imm0))
@[match_pattern] def Instruction.SHR_GPR8_ONE (reg0 : Registers.GPR8) : Instruction :=
  .group1 (.SAL (.SHR_GPR8_ONE reg0))
@[match_pattern] def Instruction.SHR_GPRv_CL (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SHR_GPRv_CL reg0))
@[match_pattern] def Instruction.SHR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.SHR_GPRv_ONE (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.SAL (.SHR_GPRv_ONE reg0))
@[match_pattern] def Instruction.SHR_MEMb_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHR_MEMb_CL mem0))
@[match_pattern] def Instruction.SHR_MEMb_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHR_MEMb_IMMb mem0 imm0))
@[match_pattern] def Instruction.SHR_MEMb_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHR_MEMb_ONE mem0))
@[match_pattern] def Instruction.SHR_MEMv_CL (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHR_MEMv_CL mem0))
@[match_pattern] def Instruction.SHR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group1 (.SAL (.SHR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.SHR_MEMv_ONE (mem0 : MemoryOperand) : Instruction :=
  .group1 (.SAL (.SHR_MEMv_ONE mem0))
@[match_pattern] def Instruction.SHUFPD_XMMpd_MEMpd_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SHUFPD (.SHUFPD_XMMpd_MEMpd_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.SHUFPD_XMMpd_XMMpd_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group2 (.SHUFPD (.SHUFPD_XMMpd_XMMpd_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.SHUFPS_XMMps_MEMps_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SHUFPS (.SHUFPS_XMMps_MEMps_IMMb reg0 mem0 imm0))
@[match_pattern] def Instruction.SHUFPS_XMMps_XMMps_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate) : Instruction :=
  .group2 (.SHUFPS (.SHUFPS_XMMps_XMMps_IMMb reg0 reg1 imm0))
@[match_pattern] def Instruction.SIDT_MEMs64 (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SIDT (.SIDT_MEMs64 mem0))
@[match_pattern] def Instruction.SLDT_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.SLDT (.SLDT_GPRv reg0))
@[match_pattern] def Instruction.SLDT_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SLDT (.SLDT_MEMw mem0))
@[match_pattern] def Instruction.SMSW_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.SMSW (.SMSW_GPRv reg0))
@[match_pattern] def Instruction.SMSW_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SMSW (.SMSW_MEMw mem0))
@[match_pattern] def Instruction.SQRTPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SQRTPD (.SQRTPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.SQRTPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SQRTPD (.SQRTPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.SQRTPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SQRTPS (.SQRTPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.SQRTPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SQRTPS (.SQRTPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.SQRTSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SQRTSD (.SQRTSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.SQRTSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SQRTSD (.SQRTSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.SQRTSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SQRTSS (.SQRTSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.SQRTSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SQRTSS (.SQRTSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.STC : Instruction :=
  .group2 (.STC (.STC ))
@[match_pattern] def Instruction.STD : Instruction :=
  .group2 (.STD (.STD ))
@[match_pattern] def Instruction.STI : Instruction :=
  .group2 (.STI (.STI ))
@[match_pattern] def Instruction.STMXCSR_MEMd (mem0 : MemoryOperand) : Instruction :=
  .group2 (.STMXCSR (.STMXCSR_MEMd mem0))
@[match_pattern] def Instruction.STOSB : Instruction :=
  .group2 (.STOS (.STOSB ))
@[match_pattern] def Instruction.STOSD : Instruction :=
  .group2 (.STOS (.STOSD ))
@[match_pattern] def Instruction.STOSQ : Instruction :=
  .group2 (.STOS (.STOSQ ))
@[match_pattern] def Instruction.STOSW : Instruction :=
  .group2 (.STOS (.STOSW ))
@[match_pattern] def Instruction.STR_GPRv (reg0 : Registers.GPRv) : Instruction :=
  .group1 (.Local (.STR_GPRv reg0))
@[match_pattern] def Instruction.STR_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group1 (.Local (.STR_MEMw mem0))
@[match_pattern] def Instruction.SUBPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SUBPD (.SUBPD_XMMpd_MEMpd reg0 mem0))
@[match_pattern] def Instruction.SUBPD_XMMpd_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SUBPD (.SUBPD_XMMpd_XMMpd reg0 reg1))
@[match_pattern] def Instruction.SUBPS_XMMps_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SUBPS (.SUBPS_XMMps_MEMps reg0 mem0))
@[match_pattern] def Instruction.SUBPS_XMMps_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SUBPS (.SUBPS_XMMps_XMMps reg0 reg1))
@[match_pattern] def Instruction.SUBSD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SUBSD (.SUBSD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.SUBSD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SUBSD (.SUBSD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.SUBSS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SUBSS (.SUBSS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.SUBSS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.SUBSS (.SUBSS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.SUB_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_AL_IMMb imm0))
@[match_pattern] def Instruction.SUB_GPR8_GPR8_28 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.SUB (.SUB_GPR8_GPR8_28 reg0 reg1))
@[match_pattern] def Instruction.SUB_GPR8_GPR8_2A (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.SUB (.SUB_GPR8_GPR8_2A reg0 reg1))
@[match_pattern] def Instruction.SUB_GPR8_IMMb_80r5 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_GPR8_IMMb_80r5 reg0 imm0))
@[match_pattern] def Instruction.SUB_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SUB (.SUB_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.SUB_GPRv_GPRv_29 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.SUB (.SUB_GPRv_GPRv_29 reg0 reg1))
@[match_pattern] def Instruction.SUB_GPRv_GPRv_2B (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.SUB (.SUB_GPRv_GPRv_2B reg0 reg1))
@[match_pattern] def Instruction.SUB_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.SUB_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.SUB_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.SUB (.SUB_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.SUB_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.SUB (.SUB_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.SUB_LOCK_MEMb_IMMb_80r5 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_LOCK_MEMb_IMMb_80r5 mem0 imm0))
@[match_pattern] def Instruction.SUB_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.SUB (.SUB_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.SUB_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.SUB_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.SUB_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.SUB (.SUB_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.SUB_MEMb_IMMb_80r5 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_MEMb_IMMb_80r5 mem0 imm0))
@[match_pattern] def Instruction.SUB_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.SUB (.SUB_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.SUB_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.SUB_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.SUB_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group2 (.SUB (.SUB_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.SWAPGS : Instruction :=
  .group2 (.SWAPGS (.SWAPGS ))
@[match_pattern] def Instruction.SYSCALL : Instruction :=
  .group2 (.SYSCALL (.SYSCALL ))
@[match_pattern] def Instruction.SYSRET : Instruction :=
  .group1 (.Local (.SYSRET ))
@[match_pattern] def Instruction.SYSRET64 : Instruction :=
  .group1 (.Local (.SYSRET64 ))
@[match_pattern] def Instruction.TEST_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_AL_IMMb imm0))
@[match_pattern] def Instruction.TEST_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.TEST (.TEST_GPR8_GPR8 reg0 reg1))
@[match_pattern] def Instruction.TEST_GPR8_IMMb_F6r0 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_GPR8_IMMb_F6r0 reg0 imm0))
@[match_pattern] def Instruction.TEST_GPR8_IMMb_F6r1 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_GPR8_IMMb_F6r1 reg0 imm0))
@[match_pattern] def Instruction.TEST_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.TEST (.TEST_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.TEST_GPRv_IMMz_F7r0 (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_GPRv_IMMz_F7r0 reg0 imm0))
@[match_pattern] def Instruction.TEST_GPRv_IMMz_F7r1 (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_GPRv_IMMz_F7r1 reg0 imm0))
@[match_pattern] def Instruction.TEST_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.TEST (.TEST_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.TEST_MEMb_IMMb_F6r0 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_MEMb_IMMb_F6r0 mem0 imm0))
@[match_pattern] def Instruction.TEST_MEMb_IMMb_F6r1 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_MEMb_IMMb_F6r1 mem0 imm0))
@[match_pattern] def Instruction.TEST_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.TEST (.TEST_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.TEST_MEMv_IMMz_F7r0 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_MEMv_IMMz_F7r0 mem0 imm0))
@[match_pattern] def Instruction.TEST_MEMv_IMMz_F7r1 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_MEMv_IMMz_F7r1 mem0 imm0))
@[match_pattern] def Instruction.TEST_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group2 (.TEST (.TEST_OrAX_IMMz reg0 imm0))
@[match_pattern] def Instruction.UCOMISD_XMMsd_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UCOMISD (.UCOMISD_XMMsd_MEMsd reg0 mem0))
@[match_pattern] def Instruction.UCOMISD_XMMsd_XMMsd (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.UCOMISD (.UCOMISD_XMMsd_XMMsd reg0 reg1))
@[match_pattern] def Instruction.UCOMISS_XMMss_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UCOMISS (.UCOMISS_XMMss_MEMss reg0 mem0))
@[match_pattern] def Instruction.UCOMISS_XMMss_XMMss (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.UCOMISS (.UCOMISS_XMMss_XMMss reg0 reg1))
@[match_pattern] def Instruction.UD0_GPR32_GPR32 (reg0 : Registers.GPR32) (reg1 : Registers.GPR32) : Instruction :=
  .group2 (.UD (.UD0_GPR32_GPR32 reg0 reg1))
@[match_pattern] def Instruction.UD0_GPR32_MEMd (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UD (.UD0_GPR32_MEMd reg0 mem0))
@[match_pattern] def Instruction.UD1_GPR32_GPR32 (reg0 : Registers.GPR32) (reg1 : Registers.GPR32) : Instruction :=
  .group2 (.UD (.UD1_GPR32_GPR32 reg0 reg1))
@[match_pattern] def Instruction.UD1_GPR32_MEMd (reg0 : Registers.GPR32) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UD (.UD1_GPR32_MEMd reg0 mem0))
@[match_pattern] def Instruction.UD2 : Instruction :=
  .group2 (.UD (.UD2 ))
@[match_pattern] def Instruction.UDB : Instruction :=
  .group2 (.UD (.UDB ))
@[match_pattern] def Instruction.UNPCKHPD_XMMpd_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UNPCKHPD (.UNPCKHPD_XMMpd_MEMdq reg0 mem0))
@[match_pattern] def Instruction.UNPCKHPD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.UNPCKHPD (.UNPCKHPD_XMMpd_XMMq reg0 reg1))
@[match_pattern] def Instruction.UNPCKHPS_XMMps_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UNPCKHPS (.UNPCKHPS_XMMps_MEMdq reg0 mem0))
@[match_pattern] def Instruction.UNPCKHPS_XMMps_XMMdq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.UNPCKHPS (.UNPCKHPS_XMMps_XMMdq reg0 reg1))
@[match_pattern] def Instruction.UNPCKLPD_XMMpd_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UNPCKLPD (.UNPCKLPD_XMMpd_MEMdq reg0 mem0))
@[match_pattern] def Instruction.UNPCKLPD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.UNPCKLPD (.UNPCKLPD_XMMpd_XMMq reg0 reg1))
@[match_pattern] def Instruction.UNPCKLPS_XMMps_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.UNPCKLPS (.UNPCKLPS_XMMps_MEMdq reg0 mem0))
@[match_pattern] def Instruction.UNPCKLPS_XMMps_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.UNPCKLPS (.UNPCKLPS_XMMps_XMMq reg0 reg1))
@[match_pattern] def Instruction.VERR_GPR16 (reg0 : Registers.GPR16) : Instruction :=
  .group2 (.VERR (.VERR_GPR16 reg0))
@[match_pattern] def Instruction.VERR_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group2 (.VERR (.VERR_MEMw mem0))
@[match_pattern] def Instruction.VERW_GPR16 (reg0 : Registers.GPR16) : Instruction :=
  .group2 (.VERR (.VERW_GPR16 reg0))
@[match_pattern] def Instruction.VERW_MEMw (mem0 : MemoryOperand) : Instruction :=
  .group2 (.VERR (.VERW_MEMw mem0))
@[match_pattern] def Instruction.WBINVD : Instruction :=
  .group2 (.WBINVD (.WBINVD ))
@[match_pattern] def Instruction.WRMSR : Instruction :=
  .group2 (.WRMSR (.WRMSR ))
@[match_pattern] def Instruction.XADD_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.XADD (.XADD_GPR8_GPR8 reg0 reg1))
@[match_pattern] def Instruction.XADD_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.XADD (.XADD_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.XADD_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.XADD (.XADD_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.XADD_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.XADD (.XADD_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.XADD_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.XADD (.XADD_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.XADD_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.XADD (.XADD_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.XCHG_GPR8_GPR8 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.XCHG (.XCHG_GPR8_GPR8 reg0 reg1))
@[match_pattern] def Instruction.XCHG_GPRv_GPRv (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.XCHG (.XCHG_GPRv_GPRv reg0 reg1))
@[match_pattern] def Instruction.XCHG_GPRv_OrAX (reg0 : Registers.GPRv) (reg1 : Registers.OrAX) : Instruction :=
  .group2 (.XCHG (.XCHG_GPRv_OrAX reg0 reg1))
@[match_pattern] def Instruction.XCHG_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.XCHG (.XCHG_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.XCHG_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.XCHG (.XCHG_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.XLAT : Instruction :=
  .group2 (.XLAT (.XLAT ))
@[match_pattern] def Instruction.XORPD_XMMxuq_MEMxuq (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.XORPD (.XORPD_XMMxuq_MEMxuq reg0 mem0))
@[match_pattern] def Instruction.XORPD_XMMxuq_XMMxuq (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.XORPD (.XORPD_XMMxuq_XMMxuq reg0 reg1))
@[match_pattern] def Instruction.XORPS_XMMxud_MEMxud (reg0 : Registers.XMM) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.XORPS (.XORPS_XMMxud_MEMxud reg0 mem0))
@[match_pattern] def Instruction.XORPS_XMMxud_XMMxud (reg0 : Registers.XMM) (reg1 : Registers.XMM) : Instruction :=
  .group2 (.XORPS (.XORPS_XMMxud_XMMxud reg0 reg1))
@[match_pattern] def Instruction.XOR_AL_IMMb (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_AL_IMMb imm0))
@[match_pattern] def Instruction.XOR_GPR8_GPR8_30 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.XOR (.XOR_GPR8_GPR8_30 reg0 reg1))
@[match_pattern] def Instruction.XOR_GPR8_GPR8_32 (reg0 : Registers.GPR8) (reg1 : Registers.GPR8) : Instruction :=
  .group2 (.XOR (.XOR_GPR8_GPR8_32 reg0 reg1))
@[match_pattern] def Instruction.XOR_GPR8_IMMb_80r6 (reg0 : Registers.GPR8) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_GPR8_IMMb_80r6 reg0 imm0))
@[match_pattern] def Instruction.XOR_GPR8_MEMb (reg0 : Registers.GPR8) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.XOR (.XOR_GPR8_MEMb reg0 mem0))
@[match_pattern] def Instruction.XOR_GPRv_GPRv_31 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.XOR (.XOR_GPRv_GPRv_31 reg0 reg1))
@[match_pattern] def Instruction.XOR_GPRv_GPRv_33 (reg0 : Registers.GPRv) (reg1 : Registers.GPRv) : Instruction :=
  .group2 (.XOR (.XOR_GPRv_GPRv_33 reg0 reg1))
@[match_pattern] def Instruction.XOR_GPRv_IMMb (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_GPRv_IMMb reg0 imm0))
@[match_pattern] def Instruction.XOR_GPRv_IMMz (reg0 : Registers.GPRv) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_GPRv_IMMz reg0 imm0))
@[match_pattern] def Instruction.XOR_GPRv_MEMv (reg0 : Registers.GPRv) (mem0 : MemoryOperand) : Instruction :=
  .group2 (.XOR (.XOR_GPRv_MEMv reg0 mem0))
@[match_pattern] def Instruction.XOR_LOCK_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.XOR (.XOR_LOCK_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.XOR_LOCK_MEMb_IMMb_80r6 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_LOCK_MEMb_IMMb_80r6 mem0 imm0))
@[match_pattern] def Instruction.XOR_LOCK_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.XOR (.XOR_LOCK_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.XOR_LOCK_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_LOCK_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.XOR_LOCK_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_LOCK_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.XOR_MEMb_GPR8 (mem0 : MemoryOperand) (reg0 : Registers.GPR8) : Instruction :=
  .group2 (.XOR (.XOR_MEMb_GPR8 mem0 reg0))
@[match_pattern] def Instruction.XOR_MEMb_IMMb_80r6 (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_MEMb_IMMb_80r6 mem0 imm0))
@[match_pattern] def Instruction.XOR_MEMv_GPRv (mem0 : MemoryOperand) (reg0 : Registers.GPRv) : Instruction :=
  .group2 (.XOR (.XOR_MEMv_GPRv mem0 reg0))
@[match_pattern] def Instruction.XOR_MEMv_IMMb (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_MEMv_IMMb mem0 imm0))
@[match_pattern] def Instruction.XOR_MEMv_IMMz (mem0 : MemoryOperand) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_MEMv_IMMz mem0 imm0))
@[match_pattern] def Instruction.XOR_OrAX_IMMz (reg0 : Registers.OrAX) (imm0 : Immediate) : Instruction :=
  .group2 (.XOR (.XOR_OrAX_IMMz reg0 imm0))

end X86.Syntax

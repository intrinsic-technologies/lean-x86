-- Generated from Intel XML instruction-form metadata and XED encoding tables; generated selection and dispatch, not an Intel decoder body; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; reserved-encoding bounds: datafiles/amd/xed-amd-3dnow.txt, datafiles/amd/xed-amd-base.txt, datafiles/amd/xed-amd-clzero.txt, datafiles/amd/xed-amd-invlpgb.txt, datafiles/amd/xed-amd-mcommit.txt, datafiles/amd/xed-amd-monitorx.txt, datafiles/amd/xed-amd-rdpru.txt, datafiles/amd/xed-amd-snp.txt, datafiles/amd/xed-amd-sse4a.txt, datafiles/amd/xed-amd-svm.txt, datafiles/apx-f/apx-ppx-isa.xed.txt, datafiles/bdw/adox-adcx-isa.xed.txt, datafiles/cldemote/cldemote-isa.xed.txt, datafiles/clflushopt/clflushopt.xed.txt, datafiles/clwb/clwb.xed.txt, datafiles/enqcmd/enqcmd-isa.xed.txt, datafiles/fred/fred-isa.xed.txt, datafiles/fsgsbase/fsgsbase-isa.xed.txt, datafiles/gfni-vaes-vpcl/gfni-sse-isa.xed.txt, datafiles/hreset/hreset-isa.xed.txt, datafiles/hsw/invpcid-isa.xed.txt, datafiles/hsw/rtm-isa.xed.txt, datafiles/hsw/vmfunc-isa.xed.txt, datafiles/hswbmi/tzcnt-isa.xed.txt, datafiles/ibhf/ibhf-isa.xed.txt, datafiles/iprefetch/iprefetch-isa.xed.txt, datafiles/keylocker/keylocker-isa.xed.txt, datafiles/movdir/movdir-isa.xed.txt, datafiles/mpx/mpx-isa.txt, datafiles/msrlist/msrlist-isa.xed.txt, datafiles/pbndkb/pbndkb-isa.xed.txt, datafiles/pconfig/pconfig-isa.xed.txt, datafiles/pku/pku-isa.xed.txt, datafiles/pt/intelpt-isa.xed.txt, datafiles/rao-int/rao-int-isa.xed.txt, datafiles/rdpid/rdpid-isa.xed.txt, datafiles/rdrand/rdrand-isa.xed.txt, datafiles/rdseed/rdseed-isa.xed.txt, datafiles/serialize/serialize-isa.xed.txt, datafiles/sgx-enclv/sgx-enclv-isa.xed.txt, datafiles/sgx/sgx-isa.xed.txt, datafiles/sha/sha-isa.xed.txt, datafiles/smap/smap-isa.xed.txt, datafiles/tdx/tdx-isa.xed.txt, datafiles/tsx-ldtrk/tsx-ldtrk-isa.xed.txt, datafiles/uintr/uintr-isa.xed.txt, datafiles/waitpkg/waitpkg-isa.xed.txt, datafiles/wbnoinvd/wbnoinvd-isa.xed.txt, datafiles/wrmsrns/wrmsrns-isa.xed.txt, datafiles/xsavec/xsavec-isa.txt, datafiles/xsaveopt/xsaveopt-isa.txt, datafiles/xsaves/xsaves-isa.txt; do not edit.
-- Source SHA256: 5ca53602832653f946918404c9de2424b0374f4f0cc65a1ca46ac888f55bd9e0
import X86.Runtime
import X86.Cpuid
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Unimplemented_Feature
import X86.Instructions.ADDPD
import X86.Instructions.ADDPS
import X86.Instructions.ADDSD
import X86.Instructions.ADDSS
import X86.Instructions.ANDNPD
import X86.Instructions.ANDNPS
import X86.Instructions.ANDPD
import X86.Instructions.ANDPS
import X86.Instructions.BSF
import X86.Instructions.BSR
import X86.Instructions.BSWAP
import X86.Instructions.BT
import X86.Instructions.BTC
import X86.Instructions.BTR
import X86.Instructions.BTS
import X86.Instructions.CLFLUSH
import X86.Instructions.CLTS
import X86.Instructions.CMOVcc
import X86.Instructions.CMPPD
import X86.Instructions.CMPPS
import X86.Instructions.CMPSD
import X86.Instructions.CMPSS
import X86.Instructions.CMPXCHG
import X86.Instructions.CMPXCHG8B
import X86.Instructions.COMISD
import X86.Instructions.COMISS
import X86.Instructions.CPUID
import X86.Instructions.CVTDQ2PD
import X86.Instructions.CVTDQ2PS
import X86.Instructions.CVTPD2DQ
import X86.Instructions.CVTPD2PI
import X86.Instructions.CVTPD2PS
import X86.Instructions.CVTPI2PD
import X86.Instructions.CVTPI2PS
import X86.Instructions.CVTPS2DQ
import X86.Instructions.CVTPS2PD
import X86.Instructions.CVTPS2PI
import X86.Instructions.CVTSD2SI
import X86.Instructions.CVTSD2SS
import X86.Instructions.CVTSI2SD
import X86.Instructions.CVTSI2SS
import X86.Instructions.CVTSS2SD
import X86.Instructions.CVTSS2SI
import X86.Instructions.CVTTPD2DQ
import X86.Instructions.CVTTPD2PI
import X86.Instructions.CVTTPS2DQ
import X86.Instructions.CVTTPS2PI
import X86.Instructions.CVTTSD2SI
import X86.Instructions.CVTTSS2SI
import X86.Instructions.DIVPD
import X86.Instructions.DIVPS
import X86.Instructions.DIVSD
import X86.Instructions.DIVSS
import X86.Instructions.EMMS
import X86.Instructions.ENDBR64
import X86.Instructions.FXRSTOR
import X86.Instructions.FXSAVE
import X86.Instructions.IMUL
import X86.Instructions.INVD
import X86.Instructions.INVLPG
import X86.Instructions.Jcc
import X86.Instructions.LAR
import X86.Instructions.LDMXCSR
import X86.Instructions.LDS
import X86.Instructions.LFENCE
import X86.Instructions.LGDT
import X86.Instructions.LLDT
import X86.Instructions.LMSW
import X86.Instructions.LSL
import X86.Instructions.LTR
import X86.Instructions.LZCNT
import X86.Instructions.MASKMOVDQU
import X86.Instructions.MASKMOVQ
import X86.Instructions.MAXPD
import X86.Instructions.MAXPS
import X86.Instructions.MAXSD
import X86.Instructions.MAXSS
import X86.Instructions.MFENCE
import X86.Instructions.MINPD
import X86.Instructions.MINPS
import X86.Instructions.MINSD
import X86.Instructions.MINSS
import X86.Instructions.MOVAPD
import X86.Instructions.MOVAPS
import X86.Instructions.MOVD
import X86.Instructions.MOVDQ2Q
import X86.Instructions.MOVDQA
import X86.Instructions.MOVDQU
import X86.Instructions.MOVHLPS
import X86.Instructions.MOVHPD
import X86.Instructions.MOVHPS
import X86.Instructions.MOVLHPS
import X86.Instructions.MOVLPD
import X86.Instructions.MOVLPS
import X86.Instructions.MOVMSKPD
import X86.Instructions.MOVMSKPS
import X86.Instructions.MOVNTDQ
import X86.Instructions.MOVNTI
import X86.Instructions.MOVNTPD
import X86.Instructions.MOVNTPS
import X86.Instructions.MOVNTQ
import X86.Instructions.MOVQ2DQ
import X86.Instructions.MOVSD
import X86.Instructions.MOVSS
import X86.Instructions.MOVSX
import X86.Instructions.MOVUPD
import X86.Instructions.MOVUPS
import X86.Instructions.MOVZX
import X86.Instructions.MOV_CR
import X86.Instructions.MOV_DR
import X86.Instructions.MULPD
import X86.Instructions.MULPS
import X86.Instructions.MULSD
import X86.Instructions.MULSS
import X86.Instructions.NOP
import X86.Instructions.ORPD
import X86.Instructions.ORPS
import X86.Instructions.PACKSSWB
import X86.Instructions.PACKUSWB
import X86.Instructions.PADDB
import X86.Instructions.PADDSB
import X86.Instructions.PADDUSB
import X86.Instructions.PAND
import X86.Instructions.PANDN
import X86.Instructions.PAVGB
import X86.Instructions.PCMPEQB
import X86.Instructions.PCMPGTB
import X86.Instructions.PEXTRW
import X86.Instructions.PINSRW
import X86.Instructions.PMADDWD
import X86.Instructions.PMAXSB
import X86.Instructions.PMAXUB
import X86.Instructions.PMINSB
import X86.Instructions.PMINUB
import X86.Instructions.PMOVMSKB
import X86.Instructions.PMULHUW
import X86.Instructions.PMULHW
import X86.Instructions.PMULLW
import X86.Instructions.PMULUDQ
import X86.Instructions.POP
import X86.Instructions.POR
import X86.Instructions.PREFETCHW
import X86.Instructions.PREFETCHh
import X86.Instructions.PSADBW
import X86.Instructions.PSHUFD
import X86.Instructions.PSHUFHW
import X86.Instructions.PSHUFLW
import X86.Instructions.PSHUFW
import X86.Instructions.PSLLDQ
import X86.Instructions.PSLLW
import X86.Instructions.PSRAW
import X86.Instructions.PSRLDQ
import X86.Instructions.PSRLW
import X86.Instructions.PSUBB
import X86.Instructions.PSUBQ
import X86.Instructions.PSUBSB
import X86.Instructions.PSUBUSB
import X86.Instructions.PUNPCKHBW
import X86.Instructions.PUNPCKLBW
import X86.Instructions.PUSH
import X86.Instructions.PXOR
import X86.Instructions.RCPPS
import X86.Instructions.RCPSS
import X86.Instructions.RDMSR
import X86.Instructions.RDTSC
import X86.Instructions.RSQRTPS
import X86.Instructions.RSQRTSS
import X86.Instructions.SETcc
import X86.Instructions.SFENCE
import X86.Instructions.SGDT
import X86.Instructions.SHLD
import X86.Instructions.SHRD
import X86.Instructions.SHUFPD
import X86.Instructions.SHUFPS
import X86.Instructions.SIDT
import X86.Instructions.SLDT
import X86.Instructions.SMSW
import X86.Instructions.SQRTPD
import X86.Instructions.SQRTPS
import X86.Instructions.SQRTSD
import X86.Instructions.SQRTSS
import X86.Instructions.STMXCSR
import X86.Instructions.STR
import X86.Instructions.SUBPD
import X86.Instructions.SUBPS
import X86.Instructions.SUBSD
import X86.Instructions.SUBSS
import X86.Instructions.SWAPGS
import X86.Instructions.SYSCALL
import X86.Instructions.SYSRET
import X86.Instructions.UCOMISD
import X86.Instructions.UCOMISS
import X86.Instructions.UD
import X86.Instructions.UNPCKHPD
import X86.Instructions.UNPCKHPS
import X86.Instructions.UNPCKLPD
import X86.Instructions.UNPCKLPS
import X86.Instructions.VERR
import X86.Instructions.WBINVD
import X86.Instructions.WRMSR
import X86.Instructions.XADD
import X86.Instructions.XORPD
import X86.Instructions.XORPS
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.CR0_Guest_Host_Mask.Binding σ]
  [X86.CR0_Read_Shadow.Binding σ]
  [X86.CR3_Target_Count.Binding σ]
  [X86.CR3_Target_Value0.Binding σ]
  [X86.CR3_Target_Value1.Binding σ]
  [X86.CR3_Target_Value2.Binding σ]
  [X86.CR3_Target_Value3.Binding σ]
  [X86.CR4_Guest_Host_Mask.Binding σ]
  [X86.CR4_Read_Shadow.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Cache.Flush_By_Address.Binding σ]
  [X86.Helpers.Cache.Invalidate.Binding σ]
  [X86.Helpers.Cache.Prefetch_By_Address.Binding σ]
  [X86.Helpers.Cache.Writeback.Binding σ]
  [X86.Helpers.Emulate_RCPSS.Binding σ]
  [X86.Helpers.Emulate_RSQRTSS.Binding σ]
  [X86.Helpers.FRED.Event_Delivery.Binding σ]
  [X86.Helpers.Memory_Fence.Binding σ]
  [X86.Helpers.Memory_Load_Fence.Binding σ]
  [X86.Helpers.Memory_Store_Fence.Binding σ]
  [X86.Helpers.Other_MSR_Commit.Binding σ]
  [X86.Helpers.Other_MSR_Read.Binding σ]
  [X86.Helpers.Other_MSR_Read_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Behavior.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Read_Time_Stamp_Counter.Binding σ]
  [X86.Helpers.Select_FXSAVE_AC.Binding σ]
  [X86.Helpers.Select_FXSAVE_Fields.Binding σ]
  [X86.Helpers.Select_FXSAVE_Page_Fault_Priority.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Header.Binding σ]
  [X86.Helpers.Select_FXSAVE_Reserved_Slot.Binding σ]
  [X86.Helpers.Select_FXSAVE_Schedule_Domain.Binding σ]
  [X86.Helpers.Select_FXSAVE_Write_Swap.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.Invalidate_All_Translation_Caches.Binding σ]
  [X86.Invalidate_Translation_Caches.Binding σ]
  [X86.Read_MXCSR_DAZ16.Binding σ]
  [X86.Read_MXCSR_FTZ16.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Max_Physical_Address]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Max_Linear_Address]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Select_Legacy_1_Opcode_00
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 2
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 4
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 12
  return 0

def Select_Legacy_1_Opcode_01
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _rm == 0 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 8
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 10
  return 0

def Select_Legacy_1_Opcode_02
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_03
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_05
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_06
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_07
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rex_w == 0) then
    return 1
  if (_mode64 and _context.rex_w == 1) then
    return 2
  return 0

def Select_Legacy_1_Opcode_08
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_09
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_0B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_0D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_10
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_11
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_12
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  return 0

def Select_Legacy_1_Opcode_13
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_14
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_15
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_16
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  return 0

def Select_Legacy_1_Opcode_17
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_18
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 4
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 9
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 14
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 16
  return 0

def Select_Legacy_1_Opcode_19
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_1A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_1B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_1C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_1D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_1E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 7 and _rm == 2 and (_mode64 and _context.rep_prefix == 243 and _feature_CPUID_CET_SS)) then
    if (not _feature_CPUID_CET_SS) then
      return - 1
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  if (_mod == 3 and (_mode64 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    return 3
  if (_mod == 3 and _reg == 0 and (_mode64 and _context.rep_prefix == 243)) then
    return 4
  if (_mod == 3 and _reg == 2 and (_mode64 and _context.rep_prefix == 243)) then
    return 5
  if (_mod == 3 and _reg == 3 and (_mode64 and _context.rep_prefix == 243)) then
    return 6
  if (_mod == 3 and _reg == 4 and (_mode64 and _context.rep_prefix == 243)) then
    return 7
  if (_mod == 3 and _reg == 5 and (_mode64 and _context.rep_prefix == 243)) then
    return 8
  if (_mod == 3 and _reg == 7 and _rm == 1 and (_mode64 and _context.rep_prefix == 243)) then
    return 9
  if (_mod == 3 and _reg == 7 and _rm == 5 and (_mode64 and _context.rep_prefix == 243)) then
    return 10
  if (_mod == 3 and _reg == 7 and _rm == 6 and (_mode64 and _context.rep_prefix == 243)) then
    return 11
  if (_mod == 3 and _reg == 7 and _rm == 7 and (_mode64 and _context.rep_prefix == 243)) then
    return 12
  if (_mod == 3 and _reg == 6 and (_mode64 and _context.rep_prefix == 243)) then
    return 13
  if (_mod == 3 and _reg == 7 and _rm == 0 and (_mode64 and _context.rep_prefix == 243)) then
    return 14
  if (_mod == 3 and _reg == 7 and _rm == 4 and (_mode64 and _context.rep_prefix == 243)) then
    return 15
  if (_mod == 3 and _reg == 7 and _rm == 2 and (_mode64 and _context.rep_prefix == 243 and not _feature_CPUID_CET_SS)) then
    return 16
  if (_mod == 3 and _reg == 7 and _rm == 3 and (_mode64 and _context.rep_prefix == 243 and not _feature_CPUID_CET_SS)) then
    return 17
  if (_mod == 3 and _reg == 1 and (_mode64 and _context.rep_prefix == 243 and not _feature_CPUID_CET_SS)) then
    return 18
  return 0

def Select_Legacy_1_Opcode_1F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_20
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_21
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_22
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_23
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_28
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_29
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_2A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod != 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod == 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod != 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 9
    return 9
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 10
    return 10
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 11
    return 11
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 12
    return 12
  return 0

def Select_Legacy_1_Opcode_2B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_2C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 8
    return 8
  if (_mod != 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 9
    return 9
  if (_mod == 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 10
    return 10
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 11
    return 11
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 12
    return 12
  return 0

def Select_Legacy_1_Opcode_2D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rex_w == 0 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 9
    return 9
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 10
    return 10
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 11
    return 11
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 12
    return 12
  return 0

def Select_Legacy_1_Opcode_2E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_2F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_30
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_31
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_32
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_40
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_41
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_42
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_43
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_44
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_45
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_46
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_47
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_48
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_49
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_4A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_4B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_4C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_4D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_4E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_4F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_50
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_51
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_52
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and (not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242) or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and (not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242) or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_53
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and (not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242) or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and (not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242) or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_54
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_55
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_56
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_57
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_58
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_59
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_5A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_5B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_5C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_5D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_5E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_5F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_60
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_61
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_62
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_63
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_64
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_65
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_66
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_67
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_68
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_69
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_6A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_6B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_6C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_6D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_6E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 1)) then
    if (not _feature_CPUID_MMX) then
      return - 3
    return 3
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 1)) then
    if (not _feature_CPUID_MMX) then
      return - 4
    return 4
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 1)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 1)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_6F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_70
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_71
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 6 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and _reg == 6 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and _reg == 2 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 3
    return 3
  if (_mod == 3 and _reg == 2 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod == 3 and _reg == 4 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 5
    return 5
  if (_mod == 3 and _reg == 4 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_72
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 6 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and _reg == 6 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and _reg == 2 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 3
    return 3
  if (_mod == 3 and _reg == 2 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod == 3 and _reg == 4 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 5
    return 5
  if (_mod == 3 and _reg == 4 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_73
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 6 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and _reg == 6 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and _reg == 2 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 3
    return 3
  if (_mod == 3 and _reg == 2 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod == 3 and _reg == 7 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and _reg == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_74
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_75
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_76
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_77
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and (not _context.osz_prefix_present or _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  return 0

def Select_Legacy_1_Opcode_7E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 3
    return 3
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 4
    return 4
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 1 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 5
    return 5
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 1 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 6
    return 6
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 1 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 9
    return 9
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 1 and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 10
    return 10
  return 0

def Select_Legacy_1_Opcode_7F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242))) then
    if (not _feature_CPUID_MMX) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_80
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_81
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_82
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_83
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_84
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_85
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_86
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_87
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_88
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_89
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_8A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_8B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_8C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_8D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_8E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_8F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_90
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_91
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_92
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_93
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_94
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_95
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_96
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_97
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_98
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_99
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_9A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_9B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_9C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_9D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_9E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_9F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_A0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_A1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_A2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_A3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_A4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_A5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_A8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_A9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_AB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_AC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_AD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_AE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 2 and (_mode64 and (not _context.osz_prefix_present or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod != 3 and _reg == 3 and (_mode64 and (not _context.osz_prefix_present or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and _reg == 7 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    return 3
  if (_mod == 3 and _reg == 5 and (_mode64 and (not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242) or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod == 3 and _reg == 7 and (_mode64 and (not _context.osz_prefix_present or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and _reg == 6 and (_mode64 and (not _context.osz_prefix_present and (_context.rep_prefix == 0 or _context.rep_prefix == 242) or _context.osz_prefix_present and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 7
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 1)) then
    return 8
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0)) then
    return 9
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 1 and _context.rep_prefix == 0)) then
    return 10
  return 0

def Select_Legacy_1_Opcode_AF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_B0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_B1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_B2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  return 0

def Select_Legacy_1_Opcode_B3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_B4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  return 0

def Select_Legacy_1_Opcode_B5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  return 0

def Select_Legacy_1_Opcode_B6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_B7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.rex_w == 1)) then
    return 3
  if (_mod == 3 and _mode64) then
    return 4
  return 0

def Select_Legacy_1_Opcode_B9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_BA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 5 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and _reg == 5 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 6 and (_mode64 and not _context.lock_prefix_present)) then
    return 5
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.lock_prefix_present)) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and (_mode64 and not _context.lock_prefix_present)) then
    return 8
  if (_mod != 3 and _reg == 7 and (_mode64 and _context.lock_prefix_present)) then
    return 9
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 11
  return 0

def Select_Legacy_1_Opcode_BB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_BC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_BD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243 and _feature_CPUID_LZCNT)) then
    if (not _feature_CPUID_LZCNT) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243 and _feature_CPUID_LZCNT)) then
    if (not _feature_CPUID_LZCNT) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and (_context.rep_prefix == 0 or _context.rep_prefix == 242 or _context.rep_prefix == 243 and not _feature_CPUID_LZCNT))) then
    return 3
  if (_mod != 3 and (_mode64 and (_context.rep_prefix == 0 or _context.rep_prefix == 242 or _context.rep_prefix == 243 and not _feature_CPUID_LZCNT))) then
    return 4
  return 0

def Select_Legacy_1_Opcode_BE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

def Select_Legacy_1_Opcode_BF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.rex_w == 1)) then
    return 3
  if (_mod == 3 and _mode64) then
    return 4
  return 0

def Select_Legacy_1_Opcode_C0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_C1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_1_Opcode_C2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE) then
      return - 6
    return 6
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 7
    return 7
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 8
    return 8
  return 0

def Select_Legacy_1_Opcode_C3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and (not _context.osz_prefix_present and _context.rex_w == 0 or _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and (not _context.osz_prefix_present and _context.rex_w == 1 or _context.osz_prefix_present and _context.rex_w == 1 and _context.rep_prefix == 0))) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_C4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_C5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_C6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_C7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.rex_w == 1 and not _context.lock_prefix_present)) then
    if (not _feature_CPUID_CMPXCHG16B) then
      return - 1
    return 1
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.rex_w == 0 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.rex_w == 1 and _context.lock_prefix_present)) then
    if (not _feature_CPUID_CMPXCHG16B) then
      return - 3
    return 3
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.rex_w == 0 and _context.lock_prefix_present)) then
    return 4
  return 0

def Select_Legacy_1_Opcode_C8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_C9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_CA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_CB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_CC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_CD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_CE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_CF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_1_Opcode_D1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not (_feature_CPUID_SSE2 and _feature_CPUID_MMX)) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not (_feature_CPUID_SSE2 and _feature_CPUID_MMX)) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_D8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_D9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_DA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_DB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_DC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_DD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_DE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_DF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 243)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present and _context.rep_prefix == 0)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  if (_mod != 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 5
    return 5
  if (_mod == 3 and (_mode64 and _context.rep_prefix == 242)) then
    if (not _feature_CPUID_SSE2) then
      return - 6
    return 6
  return 0

def Select_Legacy_1_Opcode_E7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 1
    return 1
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_E8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_E9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_EA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_EB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_EC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_ED
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_EE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_EF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not (_feature_CPUID_SSE2 and _feature_CPUID_MMX)) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not (_feature_CPUID_SSE2 and _feature_CPUID_MMX)) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 2
    return 2
  return 0

def Select_Legacy_1_Opcode_F8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_F9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_FA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_FB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not (_feature_CPUID_SSE2 and _feature_CPUID_MMX)) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not (_feature_CPUID_SSE2 and _feature_CPUID_MMX)) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_FC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_FD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_FE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 1
    return 1
  if (_mod == 3 and (_mode64 and not _context.osz_prefix_present)) then
    if (not _feature_CPUID_MMX) then
      return - 2
    return 2
  if (_mod != 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 3
    return 3
  if (_mod == 3 and (_mode64 and _context.osz_prefix_present)) then
    if (not _feature_CPUID_SSE2) then
      return - 4
    return 4
  return 0

def Select_Legacy_1_Opcode_FF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _mode64) then
    return 1
  if (_mod != 3 and _mode64) then
    return 2
  return 0

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_00
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_00 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.VERR_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.VERR_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.VERW_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.VERW_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.LLDT_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.LLDT_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SLDT_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SLDT_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.STR_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.STR_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.LTR_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.LTR_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and (context.rep_prefix == 0 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_01
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_01 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LMSW_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.LMSW_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.LGDT_MEMs64 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.LIDT_MEMs64 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SGDT_MEMs64 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SIDT_MEMs64 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SWAPGS (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.SMSW_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.SMSW_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.INVLPG_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 0 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 1 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 2 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 4 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 5 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 6 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and (← modrm[2:0]) == 7 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 0 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 0 and context.address_size == 16 or (context.rep_prefix == 242 or context.rep_prefix == 243) and context.lock_prefix_present) or context.osz_prefix_present and context.lock_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 1 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) and context.lock_prefix_present or context.osz_prefix_present and context.lock_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 2 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 4 and ((← In_64Bit_Mode) and (not context.osz_prefix_present or context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 5 and ((← In_64Bit_Mode) and (not context.osz_prefix_present or context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 6 and ((← In_64Bit_Mode) and (not context.osz_prefix_present or context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and (← modrm[2:0]) == 7 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 0 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 1 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 4 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 5 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 6 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 7 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 0 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 1 and ((← In_64Bit_Mode) and (context.rep_prefix == 0 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 2 and ((← In_64Bit_Mode) and (context.rep_prefix == 0 or context.rep_prefix == 242))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 4 and ((← In_64Bit_Mode) and (context.rep_prefix == 0 or context.rep_prefix == 242))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 5 and ((← In_64Bit_Mode) and (context.rep_prefix == 0 or context.rep_prefix == 242))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 6 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 7 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 2 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 0 and context.address_size == 16 or context.rep_prefix == 242) or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 6 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 0 and context.address_size == 16 or context.osz_prefix_present and context.rep_prefix == 0))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 7 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 5 and ((← In_64Bit_Mode) and (context.rep_prefix == 0 or context.rep_prefix == 242))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_02
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_02 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LAR_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.LAR_GPRv_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_03
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_03 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LSL_GPRv_GPRz (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.LSL_GPRv_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_05
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_05 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.SYSCALL (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_06
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_06 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CLTS (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_07
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_07 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.SYSRET (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.SYSRET64 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_08
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_08 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.INVD (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_09
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_09 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.WBINVD_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_0B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_0B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.UD2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_0D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_0D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PREFETCHW_0F0Dr1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.PREFETCHW_0F0Dr3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_10
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_10 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVSD_XMM_XMMdq_MEMsd_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVSD_XMM_XMMsd_XMMsd_0F10 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVSS_XMMdq_MEMss_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVSS_XMMss_XMMss_0F10 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MOVUPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MOVUPS_XMMps_XMMps_0F10 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MOVUPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MOVUPD_XMMpd_XMMpd_0F10 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_11
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_11 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVSD_XMM_XMMsd_XMMsd_0F11 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVSD_XMM_MEMsd_XMMsd_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVSS_XMMss_XMMss_0F11 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVSS_MEMss_XMMss_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MOVUPS_MEMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MOVUPS_XMMps_XMMps_0F11 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MOVUPD_MEMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MOVUPD_XMMpd_XMMpd_0F11 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_12
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_12 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVLPS_XMMq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVLPD_XMMsd_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVHLPS_XMMq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  -- Intel SDM 325462-093, MOVLPD Vol.2B4-80 (PDF1369)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_13
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_13 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVLPS_MEMq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVLPD_MEMq_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, MOVLPS Vol.2B4-82 (PDF1371)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, MOVLPD Vol.2B4-80 (PDF1369)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_14
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_14 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.UNPCKLPS_XMMps_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.UNPCKLPS_XMMps_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.UNPCKLPD_XMMpd_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.UNPCKLPD_XMMpd_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_15
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_15 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.UNPCKHPD_XMMpd_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.UNPCKHPD_XMMpd_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.UNPCKHPS_XMMps_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.UNPCKHPS_XMMps_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_16
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_16 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVHPS_XMMq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVHPD_XMMsd_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVLHPS_XMMq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  -- Intel SDM 325462-093, MOVHPD Vol.2B4-74 (PDF1363)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 242)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_17
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_17 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVHPS_MEMq_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVHPD_MEMq_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, MOVHPS Vol.2B4-76 (PDF1365)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, MOVHPD Vol.2B4-74 (PDF1363)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_18
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_18 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PREFETCHNTA_MEMmprefetch (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.PREFETCHT0_MEMmprefetch (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.PREFETCHT1_MEMmprefetch (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.PREFETCHT2_MEMmprefetch (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.NOP_GPRv_0F18r0 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.NOP_GPRv_0F18r1 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.NOP_GPRv_0F18r2 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.NOP_GPRv_0F18r3 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.NOP_GPRv_0F18r4 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 10) then
    Instructions.NOP_GPRv_0F18r5 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 11) then
    Instructions.NOP_GPRv_0F18r6 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 12) then
    Instructions.NOP_GPRv_0F18r7 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 13) then
    Instructions.NOP_MEMv_0F18r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.NOP_MEMv_0F18r5 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.NOP_MEMv_0F18r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.NOP_MEMv_0F18r7 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_19
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_19 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.NOP_MEMv_GPRv_0F19 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_GPRv_GPRv_0F19 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_1A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_1A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.NOP_MEMv_GPRv_0F1A (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_GPRv_GPRv_0F1A (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_1B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_1B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.NOP_MEMv_GPRv_0F1B (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_GPRv_GPRv_0F1B (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_1C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_1C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.NOP_MEMv_GPRv_0F1C (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_GPRv_GPRv_0F1C (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_1D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_1D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.NOP_MEMv_GPRv_0F1D (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_GPRv_GPRv_0F1D (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_1E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_1E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ENDBR64 (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_CET_SS" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_MEMv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 10) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 11) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 12) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 13) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 14) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 15) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 16) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 17) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 18) then
    Instructions.NOP_GPRv_GPRv_0F1E (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_1F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_1F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.NOP_GPRv_0F1F (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_MEMv_0F1F (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_20
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_20 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_CR_GPR64_CR (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_21
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_21 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_DR_GPR64_DR (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_22
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_22 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_CR_CR_GPR64 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_23
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_23 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_DR_DR_GPR64 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_28
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_28 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVAPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVAPS_XMMps_XMMps_0F28 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVAPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVAPD_XMMpd_XMMpd_0F28 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_29
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_29 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVAPS_MEMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVAPS_XMMps_XMMps_0F29 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVAPD_MEMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVAPD_XMMpd_XMMpd_0F29 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_2A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_2A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CVTSI2SS_XMMss_GPR32d (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.CVTSI2SS_XMMss_GPR64q (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.CVTSI2SS_XMMss_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.CVTSI2SS_XMMss_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.CVTSI2SD_XMMsd_GPR32d (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.CVTSI2SD_XMMsd_GPR64q (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.CVTSI2SD_XMMsd_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.CVTSI2SD_XMMsd_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 9) then
    Instructions.CVTPI2PD_XMMpd_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -9) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 10) then
    Instructions.CVTPI2PD_XMMpd_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -10) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 11) then
    Instructions.CVTPI2PS_XMMq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -11) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 12) then
    Instructions.CVTPI2PS_XMMq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -12) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_2B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_2B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVNTPD_MEMdq_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVNTPS_MEMdq_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  -- Intel SDM 325462-093, MOVNTPD Vol.2B4-94 (PDF1383)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, MOVNTPS Vol.2B4-96 (PDF1385)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_2C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_2C context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.CVTTPD2PI_MMXq_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 2) then
    Instructions.CVTTPD2PI_MMXq_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.CVTTSD2SI_GPR32d_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.CVTTSD2SI_GPR32d_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 5) then
    Instructions.CVTTSD2SI_GPR64q_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 6) then
    Instructions.CVTTSD2SI_GPR64q_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 7) then
    Instructions.CVTTSS2SI_GPR32d_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 8) then
    Instructions.CVTTSS2SI_GPR32d_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 9) then
    Instructions.CVTTSS2SI_GPR64q_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -9) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 10) then
    Instructions.CVTTSS2SI_GPR64q_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -10) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 11) then
    Instructions.CVTTPS2PI_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -11) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 12) then
    Instructions.CVTTPS2PI_MMXq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -12) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_2D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_2D context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.CVTSS2SI_GPR32d_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 2) then
    Instructions.CVTSS2SI_GPR32d_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.CVTSS2SI_GPR64q_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.CVTSS2SI_GPR64q_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 5) then
    Instructions.CVTSD2SI_GPR32d_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 6) then
    Instructions.CVTSD2SI_GPR32d_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 7) then
    Instructions.CVTSD2SI_GPR64q_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 8) then
    Instructions.CVTSD2SI_GPR64q_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 9) then
    Instructions.CVTPS2PI_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -9) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 10) then
    Instructions.CVTPS2PI_MMXq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -10) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 11) then
    Instructions.CVTPD2PI_MMXq_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -11) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 12) then
    Instructions.CVTPD2PI_MMXq_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -12) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_2E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_2E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.UCOMISS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.UCOMISS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.UCOMISD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.UCOMISD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_2F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_2F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.COMISS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.COMISS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.COMISD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.COMISD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_30
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_30 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.WRMSR (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_31
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_31 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.RDTSC (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_32
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_32 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.RDMSR (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_40
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_40 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVO_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVO_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_41
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_41 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNO_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNO_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_42
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_42 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVB_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVB_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_43
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_43 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNB_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNB_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_44
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_44 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVZ_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVZ_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_45
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_45 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNZ_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNZ_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_46
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_46 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVBE_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVBE_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_47
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_47 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNBE_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNBE_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_48
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_48 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVS_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVS_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_49
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_49 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNS_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNS_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_4A
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_4A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVP_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVP_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_4B
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_4B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNP_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNP_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_4C
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_4C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVL_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVL_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_4D
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_4D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNL_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNL_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_4E
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_4E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVLE_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVLE_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_4F
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_4F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMOVNLE_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMOVNLE_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_50
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_50 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVMSKPS_GPR32_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVMSKPD_GPR32_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, MOVMSKPS Vol.2B4-86 (PDF1375)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, MOVMSKPD Vol.2B4-84 (PDF1373)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_51
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_51 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SQRTPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.SQRTPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.SQRTPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.SQRTPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.SQRTSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.SQRTSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.SQRTSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.SQRTSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_52
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_52 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.RSQRTPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.RSQRTPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.RSQRTSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.RSQRTSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 242) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_53
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_53 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.RCPPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.RCPPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.RCPSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.RCPSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 242) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_54
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_54 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ANDPS_XMMxud_MEMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.ANDPS_XMMxud_XMMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.ANDPD_XMMxuq_MEMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.ANDPD_XMMxuq_XMMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_55
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_55 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ANDNPS_XMMxud_MEMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.ANDNPS_XMMxud_XMMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.ANDNPD_XMMxuq_MEMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.ANDNPD_XMMxuq_XMMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_56
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_56 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ORPS_XMMxud_MEMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.ORPS_XMMxud_XMMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.ORPD_XMMxuq_MEMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.ORPD_XMMxuq_XMMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_57
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_57 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XORPS_XMMxud_MEMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.XORPS_XMMxud_XMMxud (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.XORPD_XMMxuq_MEMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.XORPD_XMMxuq_XMMxuq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_58
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_58 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADDPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADDPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADDPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.ADDPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.ADDSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.ADDSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.ADDSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.ADDSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_59
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_59 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MULPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MULPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MULPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MULPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MULSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MULSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MULSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MULSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_5A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_5A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CVTPS2PD_XMMpd_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.CVTPS2PD_XMMpd_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.CVTPD2PS_XMMps_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.CVTPD2PS_XMMps_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.CVTSS2SD_XMMsd_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.CVTSS2SD_XMMsd_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.CVTSD2SS_XMMss_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.CVTSD2SS_XMMss_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_5B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_5B context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Runtime.liftTotal (Instructions.CVTDQ2PS_XMMps_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.CVTDQ2PS_XMMps_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.CVTPS2DQ_XMMdq_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.CVTPS2DQ_XMMdq_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 5) then
    Instructions.CVTTPS2DQ_XMMdq_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 6) then
    Instructions.CVTTPS2DQ_XMMdq_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_5C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_5C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SUBSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.SUBSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.SUBSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.SUBSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.SUBPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.SUBPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.SUBPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.SUBPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_5D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_5D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MINPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MINPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MINPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MINPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MINSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MINSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MINSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MINSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_5E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_5E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.DIVPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.DIVPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.DIVPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.DIVPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.DIVSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.DIVSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.DIVSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.DIVSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_5F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_5F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MAXPS_XMMps_MEMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MAXPS_XMMps_XMMps (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MAXPD_XMMpd_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MAXPD_XMMpd_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MAXSS_XMMss_MEMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MAXSS_XMMss_XMMss (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MAXSD_XMMsd_MEMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MAXSD_XMMsd_XMMsd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_60
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_60 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKLBW_MMXq_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKLBW_MMXq_MMXd (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUNPCKLBW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PUNPCKLBW_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_61
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_61 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKLWD_MMXq_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKLWD_MMXq_MMXd (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUNPCKLWD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PUNPCKLWD_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_62
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_62 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKLDQ_MMXq_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKLDQ_MMXq_MMXd (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUNPCKLDQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PUNPCKLDQ_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_63
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_63 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PACKSSWB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PACKSSWB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PACKSSWB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PACKSSWB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_64
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_64 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PCMPGTB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PCMPGTB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PCMPGTB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PCMPGTB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_65
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_65 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PCMPGTW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PCMPGTW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PCMPGTW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PCMPGTW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_66
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_66 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PCMPGTD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PCMPGTD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PCMPGTD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PCMPGTD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_67
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_67 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PACKUSWB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PACKUSWB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PACKUSWB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PACKUSWB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_68
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_68 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKHBW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKHBW_MMXq_MMXd (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUNPCKHBW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PUNPCKHBW_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_69
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_69 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKHWD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKHWD_MMXq_MMXd (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUNPCKHWD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PUNPCKHWD_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_6A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_6A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKHDQ_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKHDQ_MMXq_MMXd (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUNPCKHDQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PUNPCKHDQ_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_6B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_6B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PACKSSDW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PACKSSDW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PACKSSDW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PACKSSDW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_6C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_6C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKLQDQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKLQDQ_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← In_64Bit_Mode) and not context.osz_prefix_present) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_6D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_6D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUNPCKHQDQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUNPCKHQDQ_XMMdq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← In_64Bit_Mode) and not context.osz_prefix_present) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_6E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_6E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVD_MMXq_GPR32_0 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVD_MMXq_MEMd_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVQ_MMXq_GPR64 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVQ_MMXq_MEMq_0F6E (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MOVD_XMMdq_GPR32_0 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MOVD_XMMdq_MEMd_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MOVQ_XMMdq_GPR64 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MOVQ_XMMdq_MEMq_0F6E_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_6F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_6F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVDQU_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVDQU_XMMdq_XMMdq_0F6F (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVDQA_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVDQA_XMMdq_XMMdq_0F6F (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MOVQ_MMXq_MEMq_0F6F (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MOVQ_MMXq_MMXq_0F6F (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_70
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_70 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.PSHUFW_MMXq_MEMq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true)
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSHUFW_MMXq_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSHUFD_XMMdq_MEMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSHUFD_XMMdq_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 5) then
    Runtime.liftTotal (Instructions.PSHUFLW_XMMdq_MEMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -5) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.PSHUFLW_XMMdq_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -6) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.PSHUFHW_XMMdq_MEMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -7) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 8) then
    Runtime.liftTotal (Instructions.PSHUFHW_XMMdq_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -8) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_71
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_71 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSLLW_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSLLW_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRLW_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRLW_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.PSRAW_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.PSRAW_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, immediate register operand PDF1732, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1732, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1756, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1756, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1744, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1744, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 0 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_72
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_72 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSLLD_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSLLD_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRLD_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRLD_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.PSRAD_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.PSRAD_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, immediate register operand PDF1732, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1732, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1756, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1756, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1744, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1744, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 0 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_73
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_73 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSLLQ_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSLLQ_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRLQ_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRLQ_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.PSLLDQ_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.PSRLDQ_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, immediate register operand PDF1732, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1732, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1756, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1756, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1730, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, immediate register operand PDF1754, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 0 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and not context.osz_prefix_present)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present or context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and (not context.osz_prefix_present or context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243)))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_74
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_74 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PCMPEQB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PCMPEQB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PCMPEQB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PCMPEQB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_75
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_75 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PCMPEQW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PCMPEQW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PCMPEQW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PCMPEQW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_76
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_76 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PCMPEQD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PCMPEQD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PCMPEQD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PCMPEQD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_77
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_77 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.EMMS (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← In_64Bit_Mode) and context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_7E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_7E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVQ_XMMdq_MEMq_0F7E_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVQ_XMMdq_XMMq_0F7E (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVD_GPR32_MMXd_0 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVD_MEMd_MMXd_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MOVQ_GPR64_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MOVQ_MEMq_MMXq_0F7E (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.MOVD_GPR32_XMMd_0 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.MOVD_MEMd_XMMd_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 9) then
    Instructions.MOVQ_GPR64_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -9) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 10) then
    Instructions.MOVQ_MEMq_XMMq_0F7E_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -10) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_7F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_7F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVDQU_MEMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVDQU_XMMdq_XMMdq_0F7F (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVDQA_MEMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVDQA_XMMdq_XMMdq_0F7F (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.MOVQ_MEMq_MMXq_0F7F (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MOVQ_MMXq_MMXq_0F7F (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_80
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_80 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JO_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_81
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_81 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNO_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_82
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_82 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JB_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_83
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_83 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNB_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_84
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_84 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JZ_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_85
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_85 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNZ_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_86
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_86 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JBE_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_87
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_87 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNBE_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_88
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_88 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JS_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_89
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_89 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNS_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_8A
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_8A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JP_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_8B
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_8B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNP_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_8C
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_8C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JL_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_8D
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_8D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNL_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_8E
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_8E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JLE_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_8F
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_8F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNLE_RELBRd_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_90
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_90 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETO_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETO_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_91
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_91 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNO_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNO_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_92
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_92 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETB_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETB_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_93
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_93 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNB_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNB_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_94
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_94 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETZ_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETZ_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_95
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_95 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNZ_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNZ_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_96
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_96 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETBE_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETBE_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_97
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_97 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNBE_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNBE_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_98
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_98 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETS_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETS_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_99
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_99 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNS_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNS_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_9A
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_9A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETP_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETP_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_9B
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_9B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNP_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNP_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_9C
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_9C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETL_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETL_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_9D
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_9D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNL_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNL_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_9E
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_9E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETLE_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETLE_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_9F
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_9F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SETNLE_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.SETNLE_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_FS (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_FS (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CPUID (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.BT_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.BT_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHLD_GPRv_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHLD_MEMv_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHLD_GPRv_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHLD_MEMv_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GS (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_A9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_A9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GS (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_AB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_AB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.BTS_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.BTS_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.BTS_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_AC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_AC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHRD_GPRv_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHRD_MEMv_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_AD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_AD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHRD_GPRv_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHRD_MEMv_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_AE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_AE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LDMXCSR_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.STMXCSR_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.CLFLUSH_MEMmprefetch (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.LFENCE (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.SFENCE (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.MFENCE (← Std.Bits.Add_int (n := 64) ip 2) context
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.FXRSTOR_MEMmfpxenv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.FXRSTOR64_MEMmfpxenv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.FXSAVE_MEMmfpxenv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.FXSAVE64_MEMmfpxenv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, LDMXCSR Vol.2A3-539 (PDF1243)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, STMXCSR Vol.2B4-676 (PDF1965)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FXRSTOR Vol.2A3-409 (PDF1113), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rex_w == 0 and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FXRSTOR Vol.2A3-409 (PDF1113), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rex_w == 1 and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FXSAVE Vol.2A3-412 (PDF1116), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rex_w == 0 and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FXSAVE Vol.2A3-412 (PDF1116), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rex_w == 1 and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 0 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242)))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 0 or context.rep_prefix == 242) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 242)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 0 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and context.osz_prefix_present)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 2 and ((← In_64Bit_Mode) and context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and context.rep_prefix == 242 or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 5 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and context.rep_prefix == 242)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_AF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_AF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.IMUL_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.IMUL_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMPXCHG_GPR8_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMPXCHG_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.CMPXCHG_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMPXCHG_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMPXCHG_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.CMPXCHG_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LSS_GPRv_MEMp2 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  -- Intel SDM 325462-093, PDF1247, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.BTR_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.BTR_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.BTR_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LFS_GPRv_MEMp2 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  -- Intel SDM 325462-093, PDF1247, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LGS_GPRv_MEMp2 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  -- Intel SDM 325462-093, PDF1247, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVZX_GPRv_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVZX_GPRv_MEMb_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVZX_GPR16_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVZX_GPR32_MEMw_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVZX_GPR64_MEMw_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVZX_GPRv_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_B9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_B9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.UD1_GPR32_GPR32 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.UD1_GPR32_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_BA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_BA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.BTS_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.BTS_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.BTS_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.BTR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.BTR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.BTR_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.BTC_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.BTC_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.BTC_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.BT_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.BT_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 0 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_BB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_BB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.BTC_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.BTC_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.BTC_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_BC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_BC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.BSF_GPRv_GPRv_0 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.BSF_GPRv_MEMv_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_BD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_BD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LZCNT_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_LZCNT" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.LZCNT_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_LZCNT" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.BSR_GPRv_GPRv_0 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.BSR_GPRv_MEMv_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_BE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_BE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVSX_GPRv_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVSX_GPRv_MEMb_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_BF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_BF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVSX_GPR16_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVSX_GPR32_MEMw_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVSX_GPR64_MEMw_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVSX_GPRv_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XADD_GPR8_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XADD_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.XADD_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XADD_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XADD_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.XADD_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMPPS_XMMps_MEMps_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMPPS_XMMps_XMMps_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.CMPPD_XMMpd_MEMpd_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.CMPPD_XMMpd_XMMpd_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 5) then
    Instructions.CMPSS_XMMss_MEMss_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 6) then
    Instructions.CMPSS_XMMss_XMMss_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 7) then
    Instructions.CMPSD_XMM_XMMsd_MEMsd_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -7) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 8) then
    Instructions.CMPSD_XMM_XMMsd_XMMsd_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -8) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVNTI_MEMd_GPR32_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVNTI_MEMq_GPR64 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, MOVNTI Vol.2B4-92 (PDF1381)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rex_w == 0 and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, MOVNTI Vol.2B4-92 (PDF1381)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rex_w == 1 and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C4 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.PINSRW_MMXq_GPR32_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true)
    return ()
  if (decoder_form_index == 2) then
    Instructions.PINSRW_MMXq_MEMw_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.PINSRW_XMMdq_GPR32_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.PINSRW_XMMdq_MEMw_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C5 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.PEXTRW_GPR32_MMXq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true)
    return ()
  if (decoder_form_index == 2) then
    Instructions.PEXTRW_GPR32_XMMdq_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  -- Intel SDM 325462-093, PEXTRW Vol.2B4-289 (PDF1578)
  if ((← modrm[7:6]) != 3 and ((← Runtime.liftTotal (In_64Bit_Mode)) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, PEXTRW Vol.2B4-289 (PDF1578)
  if ((← modrm[7:6]) != 3 and ((← Runtime.liftTotal (In_64Bit_Mode)) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← Runtime.liftTotal (In_64Bit_Mode)) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C6 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.SHUFPD_XMMpd_MEMpd_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHUFPD_XMMpd_XMMpd_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHUFPS_XMMps_MEMps_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHUFPS_XMMps_XMMps_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMPXCHG16B_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_CMPXCHG16B" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMPXCHG8B_MEMq_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.CMPXCHG16B_LOCK_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_CMPXCHG16B" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.CMPXCHG8B_LOCK_MEMq_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, PDF902, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and context.rex_w == 0 and not context.lock_prefix_present)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, PDF902, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and context.rex_w == 0 and context.lock_prefix_present)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 0 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 1 and ((← In_64Bit_Mode) and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 6 and ((← In_64Bit_Mode) and context.rep_prefix == 242)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and context.rep_prefix == 242)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 3 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 5 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 7 and ((← In_64Bit_Mode) and (not context.osz_prefix_present and (context.rep_prefix == 242 or context.rep_prefix == 243) or context.osz_prefix_present))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C8
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_C9
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_C9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_CA
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_CA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_CB
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_CB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_CC
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_CC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_CD
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_CD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_CE
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_CE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_CF
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_CF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.BSWAP_GPRv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSRLW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSRLW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRLW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRLW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSRLD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSRLD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRLD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRLD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSRLQ_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSRLQ_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRLQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRLQ_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDQ_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2 and CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDQ_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2 and CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDQ_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMULLW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMULLW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMULLW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMULLW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVQ_MEMq_XMMq_0FD6_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVQ_XMMdq_XMMq_0FD6 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVDQ2Q_MMXq_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.MOVQ2DQ_XMMdq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, PDF1347, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and context.rep_prefix == 242)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, PDF1391, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and context.rep_prefix == 243)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMOVMSKB_GPR32_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMOVMSKB_GPR32_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, PMOVMSKB Vol.2B4-350 (PDF1639)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, PMOVMSKB Vol.2B4-350 (PDF1639)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBUSB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBUSB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBUSB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBUSB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_D9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_D9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBUSW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBUSW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBUSW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBUSW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_DA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_DA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMINUB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMINUB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMINUB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMINUB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_DB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_DB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PAND_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PAND_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PAND_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PAND_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_DC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_DC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDUSB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDUSB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDUSB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDUSB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_DD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_DD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDUSW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDUSW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDUSW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDUSW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_DE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_DE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMAXUB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMAXUB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMAXUB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMAXUB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_DF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_DF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PANDN_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PANDN_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PANDN_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PANDN_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PAVGB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PAVGB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PAVGB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PAVGB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSRAW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSRAW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRAW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRAW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSRAD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSRAD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSRAD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSRAD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PAVGW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PAVGW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PAVGW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PAVGW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMULHUW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMULHUW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMULHUW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMULHUW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMULHW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMULHW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMULHW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMULHW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E6 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Runtime.liftTotal (Instructions.CVTDQ2PD_XMMpd_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -1) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.CVTDQ2PD_XMMpd_XMMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm)
    return ()
  if (decoder_form_index == -2) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 3) then
    Instructions.CVTTPD2DQ_XMMdq_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 4) then
    Instructions.CVTTPD2DQ_XMMdq_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 5) then
    Instructions.CVTPD2DQ_XMMdq_MEMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -5) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  if (decoder_form_index == 6) then
    Instructions.CVTPD2DQ_XMMdq_XMMpd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -6) then
    Runtime.liftTotal (Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true)
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← Runtime.liftTotal (In_64Bit_Mode)) and not context.osz_prefix_present and context.rep_prefix == 0) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVNTDQ_MEMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVNTQ_MEMq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  -- Intel SDM 325462-093, MOVNTDQ Vol.2B4-88 (PDF1377)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, MOVNTQ Vol.2B4-98 (PDF1387)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBSB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBSB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBSB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBSB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_E9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_E9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBSW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBSW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBSW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBSW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_EA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_EA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMINSW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMINSW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMINSW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMINSW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_EB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_EB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.POR_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.POR_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.POR_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.POR_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_EC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_EC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDSB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDSB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDSB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDSB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_ED
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_ED context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDSW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDSW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDSW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDSW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_EE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_EE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMAXSW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMAXSW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMAXSW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMAXSW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_EF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_EF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PXOR_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PXOR_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PXOR_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PXOR_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSLLW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSLLW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSLLW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSLLW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSLLD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSLLD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSLLD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSLLD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSLLQ_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSLLQ_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSLLQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSLLQ_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMULUDQ_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2 and CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMULUDQ_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2 and CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMULUDQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMULUDQ_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PMADDWD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PMADDWD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PMADDWD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PMADDWD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSADBW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSADBW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSADBW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSADBW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MASKMOVQ_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.MASKMOVDQU_XMMxub_XMMxub (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  -- Intel SDM 325462-093, PDF1292, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and not context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, PDF1290, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and context.osz_prefix_present and context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and ((← In_64Bit_Mode) and (context.rep_prefix == 242 or context.rep_prefix == 243))) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_F9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_F9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_FA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_FA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_FB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_FB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PSUBQ_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2 and CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PSUBQ_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2 and CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PSUBQ_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PSUBQ_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_FC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_FC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDB_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDB_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDB_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDB_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_FD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_FD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDW_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDW_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDW_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDW_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_FE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_FE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PADDD_MMXq_MEMq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -1) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 2) then
    Instructions.PADDD_MMXq_MMXq (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == -2) then
    Unimplemented_Feature "disabled decoder capability: CPUID_MMX" false true
    return ()
  if (decoder_form_index == 3) then
    Instructions.PADDD_XMMdq_MEMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -3) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  if (decoder_form_index == 4) then
    Instructions.PADDD_XMMdq_XMMdq (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == -4) then
    Unimplemented_Feature "disabled decoder capability: CPUID_SSE2" false true
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_1_Opcode_FF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_1_Opcode_FF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.UD0_GPR32_GPR32 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.UD0_GPR32_MEMd (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

def Legacy_1_Uses_ModRM (opcode : Bits 8) : Except (Runtime.Error Empty) (Bool) := do
  match Unsigned opcode with
  | 0b00000000 => do
    return true
  | 0b00000001 => do
    return true
  | 0b00000010 => do
    return true
  | 0b00000011 => do
    return true
  | 0b00001101 => do
    return true
  | 0b00010000 => do
    return true
  | 0b00010001 => do
    return true
  | 0b00010010 => do
    return true
  | 0b00010011 => do
    return true
  | 0b00010100 => do
    return true
  | 0b00010101 => do
    return true
  | 0b00010110 => do
    return true
  | 0b00010111 => do
    return true
  | 0b00011000 => do
    return true
  | 0b00011001 => do
    return true
  | 0b00011010 => do
    return true
  | 0b00011011 => do
    return true
  | 0b00011100 => do
    return true
  | 0b00011101 => do
    return true
  | 0b00011110 => do
    return true
  | 0b00011111 => do
    return true
  | 0b00100000 => do
    return true
  | 0b00100001 => do
    return true
  | 0b00100010 => do
    return true
  | 0b00100011 => do
    return true
  | 0b00101000 => do
    return true
  | 0b00101001 => do
    return true
  | 0b00101010 => do
    return true
  | 0b00101011 => do
    return true
  | 0b00101100 => do
    return true
  | 0b00101101 => do
    return true
  | 0b00101110 => do
    return true
  | 0b00101111 => do
    return true
  | 0b01000000 => do
    return true
  | 0b01000001 => do
    return true
  | 0b01000010 => do
    return true
  | 0b01000011 => do
    return true
  | 0b01000100 => do
    return true
  | 0b01000101 => do
    return true
  | 0b01000110 => do
    return true
  | 0b01000111 => do
    return true
  | 0b01001000 => do
    return true
  | 0b01001001 => do
    return true
  | 0b01001010 => do
    return true
  | 0b01001011 => do
    return true
  | 0b01001100 => do
    return true
  | 0b01001101 => do
    return true
  | 0b01001110 => do
    return true
  | 0b01001111 => do
    return true
  | 0b01010000 => do
    return true
  | 0b01010001 => do
    return true
  | 0b01010010 => do
    return true
  | 0b01010011 => do
    return true
  | 0b01010100 => do
    return true
  | 0b01010101 => do
    return true
  | 0b01010110 => do
    return true
  | 0b01010111 => do
    return true
  | 0b01011000 => do
    return true
  | 0b01011001 => do
    return true
  | 0b01011010 => do
    return true
  | 0b01011011 => do
    return true
  | 0b01011100 => do
    return true
  | 0b01011101 => do
    return true
  | 0b01011110 => do
    return true
  | 0b01011111 => do
    return true
  | 0b01100000 => do
    return true
  | 0b01100001 => do
    return true
  | 0b01100010 => do
    return true
  | 0b01100011 => do
    return true
  | 0b01100100 => do
    return true
  | 0b01100101 => do
    return true
  | 0b01100110 => do
    return true
  | 0b01100111 => do
    return true
  | 0b01101000 => do
    return true
  | 0b01101001 => do
    return true
  | 0b01101010 => do
    return true
  | 0b01101011 => do
    return true
  | 0b01101100 => do
    return true
  | 0b01101101 => do
    return true
  | 0b01101110 => do
    return true
  | 0b01101111 => do
    return true
  | 0b01110000 => do
    return true
  | 0b01110001 => do
    return true
  | 0b01110010 => do
    return true
  | 0b01110011 => do
    return true
  | 0b01110100 => do
    return true
  | 0b01110101 => do
    return true
  | 0b01110110 => do
    return true
  | 0b01111110 => do
    return true
  | 0b01111111 => do
    return true
  | 0b10010000 => do
    return true
  | 0b10010001 => do
    return true
  | 0b10010010 => do
    return true
  | 0b10010011 => do
    return true
  | 0b10010100 => do
    return true
  | 0b10010101 => do
    return true
  | 0b10010110 => do
    return true
  | 0b10010111 => do
    return true
  | 0b10011000 => do
    return true
  | 0b10011001 => do
    return true
  | 0b10011010 => do
    return true
  | 0b10011011 => do
    return true
  | 0b10011100 => do
    return true
  | 0b10011101 => do
    return true
  | 0b10011110 => do
    return true
  | 0b10011111 => do
    return true
  | 0b10100011 => do
    return true
  | 0b10100100 => do
    return true
  | 0b10100101 => do
    return true
  | 0b10101011 => do
    return true
  | 0b10101100 => do
    return true
  | 0b10101101 => do
    return true
  | 0b10101110 => do
    return true
  | 0b10101111 => do
    return true
  | 0b10110000 => do
    return true
  | 0b10110001 => do
    return true
  | 0b10110010 => do
    return true
  | 0b10110011 => do
    return true
  | 0b10110100 => do
    return true
  | 0b10110101 => do
    return true
  | 0b10110110 => do
    return true
  | 0b10110111 => do
    return true
  | 0b10111001 => do
    return true
  | 0b10111010 => do
    return true
  | 0b10111011 => do
    return true
  | 0b10111100 => do
    return true
  | 0b10111101 => do
    return true
  | 0b10111110 => do
    return true
  | 0b10111111 => do
    return true
  | 0b11000000 => do
    return true
  | 0b11000001 => do
    return true
  | 0b11000010 => do
    return true
  | 0b11000011 => do
    return true
  | 0b11000100 => do
    return true
  | 0b11000101 => do
    return true
  | 0b11000110 => do
    return true
  | 0b11000111 => do
    return true
  | 0b11010001 => do
    return true
  | 0b11010010 => do
    return true
  | 0b11010011 => do
    return true
  | 0b11010100 => do
    return true
  | 0b11010101 => do
    return true
  | 0b11010110 => do
    return true
  | 0b11010111 => do
    return true
  | 0b11011000 => do
    return true
  | 0b11011001 => do
    return true
  | 0b11011010 => do
    return true
  | 0b11011011 => do
    return true
  | 0b11011100 => do
    return true
  | 0b11011101 => do
    return true
  | 0b11011110 => do
    return true
  | 0b11011111 => do
    return true
  | 0b11100000 => do
    return true
  | 0b11100001 => do
    return true
  | 0b11100010 => do
    return true
  | 0b11100011 => do
    return true
  | 0b11100100 => do
    return true
  | 0b11100101 => do
    return true
  | 0b11100110 => do
    return true
  | 0b11100111 => do
    return true
  | 0b11101000 => do
    return true
  | 0b11101001 => do
    return true
  | 0b11101010 => do
    return true
  | 0b11101011 => do
    return true
  | 0b11101100 => do
    return true
  | 0b11101101 => do
    return true
  | 0b11101110 => do
    return true
  | 0b11101111 => do
    return true
  | 0b11110001 => do
    return true
  | 0b11110010 => do
    return true
  | 0b11110011 => do
    return true
  | 0b11110100 => do
    return true
  | 0b11110101 => do
    return true
  | 0b11110110 => do
    return true
  | 0b11110111 => do
    return true
  | 0b11111000 => do
    return true
  | 0b11111001 => do
    return true
  | 0b11111010 => do
    return true
  | 0b11111011 => do
    return true
  | 0b11111100 => do
    return true
  | 0b11111101 => do
    return true
  | 0b11111110 => do
    return true
  | 0b11111111 => do
    return true
  | _ => do
    return false

def Select_Legacy_1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (opcode _modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _context.rex2_prefix_present then
    return 0
  match Unsigned opcode with
  | 0b00000000 => do
    return (← Select_Legacy_1_Opcode_00 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000001 => do
    return (← Select_Legacy_1_Opcode_01 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000010 => do
    return (← Select_Legacy_1_Opcode_02 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000011 => do
    return (← Select_Legacy_1_Opcode_03 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000101 => do
    return (← Select_Legacy_1_Opcode_05 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000110 => do
    return (← Select_Legacy_1_Opcode_06 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000111 => do
    return (← Select_Legacy_1_Opcode_07 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001000 => do
    return (← Select_Legacy_1_Opcode_08 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001001 => do
    return (← Select_Legacy_1_Opcode_09 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001011 => do
    return (← Select_Legacy_1_Opcode_0B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001101 => do
    return (← Select_Legacy_1_Opcode_0D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010000 => do
    return (← Select_Legacy_1_Opcode_10 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010001 => do
    return (← Select_Legacy_1_Opcode_11 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010010 => do
    return (← Select_Legacy_1_Opcode_12 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010011 => do
    return (← Select_Legacy_1_Opcode_13 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010100 => do
    return (← Select_Legacy_1_Opcode_14 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010101 => do
    return (← Select_Legacy_1_Opcode_15 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010110 => do
    return (← Select_Legacy_1_Opcode_16 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010111 => do
    return (← Select_Legacy_1_Opcode_17 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011000 => do
    return (← Select_Legacy_1_Opcode_18 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011001 => do
    return (← Select_Legacy_1_Opcode_19 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011010 => do
    return (← Select_Legacy_1_Opcode_1A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011011 => do
    return (← Select_Legacy_1_Opcode_1B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011100 => do
    return (← Select_Legacy_1_Opcode_1C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011101 => do
    return (← Select_Legacy_1_Opcode_1D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011110 => do
    return (← Select_Legacy_1_Opcode_1E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011111 => do
    return (← Select_Legacy_1_Opcode_1F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100000 => do
    return (← Select_Legacy_1_Opcode_20 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100001 => do
    return (← Select_Legacy_1_Opcode_21 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100010 => do
    return (← Select_Legacy_1_Opcode_22 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100011 => do
    return (← Select_Legacy_1_Opcode_23 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101000 => do
    return (← Select_Legacy_1_Opcode_28 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101001 => do
    return (← Select_Legacy_1_Opcode_29 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101010 => do
    return (← Select_Legacy_1_Opcode_2A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101011 => do
    return (← Select_Legacy_1_Opcode_2B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101100 => do
    return (← Select_Legacy_1_Opcode_2C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101101 => do
    return (← Select_Legacy_1_Opcode_2D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101110 => do
    return (← Select_Legacy_1_Opcode_2E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101111 => do
    return (← Select_Legacy_1_Opcode_2F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110000 => do
    return (← Select_Legacy_1_Opcode_30 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110001 => do
    return (← Select_Legacy_1_Opcode_31 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110010 => do
    return (← Select_Legacy_1_Opcode_32 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000000 => do
    return (← Select_Legacy_1_Opcode_40 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000001 => do
    return (← Select_Legacy_1_Opcode_41 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000010 => do
    return (← Select_Legacy_1_Opcode_42 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000011 => do
    return (← Select_Legacy_1_Opcode_43 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000100 => do
    return (← Select_Legacy_1_Opcode_44 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000101 => do
    return (← Select_Legacy_1_Opcode_45 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000110 => do
    return (← Select_Legacy_1_Opcode_46 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01000111 => do
    return (← Select_Legacy_1_Opcode_47 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001000 => do
    return (← Select_Legacy_1_Opcode_48 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001001 => do
    return (← Select_Legacy_1_Opcode_49 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001010 => do
    return (← Select_Legacy_1_Opcode_4A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001011 => do
    return (← Select_Legacy_1_Opcode_4B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001100 => do
    return (← Select_Legacy_1_Opcode_4C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001101 => do
    return (← Select_Legacy_1_Opcode_4D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001110 => do
    return (← Select_Legacy_1_Opcode_4E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01001111 => do
    return (← Select_Legacy_1_Opcode_4F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010000 => do
    return (← Select_Legacy_1_Opcode_50 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010001 => do
    return (← Select_Legacy_1_Opcode_51 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010010 => do
    return (← Select_Legacy_1_Opcode_52 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010011 => do
    return (← Select_Legacy_1_Opcode_53 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010100 => do
    return (← Select_Legacy_1_Opcode_54 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010101 => do
    return (← Select_Legacy_1_Opcode_55 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010110 => do
    return (← Select_Legacy_1_Opcode_56 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010111 => do
    return (← Select_Legacy_1_Opcode_57 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011000 => do
    return (← Select_Legacy_1_Opcode_58 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011001 => do
    return (← Select_Legacy_1_Opcode_59 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011010 => do
    return (← Select_Legacy_1_Opcode_5A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011011 => do
    return (← Select_Legacy_1_Opcode_5B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011100 => do
    return (← Select_Legacy_1_Opcode_5C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011101 => do
    return (← Select_Legacy_1_Opcode_5D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011110 => do
    return (← Select_Legacy_1_Opcode_5E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011111 => do
    return (← Select_Legacy_1_Opcode_5F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100000 => do
    return (← Select_Legacy_1_Opcode_60 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100001 => do
    return (← Select_Legacy_1_Opcode_61 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100010 => do
    return (← Select_Legacy_1_Opcode_62 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100011 => do
    return (← Select_Legacy_1_Opcode_63 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100100 => do
    return (← Select_Legacy_1_Opcode_64 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100101 => do
    return (← Select_Legacy_1_Opcode_65 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100110 => do
    return (← Select_Legacy_1_Opcode_66 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100111 => do
    return (← Select_Legacy_1_Opcode_67 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101000 => do
    return (← Select_Legacy_1_Opcode_68 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101001 => do
    return (← Select_Legacy_1_Opcode_69 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101010 => do
    return (← Select_Legacy_1_Opcode_6A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101011 => do
    return (← Select_Legacy_1_Opcode_6B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101100 => do
    return (← Select_Legacy_1_Opcode_6C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101101 => do
    return (← Select_Legacy_1_Opcode_6D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101110 => do
    return (← Select_Legacy_1_Opcode_6E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101111 => do
    return (← Select_Legacy_1_Opcode_6F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110000 => do
    return (← Select_Legacy_1_Opcode_70 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110001 => do
    return (← Select_Legacy_1_Opcode_71 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110010 => do
    return (← Select_Legacy_1_Opcode_72 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110011 => do
    return (← Select_Legacy_1_Opcode_73 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110100 => do
    return (← Select_Legacy_1_Opcode_74 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110101 => do
    return (← Select_Legacy_1_Opcode_75 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110110 => do
    return (← Select_Legacy_1_Opcode_76 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110111 => do
    return (← Select_Legacy_1_Opcode_77 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111110 => do
    return (← Select_Legacy_1_Opcode_7E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111111 => do
    return (← Select_Legacy_1_Opcode_7F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000000 => do
    return (← Select_Legacy_1_Opcode_80 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000001 => do
    return (← Select_Legacy_1_Opcode_81 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000010 => do
    return (← Select_Legacy_1_Opcode_82 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000011 => do
    return (← Select_Legacy_1_Opcode_83 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000100 => do
    return (← Select_Legacy_1_Opcode_84 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000101 => do
    return (← Select_Legacy_1_Opcode_85 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000110 => do
    return (← Select_Legacy_1_Opcode_86 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000111 => do
    return (← Select_Legacy_1_Opcode_87 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001000 => do
    return (← Select_Legacy_1_Opcode_88 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001001 => do
    return (← Select_Legacy_1_Opcode_89 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001010 => do
    return (← Select_Legacy_1_Opcode_8A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001011 => do
    return (← Select_Legacy_1_Opcode_8B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001100 => do
    return (← Select_Legacy_1_Opcode_8C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001101 => do
    return (← Select_Legacy_1_Opcode_8D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001110 => do
    return (← Select_Legacy_1_Opcode_8E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001111 => do
    return (← Select_Legacy_1_Opcode_8F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010000 => do
    return (← Select_Legacy_1_Opcode_90 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010001 => do
    return (← Select_Legacy_1_Opcode_91 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010010 => do
    return (← Select_Legacy_1_Opcode_92 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010011 => do
    return (← Select_Legacy_1_Opcode_93 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010100 => do
    return (← Select_Legacy_1_Opcode_94 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010101 => do
    return (← Select_Legacy_1_Opcode_95 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010110 => do
    return (← Select_Legacy_1_Opcode_96 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010111 => do
    return (← Select_Legacy_1_Opcode_97 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011000 => do
    return (← Select_Legacy_1_Opcode_98 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011001 => do
    return (← Select_Legacy_1_Opcode_99 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011010 => do
    return (← Select_Legacy_1_Opcode_9A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011011 => do
    return (← Select_Legacy_1_Opcode_9B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011100 => do
    return (← Select_Legacy_1_Opcode_9C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011101 => do
    return (← Select_Legacy_1_Opcode_9D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011110 => do
    return (← Select_Legacy_1_Opcode_9E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011111 => do
    return (← Select_Legacy_1_Opcode_9F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100000 => do
    return (← Select_Legacy_1_Opcode_A0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100001 => do
    return (← Select_Legacy_1_Opcode_A1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100010 => do
    return (← Select_Legacy_1_Opcode_A2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100011 => do
    return (← Select_Legacy_1_Opcode_A3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100100 => do
    return (← Select_Legacy_1_Opcode_A4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100101 => do
    return (← Select_Legacy_1_Opcode_A5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101000 => do
    return (← Select_Legacy_1_Opcode_A8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101001 => do
    return (← Select_Legacy_1_Opcode_A9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101011 => do
    return (← Select_Legacy_1_Opcode_AB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101100 => do
    return (← Select_Legacy_1_Opcode_AC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101101 => do
    return (← Select_Legacy_1_Opcode_AD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101110 => do
    return (← Select_Legacy_1_Opcode_AE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101111 => do
    return (← Select_Legacy_1_Opcode_AF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110000 => do
    return (← Select_Legacy_1_Opcode_B0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110001 => do
    return (← Select_Legacy_1_Opcode_B1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110010 => do
    return (← Select_Legacy_1_Opcode_B2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110011 => do
    return (← Select_Legacy_1_Opcode_B3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110100 => do
    return (← Select_Legacy_1_Opcode_B4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110101 => do
    return (← Select_Legacy_1_Opcode_B5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110110 => do
    return (← Select_Legacy_1_Opcode_B6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110111 => do
    return (← Select_Legacy_1_Opcode_B7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111001 => do
    return (← Select_Legacy_1_Opcode_B9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111010 => do
    return (← Select_Legacy_1_Opcode_BA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111011 => do
    return (← Select_Legacy_1_Opcode_BB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111100 => do
    return (← Select_Legacy_1_Opcode_BC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111101 => do
    return (← Select_Legacy_1_Opcode_BD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111110 => do
    return (← Select_Legacy_1_Opcode_BE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111111 => do
    return (← Select_Legacy_1_Opcode_BF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000000 => do
    return (← Select_Legacy_1_Opcode_C0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000001 => do
    return (← Select_Legacy_1_Opcode_C1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000010 => do
    return (← Select_Legacy_1_Opcode_C2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000011 => do
    return (← Select_Legacy_1_Opcode_C3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000100 => do
    return (← Select_Legacy_1_Opcode_C4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000101 => do
    return (← Select_Legacy_1_Opcode_C5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000110 => do
    return (← Select_Legacy_1_Opcode_C6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000111 => do
    return (← Select_Legacy_1_Opcode_C7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001000 => do
    return (← Select_Legacy_1_Opcode_C8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001001 => do
    return (← Select_Legacy_1_Opcode_C9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001010 => do
    return (← Select_Legacy_1_Opcode_CA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001011 => do
    return (← Select_Legacy_1_Opcode_CB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001100 => do
    return (← Select_Legacy_1_Opcode_CC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001101 => do
    return (← Select_Legacy_1_Opcode_CD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001110 => do
    return (← Select_Legacy_1_Opcode_CE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001111 => do
    return (← Select_Legacy_1_Opcode_CF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010001 => do
    return (← Select_Legacy_1_Opcode_D1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010010 => do
    return (← Select_Legacy_1_Opcode_D2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010011 => do
    return (← Select_Legacy_1_Opcode_D3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010100 => do
    return (← Select_Legacy_1_Opcode_D4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010101 => do
    return (← Select_Legacy_1_Opcode_D5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010110 => do
    return (← Select_Legacy_1_Opcode_D6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010111 => do
    return (← Select_Legacy_1_Opcode_D7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011000 => do
    return (← Select_Legacy_1_Opcode_D8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011001 => do
    return (← Select_Legacy_1_Opcode_D9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011010 => do
    return (← Select_Legacy_1_Opcode_DA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011011 => do
    return (← Select_Legacy_1_Opcode_DB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011100 => do
    return (← Select_Legacy_1_Opcode_DC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011101 => do
    return (← Select_Legacy_1_Opcode_DD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011110 => do
    return (← Select_Legacy_1_Opcode_DE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011111 => do
    return (← Select_Legacy_1_Opcode_DF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100000 => do
    return (← Select_Legacy_1_Opcode_E0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100001 => do
    return (← Select_Legacy_1_Opcode_E1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100010 => do
    return (← Select_Legacy_1_Opcode_E2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100011 => do
    return (← Select_Legacy_1_Opcode_E3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100100 => do
    return (← Select_Legacy_1_Opcode_E4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100101 => do
    return (← Select_Legacy_1_Opcode_E5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100110 => do
    return (← Select_Legacy_1_Opcode_E6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100111 => do
    return (← Select_Legacy_1_Opcode_E7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101000 => do
    return (← Select_Legacy_1_Opcode_E8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101001 => do
    return (← Select_Legacy_1_Opcode_E9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101010 => do
    return (← Select_Legacy_1_Opcode_EA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101011 => do
    return (← Select_Legacy_1_Opcode_EB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101100 => do
    return (← Select_Legacy_1_Opcode_EC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101101 => do
    return (← Select_Legacy_1_Opcode_ED _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101110 => do
    return (← Select_Legacy_1_Opcode_EE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101111 => do
    return (← Select_Legacy_1_Opcode_EF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110001 => do
    return (← Select_Legacy_1_Opcode_F1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110010 => do
    return (← Select_Legacy_1_Opcode_F2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110011 => do
    return (← Select_Legacy_1_Opcode_F3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110100 => do
    return (← Select_Legacy_1_Opcode_F4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110101 => do
    return (← Select_Legacy_1_Opcode_F5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110110 => do
    return (← Select_Legacy_1_Opcode_F6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110111 => do
    return (← Select_Legacy_1_Opcode_F7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111000 => do
    return (← Select_Legacy_1_Opcode_F8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111001 => do
    return (← Select_Legacy_1_Opcode_F9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111010 => do
    return (← Select_Legacy_1_Opcode_FA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111011 => do
    return (← Select_Legacy_1_Opcode_FB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111100 => do
    return (← Select_Legacy_1_Opcode_FC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111101 => do
    return (← Select_Legacy_1_Opcode_FD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111110 => do
    return (← Select_Legacy_1_Opcode_FE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111111 => do
    return (← Select_Legacy_1_Opcode_FF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | _ => do
    return 0

def Legacy_1_Form_Names
    (opcode : Bits 8) (decoder_form_index : Int) :
    Except (Runtime.Error Empty) (String × String) := do
  match Unsigned opcode with
  | 0b00000000 => do
    match decoder_form_index with
    | 1 => do
      return ("VERR_GPR16", "VERR_GPR16")
    | 2 => do
      return ("VERR_MEMw", "VERR_MEMw")
    | 3 => do
      return ("VERW_GPR16", "VERW_GPR16")
    | 4 => do
      return ("VERW_MEMw", "VERW_MEMw")
    | 5 => do
      return ("LLDT_GPR16", "LLDT_GPR16")
    | 6 => do
      return ("LLDT_MEMw", "LLDT_MEMw")
    | 7 => do
      return ("SLDT_GPRv", "SLDT_GPRv")
    | 8 => do
      return ("SLDT_MEMw", "SLDT_MEMw")
    | 9 => do
      return ("STR_GPRv", "STR_GPRv")
    | 10 => do
      return ("STR_MEMw", "STR_MEMw")
    | 11 => do
      return ("LTR_GPR16", "LTR_GPR16")
    | 12 => do
      return ("LTR_MEMw", "LTR_MEMw")
    | _ => do
      return ("", "")
  | 0b00000001 => do
    match decoder_form_index with
    | 1 => do
      return ("LMSW_GPR16", "LMSW_GPR16")
    | 2 => do
      return ("LMSW_MEMw", "LMSW_MEMw")
    | 3 => do
      return ("LGDT_MEMs64", "LGDT_MEMs64")
    | 4 => do
      return ("LIDT_MEMs64", "LIDT_MEMs64")
    | 5 => do
      return ("SGDT_MEMs64", "SGDT_MEMs64")
    | 6 => do
      return ("SIDT_MEMs64", "SIDT_MEMs64")
    | 7 => do
      return ("SWAPGS", "SWAPGS")
    | 8 => do
      return ("SMSW_GPRv", "SMSW_GPRv")
    | 9 => do
      return ("SMSW_MEMw", "SMSW_MEMw")
    | 10 => do
      return ("INVLPG_MEMb", "INVLPG_MEMb")
    | _ => do
      return ("", "")
  | 0b00000010 => do
    match decoder_form_index with
    | 1 => do
      return ("LAR_GPRv_GPRv", "LAR_GPRv_GPRv")
    | 2 => do
      return ("LAR_GPRv_MEMw", "LAR_GPRv_MEMw")
    | _ => do
      return ("", "")
  | 0b00000011 => do
    match decoder_form_index with
    | 1 => do
      return ("LSL_GPRv_GPRz", "LSL_GPRv_GPRz")
    | 2 => do
      return ("LSL_GPRv_MEMw", "LSL_GPRv_MEMw")
    | _ => do
      return ("", "")
  | 0b00000101 => do
    match decoder_form_index with
    | 1 => do
      return ("SYSCALL", "SYSCALL")
    | _ => do
      return ("", "")
  | 0b00000110 => do
    match decoder_form_index with
    | 1 => do
      return ("CLTS", "CLTS")
    | _ => do
      return ("", "")
  | 0b00000111 => do
    match decoder_form_index with
    | 1 => do
      return ("SYSRET", "SYSRET")
    | 2 => do
      return ("SYSRET64", "SYSRET64")
    | _ => do
      return ("", "")
  | 0b00001000 => do
    match decoder_form_index with
    | 1 => do
      return ("INVD", "INVD")
    | _ => do
      return ("", "")
  | 0b00001001 => do
    match decoder_form_index with
    | 1 => do
      return ("WBINVD_1", "WBINVD")
    | _ => do
      return ("", "")
  | 0b00001011 => do
    match decoder_form_index with
    | 1 => do
      return ("UD2", "UD2")
    | _ => do
      return ("", "")
  | 0b00001101 => do
    match decoder_form_index with
    | 1 => do
      return ("PREFETCHW_0F0Dr1", "PREFETCHW_0F0Dr1")
    | 2 => do
      return ("PREFETCHW_0F0Dr3", "PREFETCHW_0F0Dr3")
    | _ => do
      return ("", "")
  | 0b00010000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVSD_XMM_XMMdq_MEMsd_1", "MOVSD_XMM_XMMdq_MEMsd")
    | 2 => do
      return ("MOVSD_XMM_XMMsd_XMMsd_0F10", "MOVSD_XMM_XMMsd_XMMsd_0F10")
    | 3 => do
      return ("MOVSS_XMMdq_MEMss_1", "MOVSS_XMMdq_MEMss")
    | 4 => do
      return ("MOVSS_XMMss_XMMss_0F10", "MOVSS_XMMss_XMMss_0F10")
    | 5 => do
      return ("MOVUPS_XMMps_MEMps", "MOVUPS_XMMps_MEMps")
    | 6 => do
      return ("MOVUPS_XMMps_XMMps_0F10", "MOVUPS_XMMps_XMMps_0F10")
    | 7 => do
      return ("MOVUPD_XMMpd_MEMpd", "MOVUPD_XMMpd_MEMpd")
    | 8 => do
      return ("MOVUPD_XMMpd_XMMpd_0F10", "MOVUPD_XMMpd_XMMpd_0F10")
    | _ => do
      return ("", "")
  | 0b00010001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVSD_XMM_XMMsd_XMMsd_0F11", "MOVSD_XMM_XMMsd_XMMsd_0F11")
    | 2 => do
      return ("MOVSD_XMM_MEMsd_XMMsd_1", "MOVSD_XMM_MEMsd_XMMsd")
    | 3 => do
      return ("MOVSS_XMMss_XMMss_0F11", "MOVSS_XMMss_XMMss_0F11")
    | 4 => do
      return ("MOVSS_MEMss_XMMss_1", "MOVSS_MEMss_XMMss")
    | 5 => do
      return ("MOVUPS_MEMps_XMMps", "MOVUPS_MEMps_XMMps")
    | 6 => do
      return ("MOVUPS_XMMps_XMMps_0F11", "MOVUPS_XMMps_XMMps_0F11")
    | 7 => do
      return ("MOVUPD_MEMpd_XMMpd", "MOVUPD_MEMpd_XMMpd")
    | 8 => do
      return ("MOVUPD_XMMpd_XMMpd_0F11", "MOVUPD_XMMpd_XMMpd_0F11")
    | _ => do
      return ("", "")
  | 0b00010010 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVLPS_XMMq_MEMq", "MOVLPS_XMMq_MEMq")
    | 2 => do
      return ("MOVLPD_XMMsd_MEMq", "MOVLPD_XMMsd_MEMq")
    | 3 => do
      return ("MOVHLPS_XMMq_XMMq", "MOVHLPS_XMMq_XMMq")
    | _ => do
      return ("", "")
  | 0b00010011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVLPS_MEMq_XMMq", "MOVLPS_MEMq_XMMq")
    | 2 => do
      return ("MOVLPD_MEMq_XMMsd", "MOVLPD_MEMq_XMMsd")
    | _ => do
      return ("", "")
  | 0b00010100 => do
    match decoder_form_index with
    | 1 => do
      return ("UNPCKLPS_XMMps_MEMdq", "UNPCKLPS_XMMps_MEMdq")
    | 2 => do
      return ("UNPCKLPS_XMMps_XMMq", "UNPCKLPS_XMMps_XMMq")
    | 3 => do
      return ("UNPCKLPD_XMMpd_MEMdq", "UNPCKLPD_XMMpd_MEMdq")
    | 4 => do
      return ("UNPCKLPD_XMMpd_XMMq", "UNPCKLPD_XMMpd_XMMq")
    | _ => do
      return ("", "")
  | 0b00010101 => do
    match decoder_form_index with
    | 1 => do
      return ("UNPCKHPD_XMMpd_MEMdq", "UNPCKHPD_XMMpd_MEMdq")
    | 2 => do
      return ("UNPCKHPD_XMMpd_XMMq", "UNPCKHPD_XMMpd_XMMq")
    | 3 => do
      return ("UNPCKHPS_XMMps_MEMdq", "UNPCKHPS_XMMps_MEMdq")
    | 4 => do
      return ("UNPCKHPS_XMMps_XMMdq", "UNPCKHPS_XMMps_XMMdq")
    | _ => do
      return ("", "")
  | 0b00010110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVHPS_XMMq_MEMq", "MOVHPS_XMMq_MEMq")
    | 2 => do
      return ("MOVHPD_XMMsd_MEMq", "MOVHPD_XMMsd_MEMq")
    | 3 => do
      return ("MOVLHPS_XMMq_XMMq", "MOVLHPS_XMMq_XMMq")
    | _ => do
      return ("", "")
  | 0b00010111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVHPS_MEMq_XMMps", "MOVHPS_MEMq_XMMps")
    | 2 => do
      return ("MOVHPD_MEMq_XMMsd", "MOVHPD_MEMq_XMMsd")
    | _ => do
      return ("", "")
  | 0b00011000 => do
    match decoder_form_index with
    | 1 => do
      return ("PREFETCHNTA_MEMmprefetch", "PREFETCHNTA_MEMmprefetch")
    | 2 => do
      return ("PREFETCHT0_MEMmprefetch", "PREFETCHT0_MEMmprefetch")
    | 3 => do
      return ("PREFETCHT1_MEMmprefetch", "PREFETCHT1_MEMmprefetch")
    | 4 => do
      return ("PREFETCHT2_MEMmprefetch", "PREFETCHT2_MEMmprefetch")
    | 5 => do
      return ("NOP_GPRv_0F18r0", "NOP_GPRv_0F18r0")
    | 6 => do
      return ("NOP_GPRv_0F18r1", "NOP_GPRv_0F18r1")
    | 7 => do
      return ("NOP_GPRv_0F18r2", "NOP_GPRv_0F18r2")
    | 8 => do
      return ("NOP_GPRv_0F18r3", "NOP_GPRv_0F18r3")
    | 9 => do
      return ("NOP_GPRv_0F18r4", "NOP_GPRv_0F18r4")
    | 10 => do
      return ("NOP_GPRv_0F18r5", "NOP_GPRv_0F18r5")
    | 11 => do
      return ("NOP_GPRv_0F18r6", "NOP_GPRv_0F18r6")
    | 12 => do
      return ("NOP_GPRv_0F18r7", "NOP_GPRv_0F18r7")
    | 13 => do
      return ("NOP_MEMv_0F18r4", "NOP_MEMv_0F18r4")
    | 14 => do
      return ("NOP_MEMv_0F18r5", "NOP_MEMv_0F18r5")
    | 15 => do
      return ("NOP_MEMv_0F18r6", "NOP_MEMv_0F18r6")
    | 16 => do
      return ("NOP_MEMv_0F18r7", "NOP_MEMv_0F18r7")
    | _ => do
      return ("", "")
  | 0b00011001 => do
    match decoder_form_index with
    | 1 => do
      return ("NOP_MEMv_GPRv_0F19", "NOP_MEMv_GPRv_0F19")
    | 2 => do
      return ("NOP_GPRv_GPRv_0F19", "NOP_GPRv_GPRv_0F19")
    | _ => do
      return ("", "")
  | 0b00011010 => do
    match decoder_form_index with
    | 1 => do
      return ("NOP_MEMv_GPRv_0F1A", "NOP_MEMv_GPRv_0F1A")
    | 2 => do
      return ("NOP_GPRv_GPRv_0F1A", "NOP_GPRv_GPRv_0F1A")
    | _ => do
      return ("", "")
  | 0b00011011 => do
    match decoder_form_index with
    | 1 => do
      return ("NOP_MEMv_GPRv_0F1B", "NOP_MEMv_GPRv_0F1B")
    | 2 => do
      return ("NOP_GPRv_GPRv_0F1B", "NOP_GPRv_GPRv_0F1B")
    | _ => do
      return ("", "")
  | 0b00011100 => do
    match decoder_form_index with
    | 1 => do
      return ("NOP_MEMv_GPRv_0F1C", "NOP_MEMv_GPRv_0F1C")
    | 2 => do
      return ("NOP_GPRv_GPRv_0F1C", "NOP_GPRv_GPRv_0F1C")
    | _ => do
      return ("", "")
  | 0b00011101 => do
    match decoder_form_index with
    | 1 => do
      return ("NOP_MEMv_GPRv_0F1D", "NOP_MEMv_GPRv_0F1D")
    | 2 => do
      return ("NOP_GPRv_GPRv_0F1D", "NOP_GPRv_GPRv_0F1D")
    | _ => do
      return ("", "")
  | 0b00011110 => do
    match decoder_form_index with
    | 1 => do
      return ("ENDBR64", "ENDBR64")
    | 2 => do
      return ("NOP_MEMv_GPRv_0F1E", "NOP_MEMv_GPRv_0F1E")
    | 3 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 4 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 5 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 6 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 7 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 8 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 9 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 10 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 11 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 12 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 13 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 14 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 15 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 16 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 17 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | 18 => do
      return ("NOP_GPRv_GPRv_0F1E", "NOP_GPRv_GPRv_0F1E")
    | _ => do
      return ("", "")
  | 0b00011111 => do
    match decoder_form_index with
    | 1 => do
      return ("NOP_GPRv_0F1F", "NOP_GPRv_0F1F")
    | 2 => do
      return ("NOP_MEMv_0F1F", "NOP_MEMv_0F1F")
    | _ => do
      return ("", "")
  | 0b00100000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_CR_GPR64_CR", "MOV_CR_GPR64_CR")
    | _ => do
      return ("", "")
  | 0b00100001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_DR_GPR64_DR", "MOV_DR_GPR64_DR")
    | _ => do
      return ("", "")
  | 0b00100010 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_CR_CR_GPR64", "MOV_CR_CR_GPR64")
    | _ => do
      return ("", "")
  | 0b00100011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_DR_DR_GPR64", "MOV_DR_DR_GPR64")
    | _ => do
      return ("", "")
  | 0b00101000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVAPS_XMMps_MEMps", "MOVAPS_XMMps_MEMps")
    | 2 => do
      return ("MOVAPS_XMMps_XMMps_0F28", "MOVAPS_XMMps_XMMps_0F28")
    | 3 => do
      return ("MOVAPD_XMMpd_MEMpd", "MOVAPD_XMMpd_MEMpd")
    | 4 => do
      return ("MOVAPD_XMMpd_XMMpd_0F28", "MOVAPD_XMMpd_XMMpd_0F28")
    | _ => do
      return ("", "")
  | 0b00101001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVAPS_MEMps_XMMps", "MOVAPS_MEMps_XMMps")
    | 2 => do
      return ("MOVAPS_XMMps_XMMps_0F29", "MOVAPS_XMMps_XMMps_0F29")
    | 3 => do
      return ("MOVAPD_MEMpd_XMMpd", "MOVAPD_MEMpd_XMMpd")
    | 4 => do
      return ("MOVAPD_XMMpd_XMMpd_0F29", "MOVAPD_XMMpd_XMMpd_0F29")
    | _ => do
      return ("", "")
  | 0b00101010 => do
    match decoder_form_index with
    | 1 => do
      return ("CVTSI2SS_XMMss_GPR32d", "CVTSI2SS_XMMss_GPR32d")
    | 2 => do
      return ("CVTSI2SS_XMMss_GPR64q", "CVTSI2SS_XMMss_GPR64q")
    | 3 => do
      return ("CVTSI2SS_XMMss_MEMd", "CVTSI2SS_XMMss_MEMd")
    | 4 => do
      return ("CVTSI2SS_XMMss_MEMq", "CVTSI2SS_XMMss_MEMq")
    | 5 => do
      return ("CVTSI2SD_XMMsd_GPR32d", "CVTSI2SD_XMMsd_GPR32d")
    | 6 => do
      return ("CVTSI2SD_XMMsd_GPR64q", "CVTSI2SD_XMMsd_GPR64q")
    | 7 => do
      return ("CVTSI2SD_XMMsd_MEMd", "CVTSI2SD_XMMsd_MEMd")
    | 8 => do
      return ("CVTSI2SD_XMMsd_MEMq", "CVTSI2SD_XMMsd_MEMq")
    | 9 => do
      return ("CVTPI2PD_XMMpd_MEMq", "CVTPI2PD_XMMpd_MEMq")
    | 10 => do
      return ("CVTPI2PD_XMMpd_MMXq", "CVTPI2PD_XMMpd_MMXq")
    | 11 => do
      return ("CVTPI2PS_XMMq_MEMq", "CVTPI2PS_XMMq_MEMq")
    | 12 => do
      return ("CVTPI2PS_XMMq_MMXq", "CVTPI2PS_XMMq_MMXq")
    | _ => do
      return ("", "")
  | 0b00101011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVNTPD_MEMdq_XMMpd", "MOVNTPD_MEMdq_XMMpd")
    | 2 => do
      return ("MOVNTPS_MEMdq_XMMps", "MOVNTPS_MEMdq_XMMps")
    | _ => do
      return ("", "")
  | 0b00101100 => do
    match decoder_form_index with
    | 1 => do
      return ("CVTTPD2PI_MMXq_MEMpd", "CVTTPD2PI_MMXq_MEMpd")
    | 2 => do
      return ("CVTTPD2PI_MMXq_XMMpd", "CVTTPD2PI_MMXq_XMMpd")
    | 3 => do
      return ("CVTTSD2SI_GPR32d_MEMsd", "CVTTSD2SI_GPR32d_MEMsd")
    | 4 => do
      return ("CVTTSD2SI_GPR32d_XMMsd", "CVTTSD2SI_GPR32d_XMMsd")
    | 5 => do
      return ("CVTTSD2SI_GPR64q_MEMsd", "CVTTSD2SI_GPR64q_MEMsd")
    | 6 => do
      return ("CVTTSD2SI_GPR64q_XMMsd", "CVTTSD2SI_GPR64q_XMMsd")
    | 7 => do
      return ("CVTTSS2SI_GPR32d_MEMss", "CVTTSS2SI_GPR32d_MEMss")
    | 8 => do
      return ("CVTTSS2SI_GPR32d_XMMss", "CVTTSS2SI_GPR32d_XMMss")
    | 9 => do
      return ("CVTTSS2SI_GPR64q_MEMss", "CVTTSS2SI_GPR64q_MEMss")
    | 10 => do
      return ("CVTTSS2SI_GPR64q_XMMss", "CVTTSS2SI_GPR64q_XMMss")
    | 11 => do
      return ("CVTTPS2PI_MMXq_MEMq", "CVTTPS2PI_MMXq_MEMq")
    | 12 => do
      return ("CVTTPS2PI_MMXq_XMMq", "CVTTPS2PI_MMXq_XMMq")
    | _ => do
      return ("", "")
  | 0b00101101 => do
    match decoder_form_index with
    | 1 => do
      return ("CVTSS2SI_GPR32d_MEMss", "CVTSS2SI_GPR32d_MEMss")
    | 2 => do
      return ("CVTSS2SI_GPR32d_XMMss", "CVTSS2SI_GPR32d_XMMss")
    | 3 => do
      return ("CVTSS2SI_GPR64q_MEMss", "CVTSS2SI_GPR64q_MEMss")
    | 4 => do
      return ("CVTSS2SI_GPR64q_XMMss", "CVTSS2SI_GPR64q_XMMss")
    | 5 => do
      return ("CVTSD2SI_GPR32d_MEMsd", "CVTSD2SI_GPR32d_MEMsd")
    | 6 => do
      return ("CVTSD2SI_GPR32d_XMMsd", "CVTSD2SI_GPR32d_XMMsd")
    | 7 => do
      return ("CVTSD2SI_GPR64q_MEMsd", "CVTSD2SI_GPR64q_MEMsd")
    | 8 => do
      return ("CVTSD2SI_GPR64q_XMMsd", "CVTSD2SI_GPR64q_XMMsd")
    | 9 => do
      return ("CVTPS2PI_MMXq_MEMq", "CVTPS2PI_MMXq_MEMq")
    | 10 => do
      return ("CVTPS2PI_MMXq_XMMq", "CVTPS2PI_MMXq_XMMq")
    | 11 => do
      return ("CVTPD2PI_MMXq_MEMpd", "CVTPD2PI_MMXq_MEMpd")
    | 12 => do
      return ("CVTPD2PI_MMXq_XMMpd", "CVTPD2PI_MMXq_XMMpd")
    | _ => do
      return ("", "")
  | 0b00101110 => do
    match decoder_form_index with
    | 1 => do
      return ("UCOMISS_XMMss_MEMss", "UCOMISS_XMMss_MEMss")
    | 2 => do
      return ("UCOMISS_XMMss_XMMss", "UCOMISS_XMMss_XMMss")
    | 3 => do
      return ("UCOMISD_XMMsd_MEMsd", "UCOMISD_XMMsd_MEMsd")
    | 4 => do
      return ("UCOMISD_XMMsd_XMMsd", "UCOMISD_XMMsd_XMMsd")
    | _ => do
      return ("", "")
  | 0b00101111 => do
    match decoder_form_index with
    | 1 => do
      return ("COMISS_XMMss_MEMss", "COMISS_XMMss_MEMss")
    | 2 => do
      return ("COMISS_XMMss_XMMss", "COMISS_XMMss_XMMss")
    | 3 => do
      return ("COMISD_XMMsd_MEMsd", "COMISD_XMMsd_MEMsd")
    | 4 => do
      return ("COMISD_XMMsd_XMMsd", "COMISD_XMMsd_XMMsd")
    | _ => do
      return ("", "")
  | 0b00110000 => do
    match decoder_form_index with
    | 1 => do
      return ("WRMSR", "WRMSR")
    | _ => do
      return ("", "")
  | 0b00110001 => do
    match decoder_form_index with
    | 1 => do
      return ("RDTSC", "RDTSC")
    | _ => do
      return ("", "")
  | 0b00110010 => do
    match decoder_form_index with
    | 1 => do
      return ("RDMSR", "RDMSR")
    | _ => do
      return ("", "")
  | 0b01000000 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVO_GPRv_GPRv", "CMOVO_GPRv_GPRv")
    | 2 => do
      return ("CMOVO_GPRv_MEMv", "CMOVO_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000001 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNO_GPRv_GPRv", "CMOVNO_GPRv_GPRv")
    | 2 => do
      return ("CMOVNO_GPRv_MEMv", "CMOVNO_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000010 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVB_GPRv_GPRv", "CMOVB_GPRv_GPRv")
    | 2 => do
      return ("CMOVB_GPRv_MEMv", "CMOVB_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000011 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNB_GPRv_GPRv", "CMOVNB_GPRv_GPRv")
    | 2 => do
      return ("CMOVNB_GPRv_MEMv", "CMOVNB_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000100 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVZ_GPRv_GPRv", "CMOVZ_GPRv_GPRv")
    | 2 => do
      return ("CMOVZ_GPRv_MEMv", "CMOVZ_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000101 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNZ_GPRv_GPRv", "CMOVNZ_GPRv_GPRv")
    | 2 => do
      return ("CMOVNZ_GPRv_MEMv", "CMOVNZ_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000110 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVBE_GPRv_GPRv", "CMOVBE_GPRv_GPRv")
    | 2 => do
      return ("CMOVBE_GPRv_MEMv", "CMOVBE_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01000111 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNBE_GPRv_GPRv", "CMOVNBE_GPRv_GPRv")
    | 2 => do
      return ("CMOVNBE_GPRv_MEMv", "CMOVNBE_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001000 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVS_GPRv_GPRv", "CMOVS_GPRv_GPRv")
    | 2 => do
      return ("CMOVS_GPRv_MEMv", "CMOVS_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001001 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNS_GPRv_GPRv", "CMOVNS_GPRv_GPRv")
    | 2 => do
      return ("CMOVNS_GPRv_MEMv", "CMOVNS_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001010 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVP_GPRv_GPRv", "CMOVP_GPRv_GPRv")
    | 2 => do
      return ("CMOVP_GPRv_MEMv", "CMOVP_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001011 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNP_GPRv_GPRv", "CMOVNP_GPRv_GPRv")
    | 2 => do
      return ("CMOVNP_GPRv_MEMv", "CMOVNP_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001100 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVL_GPRv_GPRv", "CMOVL_GPRv_GPRv")
    | 2 => do
      return ("CMOVL_GPRv_MEMv", "CMOVL_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001101 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNL_GPRv_GPRv", "CMOVNL_GPRv_GPRv")
    | 2 => do
      return ("CMOVNL_GPRv_MEMv", "CMOVNL_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001110 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVLE_GPRv_GPRv", "CMOVLE_GPRv_GPRv")
    | 2 => do
      return ("CMOVLE_GPRv_MEMv", "CMOVLE_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01001111 => do
    match decoder_form_index with
    | 1 => do
      return ("CMOVNLE_GPRv_GPRv", "CMOVNLE_GPRv_GPRv")
    | 2 => do
      return ("CMOVNLE_GPRv_MEMv", "CMOVNLE_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b01010000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVMSKPS_GPR32_XMMps", "MOVMSKPS_GPR32_XMMps")
    | 2 => do
      return ("MOVMSKPD_GPR32_XMMpd", "MOVMSKPD_GPR32_XMMpd")
    | _ => do
      return ("", "")
  | 0b01010001 => do
    match decoder_form_index with
    | 1 => do
      return ("SQRTPS_XMMps_MEMps", "SQRTPS_XMMps_MEMps")
    | 2 => do
      return ("SQRTPS_XMMps_XMMps", "SQRTPS_XMMps_XMMps")
    | 3 => do
      return ("SQRTPD_XMMpd_MEMpd", "SQRTPD_XMMpd_MEMpd")
    | 4 => do
      return ("SQRTPD_XMMpd_XMMpd", "SQRTPD_XMMpd_XMMpd")
    | 5 => do
      return ("SQRTSS_XMMss_MEMss", "SQRTSS_XMMss_MEMss")
    | 6 => do
      return ("SQRTSS_XMMss_XMMss", "SQRTSS_XMMss_XMMss")
    | 7 => do
      return ("SQRTSD_XMMsd_MEMsd", "SQRTSD_XMMsd_MEMsd")
    | 8 => do
      return ("SQRTSD_XMMsd_XMMsd", "SQRTSD_XMMsd_XMMsd")
    | _ => do
      return ("", "")
  | 0b01010010 => do
    match decoder_form_index with
    | 1 => do
      return ("RSQRTPS_XMMps_MEMps", "RSQRTPS_XMMps_MEMps")
    | 2 => do
      return ("RSQRTPS_XMMps_XMMps", "RSQRTPS_XMMps_XMMps")
    | 3 => do
      return ("RSQRTSS_XMMss_MEMss", "RSQRTSS_XMMss_MEMss")
    | 4 => do
      return ("RSQRTSS_XMMss_XMMss", "RSQRTSS_XMMss_XMMss")
    | _ => do
      return ("", "")
  | 0b01010011 => do
    match decoder_form_index with
    | 1 => do
      return ("RCPPS_XMMps_MEMps", "RCPPS_XMMps_MEMps")
    | 2 => do
      return ("RCPPS_XMMps_XMMps", "RCPPS_XMMps_XMMps")
    | 3 => do
      return ("RCPSS_XMMss_MEMss", "RCPSS_XMMss_MEMss")
    | 4 => do
      return ("RCPSS_XMMss_XMMss", "RCPSS_XMMss_XMMss")
    | _ => do
      return ("", "")
  | 0b01010100 => do
    match decoder_form_index with
    | 1 => do
      return ("ANDPS_XMMxud_MEMxud", "ANDPS_XMMxud_MEMxud")
    | 2 => do
      return ("ANDPS_XMMxud_XMMxud", "ANDPS_XMMxud_XMMxud")
    | 3 => do
      return ("ANDPD_XMMxuq_MEMxuq", "ANDPD_XMMxuq_MEMxuq")
    | 4 => do
      return ("ANDPD_XMMxuq_XMMxuq", "ANDPD_XMMxuq_XMMxuq")
    | _ => do
      return ("", "")
  | 0b01010101 => do
    match decoder_form_index with
    | 1 => do
      return ("ANDNPS_XMMxud_MEMxud", "ANDNPS_XMMxud_MEMxud")
    | 2 => do
      return ("ANDNPS_XMMxud_XMMxud", "ANDNPS_XMMxud_XMMxud")
    | 3 => do
      return ("ANDNPD_XMMxuq_MEMxuq", "ANDNPD_XMMxuq_MEMxuq")
    | 4 => do
      return ("ANDNPD_XMMxuq_XMMxuq", "ANDNPD_XMMxuq_XMMxuq")
    | _ => do
      return ("", "")
  | 0b01010110 => do
    match decoder_form_index with
    | 1 => do
      return ("ORPS_XMMxud_MEMxud", "ORPS_XMMxud_MEMxud")
    | 2 => do
      return ("ORPS_XMMxud_XMMxud", "ORPS_XMMxud_XMMxud")
    | 3 => do
      return ("ORPD_XMMxuq_MEMxuq", "ORPD_XMMxuq_MEMxuq")
    | 4 => do
      return ("ORPD_XMMxuq_XMMxuq", "ORPD_XMMxuq_XMMxuq")
    | _ => do
      return ("", "")
  | 0b01010111 => do
    match decoder_form_index with
    | 1 => do
      return ("XORPS_XMMxud_MEMxud", "XORPS_XMMxud_MEMxud")
    | 2 => do
      return ("XORPS_XMMxud_XMMxud", "XORPS_XMMxud_XMMxud")
    | 3 => do
      return ("XORPD_XMMxuq_MEMxuq", "XORPD_XMMxuq_MEMxuq")
    | 4 => do
      return ("XORPD_XMMxuq_XMMxuq", "XORPD_XMMxuq_XMMxuq")
    | _ => do
      return ("", "")
  | 0b01011000 => do
    match decoder_form_index with
    | 1 => do
      return ("ADDPD_XMMpd_MEMpd", "ADDPD_XMMpd_MEMpd")
    | 2 => do
      return ("ADDPD_XMMpd_XMMpd", "ADDPD_XMMpd_XMMpd")
    | 3 => do
      return ("ADDPS_XMMps_MEMps", "ADDPS_XMMps_MEMps")
    | 4 => do
      return ("ADDPS_XMMps_XMMps", "ADDPS_XMMps_XMMps")
    | 5 => do
      return ("ADDSD_XMMsd_MEMsd", "ADDSD_XMMsd_MEMsd")
    | 6 => do
      return ("ADDSD_XMMsd_XMMsd", "ADDSD_XMMsd_XMMsd")
    | 7 => do
      return ("ADDSS_XMMss_MEMss", "ADDSS_XMMss_MEMss")
    | 8 => do
      return ("ADDSS_XMMss_XMMss", "ADDSS_XMMss_XMMss")
    | _ => do
      return ("", "")
  | 0b01011001 => do
    match decoder_form_index with
    | 1 => do
      return ("MULPD_XMMpd_MEMpd", "MULPD_XMMpd_MEMpd")
    | 2 => do
      return ("MULPD_XMMpd_XMMpd", "MULPD_XMMpd_XMMpd")
    | 3 => do
      return ("MULPS_XMMps_MEMps", "MULPS_XMMps_MEMps")
    | 4 => do
      return ("MULPS_XMMps_XMMps", "MULPS_XMMps_XMMps")
    | 5 => do
      return ("MULSD_XMMsd_MEMsd", "MULSD_XMMsd_MEMsd")
    | 6 => do
      return ("MULSD_XMMsd_XMMsd", "MULSD_XMMsd_XMMsd")
    | 7 => do
      return ("MULSS_XMMss_MEMss", "MULSS_XMMss_MEMss")
    | 8 => do
      return ("MULSS_XMMss_XMMss", "MULSS_XMMss_XMMss")
    | _ => do
      return ("", "")
  | 0b01011010 => do
    match decoder_form_index with
    | 1 => do
      return ("CVTPS2PD_XMMpd_MEMq", "CVTPS2PD_XMMpd_MEMq")
    | 2 => do
      return ("CVTPS2PD_XMMpd_XMMq", "CVTPS2PD_XMMpd_XMMq")
    | 3 => do
      return ("CVTPD2PS_XMMps_MEMpd", "CVTPD2PS_XMMps_MEMpd")
    | 4 => do
      return ("CVTPD2PS_XMMps_XMMpd", "CVTPD2PS_XMMps_XMMpd")
    | 5 => do
      return ("CVTSS2SD_XMMsd_MEMss", "CVTSS2SD_XMMsd_MEMss")
    | 6 => do
      return ("CVTSS2SD_XMMsd_XMMss", "CVTSS2SD_XMMsd_XMMss")
    | 7 => do
      return ("CVTSD2SS_XMMss_MEMsd", "CVTSD2SS_XMMss_MEMsd")
    | 8 => do
      return ("CVTSD2SS_XMMss_XMMsd", "CVTSD2SS_XMMss_XMMsd")
    | _ => do
      return ("", "")
  | 0b01011011 => do
    match decoder_form_index with
    | 1 => do
      return ("CVTDQ2PS_XMMps_MEMdq", "CVTDQ2PS_XMMps_MEMdq")
    | 2 => do
      return ("CVTDQ2PS_XMMps_XMMdq", "CVTDQ2PS_XMMps_XMMdq")
    | 3 => do
      return ("CVTPS2DQ_XMMdq_MEMps", "CVTPS2DQ_XMMdq_MEMps")
    | 4 => do
      return ("CVTPS2DQ_XMMdq_XMMps", "CVTPS2DQ_XMMdq_XMMps")
    | 5 => do
      return ("CVTTPS2DQ_XMMdq_MEMps", "CVTTPS2DQ_XMMdq_MEMps")
    | 6 => do
      return ("CVTTPS2DQ_XMMdq_XMMps", "CVTTPS2DQ_XMMdq_XMMps")
    | _ => do
      return ("", "")
  | 0b01011100 => do
    match decoder_form_index with
    | 1 => do
      return ("SUBSD_XMMsd_MEMsd", "SUBSD_XMMsd_MEMsd")
    | 2 => do
      return ("SUBSD_XMMsd_XMMsd", "SUBSD_XMMsd_XMMsd")
    | 3 => do
      return ("SUBSS_XMMss_MEMss", "SUBSS_XMMss_MEMss")
    | 4 => do
      return ("SUBSS_XMMss_XMMss", "SUBSS_XMMss_XMMss")
    | 5 => do
      return ("SUBPD_XMMpd_MEMpd", "SUBPD_XMMpd_MEMpd")
    | 6 => do
      return ("SUBPD_XMMpd_XMMpd", "SUBPD_XMMpd_XMMpd")
    | 7 => do
      return ("SUBPS_XMMps_MEMps", "SUBPS_XMMps_MEMps")
    | 8 => do
      return ("SUBPS_XMMps_XMMps", "SUBPS_XMMps_XMMps")
    | _ => do
      return ("", "")
  | 0b01011101 => do
    match decoder_form_index with
    | 1 => do
      return ("MINPS_XMMps_MEMps", "MINPS_XMMps_MEMps")
    | 2 => do
      return ("MINPS_XMMps_XMMps", "MINPS_XMMps_XMMps")
    | 3 => do
      return ("MINPD_XMMpd_MEMpd", "MINPD_XMMpd_MEMpd")
    | 4 => do
      return ("MINPD_XMMpd_XMMpd", "MINPD_XMMpd_XMMpd")
    | 5 => do
      return ("MINSS_XMMss_MEMss", "MINSS_XMMss_MEMss")
    | 6 => do
      return ("MINSS_XMMss_XMMss", "MINSS_XMMss_XMMss")
    | 7 => do
      return ("MINSD_XMMsd_MEMsd", "MINSD_XMMsd_MEMsd")
    | 8 => do
      return ("MINSD_XMMsd_XMMsd", "MINSD_XMMsd_XMMsd")
    | _ => do
      return ("", "")
  | 0b01011110 => do
    match decoder_form_index with
    | 1 => do
      return ("DIVPD_XMMpd_MEMpd", "DIVPD_XMMpd_MEMpd")
    | 2 => do
      return ("DIVPD_XMMpd_XMMpd", "DIVPD_XMMpd_XMMpd")
    | 3 => do
      return ("DIVPS_XMMps_MEMps", "DIVPS_XMMps_MEMps")
    | 4 => do
      return ("DIVPS_XMMps_XMMps", "DIVPS_XMMps_XMMps")
    | 5 => do
      return ("DIVSD_XMMsd_MEMsd", "DIVSD_XMMsd_MEMsd")
    | 6 => do
      return ("DIVSD_XMMsd_XMMsd", "DIVSD_XMMsd_XMMsd")
    | 7 => do
      return ("DIVSS_XMMss_MEMss", "DIVSS_XMMss_MEMss")
    | 8 => do
      return ("DIVSS_XMMss_XMMss", "DIVSS_XMMss_XMMss")
    | _ => do
      return ("", "")
  | 0b01011111 => do
    match decoder_form_index with
    | 1 => do
      return ("MAXPS_XMMps_MEMps", "MAXPS_XMMps_MEMps")
    | 2 => do
      return ("MAXPS_XMMps_XMMps", "MAXPS_XMMps_XMMps")
    | 3 => do
      return ("MAXPD_XMMpd_MEMpd", "MAXPD_XMMpd_MEMpd")
    | 4 => do
      return ("MAXPD_XMMpd_XMMpd", "MAXPD_XMMpd_XMMpd")
    | 5 => do
      return ("MAXSS_XMMss_MEMss", "MAXSS_XMMss_MEMss")
    | 6 => do
      return ("MAXSS_XMMss_XMMss", "MAXSS_XMMss_XMMss")
    | 7 => do
      return ("MAXSD_XMMsd_MEMsd", "MAXSD_XMMsd_MEMsd")
    | 8 => do
      return ("MAXSD_XMMsd_XMMsd", "MAXSD_XMMsd_XMMsd")
    | _ => do
      return ("", "")
  | 0b01100000 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKLBW_MMXq_MEMd", "PUNPCKLBW_MMXq_MEMd")
    | 2 => do
      return ("PUNPCKLBW_MMXq_MMXd", "PUNPCKLBW_MMXq_MMXd")
    | 3 => do
      return ("PUNPCKLBW_XMMdq_MEMdq", "PUNPCKLBW_XMMdq_MEMdq")
    | 4 => do
      return ("PUNPCKLBW_XMMdq_XMMq", "PUNPCKLBW_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01100001 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKLWD_MMXq_MEMd", "PUNPCKLWD_MMXq_MEMd")
    | 2 => do
      return ("PUNPCKLWD_MMXq_MMXd", "PUNPCKLWD_MMXq_MMXd")
    | 3 => do
      return ("PUNPCKLWD_XMMdq_MEMdq", "PUNPCKLWD_XMMdq_MEMdq")
    | 4 => do
      return ("PUNPCKLWD_XMMdq_XMMq", "PUNPCKLWD_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01100010 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKLDQ_MMXq_MEMd", "PUNPCKLDQ_MMXq_MEMd")
    | 2 => do
      return ("PUNPCKLDQ_MMXq_MMXd", "PUNPCKLDQ_MMXq_MMXd")
    | 3 => do
      return ("PUNPCKLDQ_XMMdq_MEMdq", "PUNPCKLDQ_XMMdq_MEMdq")
    | 4 => do
      return ("PUNPCKLDQ_XMMdq_XMMq", "PUNPCKLDQ_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01100011 => do
    match decoder_form_index with
    | 1 => do
      return ("PACKSSWB_MMXq_MEMq", "PACKSSWB_MMXq_MEMq")
    | 2 => do
      return ("PACKSSWB_MMXq_MMXq", "PACKSSWB_MMXq_MMXq")
    | 3 => do
      return ("PACKSSWB_XMMdq_MEMdq", "PACKSSWB_XMMdq_MEMdq")
    | 4 => do
      return ("PACKSSWB_XMMdq_XMMdq", "PACKSSWB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01100100 => do
    match decoder_form_index with
    | 1 => do
      return ("PCMPGTB_MMXq_MEMq", "PCMPGTB_MMXq_MEMq")
    | 2 => do
      return ("PCMPGTB_MMXq_MMXq", "PCMPGTB_MMXq_MMXq")
    | 3 => do
      return ("PCMPGTB_XMMdq_MEMdq", "PCMPGTB_XMMdq_MEMdq")
    | 4 => do
      return ("PCMPGTB_XMMdq_XMMdq", "PCMPGTB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01100101 => do
    match decoder_form_index with
    | 1 => do
      return ("PCMPGTW_MMXq_MEMq", "PCMPGTW_MMXq_MEMq")
    | 2 => do
      return ("PCMPGTW_MMXq_MMXq", "PCMPGTW_MMXq_MMXq")
    | 3 => do
      return ("PCMPGTW_XMMdq_MEMdq", "PCMPGTW_XMMdq_MEMdq")
    | 4 => do
      return ("PCMPGTW_XMMdq_XMMdq", "PCMPGTW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01100110 => do
    match decoder_form_index with
    | 1 => do
      return ("PCMPGTD_MMXq_MEMq", "PCMPGTD_MMXq_MEMq")
    | 2 => do
      return ("PCMPGTD_MMXq_MMXq", "PCMPGTD_MMXq_MMXq")
    | 3 => do
      return ("PCMPGTD_XMMdq_MEMdq", "PCMPGTD_XMMdq_MEMdq")
    | 4 => do
      return ("PCMPGTD_XMMdq_XMMdq", "PCMPGTD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01100111 => do
    match decoder_form_index with
    | 1 => do
      return ("PACKUSWB_MMXq_MEMq", "PACKUSWB_MMXq_MEMq")
    | 2 => do
      return ("PACKUSWB_MMXq_MMXq", "PACKUSWB_MMXq_MMXq")
    | 3 => do
      return ("PACKUSWB_XMMdq_MEMdq", "PACKUSWB_XMMdq_MEMdq")
    | 4 => do
      return ("PACKUSWB_XMMdq_XMMdq", "PACKUSWB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01101000 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKHBW_MMXq_MEMq", "PUNPCKHBW_MMXq_MEMq")
    | 2 => do
      return ("PUNPCKHBW_MMXq_MMXd", "PUNPCKHBW_MMXq_MMXd")
    | 3 => do
      return ("PUNPCKHBW_XMMdq_MEMdq", "PUNPCKHBW_XMMdq_MEMdq")
    | 4 => do
      return ("PUNPCKHBW_XMMdq_XMMq", "PUNPCKHBW_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01101001 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKHWD_MMXq_MEMq", "PUNPCKHWD_MMXq_MEMq")
    | 2 => do
      return ("PUNPCKHWD_MMXq_MMXd", "PUNPCKHWD_MMXq_MMXd")
    | 3 => do
      return ("PUNPCKHWD_XMMdq_MEMdq", "PUNPCKHWD_XMMdq_MEMdq")
    | 4 => do
      return ("PUNPCKHWD_XMMdq_XMMq", "PUNPCKHWD_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01101010 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKHDQ_MMXq_MEMq", "PUNPCKHDQ_MMXq_MEMq")
    | 2 => do
      return ("PUNPCKHDQ_MMXq_MMXd", "PUNPCKHDQ_MMXq_MMXd")
    | 3 => do
      return ("PUNPCKHDQ_XMMdq_MEMdq", "PUNPCKHDQ_XMMdq_MEMdq")
    | 4 => do
      return ("PUNPCKHDQ_XMMdq_XMMq", "PUNPCKHDQ_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01101011 => do
    match decoder_form_index with
    | 1 => do
      return ("PACKSSDW_MMXq_MEMq", "PACKSSDW_MMXq_MEMq")
    | 2 => do
      return ("PACKSSDW_MMXq_MMXq", "PACKSSDW_MMXq_MMXq")
    | 3 => do
      return ("PACKSSDW_XMMdq_MEMdq", "PACKSSDW_XMMdq_MEMdq")
    | 4 => do
      return ("PACKSSDW_XMMdq_XMMdq", "PACKSSDW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01101100 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKLQDQ_XMMdq_MEMdq", "PUNPCKLQDQ_XMMdq_MEMdq")
    | 2 => do
      return ("PUNPCKLQDQ_XMMdq_XMMq", "PUNPCKLQDQ_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01101101 => do
    match decoder_form_index with
    | 1 => do
      return ("PUNPCKHQDQ_XMMdq_MEMdq", "PUNPCKHQDQ_XMMdq_MEMdq")
    | 2 => do
      return ("PUNPCKHQDQ_XMMdq_XMMq", "PUNPCKHQDQ_XMMdq_XMMq")
    | _ => do
      return ("", "")
  | 0b01101110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVD_MMXq_GPR32_0", "MOVD_MMXq_GPR32")
    | 2 => do
      return ("MOVD_MMXq_MEMd_0", "MOVD_MMXq_MEMd")
    | 3 => do
      return ("MOVQ_MMXq_GPR64", "MOVQ_MMXq_GPR64")
    | 4 => do
      return ("MOVQ_MMXq_MEMq_0F6E", "MOVQ_MMXq_MEMq_0F6E")
    | 5 => do
      return ("MOVD_XMMdq_GPR32_0", "MOVD_XMMdq_GPR32")
    | 6 => do
      return ("MOVD_XMMdq_MEMd_1", "MOVD_XMMdq_MEMd")
    | 7 => do
      return ("MOVQ_XMMdq_GPR64", "MOVQ_XMMdq_GPR64")
    | 8 => do
      return ("MOVQ_XMMdq_MEMq_0F6E_0", "MOVQ_XMMdq_MEMq_0F6E")
    | _ => do
      return ("", "")
  | 0b01101111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVDQU_XMMdq_MEMdq", "MOVDQU_XMMdq_MEMdq")
    | 2 => do
      return ("MOVDQU_XMMdq_XMMdq_0F6F", "MOVDQU_XMMdq_XMMdq_0F6F")
    | 3 => do
      return ("MOVDQA_XMMdq_MEMdq", "MOVDQA_XMMdq_MEMdq")
    | 4 => do
      return ("MOVDQA_XMMdq_XMMdq_0F6F", "MOVDQA_XMMdq_XMMdq_0F6F")
    | 5 => do
      return ("MOVQ_MMXq_MEMq_0F6F", "MOVQ_MMXq_MEMq_0F6F")
    | 6 => do
      return ("MOVQ_MMXq_MMXq_0F6F", "MOVQ_MMXq_MMXq_0F6F")
    | _ => do
      return ("", "")
  | 0b01110000 => do
    match decoder_form_index with
    | 1 => do
      return ("PSHUFW_MMXq_MEMq_IMMb", "PSHUFW_MMXq_MEMq_IMMb")
    | 2 => do
      return ("PSHUFW_MMXq_MMXq_IMMb", "PSHUFW_MMXq_MMXq_IMMb")
    | 3 => do
      return ("PSHUFD_XMMdq_MEMdq_IMMb", "PSHUFD_XMMdq_MEMdq_IMMb")
    | 4 => do
      return ("PSHUFD_XMMdq_XMMdq_IMMb", "PSHUFD_XMMdq_XMMdq_IMMb")
    | 5 => do
      return ("PSHUFLW_XMMdq_MEMdq_IMMb", "PSHUFLW_XMMdq_MEMdq_IMMb")
    | 6 => do
      return ("PSHUFLW_XMMdq_XMMdq_IMMb", "PSHUFLW_XMMdq_XMMdq_IMMb")
    | 7 => do
      return ("PSHUFHW_XMMdq_MEMdq_IMMb", "PSHUFHW_XMMdq_MEMdq_IMMb")
    | 8 => do
      return ("PSHUFHW_XMMdq_XMMdq_IMMb", "PSHUFHW_XMMdq_XMMdq_IMMb")
    | _ => do
      return ("", "")
  | 0b01110001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSLLW_MMXq_IMMb", "PSLLW_MMXq_IMMb")
    | 2 => do
      return ("PSLLW_XMMdq_IMMb", "PSLLW_XMMdq_IMMb")
    | 3 => do
      return ("PSRLW_MMXq_IMMb", "PSRLW_MMXq_IMMb")
    | 4 => do
      return ("PSRLW_XMMdq_IMMb", "PSRLW_XMMdq_IMMb")
    | 5 => do
      return ("PSRAW_MMXq_IMMb", "PSRAW_MMXq_IMMb")
    | 6 => do
      return ("PSRAW_XMMdq_IMMb", "PSRAW_XMMdq_IMMb")
    | _ => do
      return ("", "")
  | 0b01110010 => do
    match decoder_form_index with
    | 1 => do
      return ("PSLLD_MMXq_IMMb", "PSLLD_MMXq_IMMb")
    | 2 => do
      return ("PSLLD_XMMdq_IMMb", "PSLLD_XMMdq_IMMb")
    | 3 => do
      return ("PSRLD_MMXq_IMMb", "PSRLD_MMXq_IMMb")
    | 4 => do
      return ("PSRLD_XMMdq_IMMb", "PSRLD_XMMdq_IMMb")
    | 5 => do
      return ("PSRAD_MMXq_IMMb", "PSRAD_MMXq_IMMb")
    | 6 => do
      return ("PSRAD_XMMdq_IMMb", "PSRAD_XMMdq_IMMb")
    | _ => do
      return ("", "")
  | 0b01110011 => do
    match decoder_form_index with
    | 1 => do
      return ("PSLLQ_MMXq_IMMb", "PSLLQ_MMXq_IMMb")
    | 2 => do
      return ("PSLLQ_XMMdq_IMMb", "PSLLQ_XMMdq_IMMb")
    | 3 => do
      return ("PSRLQ_MMXq_IMMb", "PSRLQ_MMXq_IMMb")
    | 4 => do
      return ("PSRLQ_XMMdq_IMMb", "PSRLQ_XMMdq_IMMb")
    | 5 => do
      return ("PSLLDQ_XMMdq_IMMb", "PSLLDQ_XMMdq_IMMb")
    | 6 => do
      return ("PSRLDQ_XMMdq_IMMb", "PSRLDQ_XMMdq_IMMb")
    | _ => do
      return ("", "")
  | 0b01110100 => do
    match decoder_form_index with
    | 1 => do
      return ("PCMPEQB_MMXq_MEMq", "PCMPEQB_MMXq_MEMq")
    | 2 => do
      return ("PCMPEQB_MMXq_MMXq", "PCMPEQB_MMXq_MMXq")
    | 3 => do
      return ("PCMPEQB_XMMdq_MEMdq", "PCMPEQB_XMMdq_MEMdq")
    | 4 => do
      return ("PCMPEQB_XMMdq_XMMdq", "PCMPEQB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01110101 => do
    match decoder_form_index with
    | 1 => do
      return ("PCMPEQW_MMXq_MEMq", "PCMPEQW_MMXq_MEMq")
    | 2 => do
      return ("PCMPEQW_MMXq_MMXq", "PCMPEQW_MMXq_MMXq")
    | 3 => do
      return ("PCMPEQW_XMMdq_MEMdq", "PCMPEQW_XMMdq_MEMdq")
    | 4 => do
      return ("PCMPEQW_XMMdq_XMMdq", "PCMPEQW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01110110 => do
    match decoder_form_index with
    | 1 => do
      return ("PCMPEQD_MMXq_MEMq", "PCMPEQD_MMXq_MEMq")
    | 2 => do
      return ("PCMPEQD_MMXq_MMXq", "PCMPEQD_MMXq_MMXq")
    | 3 => do
      return ("PCMPEQD_XMMdq_MEMdq", "PCMPEQD_XMMdq_MEMdq")
    | 4 => do
      return ("PCMPEQD_XMMdq_XMMdq", "PCMPEQD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b01110111 => do
    match decoder_form_index with
    | 1 => do
      return ("EMMS", "EMMS")
    | _ => do
      return ("", "")
  | 0b01111110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVQ_XMMdq_MEMq_0F7E_1", "MOVQ_XMMdq_MEMq_0F7E")
    | 2 => do
      return ("MOVQ_XMMdq_XMMq_0F7E", "MOVQ_XMMdq_XMMq_0F7E")
    | 3 => do
      return ("MOVD_GPR32_MMXd_0", "MOVD_GPR32_MMXd")
    | 4 => do
      return ("MOVD_MEMd_MMXd_0", "MOVD_MEMd_MMXd")
    | 5 => do
      return ("MOVQ_GPR64_MMXq", "MOVQ_GPR64_MMXq")
    | 6 => do
      return ("MOVQ_MEMq_MMXq_0F7E", "MOVQ_MEMq_MMXq_0F7E")
    | 7 => do
      return ("MOVD_GPR32_XMMd_0", "MOVD_GPR32_XMMd")
    | 8 => do
      return ("MOVD_MEMd_XMMd_1", "MOVD_MEMd_XMMd")
    | 9 => do
      return ("MOVQ_GPR64_XMMq", "MOVQ_GPR64_XMMq")
    | 10 => do
      return ("MOVQ_MEMq_XMMq_0F7E_0", "MOVQ_MEMq_XMMq_0F7E")
    | _ => do
      return ("", "")
  | 0b01111111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVDQU_MEMdq_XMMdq", "MOVDQU_MEMdq_XMMdq")
    | 2 => do
      return ("MOVDQU_XMMdq_XMMdq_0F7F", "MOVDQU_XMMdq_XMMdq_0F7F")
    | 3 => do
      return ("MOVDQA_MEMdq_XMMdq", "MOVDQA_MEMdq_XMMdq")
    | 4 => do
      return ("MOVDQA_XMMdq_XMMdq_0F7F", "MOVDQA_XMMdq_XMMdq_0F7F")
    | 5 => do
      return ("MOVQ_MEMq_MMXq_0F7F", "MOVQ_MEMq_MMXq_0F7F")
    | 6 => do
      return ("MOVQ_MMXq_MMXq_0F7F", "MOVQ_MMXq_MMXq_0F7F")
    | _ => do
      return ("", "")
  | 0b10000000 => do
    match decoder_form_index with
    | 1 => do
      return ("JO_RELBRd_0", "JO_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000001 => do
    match decoder_form_index with
    | 1 => do
      return ("JNO_RELBRd_0", "JNO_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000010 => do
    match decoder_form_index with
    | 1 => do
      return ("JB_RELBRd_0", "JB_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000011 => do
    match decoder_form_index with
    | 1 => do
      return ("JNB_RELBRd_0", "JNB_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000100 => do
    match decoder_form_index with
    | 1 => do
      return ("JZ_RELBRd_0", "JZ_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000101 => do
    match decoder_form_index with
    | 1 => do
      return ("JNZ_RELBRd_0", "JNZ_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000110 => do
    match decoder_form_index with
    | 1 => do
      return ("JBE_RELBRd_0", "JBE_RELBRd")
    | _ => do
      return ("", "")
  | 0b10000111 => do
    match decoder_form_index with
    | 1 => do
      return ("JNBE_RELBRd_0", "JNBE_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001000 => do
    match decoder_form_index with
    | 1 => do
      return ("JS_RELBRd_0", "JS_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001001 => do
    match decoder_form_index with
    | 1 => do
      return ("JNS_RELBRd_0", "JNS_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001010 => do
    match decoder_form_index with
    | 1 => do
      return ("JP_RELBRd_0", "JP_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001011 => do
    match decoder_form_index with
    | 1 => do
      return ("JNP_RELBRd_0", "JNP_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001100 => do
    match decoder_form_index with
    | 1 => do
      return ("JL_RELBRd_0", "JL_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001101 => do
    match decoder_form_index with
    | 1 => do
      return ("JNL_RELBRd_0", "JNL_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001110 => do
    match decoder_form_index with
    | 1 => do
      return ("JLE_RELBRd_0", "JLE_RELBRd")
    | _ => do
      return ("", "")
  | 0b10001111 => do
    match decoder_form_index with
    | 1 => do
      return ("JNLE_RELBRd_0", "JNLE_RELBRd")
    | _ => do
      return ("", "")
  | 0b10010000 => do
    match decoder_form_index with
    | 1 => do
      return ("SETO_GPR8", "SETO_GPR8")
    | 2 => do
      return ("SETO_MEMb", "SETO_MEMb")
    | _ => do
      return ("", "")
  | 0b10010001 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNO_GPR8", "SETNO_GPR8")
    | 2 => do
      return ("SETNO_MEMb", "SETNO_MEMb")
    | _ => do
      return ("", "")
  | 0b10010010 => do
    match decoder_form_index with
    | 1 => do
      return ("SETB_GPR8", "SETB_GPR8")
    | 2 => do
      return ("SETB_MEMb", "SETB_MEMb")
    | _ => do
      return ("", "")
  | 0b10010011 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNB_GPR8", "SETNB_GPR8")
    | 2 => do
      return ("SETNB_MEMb", "SETNB_MEMb")
    | _ => do
      return ("", "")
  | 0b10010100 => do
    match decoder_form_index with
    | 1 => do
      return ("SETZ_GPR8", "SETZ_GPR8")
    | 2 => do
      return ("SETZ_MEMb", "SETZ_MEMb")
    | _ => do
      return ("", "")
  | 0b10010101 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNZ_GPR8", "SETNZ_GPR8")
    | 2 => do
      return ("SETNZ_MEMb", "SETNZ_MEMb")
    | _ => do
      return ("", "")
  | 0b10010110 => do
    match decoder_form_index with
    | 1 => do
      return ("SETBE_GPR8", "SETBE_GPR8")
    | 2 => do
      return ("SETBE_MEMb", "SETBE_MEMb")
    | _ => do
      return ("", "")
  | 0b10010111 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNBE_GPR8", "SETNBE_GPR8")
    | 2 => do
      return ("SETNBE_MEMb", "SETNBE_MEMb")
    | _ => do
      return ("", "")
  | 0b10011000 => do
    match decoder_form_index with
    | 1 => do
      return ("SETS_GPR8", "SETS_GPR8")
    | 2 => do
      return ("SETS_MEMb", "SETS_MEMb")
    | _ => do
      return ("", "")
  | 0b10011001 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNS_GPR8", "SETNS_GPR8")
    | 2 => do
      return ("SETNS_MEMb", "SETNS_MEMb")
    | _ => do
      return ("", "")
  | 0b10011010 => do
    match decoder_form_index with
    | 1 => do
      return ("SETP_GPR8", "SETP_GPR8")
    | 2 => do
      return ("SETP_MEMb", "SETP_MEMb")
    | _ => do
      return ("", "")
  | 0b10011011 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNP_GPR8", "SETNP_GPR8")
    | 2 => do
      return ("SETNP_MEMb", "SETNP_MEMb")
    | _ => do
      return ("", "")
  | 0b10011100 => do
    match decoder_form_index with
    | 1 => do
      return ("SETL_GPR8", "SETL_GPR8")
    | 2 => do
      return ("SETL_MEMb", "SETL_MEMb")
    | _ => do
      return ("", "")
  | 0b10011101 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNL_GPR8", "SETNL_GPR8")
    | 2 => do
      return ("SETNL_MEMb", "SETNL_MEMb")
    | _ => do
      return ("", "")
  | 0b10011110 => do
    match decoder_form_index with
    | 1 => do
      return ("SETLE_GPR8", "SETLE_GPR8")
    | 2 => do
      return ("SETLE_MEMb", "SETLE_MEMb")
    | _ => do
      return ("", "")
  | 0b10011111 => do
    match decoder_form_index with
    | 1 => do
      return ("SETNLE_GPR8", "SETNLE_GPR8")
    | 2 => do
      return ("SETNLE_MEMb", "SETNLE_MEMb")
    | _ => do
      return ("", "")
  | 0b10100000 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_FS", "PUSH_FS")
    | _ => do
      return ("", "")
  | 0b10100001 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_FS", "POP_FS")
    | _ => do
      return ("", "")
  | 0b10100010 => do
    match decoder_form_index with
    | 1 => do
      return ("CPUID", "CPUID")
    | _ => do
      return ("", "")
  | 0b10100011 => do
    match decoder_form_index with
    | 1 => do
      return ("BT_GPRv_GPRv", "BT_GPRv_GPRv")
    | 2 => do
      return ("BT_MEMv_GPRv", "BT_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10100100 => do
    match decoder_form_index with
    | 1 => do
      return ("SHLD_GPRv_GPRv_IMMb", "SHLD_GPRv_GPRv_IMMb")
    | 2 => do
      return ("SHLD_MEMv_GPRv_IMMb", "SHLD_MEMv_GPRv_IMMb")
    | _ => do
      return ("", "")
  | 0b10100101 => do
    match decoder_form_index with
    | 1 => do
      return ("SHLD_GPRv_GPRv_CL", "SHLD_GPRv_GPRv_CL")
    | 2 => do
      return ("SHLD_MEMv_GPRv_CL", "SHLD_MEMv_GPRv_CL")
    | _ => do
      return ("", "")
  | 0b10101000 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GS", "PUSH_GS")
    | _ => do
      return ("", "")
  | 0b10101001 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GS", "POP_GS")
    | _ => do
      return ("", "")
  | 0b10101011 => do
    match decoder_form_index with
    | 1 => do
      return ("BTS_GPRv_GPRv", "BTS_GPRv_GPRv")
    | 2 => do
      return ("BTS_MEMv_GPRv", "BTS_MEMv_GPRv")
    | 3 => do
      return ("BTS_LOCK_MEMv_GPRv", "BTS_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10101100 => do
    match decoder_form_index with
    | 1 => do
      return ("SHRD_GPRv_GPRv_IMMb", "SHRD_GPRv_GPRv_IMMb")
    | 2 => do
      return ("SHRD_MEMv_GPRv_IMMb", "SHRD_MEMv_GPRv_IMMb")
    | _ => do
      return ("", "")
  | 0b10101101 => do
    match decoder_form_index with
    | 1 => do
      return ("SHRD_GPRv_GPRv_CL", "SHRD_GPRv_GPRv_CL")
    | 2 => do
      return ("SHRD_MEMv_GPRv_CL", "SHRD_MEMv_GPRv_CL")
    | _ => do
      return ("", "")
  | 0b10101110 => do
    match decoder_form_index with
    | 1 => do
      return ("LDMXCSR_MEMd", "LDMXCSR_MEMd")
    | 2 => do
      return ("STMXCSR_MEMd", "STMXCSR_MEMd")
    | 3 => do
      return ("CLFLUSH_MEMmprefetch", "CLFLUSH_MEMmprefetch")
    | 4 => do
      return ("LFENCE", "LFENCE")
    | 5 => do
      return ("SFENCE", "SFENCE")
    | 6 => do
      return ("MFENCE", "MFENCE")
    | 7 => do
      return ("FXRSTOR_MEMmfpxenv", "FXRSTOR_MEMmfpxenv")
    | 8 => do
      return ("FXRSTOR64_MEMmfpxenv", "FXRSTOR64_MEMmfpxenv")
    | 9 => do
      return ("FXSAVE_MEMmfpxenv", "FXSAVE_MEMmfpxenv")
    | 10 => do
      return ("FXSAVE64_MEMmfpxenv", "FXSAVE64_MEMmfpxenv")
    | _ => do
      return ("", "")
  | 0b10101111 => do
    match decoder_form_index with
    | 1 => do
      return ("IMUL_GPRv_GPRv", "IMUL_GPRv_GPRv")
    | 2 => do
      return ("IMUL_GPRv_MEMv", "IMUL_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b10110000 => do
    match decoder_form_index with
    | 1 => do
      return ("CMPXCHG_GPR8_GPR8", "CMPXCHG_GPR8_GPR8")
    | 2 => do
      return ("CMPXCHG_MEMb_GPR8", "CMPXCHG_MEMb_GPR8")
    | 3 => do
      return ("CMPXCHG_LOCK_MEMb_GPR8", "CMPXCHG_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b10110001 => do
    match decoder_form_index with
    | 1 => do
      return ("CMPXCHG_GPRv_GPRv", "CMPXCHG_GPRv_GPRv")
    | 2 => do
      return ("CMPXCHG_MEMv_GPRv", "CMPXCHG_MEMv_GPRv")
    | 3 => do
      return ("CMPXCHG_LOCK_MEMv_GPRv", "CMPXCHG_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10110010 => do
    match decoder_form_index with
    | 1 => do
      return ("LSS_GPRv_MEMp2", "LSS_GPRv_MEMp2")
    | _ => do
      return ("", "")
  | 0b10110011 => do
    match decoder_form_index with
    | 1 => do
      return ("BTR_GPRv_GPRv", "BTR_GPRv_GPRv")
    | 2 => do
      return ("BTR_MEMv_GPRv", "BTR_MEMv_GPRv")
    | 3 => do
      return ("BTR_LOCK_MEMv_GPRv", "BTR_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10110100 => do
    match decoder_form_index with
    | 1 => do
      return ("LFS_GPRv_MEMp2", "LFS_GPRv_MEMp2")
    | _ => do
      return ("", "")
  | 0b10110101 => do
    match decoder_form_index with
    | 1 => do
      return ("LGS_GPRv_MEMp2", "LGS_GPRv_MEMp2")
    | _ => do
      return ("", "")
  | 0b10110110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVZX_GPRv_GPR8", "MOVZX_GPRv_GPR8")
    | 2 => do
      return ("MOVZX_GPRv_MEMb_1", "MOVZX_GPRv_MEMb")
    | _ => do
      return ("", "")
  | 0b10110111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVZX_GPR16_MEMw", "MOVZX_GPR16_MEMw")
    | 2 => do
      return ("MOVZX_GPR32_MEMw_0", "MOVZX_GPR32_MEMw")
    | 3 => do
      return ("MOVZX_GPR64_MEMw_0", "MOVZX_GPR64_MEMw")
    | 4 => do
      return ("MOVZX_GPRv_GPR16", "MOVZX_GPRv_GPR16")
    | _ => do
      return ("", "")
  | 0b10111001 => do
    match decoder_form_index with
    | 1 => do
      return ("UD1_GPR32_GPR32", "UD1_GPR32_GPR32")
    | 2 => do
      return ("UD1_GPR32_MEMd", "UD1_GPR32_MEMd")
    | _ => do
      return ("", "")
  | 0b10111010 => do
    match decoder_form_index with
    | 1 => do
      return ("BTS_GPRv_IMMb", "BTS_GPRv_IMMb")
    | 2 => do
      return ("BTS_MEMv_IMMb", "BTS_MEMv_IMMb")
    | 3 => do
      return ("BTS_LOCK_MEMv_IMMb", "BTS_LOCK_MEMv_IMMb")
    | 4 => do
      return ("BTR_GPRv_IMMb", "BTR_GPRv_IMMb")
    | 5 => do
      return ("BTR_MEMv_IMMb", "BTR_MEMv_IMMb")
    | 6 => do
      return ("BTR_LOCK_MEMv_IMMb", "BTR_LOCK_MEMv_IMMb")
    | 7 => do
      return ("BTC_GPRv_IMMb", "BTC_GPRv_IMMb")
    | 8 => do
      return ("BTC_MEMv_IMMb", "BTC_MEMv_IMMb")
    | 9 => do
      return ("BTC_LOCK_MEMv_IMMb", "BTC_LOCK_MEMv_IMMb")
    | 10 => do
      return ("BT_GPRv_IMMb", "BT_GPRv_IMMb")
    | 11 => do
      return ("BT_MEMv_IMMb", "BT_MEMv_IMMb")
    | _ => do
      return ("", "")
  | 0b10111011 => do
    match decoder_form_index with
    | 1 => do
      return ("BTC_GPRv_GPRv", "BTC_GPRv_GPRv")
    | 2 => do
      return ("BTC_MEMv_GPRv", "BTC_MEMv_GPRv")
    | 3 => do
      return ("BTC_LOCK_MEMv_GPRv", "BTC_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10111100 => do
    match decoder_form_index with
    | 1 => do
      return ("BSF_GPRv_GPRv_0", "BSF_GPRv_GPRv")
    | 2 => do
      return ("BSF_GPRv_MEMv_0", "BSF_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b10111101 => do
    match decoder_form_index with
    | 1 => do
      return ("LZCNT_GPRv_GPRv", "LZCNT_GPRv_GPRv")
    | 2 => do
      return ("LZCNT_GPRv_MEMv", "LZCNT_GPRv_MEMv")
    | 3 => do
      return ("BSR_GPRv_GPRv_0", "BSR_GPRv_GPRv")
    | 4 => do
      return ("BSR_GPRv_MEMv_0", "BSR_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b10111110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVSX_GPRv_GPR8", "MOVSX_GPRv_GPR8")
    | 2 => do
      return ("MOVSX_GPRv_MEMb_1", "MOVSX_GPRv_MEMb")
    | _ => do
      return ("", "")
  | 0b10111111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVSX_GPR16_MEMw", "MOVSX_GPR16_MEMw")
    | 2 => do
      return ("MOVSX_GPR32_MEMw_0", "MOVSX_GPR32_MEMw")
    | 3 => do
      return ("MOVSX_GPR64_MEMw_0", "MOVSX_GPR64_MEMw")
    | 4 => do
      return ("MOVSX_GPRv_GPR16", "MOVSX_GPRv_GPR16")
    | _ => do
      return ("", "")
  | 0b11000000 => do
    match decoder_form_index with
    | 1 => do
      return ("XADD_GPR8_GPR8", "XADD_GPR8_GPR8")
    | 2 => do
      return ("XADD_MEMb_GPR8", "XADD_MEMb_GPR8")
    | 3 => do
      return ("XADD_LOCK_MEMb_GPR8", "XADD_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b11000001 => do
    match decoder_form_index with
    | 1 => do
      return ("XADD_GPRv_GPRv", "XADD_GPRv_GPRv")
    | 2 => do
      return ("XADD_MEMv_GPRv", "XADD_MEMv_GPRv")
    | 3 => do
      return ("XADD_LOCK_MEMv_GPRv", "XADD_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b11000010 => do
    match decoder_form_index with
    | 1 => do
      return ("CMPPS_XMMps_MEMps_IMMb", "CMPPS_XMMps_MEMps_IMMb")
    | 2 => do
      return ("CMPPS_XMMps_XMMps_IMMb", "CMPPS_XMMps_XMMps_IMMb")
    | 3 => do
      return ("CMPPD_XMMpd_MEMpd_IMMb", "CMPPD_XMMpd_MEMpd_IMMb")
    | 4 => do
      return ("CMPPD_XMMpd_XMMpd_IMMb", "CMPPD_XMMpd_XMMpd_IMMb")
    | 5 => do
      return ("CMPSS_XMMss_MEMss_IMMb", "CMPSS_XMMss_MEMss_IMMb")
    | 6 => do
      return ("CMPSS_XMMss_XMMss_IMMb", "CMPSS_XMMss_XMMss_IMMb")
    | 7 => do
      return ("CMPSD_XMM_XMMsd_MEMsd_IMMb", "CMPSD_XMM_XMMsd_MEMsd_IMMb")
    | 8 => do
      return ("CMPSD_XMM_XMMsd_XMMsd_IMMb", "CMPSD_XMM_XMMsd_XMMsd_IMMb")
    | _ => do
      return ("", "")
  | 0b11000011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVNTI_MEMd_GPR32_1", "MOVNTI_MEMd_GPR32")
    | 2 => do
      return ("MOVNTI_MEMq_GPR64", "MOVNTI_MEMq_GPR64")
    | _ => do
      return ("", "")
  | 0b11000100 => do
    match decoder_form_index with
    | 1 => do
      return ("PINSRW_MMXq_GPR32_IMMb", "PINSRW_MMXq_GPR32_IMMb")
    | 2 => do
      return ("PINSRW_MMXq_MEMw_IMMb", "PINSRW_MMXq_MEMw_IMMb")
    | 3 => do
      return ("PINSRW_XMMdq_GPR32_IMMb", "PINSRW_XMMdq_GPR32_IMMb")
    | 4 => do
      return ("PINSRW_XMMdq_MEMw_IMMb", "PINSRW_XMMdq_MEMw_IMMb")
    | _ => do
      return ("", "")
  | 0b11000101 => do
    match decoder_form_index with
    | 1 => do
      return ("PEXTRW_GPR32_MMXq_IMMb", "PEXTRW_GPR32_MMXq_IMMb")
    | 2 => do
      return ("PEXTRW_GPR32_XMMdq_IMMb", "PEXTRW_GPR32_XMMdq_IMMb")
    | _ => do
      return ("", "")
  | 0b11000110 => do
    match decoder_form_index with
    | 1 => do
      return ("SHUFPD_XMMpd_MEMpd_IMMb", "SHUFPD_XMMpd_MEMpd_IMMb")
    | 2 => do
      return ("SHUFPD_XMMpd_XMMpd_IMMb", "SHUFPD_XMMpd_XMMpd_IMMb")
    | 3 => do
      return ("SHUFPS_XMMps_MEMps_IMMb", "SHUFPS_XMMps_MEMps_IMMb")
    | 4 => do
      return ("SHUFPS_XMMps_XMMps_IMMb", "SHUFPS_XMMps_XMMps_IMMb")
    | _ => do
      return ("", "")
  | 0b11000111 => do
    match decoder_form_index with
    | 1 => do
      return ("CMPXCHG16B_MEMdq", "CMPXCHG16B_MEMdq")
    | 2 => do
      return ("CMPXCHG8B_MEMq_1", "CMPXCHG8B_MEMq")
    | 3 => do
      return ("CMPXCHG16B_LOCK_MEMdq", "CMPXCHG16B_LOCK_MEMdq")
    | 4 => do
      return ("CMPXCHG8B_LOCK_MEMq_1", "CMPXCHG8B_LOCK_MEMq")
    | _ => do
      return ("", "")
  | 0b11001000 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001001 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001010 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001011 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001100 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001101 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001110 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11001111 => do
    match decoder_form_index with
    | 1 => do
      return ("BSWAP_GPRv", "BSWAP_GPRv")
    | _ => do
      return ("", "")
  | 0b11010001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSRLW_MMXq_MEMq", "PSRLW_MMXq_MEMq")
    | 2 => do
      return ("PSRLW_MMXq_MMXq", "PSRLW_MMXq_MMXq")
    | 3 => do
      return ("PSRLW_XMMdq_MEMdq", "PSRLW_XMMdq_MEMdq")
    | 4 => do
      return ("PSRLW_XMMdq_XMMdq", "PSRLW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11010010 => do
    match decoder_form_index with
    | 1 => do
      return ("PSRLD_MMXq_MEMq", "PSRLD_MMXq_MEMq")
    | 2 => do
      return ("PSRLD_MMXq_MMXq", "PSRLD_MMXq_MMXq")
    | 3 => do
      return ("PSRLD_XMMdq_MEMdq", "PSRLD_XMMdq_MEMdq")
    | 4 => do
      return ("PSRLD_XMMdq_XMMdq", "PSRLD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11010011 => do
    match decoder_form_index with
    | 1 => do
      return ("PSRLQ_MMXq_MEMq", "PSRLQ_MMXq_MEMq")
    | 2 => do
      return ("PSRLQ_MMXq_MMXq", "PSRLQ_MMXq_MMXq")
    | 3 => do
      return ("PSRLQ_XMMdq_MEMdq", "PSRLQ_XMMdq_MEMdq")
    | 4 => do
      return ("PSRLQ_XMMdq_XMMdq", "PSRLQ_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11010100 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDQ_MMXq_MEMq", "PADDQ_MMXq_MEMq")
    | 2 => do
      return ("PADDQ_MMXq_MMXq", "PADDQ_MMXq_MMXq")
    | 3 => do
      return ("PADDQ_XMMdq_MEMdq", "PADDQ_XMMdq_MEMdq")
    | 4 => do
      return ("PADDQ_XMMdq_XMMdq", "PADDQ_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11010101 => do
    match decoder_form_index with
    | 1 => do
      return ("PMULLW_MMXq_MEMq", "PMULLW_MMXq_MEMq")
    | 2 => do
      return ("PMULLW_MMXq_MMXq", "PMULLW_MMXq_MMXq")
    | 3 => do
      return ("PMULLW_XMMdq_MEMdq", "PMULLW_XMMdq_MEMdq")
    | 4 => do
      return ("PMULLW_XMMdq_XMMdq", "PMULLW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11010110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVQ_MEMq_XMMq_0FD6_1", "MOVQ_MEMq_XMMq_0FD6")
    | 2 => do
      return ("MOVQ_XMMdq_XMMq_0FD6", "MOVQ_XMMdq_XMMq_0FD6")
    | 3 => do
      return ("MOVDQ2Q_MMXq_XMMq", "MOVDQ2Q_MMXq_XMMq")
    | 4 => do
      return ("MOVQ2DQ_XMMdq_MMXq", "MOVQ2DQ_XMMdq_MMXq")
    | _ => do
      return ("", "")
  | 0b11010111 => do
    match decoder_form_index with
    | 1 => do
      return ("PMOVMSKB_GPR32_MMXq", "PMOVMSKB_GPR32_MMXq")
    | 2 => do
      return ("PMOVMSKB_GPR32_XMMdq", "PMOVMSKB_GPR32_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011000 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBUSB_MMXq_MEMq", "PSUBUSB_MMXq_MEMq")
    | 2 => do
      return ("PSUBUSB_MMXq_MMXq", "PSUBUSB_MMXq_MMXq")
    | 3 => do
      return ("PSUBUSB_XMMdq_MEMdq", "PSUBUSB_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBUSB_XMMdq_XMMdq", "PSUBUSB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBUSW_MMXq_MEMq", "PSUBUSW_MMXq_MEMq")
    | 2 => do
      return ("PSUBUSW_MMXq_MMXq", "PSUBUSW_MMXq_MMXq")
    | 3 => do
      return ("PSUBUSW_XMMdq_MEMdq", "PSUBUSW_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBUSW_XMMdq_XMMdq", "PSUBUSW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011010 => do
    match decoder_form_index with
    | 1 => do
      return ("PMINUB_MMXq_MEMq", "PMINUB_MMXq_MEMq")
    | 2 => do
      return ("PMINUB_MMXq_MMXq", "PMINUB_MMXq_MMXq")
    | 3 => do
      return ("PMINUB_XMMdq_MEMdq", "PMINUB_XMMdq_MEMdq")
    | 4 => do
      return ("PMINUB_XMMdq_XMMdq", "PMINUB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011011 => do
    match decoder_form_index with
    | 1 => do
      return ("PAND_MMXq_MEMq", "PAND_MMXq_MEMq")
    | 2 => do
      return ("PAND_MMXq_MMXq", "PAND_MMXq_MMXq")
    | 3 => do
      return ("PAND_XMMdq_MEMdq", "PAND_XMMdq_MEMdq")
    | 4 => do
      return ("PAND_XMMdq_XMMdq", "PAND_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011100 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDUSB_MMXq_MEMq", "PADDUSB_MMXq_MEMq")
    | 2 => do
      return ("PADDUSB_MMXq_MMXq", "PADDUSB_MMXq_MMXq")
    | 3 => do
      return ("PADDUSB_XMMdq_MEMdq", "PADDUSB_XMMdq_MEMdq")
    | 4 => do
      return ("PADDUSB_XMMdq_XMMdq", "PADDUSB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011101 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDUSW_MMXq_MEMq", "PADDUSW_MMXq_MEMq")
    | 2 => do
      return ("PADDUSW_MMXq_MMXq", "PADDUSW_MMXq_MMXq")
    | 3 => do
      return ("PADDUSW_XMMdq_MEMdq", "PADDUSW_XMMdq_MEMdq")
    | 4 => do
      return ("PADDUSW_XMMdq_XMMdq", "PADDUSW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011110 => do
    match decoder_form_index with
    | 1 => do
      return ("PMAXUB_MMXq_MEMq", "PMAXUB_MMXq_MEMq")
    | 2 => do
      return ("PMAXUB_MMXq_MMXq", "PMAXUB_MMXq_MMXq")
    | 3 => do
      return ("PMAXUB_XMMdq_MEMdq", "PMAXUB_XMMdq_MEMdq")
    | 4 => do
      return ("PMAXUB_XMMdq_XMMdq", "PMAXUB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11011111 => do
    match decoder_form_index with
    | 1 => do
      return ("PANDN_MMXq_MEMq", "PANDN_MMXq_MEMq")
    | 2 => do
      return ("PANDN_MMXq_MMXq", "PANDN_MMXq_MMXq")
    | 3 => do
      return ("PANDN_XMMdq_MEMdq", "PANDN_XMMdq_MEMdq")
    | 4 => do
      return ("PANDN_XMMdq_XMMdq", "PANDN_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100000 => do
    match decoder_form_index with
    | 1 => do
      return ("PAVGB_MMXq_MEMq", "PAVGB_MMXq_MEMq")
    | 2 => do
      return ("PAVGB_MMXq_MMXq", "PAVGB_MMXq_MMXq")
    | 3 => do
      return ("PAVGB_XMMdq_MEMdq", "PAVGB_XMMdq_MEMdq")
    | 4 => do
      return ("PAVGB_XMMdq_XMMdq", "PAVGB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSRAW_MMXq_MEMq", "PSRAW_MMXq_MEMq")
    | 2 => do
      return ("PSRAW_MMXq_MMXq", "PSRAW_MMXq_MMXq")
    | 3 => do
      return ("PSRAW_XMMdq_MEMdq", "PSRAW_XMMdq_MEMdq")
    | 4 => do
      return ("PSRAW_XMMdq_XMMdq", "PSRAW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100010 => do
    match decoder_form_index with
    | 1 => do
      return ("PSRAD_MMXq_MEMq", "PSRAD_MMXq_MEMq")
    | 2 => do
      return ("PSRAD_MMXq_MMXq", "PSRAD_MMXq_MMXq")
    | 3 => do
      return ("PSRAD_XMMdq_MEMdq", "PSRAD_XMMdq_MEMdq")
    | 4 => do
      return ("PSRAD_XMMdq_XMMdq", "PSRAD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100011 => do
    match decoder_form_index with
    | 1 => do
      return ("PAVGW_MMXq_MEMq", "PAVGW_MMXq_MEMq")
    | 2 => do
      return ("PAVGW_MMXq_MMXq", "PAVGW_MMXq_MMXq")
    | 3 => do
      return ("PAVGW_XMMdq_MEMdq", "PAVGW_XMMdq_MEMdq")
    | 4 => do
      return ("PAVGW_XMMdq_XMMdq", "PAVGW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100100 => do
    match decoder_form_index with
    | 1 => do
      return ("PMULHUW_MMXq_MEMq", "PMULHUW_MMXq_MEMq")
    | 2 => do
      return ("PMULHUW_MMXq_MMXq", "PMULHUW_MMXq_MMXq")
    | 3 => do
      return ("PMULHUW_XMMdq_MEMdq", "PMULHUW_XMMdq_MEMdq")
    | 4 => do
      return ("PMULHUW_XMMdq_XMMdq", "PMULHUW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100101 => do
    match decoder_form_index with
    | 1 => do
      return ("PMULHW_MMXq_MEMq", "PMULHW_MMXq_MEMq")
    | 2 => do
      return ("PMULHW_MMXq_MMXq", "PMULHW_MMXq_MMXq")
    | 3 => do
      return ("PMULHW_XMMdq_MEMdq", "PMULHW_XMMdq_MEMdq")
    | 4 => do
      return ("PMULHW_XMMdq_XMMdq", "PMULHW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11100110 => do
    match decoder_form_index with
    | 1 => do
      return ("CVTDQ2PD_XMMpd_MEMq", "CVTDQ2PD_XMMpd_MEMq")
    | 2 => do
      return ("CVTDQ2PD_XMMpd_XMMq", "CVTDQ2PD_XMMpd_XMMq")
    | 3 => do
      return ("CVTTPD2DQ_XMMdq_MEMpd", "CVTTPD2DQ_XMMdq_MEMpd")
    | 4 => do
      return ("CVTTPD2DQ_XMMdq_XMMpd", "CVTTPD2DQ_XMMdq_XMMpd")
    | 5 => do
      return ("CVTPD2DQ_XMMdq_MEMpd", "CVTPD2DQ_XMMdq_MEMpd")
    | 6 => do
      return ("CVTPD2DQ_XMMdq_XMMpd", "CVTPD2DQ_XMMdq_XMMpd")
    | _ => do
      return ("", "")
  | 0b11100111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVNTDQ_MEMdq_XMMdq", "MOVNTDQ_MEMdq_XMMdq")
    | 2 => do
      return ("MOVNTQ_MEMq_MMXq", "MOVNTQ_MEMq_MMXq")
    | _ => do
      return ("", "")
  | 0b11101000 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBSB_MMXq_MEMq", "PSUBSB_MMXq_MEMq")
    | 2 => do
      return ("PSUBSB_MMXq_MMXq", "PSUBSB_MMXq_MMXq")
    | 3 => do
      return ("PSUBSB_XMMdq_MEMdq", "PSUBSB_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBSB_XMMdq_XMMdq", "PSUBSB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBSW_MMXq_MEMq", "PSUBSW_MMXq_MEMq")
    | 2 => do
      return ("PSUBSW_MMXq_MMXq", "PSUBSW_MMXq_MMXq")
    | 3 => do
      return ("PSUBSW_XMMdq_MEMdq", "PSUBSW_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBSW_XMMdq_XMMdq", "PSUBSW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101010 => do
    match decoder_form_index with
    | 1 => do
      return ("PMINSW_MMXq_MEMq", "PMINSW_MMXq_MEMq")
    | 2 => do
      return ("PMINSW_MMXq_MMXq", "PMINSW_MMXq_MMXq")
    | 3 => do
      return ("PMINSW_XMMdq_MEMdq", "PMINSW_XMMdq_MEMdq")
    | 4 => do
      return ("PMINSW_XMMdq_XMMdq", "PMINSW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101011 => do
    match decoder_form_index with
    | 1 => do
      return ("POR_MMXq_MEMq", "POR_MMXq_MEMq")
    | 2 => do
      return ("POR_MMXq_MMXq", "POR_MMXq_MMXq")
    | 3 => do
      return ("POR_XMMdq_MEMdq", "POR_XMMdq_MEMdq")
    | 4 => do
      return ("POR_XMMdq_XMMdq", "POR_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101100 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDSB_MMXq_MEMq", "PADDSB_MMXq_MEMq")
    | 2 => do
      return ("PADDSB_MMXq_MMXq", "PADDSB_MMXq_MMXq")
    | 3 => do
      return ("PADDSB_XMMdq_MEMdq", "PADDSB_XMMdq_MEMdq")
    | 4 => do
      return ("PADDSB_XMMdq_XMMdq", "PADDSB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101101 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDSW_MMXq_MEMq", "PADDSW_MMXq_MEMq")
    | 2 => do
      return ("PADDSW_MMXq_MMXq", "PADDSW_MMXq_MMXq")
    | 3 => do
      return ("PADDSW_XMMdq_MEMdq", "PADDSW_XMMdq_MEMdq")
    | 4 => do
      return ("PADDSW_XMMdq_XMMdq", "PADDSW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101110 => do
    match decoder_form_index with
    | 1 => do
      return ("PMAXSW_MMXq_MEMq", "PMAXSW_MMXq_MEMq")
    | 2 => do
      return ("PMAXSW_MMXq_MMXq", "PMAXSW_MMXq_MMXq")
    | 3 => do
      return ("PMAXSW_XMMdq_MEMdq", "PMAXSW_XMMdq_MEMdq")
    | 4 => do
      return ("PMAXSW_XMMdq_XMMdq", "PMAXSW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11101111 => do
    match decoder_form_index with
    | 1 => do
      return ("PXOR_MMXq_MEMq", "PXOR_MMXq_MEMq")
    | 2 => do
      return ("PXOR_MMXq_MMXq", "PXOR_MMXq_MMXq")
    | 3 => do
      return ("PXOR_XMMdq_MEMdq", "PXOR_XMMdq_MEMdq")
    | 4 => do
      return ("PXOR_XMMdq_XMMdq", "PXOR_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSLLW_MMXq_MEMq", "PSLLW_MMXq_MEMq")
    | 2 => do
      return ("PSLLW_MMXq_MMXq", "PSLLW_MMXq_MMXq")
    | 3 => do
      return ("PSLLW_XMMdq_MEMdq", "PSLLW_XMMdq_MEMdq")
    | 4 => do
      return ("PSLLW_XMMdq_XMMdq", "PSLLW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110010 => do
    match decoder_form_index with
    | 1 => do
      return ("PSLLD_MMXq_MEMq", "PSLLD_MMXq_MEMq")
    | 2 => do
      return ("PSLLD_MMXq_MMXq", "PSLLD_MMXq_MMXq")
    | 3 => do
      return ("PSLLD_XMMdq_MEMdq", "PSLLD_XMMdq_MEMdq")
    | 4 => do
      return ("PSLLD_XMMdq_XMMdq", "PSLLD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110011 => do
    match decoder_form_index with
    | 1 => do
      return ("PSLLQ_MMXq_MEMq", "PSLLQ_MMXq_MEMq")
    | 2 => do
      return ("PSLLQ_MMXq_MMXq", "PSLLQ_MMXq_MMXq")
    | 3 => do
      return ("PSLLQ_XMMdq_MEMdq", "PSLLQ_XMMdq_MEMdq")
    | 4 => do
      return ("PSLLQ_XMMdq_XMMdq", "PSLLQ_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110100 => do
    match decoder_form_index with
    | 1 => do
      return ("PMULUDQ_MMXq_MEMq", "PMULUDQ_MMXq_MEMq")
    | 2 => do
      return ("PMULUDQ_MMXq_MMXq", "PMULUDQ_MMXq_MMXq")
    | 3 => do
      return ("PMULUDQ_XMMdq_MEMdq", "PMULUDQ_XMMdq_MEMdq")
    | 4 => do
      return ("PMULUDQ_XMMdq_XMMdq", "PMULUDQ_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110101 => do
    match decoder_form_index with
    | 1 => do
      return ("PMADDWD_MMXq_MEMq", "PMADDWD_MMXq_MEMq")
    | 2 => do
      return ("PMADDWD_MMXq_MMXq", "PMADDWD_MMXq_MMXq")
    | 3 => do
      return ("PMADDWD_XMMdq_MEMdq", "PMADDWD_XMMdq_MEMdq")
    | 4 => do
      return ("PMADDWD_XMMdq_XMMdq", "PMADDWD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110110 => do
    match decoder_form_index with
    | 1 => do
      return ("PSADBW_MMXq_MEMq", "PSADBW_MMXq_MEMq")
    | 2 => do
      return ("PSADBW_MMXq_MMXq", "PSADBW_MMXq_MMXq")
    | 3 => do
      return ("PSADBW_XMMdq_MEMdq", "PSADBW_XMMdq_MEMdq")
    | 4 => do
      return ("PSADBW_XMMdq_XMMdq", "PSADBW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11110111 => do
    match decoder_form_index with
    | 1 => do
      return ("MASKMOVQ_MMXq_MMXq", "MASKMOVQ_MMXq_MMXq")
    | 2 => do
      return ("MASKMOVDQU_XMMxub_XMMxub", "MASKMOVDQU_XMMxub_XMMxub")
    | _ => do
      return ("", "")
  | 0b11111000 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBB_MMXq_MEMq", "PSUBB_MMXq_MEMq")
    | 2 => do
      return ("PSUBB_MMXq_MMXq", "PSUBB_MMXq_MMXq")
    | 3 => do
      return ("PSUBB_XMMdq_MEMdq", "PSUBB_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBB_XMMdq_XMMdq", "PSUBB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111001 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBW_MMXq_MEMq", "PSUBW_MMXq_MEMq")
    | 2 => do
      return ("PSUBW_MMXq_MMXq", "PSUBW_MMXq_MMXq")
    | 3 => do
      return ("PSUBW_XMMdq_MEMdq", "PSUBW_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBW_XMMdq_XMMdq", "PSUBW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111010 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBD_MMXq_MEMq", "PSUBD_MMXq_MEMq")
    | 2 => do
      return ("PSUBD_MMXq_MMXq", "PSUBD_MMXq_MMXq")
    | 3 => do
      return ("PSUBD_XMMdq_MEMdq", "PSUBD_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBD_XMMdq_XMMdq", "PSUBD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111011 => do
    match decoder_form_index with
    | 1 => do
      return ("PSUBQ_MMXq_MEMq", "PSUBQ_MMXq_MEMq")
    | 2 => do
      return ("PSUBQ_MMXq_MMXq", "PSUBQ_MMXq_MMXq")
    | 3 => do
      return ("PSUBQ_XMMdq_MEMdq", "PSUBQ_XMMdq_MEMdq")
    | 4 => do
      return ("PSUBQ_XMMdq_XMMdq", "PSUBQ_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111100 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDB_MMXq_MEMq", "PADDB_MMXq_MEMq")
    | 2 => do
      return ("PADDB_MMXq_MMXq", "PADDB_MMXq_MMXq")
    | 3 => do
      return ("PADDB_XMMdq_MEMdq", "PADDB_XMMdq_MEMdq")
    | 4 => do
      return ("PADDB_XMMdq_XMMdq", "PADDB_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111101 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDW_MMXq_MEMq", "PADDW_MMXq_MEMq")
    | 2 => do
      return ("PADDW_MMXq_MMXq", "PADDW_MMXq_MMXq")
    | 3 => do
      return ("PADDW_XMMdq_MEMdq", "PADDW_XMMdq_MEMdq")
    | 4 => do
      return ("PADDW_XMMdq_XMMdq", "PADDW_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111110 => do
    match decoder_form_index with
    | 1 => do
      return ("PADDD_MMXq_MEMq", "PADDD_MMXq_MEMq")
    | 2 => do
      return ("PADDD_MMXq_MMXq", "PADDD_MMXq_MMXq")
    | 3 => do
      return ("PADDD_XMMdq_MEMdq", "PADDD_XMMdq_MEMdq")
    | 4 => do
      return ("PADDD_XMMdq_XMMdq", "PADDD_XMMdq_XMMdq")
    | _ => do
      return ("", "")
  | 0b11111111 => do
    match decoder_form_index with
    | 1 => do
      return ("UD0_GPR32_GPR32", "UD0_GPR32_GPR32")
    | 2 => do
      return ("UD0_GPR32_MEMd", "UD0_GPR32_MEMd")
    | _ => do
      return ("", "")
  | _ => do
    return ("", "")

@[noinline, nospecialize]
def Decode_Legacy_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  if context.rex2_prefix_present then
    Runtime.liftTotal (Unimplemented_Feature "unselected REX2 instruction form" false true)
  else
    let opcode : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)
    -- Intel SDM 325462-093, blank two-byte opcodes are reserved (Table A-3, PDF2997-3000), reserved opcode #UD Vol.3A7-32 (PDF3382)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 4) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 10) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 12) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 36) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 37) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 38) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 39) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 54) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 57) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 59) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 60) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 61) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 62) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 63) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 122) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 123) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 166) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 167) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 124 and not context.osz_prefix_present and context.rep_prefix == 0) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 125 and not context.osz_prefix_present and context.rep_prefix == 0) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 184 and not context.osz_prefix_present and context.rep_prefix == 0) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 208 and not context.osz_prefix_present and context.rep_prefix == 0) then
      liftM (Report_Invalid_Opcode)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 240 and not context.osz_prefix_present and context.rep_prefix == 0) then
      liftM (Report_Invalid_Opcode)
    match Unsigned opcode with
    | 0b00000000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_00 ip context)
    | 0b00000001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_01 ip context)
    | 0b00000010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_02 ip context)
    | 0b00000011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_03 ip context)
    | 0b00000101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_05 ip context)
    | 0b00000110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_06 ip context)
    | 0b00000111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_07 ip context)
    | 0b00001000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_08 ip context)
    | 0b00001001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_09 ip context)
    | 0b00001011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_0B ip context)
    | 0b00001101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_0D ip context)
    | 0b00010000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_10 ip context)
    | 0b00010001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_11 ip context)
    | 0b00010010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_12 ip context)
    | 0b00010011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_13 ip context)
    | 0b00010100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_14 ip context)
    | 0b00010101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_15 ip context)
    | 0b00010110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_16 ip context)
    | 0b00010111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_17 ip context)
    | 0b00011000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_18 ip context)
    | 0b00011001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_19 ip context)
    | 0b00011010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_1A ip context)
    | 0b00011011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_1B ip context)
    | 0b00011100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_1C ip context)
    | 0b00011101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_1D ip context)
    | 0b00011110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_1E ip context)
    | 0b00011111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_1F ip context)
    | 0b00100000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_20 ip context)
    | 0b00100001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_21 ip context)
    | 0b00100010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_22 ip context)
    | 0b00100011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_23 ip context)
    | 0b00101000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_28 ip context)
    | 0b00101001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_29 ip context)
    | 0b00101010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_2A ip context)
    | 0b00101011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_2B ip context)
    | 0b00101100 => do
      Decode_Legacy_1_Opcode_2C ip context
    | 0b00101101 => do
      Decode_Legacy_1_Opcode_2D ip context
    | 0b00101110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_2E ip context)
    | 0b00101111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_2F ip context)
    | 0b00110000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_30 ip context)
    | 0b00110001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_31 ip context)
    | 0b00110010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_32 ip context)
    | 0b01000000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_40 ip context opcode)
    | 0b01000001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_41 ip context opcode)
    | 0b01000010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_42 ip context opcode)
    | 0b01000011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_43 ip context opcode)
    | 0b01000100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_44 ip context opcode)
    | 0b01000101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_45 ip context opcode)
    | 0b01000110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_46 ip context opcode)
    | 0b01000111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_47 ip context opcode)
    | 0b01001000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_48 ip context opcode)
    | 0b01001001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_49 ip context opcode)
    | 0b01001010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_4A ip context opcode)
    | 0b01001011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_4B ip context opcode)
    | 0b01001100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_4C ip context opcode)
    | 0b01001101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_4D ip context opcode)
    | 0b01001110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_4E ip context opcode)
    | 0b01001111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_4F ip context opcode)
    | 0b01010000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_50 ip context)
    | 0b01010001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_51 ip context)
    | 0b01010010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_52 ip context)
    | 0b01010011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_53 ip context)
    | 0b01010100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_54 ip context)
    | 0b01010101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_55 ip context)
    | 0b01010110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_56 ip context)
    | 0b01010111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_57 ip context)
    | 0b01011000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_58 ip context)
    | 0b01011001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_59 ip context)
    | 0b01011010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_5A ip context)
    | 0b01011011 => do
      Decode_Legacy_1_Opcode_5B ip context
    | 0b01011100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_5C ip context)
    | 0b01011101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_5D ip context)
    | 0b01011110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_5E ip context)
    | 0b01011111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_5F ip context)
    | 0b01100000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_60 ip context)
    | 0b01100001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_61 ip context)
    | 0b01100010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_62 ip context)
    | 0b01100011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_63 ip context)
    | 0b01100100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_64 ip context)
    | 0b01100101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_65 ip context)
    | 0b01100110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_66 ip context)
    | 0b01100111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_67 ip context)
    | 0b01101000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_68 ip context)
    | 0b01101001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_69 ip context)
    | 0b01101010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_6A ip context)
    | 0b01101011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_6B ip context)
    | 0b01101100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_6C ip context)
    | 0b01101101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_6D ip context)
    | 0b01101110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_6E ip context)
    | 0b01101111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_6F ip context)
    | 0b01110000 => do
      Decode_Legacy_1_Opcode_70 ip context
    | 0b01110001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_71 ip context)
    | 0b01110010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_72 ip context)
    | 0b01110011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_73 ip context)
    | 0b01110100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_74 ip context)
    | 0b01110101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_75 ip context)
    | 0b01110110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_76 ip context)
    | 0b01110111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_77 ip context)
    | 0b01111110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_7E ip context)
    | 0b01111111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_7F ip context)
    | 0b10000000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_80 ip context opcode)
    | 0b10000001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_81 ip context opcode)
    | 0b10000010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_82 ip context opcode)
    | 0b10000011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_83 ip context opcode)
    | 0b10000100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_84 ip context opcode)
    | 0b10000101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_85 ip context opcode)
    | 0b10000110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_86 ip context opcode)
    | 0b10000111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_87 ip context opcode)
    | 0b10001000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_88 ip context opcode)
    | 0b10001001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_89 ip context opcode)
    | 0b10001010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_8A ip context opcode)
    | 0b10001011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_8B ip context opcode)
    | 0b10001100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_8C ip context opcode)
    | 0b10001101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_8D ip context opcode)
    | 0b10001110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_8E ip context opcode)
    | 0b10001111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_8F ip context opcode)
    | 0b10010000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_90 ip context opcode)
    | 0b10010001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_91 ip context opcode)
    | 0b10010010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_92 ip context opcode)
    | 0b10010011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_93 ip context opcode)
    | 0b10010100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_94 ip context opcode)
    | 0b10010101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_95 ip context opcode)
    | 0b10010110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_96 ip context opcode)
    | 0b10010111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_97 ip context opcode)
    | 0b10011000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_98 ip context opcode)
    | 0b10011001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_99 ip context opcode)
    | 0b10011010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_9A ip context opcode)
    | 0b10011011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_9B ip context opcode)
    | 0b10011100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_9C ip context opcode)
    | 0b10011101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_9D ip context opcode)
    | 0b10011110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_9E ip context opcode)
    | 0b10011111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_9F ip context opcode)
    | 0b10100000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A0 ip context)
    | 0b10100001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A1 ip context)
    | 0b10100010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A2 ip context)
    | 0b10100011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A3 ip context)
    | 0b10100100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A4 ip context)
    | 0b10100101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A5 ip context)
    | 0b10101000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A8 ip context)
    | 0b10101001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_A9 ip context)
    | 0b10101011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_AB ip context)
    | 0b10101100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_AC ip context)
    | 0b10101101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_AD ip context)
    | 0b10101110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_AE ip context)
    | 0b10101111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_AF ip context)
    | 0b10110000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B0 ip context)
    | 0b10110001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B1 ip context)
    | 0b10110010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B2 ip context)
    | 0b10110011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B3 ip context)
    | 0b10110100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B4 ip context)
    | 0b10110101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B5 ip context)
    | 0b10110110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B6 ip context)
    | 0b10110111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B7 ip context)
    | 0b10111001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_B9 ip context)
    | 0b10111010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_BA ip context)
    | 0b10111011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_BB ip context)
    | 0b10111100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_BC ip context)
    | 0b10111101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_BD ip context)
    | 0b10111110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_BE ip context)
    | 0b10111111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_BF ip context)
    | 0b11000000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C0 ip context)
    | 0b11000001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C1 ip context)
    | 0b11000010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C2 ip context)
    | 0b11000011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C3 ip context)
    | 0b11000100 => do
      Decode_Legacy_1_Opcode_C4 ip context
    | 0b11000101 => do
      Decode_Legacy_1_Opcode_C5 ip context
    | 0b11000110 => do
      Decode_Legacy_1_Opcode_C6 ip context
    | 0b11000111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C7 ip context)
    | 0b11001000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C8 ip context opcode)
    | 0b11001001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_C9 ip context opcode)
    | 0b11001010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_CA ip context opcode)
    | 0b11001011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_CB ip context opcode)
    | 0b11001100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_CC ip context opcode)
    | 0b11001101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_CD ip context opcode)
    | 0b11001110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_CE ip context opcode)
    | 0b11001111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_CF ip context opcode)
    | 0b11010001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D1 ip context)
    | 0b11010010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D2 ip context)
    | 0b11010011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D3 ip context)
    | 0b11010100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D4 ip context)
    | 0b11010101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D5 ip context)
    | 0b11010110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D6 ip context)
    | 0b11010111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D7 ip context)
    | 0b11011000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D8 ip context)
    | 0b11011001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_D9 ip context)
    | 0b11011010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_DA ip context)
    | 0b11011011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_DB ip context)
    | 0b11011100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_DC ip context)
    | 0b11011101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_DD ip context)
    | 0b11011110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_DE ip context)
    | 0b11011111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_DF ip context)
    | 0b11100000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E0 ip context)
    | 0b11100001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E1 ip context)
    | 0b11100010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E2 ip context)
    | 0b11100011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E3 ip context)
    | 0b11100100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E4 ip context)
    | 0b11100101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E5 ip context)
    | 0b11100110 => do
      Decode_Legacy_1_Opcode_E6 ip context
    | 0b11100111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E7 ip context)
    | 0b11101000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E8 ip context)
    | 0b11101001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_E9 ip context)
    | 0b11101010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_EA ip context)
    | 0b11101011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_EB ip context)
    | 0b11101100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_EC ip context)
    | 0b11101101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_ED ip context)
    | 0b11101110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_EE ip context)
    | 0b11101111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_EF ip context)
    | 0b11110001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F1 ip context)
    | 0b11110010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F2 ip context)
    | 0b11110011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F3 ip context)
    | 0b11110100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F4 ip context)
    | 0b11110101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F5 ip context)
    | 0b11110110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F6 ip context)
    | 0b11110111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F7 ip context)
    | 0b11111000 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F8 ip context)
    | 0b11111001 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_F9 ip context)
    | 0b11111010 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_FA ip context)
    | 0b11111011 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_FB ip context)
    | 0b11111100 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_FC ip context)
    | 0b11111101 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_FD ip context)
    | 0b11111110 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_FE ip context)
    | 0b11111111 => do
      Runtime.liftTotal (Decode_Legacy_1_Opcode_FF ip context)
    | _ => do
      Runtime.liftTotal (Unimplemented_Feature "unselected legacy map 1 instruction" false true)

end X86.Helpers

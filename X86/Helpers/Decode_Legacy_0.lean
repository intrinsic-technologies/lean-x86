-- Generated from Intel XML instruction-form metadata and XED encoding tables; generated selection and dispatch, not an Intel decoder body; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; reserved-encoding bounds: datafiles/amd/xed-amd-3dnow.txt, datafiles/amd/xed-amd-base.txt, datafiles/amd/xed-amd-clzero.txt, datafiles/amd/xed-amd-invlpgb.txt, datafiles/amd/xed-amd-mcommit.txt, datafiles/amd/xed-amd-monitorx.txt, datafiles/amd/xed-amd-rdpru.txt, datafiles/amd/xed-amd-snp.txt, datafiles/amd/xed-amd-sse4a.txt, datafiles/amd/xed-amd-svm.txt, datafiles/apx-f/apx-ppx-isa.xed.txt, datafiles/bdw/adox-adcx-isa.xed.txt, datafiles/cldemote/cldemote-isa.xed.txt, datafiles/clflushopt/clflushopt.xed.txt, datafiles/clwb/clwb.xed.txt, datafiles/enqcmd/enqcmd-isa.xed.txt, datafiles/fred/fred-isa.xed.txt, datafiles/fsgsbase/fsgsbase-isa.xed.txt, datafiles/gfni-vaes-vpcl/gfni-sse-isa.xed.txt, datafiles/hreset/hreset-isa.xed.txt, datafiles/hsw/invpcid-isa.xed.txt, datafiles/hsw/rtm-isa.xed.txt, datafiles/hsw/vmfunc-isa.xed.txt, datafiles/hswbmi/tzcnt-isa.xed.txt, datafiles/ibhf/ibhf-isa.xed.txt, datafiles/iprefetch/iprefetch-isa.xed.txt, datafiles/keylocker/keylocker-isa.xed.txt, datafiles/movdir/movdir-isa.xed.txt, datafiles/mpx/mpx-isa.txt, datafiles/msrlist/msrlist-isa.xed.txt, datafiles/pbndkb/pbndkb-isa.xed.txt, datafiles/pconfig/pconfig-isa.xed.txt, datafiles/pku/pku-isa.xed.txt, datafiles/pt/intelpt-isa.xed.txt, datafiles/rao-int/rao-int-isa.xed.txt, datafiles/rdpid/rdpid-isa.xed.txt, datafiles/rdrand/rdrand-isa.xed.txt, datafiles/rdseed/rdseed-isa.xed.txt, datafiles/serialize/serialize-isa.xed.txt, datafiles/sgx-enclv/sgx-enclv-isa.xed.txt, datafiles/sgx/sgx-isa.xed.txt, datafiles/sha/sha-isa.xed.txt, datafiles/smap/smap-isa.xed.txt, datafiles/tdx/tdx-isa.xed.txt, datafiles/tsx-ldtrk/tsx-ldtrk-isa.xed.txt, datafiles/uintr/uintr-isa.xed.txt, datafiles/waitpkg/waitpkg-isa.xed.txt, datafiles/wbnoinvd/wbnoinvd-isa.xed.txt, datafiles/wrmsrns/wrmsrns-isa.xed.txt, datafiles/xsavec/xsavec-isa.txt, datafiles/xsaveopt/xsaveopt-isa.txt, datafiles/xsaves/xsaves-isa.txt; do not edit.
-- Source SHA256: dfa6aed58781ff5ee645a98b794192314b83dd8f10656d3e8794a35563d23ac5
import X86.Runtime
import X86.Cpuid
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Mem_Fetch
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Unimplemented_Feature
import X86.Instructions.ADC
import X86.Instructions.ADD
import X86.Instructions.AND
import X86.Instructions.CALL
import X86.Instructions.CBW
import X86.Instructions.CLC
import X86.Instructions.CLD
import X86.Instructions.CLI
import X86.Instructions.CMC
import X86.Instructions.CMP
import X86.Instructions.CMPS
import X86.Instructions.CWD
import X86.Instructions.DEC
import X86.Instructions.DIV
import X86.Instructions.ENTER
import X86.Instructions.F2XM1
import X86.Instructions.FABS
import X86.Instructions.FADD
import X86.Instructions.FBLD
import X86.Instructions.FBSTP
import X86.Instructions.FCHS
import X86.Instructions.FCLEX
import X86.Instructions.FCMOVcc
import X86.Instructions.FCOM
import X86.Instructions.FCOMI
import X86.Instructions.FCOS
import X86.Instructions.FDECSTP
import X86.Instructions.FDIV
import X86.Instructions.FDIVR
import X86.Instructions.FFREE
import X86.Instructions.FICOM
import X86.Instructions.FILD
import X86.Instructions.FINCSTP
import X86.Instructions.FINIT
import X86.Instructions.FIST
import X86.Instructions.FLD
import X86.Instructions.FLD1
import X86.Instructions.FLDCW
import X86.Instructions.FLDENV
import X86.Instructions.FMUL
import X86.Instructions.FNOP
import X86.Instructions.FPATAN
import X86.Instructions.FPREM
import X86.Instructions.FPREM1
import X86.Instructions.FPTAN
import X86.Instructions.FRNDINT
import X86.Instructions.FRSTOR
import X86.Instructions.FSAVE
import X86.Instructions.FSCALE
import X86.Instructions.FSIN
import X86.Instructions.FSINCOS
import X86.Instructions.FSQRT
import X86.Instructions.FST
import X86.Instructions.FSTCW
import X86.Instructions.FSTENV
import X86.Instructions.FSTSW
import X86.Instructions.FSUB
import X86.Instructions.FSUBR
import X86.Instructions.FTST
import X86.Instructions.FUCOM
import X86.Instructions.FXAM
import X86.Instructions.FXCH
import X86.Instructions.FXTRACT
import X86.Instructions.FYL2X
import X86.Instructions.FYL2XP1
import X86.Instructions.HLT
import X86.Instructions.IDIV
import X86.Instructions.IMUL
import X86.Instructions.IN
import X86.Instructions.INC
import X86.Instructions.INS
import X86.Instructions.INTn
import X86.Instructions.IRET
import X86.Instructions.JMP
import X86.Instructions.Jcc
import X86.Instructions.LEA
import X86.Instructions.LEAVE
import X86.Instructions.LODS
import X86.Instructions.LOOP
import X86.Instructions.MOV
import X86.Instructions.MOVS
import X86.Instructions.MOVSD
import X86.Instructions.MOVSX
import X86.Instructions.MUL
import X86.Instructions.NEG
import X86.Instructions.NOP
import X86.Instructions.NOT
import X86.Instructions.OR
import X86.Instructions.OUT
import X86.Instructions.OUTS
import X86.Instructions.PAUSE
import X86.Instructions.POP
import X86.Instructions.POPF
import X86.Instructions.PUSH
import X86.Instructions.PUSHF
import X86.Instructions.RCL
import X86.Instructions.RET
import X86.Instructions.SAL
import X86.Instructions.SBB
import X86.Instructions.SCAS
import X86.Instructions.STC
import X86.Instructions.STD
import X86.Instructions.STI
import X86.Instructions.STOS
import X86.Instructions.SUB
import X86.Instructions.TEST
import X86.Instructions.UD
import X86.Instructions.WAIT
import X86.Instructions.XCHG
import X86.Instructions.XLAT
import X86.Instructions.XOR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Check_New_TSS.Binding σ]
  [X86.Helpers.Emulate_F2XM1.Binding σ]
  [X86.Helpers.Emulate_FCOS.Binding σ]
  [X86.Helpers.Emulate_FPATAN.Binding σ]
  [X86.Helpers.Emulate_FPTAN.Binding σ]
  [X86.Helpers.Emulate_FSIN.Binding σ]
  [X86.Helpers.Emulate_FSINCOS.Binding σ]
  [X86.Helpers.Emulate_FYL2X.Binding σ]
  [X86.Helpers.Emulate_FYL2XP1.Binding σ]
  [X86.Helpers.Get_Repeat_String_Stride.Binding σ]
  [X86.Helpers.Handle_Vectored_Event.Semantics σ]
  [X86.Helpers.IO_Read.Binding σ]
  [X86.Helpers.IO_Write.Binding σ]
  [X86.Helpers.Load_New_TSS.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Select_Buffered_Stack_Return_Swap.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Fault.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Order.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Probe.Binding σ]
  [X86.Helpers.Select_FP87_Remainder_Reduction.Binding σ]
  [X86.Helpers.Select_Stack_Return_Validation_Fault.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.__Fuzz_Next_Mem_Write.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.MODEP5]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Config.Value.Feature_Ingore_FCS_FDS_Deprecation]
  [X86.Config.Value.Feature_LAM_Moffs_Displacement]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Select_Legacy_0_Opcode_00
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

def Select_Legacy_0_Opcode_01
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

def Select_Legacy_0_Opcode_02
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

def Select_Legacy_0_Opcode_03
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

def Select_Legacy_0_Opcode_04
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_05
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_08
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

def Select_Legacy_0_Opcode_09
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

def Select_Legacy_0_Opcode_0A
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

def Select_Legacy_0_Opcode_0B
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

def Select_Legacy_0_Opcode_0C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_0D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_10
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

def Select_Legacy_0_Opcode_11
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

def Select_Legacy_0_Opcode_12
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

def Select_Legacy_0_Opcode_13
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

def Select_Legacy_0_Opcode_14
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_15
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_18
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

def Select_Legacy_0_Opcode_19
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

def Select_Legacy_0_Opcode_1A
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

def Select_Legacy_0_Opcode_1B
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

def Select_Legacy_0_Opcode_1C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_1D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_20
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

def Select_Legacy_0_Opcode_21
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

def Select_Legacy_0_Opcode_22
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

def Select_Legacy_0_Opcode_23
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

def Select_Legacy_0_Opcode_24
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_25
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_28
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

def Select_Legacy_0_Opcode_29
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

def Select_Legacy_0_Opcode_2A
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

def Select_Legacy_0_Opcode_2B
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

def Select_Legacy_0_Opcode_2C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_2D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_30
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

def Select_Legacy_0_Opcode_31
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

def Select_Legacy_0_Opcode_32
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

def Select_Legacy_0_Opcode_33
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

def Select_Legacy_0_Opcode_34
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_35
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_38
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

def Select_Legacy_0_Opcode_39
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

def Select_Legacy_0_Opcode_3A
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

def Select_Legacy_0_Opcode_3B
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

def Select_Legacy_0_Opcode_3C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_3D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_50
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_51
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_52
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_53
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_54
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_55
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_56
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_57
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_58
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_59
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_5A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_5B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_5C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_5D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_5E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_5F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_63
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.rex_w == 1)) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  if (_mod != 3 and (_mode64 and _context.rex_w == 0)) then
    return 3
  return 0

def Select_Legacy_0_Opcode_68
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_69
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

def Select_Legacy_0_Opcode_6A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_6B
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

def Select_Legacy_0_Opcode_6C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_6D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 3
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 4
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 7
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 8
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 9
  return 0

def Select_Legacy_0_Opcode_6E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_6F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 3
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 4
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 7
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 8
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 9
  return 0

def Select_Legacy_0_Opcode_70
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_71
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_72
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_73
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_74
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_75
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_76
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_77
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_78
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_79
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_7A
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_7B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_7C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_7D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_7E
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_7F
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_80
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and _reg == 0 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 2 and (_mode64 and not _context.lock_prefix_present)) then
    return 5
  if (_mod != 3 and _reg == 2 and (_mode64 and _context.lock_prefix_present)) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 8
  if (_mod != 3 and _reg == 3 and (_mode64 and _context.lock_prefix_present)) then
    return 9
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 6 and (_mode64 and not _context.lock_prefix_present)) then
    return 11
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.lock_prefix_present)) then
    return 12
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 5 and (_mode64 and not _context.lock_prefix_present)) then
    return 14
  if (_mod != 3 and _reg == 5 and (_mode64 and _context.lock_prefix_present)) then
    return 15
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 16
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 17
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 18
  if (_mod != 3 and _reg == 4 and (_mode64 and not _context.lock_prefix_present)) then
    return 19
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.lock_prefix_present)) then
    return 20
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 21
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.lock_prefix_present)) then
    return 22
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.lock_prefix_present)) then
    return 23
  return 0

def Select_Legacy_0_Opcode_81
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and _reg == 0 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 2 and (_mode64 and not _context.lock_prefix_present)) then
    return 5
  if (_mod != 3 and _reg == 2 and (_mode64 and _context.lock_prefix_present)) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 8
  if (_mod != 3 and _reg == 3 and (_mode64 and _context.lock_prefix_present)) then
    return 9
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 6 and (_mode64 and not _context.lock_prefix_present)) then
    return 11
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.lock_prefix_present)) then
    return 12
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 5 and (_mode64 and not _context.lock_prefix_present)) then
    return 14
  if (_mod != 3 and _reg == 5 and (_mode64 and _context.lock_prefix_present)) then
    return 15
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 16
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 17
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 18
  if (_mod != 3 and _reg == 4 and (_mode64 and not _context.lock_prefix_present)) then
    return 19
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.lock_prefix_present)) then
    return 20
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 21
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.lock_prefix_present)) then
    return 22
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.lock_prefix_present)) then
    return 23
  return 0

def Select_Legacy_0_Opcode_83
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and _reg == 0 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 2 and (_mode64 and not _context.lock_prefix_present)) then
    return 5
  if (_mod != 3 and _reg == 2 and (_mode64 and _context.lock_prefix_present)) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 8
  if (_mod != 3 and _reg == 3 and (_mode64 and _context.lock_prefix_present)) then
    return 9
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 6 and (_mode64 and not _context.lock_prefix_present)) then
    return 11
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.lock_prefix_present)) then
    return 12
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 5 and (_mode64 and not _context.lock_prefix_present)) then
    return 14
  if (_mod != 3 and _reg == 5 and (_mode64 and _context.lock_prefix_present)) then
    return 15
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 16
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 17
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 18
  if (_mod != 3 and _reg == 4 and (_mode64 and not _context.lock_prefix_present)) then
    return 19
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.lock_prefix_present)) then
    return 20
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 21
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.lock_prefix_present)) then
    return 22
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.lock_prefix_present)) then
    return 23
  return 0

def Select_Legacy_0_Opcode_84
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

def Select_Legacy_0_Opcode_85
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

def Select_Legacy_0_Opcode_86
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_0_Opcode_87
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and (_mode64 and _context.lock_prefix_present)) then
    return 1
  if (_mod == 3 and _mode64) then
    return 2
  if (_mod != 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 3
  return 0

def Select_Legacy_0_Opcode_88
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

def Select_Legacy_0_Opcode_89
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

def Select_Legacy_0_Opcode_8A
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

def Select_Legacy_0_Opcode_8B
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

def Select_Legacy_0_Opcode_8C
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

def Select_Legacy_0_Opcode_8D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _mode64) then
    return 1
  return 0

def Select_Legacy_0_Opcode_8E
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

def Select_Legacy_0_Opcode_8F
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

def Select_Legacy_0_Opcode_90
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and (_context.rep_prefix == 0 or _context.rep_prefix == 242) and _context.rex_b3 == 1) then
    return 1
  if (_mode64 and (_context.rep_prefix == 0 or _context.rep_prefix == 242) and _context.rex_b3 == 0) then
    return 2
  if (_mode64 and _context.rep_prefix == 243) then
    return 3
  return 0

def Select_Legacy_0_Opcode_91
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_92
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_93
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_94
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_95
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_96
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_97
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_98
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0) then
    return 1
  if (_mode64 and _context.rex_w == 1) then
    return 2
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_99
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0) then
    return 1
  if (_mode64 and _context.rex_w == 1) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_9B
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_9C
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0) then
    return 1
  if (_mode64 and _context.rex_w == 1) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_9D
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0) then
    return 1
  if (_mode64 and (not _context.osz_prefix_present or _context.osz_prefix_present and _context.rex_w == 1)) then
    return 2
  return 0

def Select_Legacy_0_Opcode_A0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_A1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_A2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_A3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_A4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_A5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 1
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 2
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 3
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 4
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 7
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 8
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 9
  return 0

def Select_Legacy_0_Opcode_A6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 0) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 242) then
    return 3
  return 0

def Select_Legacy_0_Opcode_A7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 1
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 2
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 3
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 4
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 7
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 8
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 9
  return 0

def Select_Legacy_0_Opcode_A8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_A9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_AA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_AB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 3
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 4
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 7
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 8
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 9
  return 0

def Select_Legacy_0_Opcode_AC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_AD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 3
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 4
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 7
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 8
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 9
  return 0

def Select_Legacy_0_Opcode_AE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rep_prefix == 243) then
    return 2
  if (_mode64 and _context.rep_prefix == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_AF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 1
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 242) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 242) then
    return 3
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 4
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 243) then
    return 5
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 243) then
    return 6
  if (_mode64 and _context.rex_w == 1 and _context.rep_prefix == 0) then
    return 7
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 8
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0 and _context.rep_prefix == 0) then
    return 9
  return 0

def Select_Legacy_0_Opcode_B0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_B9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_BA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_BB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_BC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_BD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_BE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_BF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_C0
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
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_C1
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
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_C2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_C3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_C6
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

def Select_Legacy_0_Opcode_C7
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

def Select_Legacy_0_Opcode_C8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_C9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_CA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_CB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_CC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_CD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_CF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0) then
    return 1
  if (_mode64 and _context.rex_w == 1) then
    return 2
  if (_mode64 and _context.osz_prefix_present and _context.rex_w == 0) then
    return 3
  return 0

def Select_Legacy_0_Opcode_D0
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
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_D1
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
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_D2
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
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_D3
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
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_D6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_D7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_D8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 3
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 6
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 9
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 13
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 14
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 15
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_D9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 6 and _rm == 0 and _mode64) then
    return 1
  if (_mod == 3 and _reg == 7 and _rm == 6 and _mode64) then
    return 2
  if (_mod == 3 and _reg == 7 and _rm == 7 and _mode64) then
    return 3
  if (_mod == 3 and _reg == 6 and _rm == 2 and _mode64) then
    return 4
  if (_mod == 3 and _reg == 7 and _rm == 3 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 6 and _rm == 3 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 6 and _rm == 1 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 7 and _rm == 1 and _mode64) then
    return 8
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    return 9
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.rex_w == 1)) then
    return 10
  if (_mod != 3 and _reg == 6 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 11
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 13
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 14
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 15
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 16
  if (_mod == 3 and _reg == 5 and _rm == 0 and _mode64) then
    return 17
  if (_mod == 3 and _reg == 5 and _rm == 1 and _mode64) then
    return 18
  if (_mod == 3 and _reg == 5 and _rm == 2 and _mode64) then
    return 19
  if (_mod == 3 and _reg == 5 and _rm == 3 and _mode64) then
    return 20
  if (_mod == 3 and _reg == 5 and _rm == 4 and _mode64) then
    return 21
  if (_mod == 3 and _reg == 5 and _rm == 5 and _mode64) then
    return 22
  if (_mod == 3 and _reg == 5 and _rm == 6 and _mode64) then
    return 23
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 24
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 25
  if (_mod == 3 and _reg == 4 and _rm == 0 and _mode64) then
    return 26
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 27
  if (_mod == 3 and _reg == 4 and _rm == 1 and _mode64) then
    return 28
  if (_mod == 3 and _reg == 6 and _rm == 6 and _mode64) then
    return 29
  if (_mod == 3 and _reg == 6 and _rm == 7 and _mode64) then
    return 30
  if (_mod == 3 and _reg == 2 and _rm == 0 and _mode64) then
    return 31
  if (_mod == 3 and _reg == 4 and _rm == 4 and _mode64) then
    return 32
  if (_mod == 3 and _reg == 4 and _rm == 5 and _mode64) then
    return 33
  if (_mod == 3 and _reg == 7 and _rm == 4 and _mode64) then
    return 34
  if (_mod == 3 and _reg == 7 and _rm == 5 and _mode64) then
    return 35
  if (_mod == 3 and _reg == 6 and _rm == 4 and _mode64) then
    return 36
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    return 37
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.rex_w == 1)) then
    return 38
  if (_mod != 3 and _reg == 4 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 39
  if (_mod == 3 and _reg == 7 and _rm == 2 and _mode64) then
    return 40
  if (_mod == 3 and _reg == 7 and _rm == 0 and _mode64) then
    return 41
  if (_mod == 3 and _reg == 6 and _rm == 5 and _mode64) then
    return 42
  return 0

def Select_Legacy_0_Opcode_DA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 3
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 4
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 5 and _rm == 1 and _mode64) then
    return 8
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 11
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 13
  return 0

def Select_Legacy_0_Opcode_DB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 1
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 6
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 4 and _rm == 2 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 4 and _rm == 3 and _mode64) then
    return 9
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 13
  if (_mod == 3 and _reg == 4 and _rm == 0 and _mode64) then
    return 14
  if (_mod == 3 and _reg == 4 and _rm == 1 and _mode64) then
    return 15
  if (_mod == 3 and _reg == 4 and _rm == 4 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_DC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 3
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 6
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 9
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 13
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 14
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 15
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_DD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.rex_w == 1)) then
    return 1
  if (_mod != 3 and _reg == 6 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 2
  if (_mod != 3 and _reg == 6 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    return 3
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 9
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 13
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.rex_w == 1)) then
    return 14
  if (_mod != 3 and _reg == 4 and (_mode64 and not _context.osz_prefix_present and _context.rex_w == 0)) then
    return 15
  if (_mod != 3 and _reg == 4 and (_mode64 and _context.osz_prefix_present and _context.rex_w == 0)) then
    return 16
  return 0

def Select_Legacy_0_Opcode_DE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 1
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 2
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 3
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 5
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 3 and _rm == 1 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 8
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 13
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 14
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 15
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 16
  return 0

def Select_Legacy_0_Opcode_DF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 2
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 3
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 6
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 7
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 12
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 13
  if (_mod == 3 and _reg == 4 and _rm == 0 and _mode64) then
    return 14
  return 0

def Select_Legacy_0_Opcode_E0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E2
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E3
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if (_mode64 and _context.address_size == 16) then
    return 1
  if (_mode64 and _context.address_size == 32) then
    return 2
  if (_mode64 and _context.address_size == 64) then
    return 3
  return 0

def Select_Legacy_0_Opcode_E4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_E9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_EB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_EC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_ED
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_EE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_EF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_F1
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_F4
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_F5
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_F6
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 2
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 4
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 8
  if (_mod != 3 and _reg == 3 and (_mode64 and _context.lock_prefix_present)) then
    return 9
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 2 and (_mode64 and not _context.lock_prefix_present)) then
    return 13
  if (_mod != 3 and _reg == 2 and (_mode64 and _context.lock_prefix_present)) then
    return 14
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 16
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 17
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 18
  return 0

def Select_Legacy_0_Opcode_F7
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 5 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 2
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 4
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 3 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 3 and (_mode64 and not _context.lock_prefix_present)) then
    return 8
  if (_mod != 3 and _reg == 3 and (_mode64 and _context.lock_prefix_present)) then
    return 9
  if (_mod == 3 and _reg == 7 and _mode64) then
    return 10
  if (_mod != 3 and _reg == 7 and _mode64) then
    return 11
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 2 and (_mode64 and not _context.lock_prefix_present)) then
    return 13
  if (_mod != 3 and _reg == 2 and (_mode64 and _context.lock_prefix_present)) then
    return 14
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 15
  if (_mod != 3 and _reg == 0 and _mode64) then
    return 16
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 17
  if (_mod != 3 and _reg == 1 and _mode64) then
    return 18
  return 0

def Select_Legacy_0_Opcode_F8
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_F9
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_FA
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_FB
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_FC
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_FD
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _mode64 then
    return 1
  return 0

def Select_Legacy_0_Opcode_FE
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.lock_prefix_present)) then
    return 2
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.lock_prefix_present)) then
    return 3
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.lock_prefix_present)) then
    return 5
  if (_mod != 3 and _reg == 0 and (_mode64 and _context.lock_prefix_present)) then
    return 6
  return 0

def Select_Legacy_0_Opcode_FF
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (_modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  let _mod : Bits 2 ← _modrm[7:6]
  let _reg : Bits 3 ← _modrm[5:3]
  let _rm : Bits 3 ← _modrm[2:0]
  if (_mod == 3 and _reg == 6 and _mode64) then
    return 1
  if (_mod != 3 and _reg == 6 and _mode64) then
    return 2
  if (_mod == 3 and _reg == 2 and _mode64) then
    return 3
  if (_mod != 3 and _reg == 2 and _mode64) then
    return 4
  if (_mod != 3 and _reg == 3 and _mode64) then
    return 5
  if (_mod != 3 and _reg == 5 and _mode64) then
    return 6
  if (_mod == 3 and _reg == 4 and _mode64) then
    return 7
  if (_mod != 3 and _reg == 4 and _mode64) then
    return 8
  if (_mod == 3 and _reg == 1 and _mode64) then
    return 9
  if (_mod != 3 and _reg == 1 and (_mode64 and not _context.lock_prefix_present)) then
    return 10
  if (_mod != 3 and _reg == 1 and (_mode64 and _context.lock_prefix_present)) then
    return 11
  if (_mod == 3 and _reg == 0 and _mode64) then
    return 12
  if (_mod != 3 and _reg == 0 and (_mode64 and not _context.lock_prefix_present)) then
    return 13
  if (_mod != 3 and _reg == 0 and (_mode64 and _context.lock_prefix_present)) then
    return 14
  return 0

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_00
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_00 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPR8_GPR8_00 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADD_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_01
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_01 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPRv_GPRv_01 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADD_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_02
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_02 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPR8_GPR8_02 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_03
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_03 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPRv_GPRv_03 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_04
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_04 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.ADD_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_05
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_05 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.ADD_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_08
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_08 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.OR_GPR8_GPR8_08 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.OR_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.OR_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_09
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_09 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.OR_GPRv_GPRv_09 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.OR_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.OR_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_0A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_0A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.OR_GPR8_GPR8_0A (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.OR_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_0B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_0B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.OR_GPRv_GPRv_0B (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.OR_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_0C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_0C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.OR_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_0D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_0D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.OR_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_10
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_10 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADC_GPR8_GPR8_10 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADC_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADC_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_11
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_11 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADC_GPRv_GPRv_11 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADC_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADC_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_12
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_12 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADC_GPR8_GPR8_12 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADC_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_13
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_13 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADC_GPRv_GPRv_13 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADC_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_14
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_14 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.ADC_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_15
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_15 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.ADC_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_18
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_18 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SBB_GPR8_GPR8_18 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SBB_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SBB_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_19
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_19 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SBB_GPRv_GPRv_19 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SBB_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SBB_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_1A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_1A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SBB_GPR8_GPR8_1A (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SBB_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_1B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_1B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SBB_GPRv_GPRv_1B (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SBB_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_1C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_1C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.SBB_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_1D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_1D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.SBB_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_20
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_20 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.AND_GPR8_GPR8_20 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.AND_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.AND_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_21
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_21 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.AND_GPRv_GPRv_21 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.AND_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.AND_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_22
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_22 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.AND_GPR8_GPR8_22 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.AND_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_23
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_23 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.AND_GPRv_GPRv_23 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.AND_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_24
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_24 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.AND_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_25
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_25 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.AND_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_28
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_28 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SUB_GPR8_GPR8_28 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SUB_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SUB_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_29
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_29 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SUB_GPRv_GPRv_29 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SUB_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SUB_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_2A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_2A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SUB_GPR8_GPR8_2A (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SUB_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_2B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_2B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SUB_GPRv_GPRv_2B (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SUB_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_2C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_2C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.SUB_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_2D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_2D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.SUB_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_30
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_30 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XOR_GPR8_GPR8_30 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XOR_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.XOR_LOCK_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_31
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_31 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XOR_GPRv_GPRv_31 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XOR_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.XOR_LOCK_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_32
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_32 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XOR_GPR8_GPR8_32 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XOR_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_33
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_33 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XOR_GPRv_GPRv_33 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XOR_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_34
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_34 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XOR_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_35
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_35 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XOR_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_38
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_38 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMP_GPR8_GPR8_38 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMP_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_39
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_39 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMP_GPRv_GPRv_39 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMP_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_3A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_3A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMP_GPR8_GPR8_3A (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMP_GPR8_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_3B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_3B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.CMP_GPRv_GPRv_3B (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMP_GPRv_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_3C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_3C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CMP_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_3D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_3D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CMP_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_50
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_50 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_51
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_51 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_52
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_52 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_53
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_53 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_54
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_54 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_55
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_55 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_56
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_56 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_57
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_57 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_50_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_58
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_58 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_59
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_59 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_5A
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_5A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_5B
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_5B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_5C
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_5C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_5D
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_5D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_5E
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_5E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_5F
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_5F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_58_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_63
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_63 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOVSXD_GPR64_MEMd_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOVSXD_GPRv_GPRz (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVSXD_GPRz_MEMz (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_68
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_68 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_69
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_69 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.IMUL_GPRv_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.IMUL_GPRv_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_6A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_6A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSH_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_6B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_6B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.IMUL_GPRv_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.IMUL_GPRv_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_6C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_6C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_INSB_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_INSB_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.INSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_6D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_6D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_INSD_6 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_INSD_7 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REP_INSW_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REP_INSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REP_INSD_3 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REP_INSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.INSD_3 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.INSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.INSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_6E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_6E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_OUTSB_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_OUTSB_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.OUTSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_6F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_6F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_OUTSD_6 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_OUTSD_7 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REP_OUTSW_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REP_OUTSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REP_OUTSD_3 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REP_OUTSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.OUTSD_3 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.OUTSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.OUTSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_70
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_70 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JO_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_71
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_71 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNO_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_72
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_72 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JB_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_73
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_73 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNB_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_74
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_74 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JZ_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_75
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_75 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNZ_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_76
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_76 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JBE_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_77
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_77 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNBE_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_78
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_78 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JS_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_79
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_79 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNS_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_7A
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_7A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JP_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_7B
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_7B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNP_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_7C
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_7C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JL_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_7D
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_7D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNL_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_7E
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_7E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JLE_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_7F
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_7F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JNLE_RELBRb_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_80
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_80 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPR8_IMMb_80r0 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_MEMb_IMMb_80r0 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADD_LOCK_MEMb_IMMb_80r0 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.ADC_GPR8_IMMb_80r2 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.ADC_MEMb_IMMb_80r2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.ADC_LOCK_MEMb_IMMb_80r2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SBB_GPR8_IMMb_80r3 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SBB_MEMb_IMMb_80r3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.SBB_LOCK_MEMb_IMMb_80r3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.XOR_GPR8_IMMb_80r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.XOR_MEMb_IMMb_80r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.XOR_LOCK_MEMb_IMMb_80r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.SUB_GPR8_IMMb_80r5 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.SUB_MEMb_IMMb_80r5 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.SUB_LOCK_MEMb_IMMb_80r5 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.CMP_GPR8_IMMb_80r7 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 17) then
    Instructions.CMP_MEMb_IMMb_80r7 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 18) then
    Instructions.AND_GPR8_IMMb_80r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 19) then
    Instructions.AND_MEMb_IMMb_80r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 20) then
    Instructions.AND_LOCK_MEMb_IMMb_80r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 21) then
    Instructions.OR_GPR8_IMMb_80r1 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 22) then
    Instructions.OR_MEMb_IMMb_80r1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 23) then
    Instructions.OR_LOCK_MEMb_IMMb_80r1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_81
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_81 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADD_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.ADC_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.ADC_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.ADC_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SBB_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SBB_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.SBB_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.XOR_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.XOR_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.XOR_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.SUB_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.SUB_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.SUB_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.CMP_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 17) then
    Instructions.CMP_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 18) then
    Instructions.AND_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 19) then
    Instructions.AND_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 20) then
    Instructions.AND_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 21) then
    Instructions.OR_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 22) then
    Instructions.OR_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 23) then
    Instructions.OR_LOCK_MEMv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_83
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_83 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.ADD_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.ADD_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.ADD_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.ADC_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.ADC_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.ADC_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SBB_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SBB_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.SBB_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.XOR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.XOR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.XOR_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.SUB_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.SUB_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.SUB_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.CMP_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 17) then
    Instructions.CMP_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 18) then
    Instructions.AND_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 19) then
    Instructions.AND_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 20) then
    Instructions.AND_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 21) then
    Instructions.OR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 22) then
    Instructions.OR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 23) then
    Instructions.OR_LOCK_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_84
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_84 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.TEST_GPR8_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.TEST_MEMb_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_85
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_85 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.TEST_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.TEST_MEMv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_86
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_86 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XCHG_MEMb_GPR8_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XCHG_GPR8_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.XCHG_MEMb_GPR8_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_87
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_87 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.XCHG_MEMv_GPRv_0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.XCHG_GPRv_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.XCHG_MEMv_GPRv_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_88
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_88 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_GPR8_88 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_MEMb_GPR8_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_89
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_89 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_GPRv_89 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_MEMv_GPRv_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_8A
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_8A context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_GPR8_8A (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_GPR8_MEMb_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_8B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_8B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_GPRv_8B (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_GPRv_MEMv_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_8C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_8C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_SEG (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_MEMw_SEG (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_8D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_8D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.LEA_GPRv_AGEN (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  -- Intel SDM 325462-093, LEA Vol.2A3-548 (PDF1252)
  if ((← modrm[7:6]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_8E
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_8E context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_SEG_GPR16 (← Std.Bits.Add_int (n := 64) ip 2) context reg rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_SEG_MEMw (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_8F
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_8F context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.POP_GPRv_8F (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.POP_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 6 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_90
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_90 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.NOP_90 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.PAUSE (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_91
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_91 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_92
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_92 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_93
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_93 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_94
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_94 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_95
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_95 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_96
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_96 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_97
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_97 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XCHG_GPRv_OrAX_0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_98
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_98 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CBW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.CDQE (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.CWDE_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_99
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_99 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CDQ_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.CQO (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.CWD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_9B
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_9B context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.FWAIT (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_9C
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_9C context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.PUSHFQ_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUSHFQ_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.PUSHF_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_9D
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_9D context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.POPF (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.POPFQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_AL_MEMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_OrAX_MEMv (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_MEMb_AL (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_MEMv_OrAX (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_MOVSB_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_MOVSB_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.MOVSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOVSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_MOVSD_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REP_MOVSQ_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REP_MOVSW_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REP_MOVSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REP_MOVSQ_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.REP_MOVSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.MOVSQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.MOVSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CMPSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REPE_CMPSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REPNE_CMPSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CMPSW (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.CMPSD (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.CMPSQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REPE_CMPSW (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REPE_CMPSD (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REPE_CMPSQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.REPNE_CMPSW (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.REPNE_CMPSD (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.REPNE_CMPSQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.TEST_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_A9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_A9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.TEST_OrAX_IMMz (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_AA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_AA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_STOSB_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_STOSB_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.STOSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_AB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_AB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_STOSD_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_STOSQ_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REP_STOSW_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REP_STOSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REP_STOSQ_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REP_STOSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.STOSQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.STOSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.STOSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_AC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_AC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_LODSB_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_LODSB_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.LODSB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_AD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_AD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REP_LODSD_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REP_LODSQ_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REP_LODSW_5 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REP_LODSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REP_LODSQ_0 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REP_LODSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Instructions.LODSQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 8) then
    Instructions.LODSW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 9) then
    Instructions.LODSD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_AE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_AE context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REPNE_SCASB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REPE_SCASB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Runtime.liftTotal (Instructions.SCASB (← Std.Bits.Add_int (n := 64) ip 1) context)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_AF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_AF context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.REPNE_SCASD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.REPNE_SCASQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.REPNE_SCASW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 4) then
    Instructions.REPE_SCASD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 5) then
    Instructions.REPE_SCASQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 6) then
    Instructions.REPE_SCASW_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.SCASQ (← Std.Bits.Add_int (n := 64) ip 1) context)
    return ()
  if (decoder_form_index == 8) then
    Runtime.liftTotal (Instructions.SCASW_2 (← Std.Bits.Add_int (n := 64) ip 1) context)
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.SCASD_2 (← Std.Bits.Add_int (n := 64) ip 1) context)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B3
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B4
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B5
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B6
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B7
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_B0 (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B8
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_B9
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_B9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_BA
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_BA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_BB
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_BB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_BC
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_BC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_BD
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_BD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_BE
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_BE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_BF
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_BF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMv (← Std.Bits.Add_int (n := 64) ip 1) context opcode
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHL_GPR8_IMMb_C0r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHL_MEMb_IMMb_C0r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHR_GPR8_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHR_MEMb_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SHL_GPR8_IMMb_C0r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SHL_MEMb_IMMb_C0r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SAR_GPR8_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SAR_MEMb_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.ROL_GPR8_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.ROL_MEMb_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.ROR_GPR8_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.ROR_MEMb_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.RCL_GPR8_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.RCL_MEMb_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.RCR_GPR8_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.RCR_MEMb_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHL_GPRv_IMMb_C1r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHL_MEMv_IMMb_C1r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SHL_GPRv_IMMb_C1r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SHL_MEMv_IMMb_C1r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SAR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SAR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.ROL_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.ROL_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.ROR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.ROR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.RCL_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.RCL_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.RCR_GPRv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.RCR_MEMv_IMMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.RET_NEAR_IMMw (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.RET_NEAR (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPR8_IMMb_C6r0 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_MEMb_IMMb_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 6 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 6 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.MOV_GPRv_IMMz (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.MOV_MEMv_IMMz_1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 6 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 1 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 6 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← modrm[2:0]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.ENTER_IMMw_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_C9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_C9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.LEAVE (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_CA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_CA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.RET_FAR_IMMw (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_CB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_CB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.RET_FAR (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_CC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_CC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.INT3 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_CD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_CD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.INT_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_CF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_CF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.IRETD_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.IRETQ (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.IRET_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHL_GPR8_ONE_D0r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHL_MEMb_ONE_D0r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHR_GPR8_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHR_MEMb_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SHL_GPR8_ONE_D0r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SHL_MEMb_ONE_D0r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SAR_GPR8_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SAR_MEMb_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.ROL_GPR8_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.ROL_MEMb_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.ROR_GPR8_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.ROR_MEMb_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.RCL_GPR8_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.RCL_MEMb_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.RCR_GPR8_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.RCR_MEMb_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHL_GPRv_ONE_D1r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHL_MEMv_ONE_D1r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHR_GPRv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHR_MEMv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SHL_GPRv_ONE_D1r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SHL_MEMv_ONE_D1r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SAR_GPRv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SAR_MEMv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.ROL_GPRv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.ROL_MEMv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.ROR_GPRv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.ROR_MEMv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.RCL_GPRv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.RCL_MEMv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.RCR_GPRv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.RCR_MEMv_ONE (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHL_GPR8_CL_D2r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHL_MEMb_CL_D2r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHR_GPR8_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHR_MEMb_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SHL_GPR8_CL_D2r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SHL_MEMb_CL_D2r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SAR_GPR8_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SAR_MEMb_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.ROL_GPR8_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.ROL_MEMb_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.ROR_GPR8_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.ROR_MEMb_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.RCL_GPR8_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.RCL_MEMb_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.RCR_GPR8_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.RCR_MEMb_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.SHL_GPRv_CL_D3r4 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.SHL_MEMv_CL_D3r4 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.SHR_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.SHR_MEMv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.SHL_GPRv_CL_D3r6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.SHL_MEMv_CL_D3r6 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.SAR_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.SAR_MEMv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.ROL_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.ROL_MEMv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.ROR_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.ROR_MEMv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.RCL_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.RCL_MEMv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.RCR_GPRv_CL (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.RCR_MEMv_CL (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.UDB (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.XLAT (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D8
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D8 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.FADD_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.FADD_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 3) then
    Instructions.FSUB_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FSUB_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Instructions.FMUL_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.FMUL_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 7) then
    Instructions.FCOM_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 8) then
    Instructions.FCOMP_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.FCOM_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 10) then
    Runtime.liftTotal (Instructions.FCOMP_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 11) then
    Instructions.FSUBR_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FSUBR_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Instructions.FDIV_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FDIV_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 15) then
    Instructions.FDIVR_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 16) then
    Runtime.liftTotal (Instructions.FDIVR_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_D9
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_D9 context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.F2XM1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.FSIN (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 3) then
    Instructions.FCOS (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 4) then
    Instructions.FPTAN (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 5) then
    Instructions.FSINCOS (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 6) then
    Instructions.FPATAN (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 7) then
    Instructions.FYL2X (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 8) then
    Instructions.FYL2XP1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.FNSTENV_MEMmem14_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 10) then
    Runtime.liftTotal (Instructions.FNSTENV_MEMmem28_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 11) then
    Runtime.liftTotal (Instructions.FNSTENV_MEMmem28_3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FST_MEMmem32real_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Runtime.liftTotal (Instructions.FSTP_MEMmem32real_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FSTPNCE_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 15) then
    Instructions.FLD_ST0_MEMmem32real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 16) then
    Runtime.liftTotal (Instructions.FLD_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 17) then
    Runtime.liftTotal (Instructions.FLD1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 18) then
    Runtime.liftTotal (Instructions.FLDL2T (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 19) then
    Runtime.liftTotal (Instructions.FLDL2E (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 20) then
    Runtime.liftTotal (Instructions.FLDPI (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 21) then
    Runtime.liftTotal (Instructions.FLDLG2 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 22) then
    Runtime.liftTotal (Instructions.FLDLN2 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 23) then
    Runtime.liftTotal (Instructions.FLDZ (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 24) then
    Runtime.liftTotal (Instructions.FLDCW_MEMmem16 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 25) then
    Runtime.liftTotal (Instructions.FNSTCW_MEMmem16 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 26) then
    Runtime.liftTotal (Instructions.FCHS (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 27) then
    Runtime.liftTotal (Instructions.FXCH_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 28) then
    Runtime.liftTotal (Instructions.FABS (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 29) then
    Runtime.liftTotal (Instructions.FDECSTP (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 30) then
    Runtime.liftTotal (Instructions.FINCSTP (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 31) then
    Runtime.liftTotal (Instructions.FNOP (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 32) then
    Runtime.liftTotal (Instructions.FTST (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 33) then
    Runtime.liftTotal (Instructions.FXAM (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 34) then
    Runtime.liftTotal (Instructions.FRNDINT (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 35) then
    Runtime.liftTotal (Instructions.FSCALE (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 36) then
    Instructions.FXTRACT (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 37) then
    Runtime.liftTotal (Instructions.FLDENV_MEMmem14_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 38) then
    Runtime.liftTotal (Instructions.FLDENV_MEMmem28_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 39) then
    Runtime.liftTotal (Instructions.FLDENV_MEMmem28_3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 40) then
    Runtime.liftTotal (Instructions.FSQRT (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 41) then
    Runtime.liftTotal (Instructions.FPREM (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 42) then
    Runtime.liftTotal (Instructions.FPREM1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  -- Intel SDM 325462-093, operand encoding PDF1111, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 1 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 1 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 2 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 3 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 4 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 5 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 2 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 2 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 3 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_DA
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_DA context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.FIADD_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Instructions.FISUB_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 3) then
    Instructions.FIMUL_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FCMOVB_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Runtime.liftTotal (Instructions.FCMOVE_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.FCMOVBE_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.FCMOVU_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 8) then
    Runtime.liftTotal (Instructions.FUCOMPP (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 9) then
    Instructions.FICOM_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 10) then
    Instructions.FICOMP_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 11) then
    Instructions.FISUBR_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 12) then
    Instructions.FIDIV_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 13) then
    Instructions.FIDIVR_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  -- Intel SDM 325462-093, operand encoding PDF1098, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, operand encoding PDF1037, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, operand encoding PDF1040, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 0 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 2 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 3 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 4 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 5 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_DB
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_DB context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Runtime.liftTotal (Instructions.FUCOMI_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.FCOMI_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 3) then
    Runtime.liftTotal (Instructions.FIST_MEMmem32int_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FISTP_MEMmem32int_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Runtime.liftTotal (Instructions.FSTP_MEMmem80real_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 6) then
    Instructions.FILD_ST0_MEMmem32int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.FLD_ST0_MEMmem80real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 8) then
    Runtime.liftTotal (Instructions.FNCLEX (← Std.Bits.Add_int (n := 64) ip 2) context)
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.FNINIT (← Std.Bits.Add_int (n := 64) ip 2) context)
    return ()
  if (decoder_form_index == 10) then
    Runtime.liftTotal (Instructions.FCMOVNB_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 11) then
    Runtime.liftTotal (Instructions.FCMOVNE_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FCMOVNBE_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Runtime.liftTotal (Instructions.FCMOVNU_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FENI8087_NOP (← Std.Bits.Add_int (n := 64) ip 2) context)
    return ()
  if (decoder_form_index == 15) then
    Runtime.liftTotal (Instructions.FDISI8087_NOP (← Std.Bits.Add_int (n := 64) ip 2) context)
    return ()
  if (decoder_form_index == 16) then
    Runtime.liftTotal (Instructions.FSETPM287_NOP (← Std.Bits.Add_int (n := 64) ip 2) context)
    return ()
  -- Intel SDM 325462-093, operand encoding PDF1031, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, operand encoding PDF1090, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, opcode PDF1024, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 2 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, opcode PDF1049, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 3 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 5 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 4 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_DC
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_DC context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.FADD_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.FADD_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 3) then
    Instructions.FSUB_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FSUB_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Instructions.FMUL_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.FMUL_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 7) then
    Instructions.FCOM_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 8) then
    Instructions.FCOMP_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.FCOM_ST0_X87_DCD0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 10) then
    Runtime.liftTotal (Instructions.FCOMP_ST0_X87_DCD1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 11) then
    Instructions.FSUBR_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FSUBR_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Instructions.FDIV_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FDIV_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 15) then
    Instructions.FDIVR_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 16) then
    Runtime.liftTotal (Instructions.FDIVR_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_DD
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_DD context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Runtime.liftTotal (Instructions.FNSAVE_MEMmem108_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.FNSAVE_MEMmem108_3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 3) then
    Runtime.liftTotal (Instructions.FNSAVE_MEMmem94_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FST_MEMm64real_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Runtime.liftTotal (Instructions.FSTP_MEMm64real_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.FST_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.FSTP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 8) then
    Instructions.FLD_ST0_MEMm64real (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.FXCH_ST0_X87_DDC1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 10) then
    Runtime.liftTotal (Instructions.FFREE_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 11) then
    Runtime.liftTotal (Instructions.FNSTSW_MEMmem16 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FUCOM_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Runtime.liftTotal (Instructions.FUCOMP_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FRSTOR_MEMmem108_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 15) then
    Runtime.liftTotal (Instructions.FRSTOR_MEMmem108_3 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  if (decoder_form_index == 16) then
    Runtime.liftTotal (Instructions.FRSTOR_MEMmem94_2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm)
    return ()
  -- Intel SDM 325462-093, FSAVE/FNSAVE Vol.2A3-375 (PDF1079), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 6 and ((← Runtime.liftTotal (In_64Bit_Mode)) and context.rex_w == 1)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FSAVE/FNSAVE Vol.2A3-375 (PDF1079), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 6 and ((← Runtime.liftTotal (In_64Bit_Mode)) and not context.osz_prefix_present and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FSAVE/FNSAVE Vol.2A3-375 (PDF1079), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 6 and ((← Runtime.liftTotal (In_64Bit_Mode)) and context.osz_prefix_present and context.rex_w == 0)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, FSTSW/FNSTSW Vol.2A3-392 (PDF1096), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, operand encoding PDF1106, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) != 3 and (← modrm[5:3]) == 5 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_DE
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_DE context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.FIADD_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.FADDP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 3) then
    Instructions.FISUB_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FSUBP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Instructions.FIMUL_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.FMULP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.FCOMPP (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 8) then
    Runtime.liftTotal (Instructions.FCOMP_ST0_X87_DED0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 9) then
    Instructions.FICOM_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 10) then
    Instructions.FICOMP_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 11) then
    Instructions.FISUBR_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FSUBRP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Instructions.FIDIV_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FDIVP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 15) then
    Instructions.FIDIVR_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 16) then
    Runtime.liftTotal (Instructions.FDIVRP_X87_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 0 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 2 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 3 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 4 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 5 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_DF
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Runtime.liftTotal (Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8)
  let mod : Bits 2 ← modrm[7:6]
  let reg : Bits 3 ← modrm[5:3]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_DF context (← Runtime.liftTotal (In_64Bit_Mode)) (← Runtime.liftTotal (CPUID_LZCNT)) (← Runtime.liftTotal (CPUID_MMX)) (← Runtime.liftTotal (CPUID_SSE)) (← Runtime.liftTotal (CPUID_SSE2)) (← Runtime.liftTotal (CPUID_CET_SS)) (← Runtime.liftTotal (CPUID_CMPXCHG16B)) modrm
  if (decoder_form_index == 1) then
    Instructions.FBLD_ST0_MEMmem80dec (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 2) then
    Runtime.liftTotal (Instructions.FBSTP_MEMmem80dec_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 3) then
    Runtime.liftTotal (Instructions.FUCOMIP_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 4) then
    Runtime.liftTotal (Instructions.FCOMIP_ST0_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 5) then
    Runtime.liftTotal (Instructions.FIST_MEMmem16int_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 6) then
    Runtime.liftTotal (Instructions.FISTP_MEMmem16int_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 7) then
    Runtime.liftTotal (Instructions.FISTP_MEMm64int_ST0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 8) then
    Runtime.liftTotal (Instructions.FSTP_X87_ST0_DFD0 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 9) then
    Runtime.liftTotal (Instructions.FSTP_X87_ST0_DFD1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 10) then
    Instructions.FILD_ST0_MEMmem16int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 11) then
    Instructions.FILD_ST0_MEMm64int (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode
    return ()
  if (decoder_form_index == 12) then
    Runtime.liftTotal (Instructions.FXCH_ST0_X87_DFC1 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 13) then
    Runtime.liftTotal (Instructions.FFREEP_X87 (← Std.Bits.Add_int (n := 64) ip 2) context mod reg rm opcode)
    return ()
  if (decoder_form_index == 14) then
    Runtime.liftTotal (Instructions.FNSTSW_AX (← Std.Bits.Add_int (n := 64) ip 2) context)
    return ()
  -- Intel SDM 325462-093, operand encoding PDF1051, invalid operand type #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 1 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 2 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 3 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 4 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 5 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 6 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 4 and (← modrm[2:0]) == 7 and (← Runtime.liftTotal (In_64Bit_Mode))) then
    liftM (Report_Invalid_Opcode)
  Runtime.liftTotal (Unimplemented_Feature "unselected instruction form" false true)

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E0 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.LOOPNE_RELBRb_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.LOOPE_RELBRb_2 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E2 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.LOOP_RELBRb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E3
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E3 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JCXZ_RELBRb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 2) then
    Instructions.JECXZ_RELBRb_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  if (decoder_form_index == 3) then
    Instructions.JRCXZ_RELBRb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.IN_AL_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.IN_OeAX_IMMb (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.OUT_IMMb_AL (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.OUT_IMMb_OeAX (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CALL_NEAR_RELBRd (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_E9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_E9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JMP_RELBRd (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_EB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_EB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.JMP_RELBRb_1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_EC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_EC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.IN_AL_DX (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_ED
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_ED context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.IN_OeAX_DX (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_EE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_EE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.OUT_DX_AL (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_EF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_EF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.OUT_DX_OeAX (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F1 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.INT1 (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F4
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F4 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.HLT (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F5
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F5 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CMC (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F6
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F6 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.IMUL_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.IMUL_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.MUL_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.MUL_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.DIV_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.DIV_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.NEG_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.NEG_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.NEG_LOCK_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.IDIV_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.IDIV_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.NOT_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.NOT_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.NOT_LOCK_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.TEST_GPR8_IMMb_F6r0 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.TEST_MEMb_IMMb_F6r0 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 17) then
    Instructions.TEST_GPR8_IMMb_F6r1 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 18) then
    Instructions.TEST_MEMb_IMMb_F6r1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F7
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F7 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.IMUL_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.IMUL_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.MUL_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.MUL_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.DIV_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.DIV_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.NEG_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.NEG_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.NEG_LOCK_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.IDIV_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.IDIV_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.NOT_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.NOT_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.NOT_LOCK_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 15) then
    Instructions.TEST_GPRv_IMMz_F7r0 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 16) then
    Instructions.TEST_MEMv_IMMz_F7r0 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 17) then
    Instructions.TEST_GPRv_IMMz_F7r1 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 18) then
    Instructions.TEST_MEMv_IMMz_F7r1 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F8
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F8 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CLC (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_F9
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_F9 context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.STC (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_FA
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_FA context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CLI (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_FB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_FB context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.STI (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_FC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_FC context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.CLD (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_FD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_FD context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) (← Std.Bits.Zero 8)
  if (decoder_form_index == 1) then
    Instructions.STD (← Std.Bits.Add_int (n := 64) ip 1) context
    return ()
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_FE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_FE context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.DEC_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.DEC_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.DEC_LOCK_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.INC_GPR8 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.INC_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.INC_LOCK_MEMb (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 2 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 4 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 6 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  if ((← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

@[noinline, nospecialize]
def Decode_Legacy_0_Opcode_FF
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let modrm : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 1) 8
  let mod : Bits 2 ← modrm[7:6]
  let rm : Bits 3 ← modrm[2:0]
  let decoder_form_index : Int ← Select_Legacy_0_Opcode_FF context (← In_64Bit_Mode) (← CPUID_LZCNT) (← CPUID_MMX) (← CPUID_SSE) (← CPUID_SSE2) (← CPUID_CET_SS) (← CPUID_CMPXCHG16B) modrm
  if (decoder_form_index == 1) then
    Instructions.PUSH_GPRv_FFr6 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 2) then
    Instructions.PUSH_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 3) then
    Instructions.CALL_NEAR_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 4) then
    Instructions.CALL_NEAR_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 5) then
    Instructions.CALL_FAR_MEMp2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 6) then
    Instructions.JMP_FAR_MEMp2 (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 7) then
    Instructions.JMP_GPRv (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 8) then
    Instructions.JMP_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 9) then
    Instructions.DEC_GPRv_FFr1 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 10) then
    Instructions.DEC_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 11) then
    Instructions.DEC_LOCK_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 12) then
    Instructions.INC_GPRv_FFr0 (← Std.Bits.Add_int (n := 64) ip 2) context rm
    return ()
  if (decoder_form_index == 13) then
    Instructions.INC_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  if (decoder_form_index == 14) then
    Instructions.INC_LOCK_MEMv (← Std.Bits.Add_int (n := 64) ip 2) context mod rm
    return ()
  -- Intel SDM 325462-093, CALL Vol.2A3-121 (PDF825), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 3 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, JMP Vol.2A3-504 (PDF1208), #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[7:6]) == 3 and (← modrm[5:3]) == 5 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  -- Intel SDM 325462-093, blank opcode-map encodings are reserved (PDF2996, PDF3006, PDF3011-3017), reserved opcode #UD Vol.3A7-32 (PDF3382)
  if ((← modrm[5:3]) == 7 and (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)
  Unimplemented_Feature "unselected instruction form" false true

def Legacy_0_Uses_ModRM (opcode : Bits 8) : Except (Runtime.Error Empty) (Bool) := do
  match Unsigned opcode with
  | 0b00000000 => do
    return true
  | 0b00000001 => do
    return true
  | 0b00000010 => do
    return true
  | 0b00000011 => do
    return true
  | 0b00001000 => do
    return true
  | 0b00001001 => do
    return true
  | 0b00001010 => do
    return true
  | 0b00001011 => do
    return true
  | 0b00010000 => do
    return true
  | 0b00010001 => do
    return true
  | 0b00010010 => do
    return true
  | 0b00010011 => do
    return true
  | 0b00011000 => do
    return true
  | 0b00011001 => do
    return true
  | 0b00011010 => do
    return true
  | 0b00011011 => do
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
  | 0b00110000 => do
    return true
  | 0b00110001 => do
    return true
  | 0b00110010 => do
    return true
  | 0b00110011 => do
    return true
  | 0b00111000 => do
    return true
  | 0b00111001 => do
    return true
  | 0b00111010 => do
    return true
  | 0b00111011 => do
    return true
  | 0b01100011 => do
    return true
  | 0b01101001 => do
    return true
  | 0b01101011 => do
    return true
  | 0b10000000 => do
    return true
  | 0b10000001 => do
    return true
  | 0b10000011 => do
    return true
  | 0b10000100 => do
    return true
  | 0b10000101 => do
    return true
  | 0b10000110 => do
    return true
  | 0b10000111 => do
    return true
  | 0b10001000 => do
    return true
  | 0b10001001 => do
    return true
  | 0b10001010 => do
    return true
  | 0b10001011 => do
    return true
  | 0b10001100 => do
    return true
  | 0b10001101 => do
    return true
  | 0b10001110 => do
    return true
  | 0b10001111 => do
    return true
  | 0b11000000 => do
    return true
  | 0b11000001 => do
    return true
  | 0b11000110 => do
    return true
  | 0b11000111 => do
    return true
  | 0b11010000 => do
    return true
  | 0b11010001 => do
    return true
  | 0b11010010 => do
    return true
  | 0b11010011 => do
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
  | 0b11110110 => do
    return true
  | 0b11110111 => do
    return true
  | 0b11111110 => do
    return true
  | 0b11111111 => do
    return true
  | _ => do
    return false

def Select_Legacy_0
    (_context : Instruction_Context) (_mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B : Bool) (opcode _modrm : Bits 8) :
    Except (Runtime.Error Empty) (Int) := do
  if _context.rex2_prefix_present then
    return 0
  match Unsigned opcode with
  | 0b00000000 => do
    return (← Select_Legacy_0_Opcode_00 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000001 => do
    return (← Select_Legacy_0_Opcode_01 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000010 => do
    return (← Select_Legacy_0_Opcode_02 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000011 => do
    return (← Select_Legacy_0_Opcode_03 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000100 => do
    return (← Select_Legacy_0_Opcode_04 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00000101 => do
    return (← Select_Legacy_0_Opcode_05 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001000 => do
    return (← Select_Legacy_0_Opcode_08 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001001 => do
    return (← Select_Legacy_0_Opcode_09 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001010 => do
    return (← Select_Legacy_0_Opcode_0A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001011 => do
    return (← Select_Legacy_0_Opcode_0B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001100 => do
    return (← Select_Legacy_0_Opcode_0C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00001101 => do
    return (← Select_Legacy_0_Opcode_0D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010000 => do
    return (← Select_Legacy_0_Opcode_10 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010001 => do
    return (← Select_Legacy_0_Opcode_11 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010010 => do
    return (← Select_Legacy_0_Opcode_12 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010011 => do
    return (← Select_Legacy_0_Opcode_13 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010100 => do
    return (← Select_Legacy_0_Opcode_14 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00010101 => do
    return (← Select_Legacy_0_Opcode_15 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011000 => do
    return (← Select_Legacy_0_Opcode_18 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011001 => do
    return (← Select_Legacy_0_Opcode_19 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011010 => do
    return (← Select_Legacy_0_Opcode_1A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011011 => do
    return (← Select_Legacy_0_Opcode_1B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011100 => do
    return (← Select_Legacy_0_Opcode_1C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00011101 => do
    return (← Select_Legacy_0_Opcode_1D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100000 => do
    return (← Select_Legacy_0_Opcode_20 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100001 => do
    return (← Select_Legacy_0_Opcode_21 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100010 => do
    return (← Select_Legacy_0_Opcode_22 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100011 => do
    return (← Select_Legacy_0_Opcode_23 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100100 => do
    return (← Select_Legacy_0_Opcode_24 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00100101 => do
    return (← Select_Legacy_0_Opcode_25 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101000 => do
    return (← Select_Legacy_0_Opcode_28 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101001 => do
    return (← Select_Legacy_0_Opcode_29 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101010 => do
    return (← Select_Legacy_0_Opcode_2A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101011 => do
    return (← Select_Legacy_0_Opcode_2B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101100 => do
    return (← Select_Legacy_0_Opcode_2C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00101101 => do
    return (← Select_Legacy_0_Opcode_2D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110000 => do
    return (← Select_Legacy_0_Opcode_30 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110001 => do
    return (← Select_Legacy_0_Opcode_31 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110010 => do
    return (← Select_Legacy_0_Opcode_32 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110011 => do
    return (← Select_Legacy_0_Opcode_33 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110100 => do
    return (← Select_Legacy_0_Opcode_34 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00110101 => do
    return (← Select_Legacy_0_Opcode_35 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00111000 => do
    return (← Select_Legacy_0_Opcode_38 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00111001 => do
    return (← Select_Legacy_0_Opcode_39 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00111010 => do
    return (← Select_Legacy_0_Opcode_3A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00111011 => do
    return (← Select_Legacy_0_Opcode_3B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00111100 => do
    return (← Select_Legacy_0_Opcode_3C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b00111101 => do
    return (← Select_Legacy_0_Opcode_3D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010000 => do
    return (← Select_Legacy_0_Opcode_50 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010001 => do
    return (← Select_Legacy_0_Opcode_51 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010010 => do
    return (← Select_Legacy_0_Opcode_52 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010011 => do
    return (← Select_Legacy_0_Opcode_53 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010100 => do
    return (← Select_Legacy_0_Opcode_54 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010101 => do
    return (← Select_Legacy_0_Opcode_55 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010110 => do
    return (← Select_Legacy_0_Opcode_56 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01010111 => do
    return (← Select_Legacy_0_Opcode_57 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011000 => do
    return (← Select_Legacy_0_Opcode_58 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011001 => do
    return (← Select_Legacy_0_Opcode_59 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011010 => do
    return (← Select_Legacy_0_Opcode_5A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011011 => do
    return (← Select_Legacy_0_Opcode_5B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011100 => do
    return (← Select_Legacy_0_Opcode_5C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011101 => do
    return (← Select_Legacy_0_Opcode_5D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011110 => do
    return (← Select_Legacy_0_Opcode_5E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01011111 => do
    return (← Select_Legacy_0_Opcode_5F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01100011 => do
    return (← Select_Legacy_0_Opcode_63 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101000 => do
    return (← Select_Legacy_0_Opcode_68 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101001 => do
    return (← Select_Legacy_0_Opcode_69 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101010 => do
    return (← Select_Legacy_0_Opcode_6A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101011 => do
    return (← Select_Legacy_0_Opcode_6B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101100 => do
    return (← Select_Legacy_0_Opcode_6C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101101 => do
    return (← Select_Legacy_0_Opcode_6D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101110 => do
    return (← Select_Legacy_0_Opcode_6E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01101111 => do
    return (← Select_Legacy_0_Opcode_6F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110000 => do
    return (← Select_Legacy_0_Opcode_70 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110001 => do
    return (← Select_Legacy_0_Opcode_71 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110010 => do
    return (← Select_Legacy_0_Opcode_72 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110011 => do
    return (← Select_Legacy_0_Opcode_73 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110100 => do
    return (← Select_Legacy_0_Opcode_74 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110101 => do
    return (← Select_Legacy_0_Opcode_75 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110110 => do
    return (← Select_Legacy_0_Opcode_76 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01110111 => do
    return (← Select_Legacy_0_Opcode_77 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111000 => do
    return (← Select_Legacy_0_Opcode_78 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111001 => do
    return (← Select_Legacy_0_Opcode_79 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111010 => do
    return (← Select_Legacy_0_Opcode_7A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111011 => do
    return (← Select_Legacy_0_Opcode_7B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111100 => do
    return (← Select_Legacy_0_Opcode_7C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111101 => do
    return (← Select_Legacy_0_Opcode_7D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111110 => do
    return (← Select_Legacy_0_Opcode_7E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b01111111 => do
    return (← Select_Legacy_0_Opcode_7F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000000 => do
    return (← Select_Legacy_0_Opcode_80 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000001 => do
    return (← Select_Legacy_0_Opcode_81 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000011 => do
    return (← Select_Legacy_0_Opcode_83 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000100 => do
    return (← Select_Legacy_0_Opcode_84 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000101 => do
    return (← Select_Legacy_0_Opcode_85 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000110 => do
    return (← Select_Legacy_0_Opcode_86 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10000111 => do
    return (← Select_Legacy_0_Opcode_87 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001000 => do
    return (← Select_Legacy_0_Opcode_88 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001001 => do
    return (← Select_Legacy_0_Opcode_89 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001010 => do
    return (← Select_Legacy_0_Opcode_8A _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001011 => do
    return (← Select_Legacy_0_Opcode_8B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001100 => do
    return (← Select_Legacy_0_Opcode_8C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001101 => do
    return (← Select_Legacy_0_Opcode_8D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001110 => do
    return (← Select_Legacy_0_Opcode_8E _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10001111 => do
    return (← Select_Legacy_0_Opcode_8F _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010000 => do
    return (← Select_Legacy_0_Opcode_90 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010001 => do
    return (← Select_Legacy_0_Opcode_91 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010010 => do
    return (← Select_Legacy_0_Opcode_92 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010011 => do
    return (← Select_Legacy_0_Opcode_93 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010100 => do
    return (← Select_Legacy_0_Opcode_94 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010101 => do
    return (← Select_Legacy_0_Opcode_95 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010110 => do
    return (← Select_Legacy_0_Opcode_96 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10010111 => do
    return (← Select_Legacy_0_Opcode_97 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011000 => do
    return (← Select_Legacy_0_Opcode_98 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011001 => do
    return (← Select_Legacy_0_Opcode_99 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011011 => do
    return (← Select_Legacy_0_Opcode_9B _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011100 => do
    return (← Select_Legacy_0_Opcode_9C _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10011101 => do
    return (← Select_Legacy_0_Opcode_9D _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100000 => do
    return (← Select_Legacy_0_Opcode_A0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100001 => do
    return (← Select_Legacy_0_Opcode_A1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100010 => do
    return (← Select_Legacy_0_Opcode_A2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100011 => do
    return (← Select_Legacy_0_Opcode_A3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100100 => do
    return (← Select_Legacy_0_Opcode_A4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100101 => do
    return (← Select_Legacy_0_Opcode_A5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100110 => do
    return (← Select_Legacy_0_Opcode_A6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10100111 => do
    return (← Select_Legacy_0_Opcode_A7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101000 => do
    return (← Select_Legacy_0_Opcode_A8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101001 => do
    return (← Select_Legacy_0_Opcode_A9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101010 => do
    return (← Select_Legacy_0_Opcode_AA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101011 => do
    return (← Select_Legacy_0_Opcode_AB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101100 => do
    return (← Select_Legacy_0_Opcode_AC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101101 => do
    return (← Select_Legacy_0_Opcode_AD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101110 => do
    return (← Select_Legacy_0_Opcode_AE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10101111 => do
    return (← Select_Legacy_0_Opcode_AF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110000 => do
    return (← Select_Legacy_0_Opcode_B0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110001 => do
    return (← Select_Legacy_0_Opcode_B1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110010 => do
    return (← Select_Legacy_0_Opcode_B2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110011 => do
    return (← Select_Legacy_0_Opcode_B3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110100 => do
    return (← Select_Legacy_0_Opcode_B4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110101 => do
    return (← Select_Legacy_0_Opcode_B5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110110 => do
    return (← Select_Legacy_0_Opcode_B6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10110111 => do
    return (← Select_Legacy_0_Opcode_B7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111000 => do
    return (← Select_Legacy_0_Opcode_B8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111001 => do
    return (← Select_Legacy_0_Opcode_B9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111010 => do
    return (← Select_Legacy_0_Opcode_BA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111011 => do
    return (← Select_Legacy_0_Opcode_BB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111100 => do
    return (← Select_Legacy_0_Opcode_BC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111101 => do
    return (← Select_Legacy_0_Opcode_BD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111110 => do
    return (← Select_Legacy_0_Opcode_BE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b10111111 => do
    return (← Select_Legacy_0_Opcode_BF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000000 => do
    return (← Select_Legacy_0_Opcode_C0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000001 => do
    return (← Select_Legacy_0_Opcode_C1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000010 => do
    return (← Select_Legacy_0_Opcode_C2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000011 => do
    return (← Select_Legacy_0_Opcode_C3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000110 => do
    return (← Select_Legacy_0_Opcode_C6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11000111 => do
    return (← Select_Legacy_0_Opcode_C7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001000 => do
    return (← Select_Legacy_0_Opcode_C8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001001 => do
    return (← Select_Legacy_0_Opcode_C9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001010 => do
    return (← Select_Legacy_0_Opcode_CA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001011 => do
    return (← Select_Legacy_0_Opcode_CB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001100 => do
    return (← Select_Legacy_0_Opcode_CC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001101 => do
    return (← Select_Legacy_0_Opcode_CD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11001111 => do
    return (← Select_Legacy_0_Opcode_CF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010000 => do
    return (← Select_Legacy_0_Opcode_D0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010001 => do
    return (← Select_Legacy_0_Opcode_D1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010010 => do
    return (← Select_Legacy_0_Opcode_D2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010011 => do
    return (← Select_Legacy_0_Opcode_D3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010110 => do
    return (← Select_Legacy_0_Opcode_D6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11010111 => do
    return (← Select_Legacy_0_Opcode_D7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011000 => do
    return (← Select_Legacy_0_Opcode_D8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011001 => do
    return (← Select_Legacy_0_Opcode_D9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011010 => do
    return (← Select_Legacy_0_Opcode_DA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011011 => do
    return (← Select_Legacy_0_Opcode_DB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011100 => do
    return (← Select_Legacy_0_Opcode_DC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011101 => do
    return (← Select_Legacy_0_Opcode_DD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011110 => do
    return (← Select_Legacy_0_Opcode_DE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11011111 => do
    return (← Select_Legacy_0_Opcode_DF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100000 => do
    return (← Select_Legacy_0_Opcode_E0 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100001 => do
    return (← Select_Legacy_0_Opcode_E1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100010 => do
    return (← Select_Legacy_0_Opcode_E2 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100011 => do
    return (← Select_Legacy_0_Opcode_E3 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100100 => do
    return (← Select_Legacy_0_Opcode_E4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100101 => do
    return (← Select_Legacy_0_Opcode_E5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100110 => do
    return (← Select_Legacy_0_Opcode_E6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11100111 => do
    return (← Select_Legacy_0_Opcode_E7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101000 => do
    return (← Select_Legacy_0_Opcode_E8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101001 => do
    return (← Select_Legacy_0_Opcode_E9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101011 => do
    return (← Select_Legacy_0_Opcode_EB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101100 => do
    return (← Select_Legacy_0_Opcode_EC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101101 => do
    return (← Select_Legacy_0_Opcode_ED _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101110 => do
    return (← Select_Legacy_0_Opcode_EE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11101111 => do
    return (← Select_Legacy_0_Opcode_EF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110001 => do
    return (← Select_Legacy_0_Opcode_F1 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110100 => do
    return (← Select_Legacy_0_Opcode_F4 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110101 => do
    return (← Select_Legacy_0_Opcode_F5 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110110 => do
    return (← Select_Legacy_0_Opcode_F6 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11110111 => do
    return (← Select_Legacy_0_Opcode_F7 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111000 => do
    return (← Select_Legacy_0_Opcode_F8 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111001 => do
    return (← Select_Legacy_0_Opcode_F9 _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111010 => do
    return (← Select_Legacy_0_Opcode_FA _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111011 => do
    return (← Select_Legacy_0_Opcode_FB _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111100 => do
    return (← Select_Legacy_0_Opcode_FC _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111101 => do
    return (← Select_Legacy_0_Opcode_FD _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111110 => do
    return (← Select_Legacy_0_Opcode_FE _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | 0b11111111 => do
    return (← Select_Legacy_0_Opcode_FF _context _mode64 _feature_CPUID_LZCNT _feature_CPUID_MMX _feature_CPUID_SSE _feature_CPUID_SSE2 _feature_CPUID_CET_SS _feature_CPUID_CMPXCHG16B _modrm)
  | _ => do
    return 0

def Legacy_0_Form_Names
    (opcode : Bits 8) (decoder_form_index : Int) :
    Except (Runtime.Error Empty) (String × String) := do
  match Unsigned opcode with
  | 0b00000000 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPR8_GPR8_00", "ADD_GPR8_GPR8_00")
    | 2 => do
      return ("ADD_MEMb_GPR8", "ADD_MEMb_GPR8")
    | 3 => do
      return ("ADD_LOCK_MEMb_GPR8", "ADD_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00000001 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPRv_GPRv_01", "ADD_GPRv_GPRv_01")
    | 2 => do
      return ("ADD_MEMv_GPRv", "ADD_MEMv_GPRv")
    | 3 => do
      return ("ADD_LOCK_MEMv_GPRv", "ADD_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00000010 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPR8_GPR8_02", "ADD_GPR8_GPR8_02")
    | 2 => do
      return ("ADD_GPR8_MEMb", "ADD_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00000011 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPRv_GPRv_03", "ADD_GPRv_GPRv_03")
    | 2 => do
      return ("ADD_GPRv_MEMv", "ADD_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00000100 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_AL_IMMb", "ADD_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00000101 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_OrAX_IMMz", "ADD_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00001000 => do
    match decoder_form_index with
    | 1 => do
      return ("OR_GPR8_GPR8_08", "OR_GPR8_GPR8_08")
    | 2 => do
      return ("OR_MEMb_GPR8", "OR_MEMb_GPR8")
    | 3 => do
      return ("OR_LOCK_MEMb_GPR8", "OR_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00001001 => do
    match decoder_form_index with
    | 1 => do
      return ("OR_GPRv_GPRv_09", "OR_GPRv_GPRv_09")
    | 2 => do
      return ("OR_MEMv_GPRv", "OR_MEMv_GPRv")
    | 3 => do
      return ("OR_LOCK_MEMv_GPRv", "OR_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00001010 => do
    match decoder_form_index with
    | 1 => do
      return ("OR_GPR8_GPR8_0A", "OR_GPR8_GPR8_0A")
    | 2 => do
      return ("OR_GPR8_MEMb", "OR_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00001011 => do
    match decoder_form_index with
    | 1 => do
      return ("OR_GPRv_GPRv_0B", "OR_GPRv_GPRv_0B")
    | 2 => do
      return ("OR_GPRv_MEMv", "OR_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00001100 => do
    match decoder_form_index with
    | 1 => do
      return ("OR_AL_IMMb", "OR_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00001101 => do
    match decoder_form_index with
    | 1 => do
      return ("OR_OrAX_IMMz", "OR_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00010000 => do
    match decoder_form_index with
    | 1 => do
      return ("ADC_GPR8_GPR8_10", "ADC_GPR8_GPR8_10")
    | 2 => do
      return ("ADC_MEMb_GPR8", "ADC_MEMb_GPR8")
    | 3 => do
      return ("ADC_LOCK_MEMb_GPR8", "ADC_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00010001 => do
    match decoder_form_index with
    | 1 => do
      return ("ADC_GPRv_GPRv_11", "ADC_GPRv_GPRv_11")
    | 2 => do
      return ("ADC_MEMv_GPRv", "ADC_MEMv_GPRv")
    | 3 => do
      return ("ADC_LOCK_MEMv_GPRv", "ADC_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00010010 => do
    match decoder_form_index with
    | 1 => do
      return ("ADC_GPR8_GPR8_12", "ADC_GPR8_GPR8_12")
    | 2 => do
      return ("ADC_GPR8_MEMb", "ADC_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00010011 => do
    match decoder_form_index with
    | 1 => do
      return ("ADC_GPRv_GPRv_13", "ADC_GPRv_GPRv_13")
    | 2 => do
      return ("ADC_GPRv_MEMv", "ADC_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00010100 => do
    match decoder_form_index with
    | 1 => do
      return ("ADC_AL_IMMb", "ADC_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00010101 => do
    match decoder_form_index with
    | 1 => do
      return ("ADC_OrAX_IMMz", "ADC_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00011000 => do
    match decoder_form_index with
    | 1 => do
      return ("SBB_GPR8_GPR8_18", "SBB_GPR8_GPR8_18")
    | 2 => do
      return ("SBB_MEMb_GPR8", "SBB_MEMb_GPR8")
    | 3 => do
      return ("SBB_LOCK_MEMb_GPR8", "SBB_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00011001 => do
    match decoder_form_index with
    | 1 => do
      return ("SBB_GPRv_GPRv_19", "SBB_GPRv_GPRv_19")
    | 2 => do
      return ("SBB_MEMv_GPRv", "SBB_MEMv_GPRv")
    | 3 => do
      return ("SBB_LOCK_MEMv_GPRv", "SBB_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00011010 => do
    match decoder_form_index with
    | 1 => do
      return ("SBB_GPR8_GPR8_1A", "SBB_GPR8_GPR8_1A")
    | 2 => do
      return ("SBB_GPR8_MEMb", "SBB_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00011011 => do
    match decoder_form_index with
    | 1 => do
      return ("SBB_GPRv_GPRv_1B", "SBB_GPRv_GPRv_1B")
    | 2 => do
      return ("SBB_GPRv_MEMv", "SBB_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00011100 => do
    match decoder_form_index with
    | 1 => do
      return ("SBB_AL_IMMb", "SBB_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00011101 => do
    match decoder_form_index with
    | 1 => do
      return ("SBB_OrAX_IMMz", "SBB_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00100000 => do
    match decoder_form_index with
    | 1 => do
      return ("AND_GPR8_GPR8_20", "AND_GPR8_GPR8_20")
    | 2 => do
      return ("AND_MEMb_GPR8", "AND_MEMb_GPR8")
    | 3 => do
      return ("AND_LOCK_MEMb_GPR8", "AND_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00100001 => do
    match decoder_form_index with
    | 1 => do
      return ("AND_GPRv_GPRv_21", "AND_GPRv_GPRv_21")
    | 2 => do
      return ("AND_MEMv_GPRv", "AND_MEMv_GPRv")
    | 3 => do
      return ("AND_LOCK_MEMv_GPRv", "AND_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00100010 => do
    match decoder_form_index with
    | 1 => do
      return ("AND_GPR8_GPR8_22", "AND_GPR8_GPR8_22")
    | 2 => do
      return ("AND_GPR8_MEMb", "AND_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00100011 => do
    match decoder_form_index with
    | 1 => do
      return ("AND_GPRv_GPRv_23", "AND_GPRv_GPRv_23")
    | 2 => do
      return ("AND_GPRv_MEMv", "AND_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00100100 => do
    match decoder_form_index with
    | 1 => do
      return ("AND_AL_IMMb", "AND_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00100101 => do
    match decoder_form_index with
    | 1 => do
      return ("AND_OrAX_IMMz", "AND_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00101000 => do
    match decoder_form_index with
    | 1 => do
      return ("SUB_GPR8_GPR8_28", "SUB_GPR8_GPR8_28")
    | 2 => do
      return ("SUB_MEMb_GPR8", "SUB_MEMb_GPR8")
    | 3 => do
      return ("SUB_LOCK_MEMb_GPR8", "SUB_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00101001 => do
    match decoder_form_index with
    | 1 => do
      return ("SUB_GPRv_GPRv_29", "SUB_GPRv_GPRv_29")
    | 2 => do
      return ("SUB_MEMv_GPRv", "SUB_MEMv_GPRv")
    | 3 => do
      return ("SUB_LOCK_MEMv_GPRv", "SUB_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00101010 => do
    match decoder_form_index with
    | 1 => do
      return ("SUB_GPR8_GPR8_2A", "SUB_GPR8_GPR8_2A")
    | 2 => do
      return ("SUB_GPR8_MEMb", "SUB_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00101011 => do
    match decoder_form_index with
    | 1 => do
      return ("SUB_GPRv_GPRv_2B", "SUB_GPRv_GPRv_2B")
    | 2 => do
      return ("SUB_GPRv_MEMv", "SUB_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00101100 => do
    match decoder_form_index with
    | 1 => do
      return ("SUB_AL_IMMb", "SUB_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00101101 => do
    match decoder_form_index with
    | 1 => do
      return ("SUB_OrAX_IMMz", "SUB_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00110000 => do
    match decoder_form_index with
    | 1 => do
      return ("XOR_GPR8_GPR8_30", "XOR_GPR8_GPR8_30")
    | 2 => do
      return ("XOR_MEMb_GPR8", "XOR_MEMb_GPR8")
    | 3 => do
      return ("XOR_LOCK_MEMb_GPR8", "XOR_LOCK_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00110001 => do
    match decoder_form_index with
    | 1 => do
      return ("XOR_GPRv_GPRv_31", "XOR_GPRv_GPRv_31")
    | 2 => do
      return ("XOR_MEMv_GPRv", "XOR_MEMv_GPRv")
    | 3 => do
      return ("XOR_LOCK_MEMv_GPRv", "XOR_LOCK_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00110010 => do
    match decoder_form_index with
    | 1 => do
      return ("XOR_GPR8_GPR8_32", "XOR_GPR8_GPR8_32")
    | 2 => do
      return ("XOR_GPR8_MEMb", "XOR_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00110011 => do
    match decoder_form_index with
    | 1 => do
      return ("XOR_GPRv_GPRv_33", "XOR_GPRv_GPRv_33")
    | 2 => do
      return ("XOR_GPRv_MEMv", "XOR_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00110100 => do
    match decoder_form_index with
    | 1 => do
      return ("XOR_AL_IMMb", "XOR_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00110101 => do
    match decoder_form_index with
    | 1 => do
      return ("XOR_OrAX_IMMz", "XOR_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b00111000 => do
    match decoder_form_index with
    | 1 => do
      return ("CMP_GPR8_GPR8_38", "CMP_GPR8_GPR8_38")
    | 2 => do
      return ("CMP_MEMb_GPR8", "CMP_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b00111001 => do
    match decoder_form_index with
    | 1 => do
      return ("CMP_GPRv_GPRv_39", "CMP_GPRv_GPRv_39")
    | 2 => do
      return ("CMP_MEMv_GPRv", "CMP_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b00111010 => do
    match decoder_form_index with
    | 1 => do
      return ("CMP_GPR8_GPR8_3A", "CMP_GPR8_GPR8_3A")
    | 2 => do
      return ("CMP_GPR8_MEMb", "CMP_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b00111011 => do
    match decoder_form_index with
    | 1 => do
      return ("CMP_GPRv_GPRv_3B", "CMP_GPRv_GPRv_3B")
    | 2 => do
      return ("CMP_GPRv_MEMv", "CMP_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b00111100 => do
    match decoder_form_index with
    | 1 => do
      return ("CMP_AL_IMMb", "CMP_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b00111101 => do
    match decoder_form_index with
    | 1 => do
      return ("CMP_OrAX_IMMz", "CMP_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b01010000 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010001 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010010 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010011 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010100 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010101 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010110 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01010111 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_50_0", "PUSH_GPRv_50")
    | _ => do
      return ("", "")
  | 0b01011000 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011001 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011010 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011011 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011100 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011101 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011110 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01011111 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_58_0", "POP_GPRv_58")
    | _ => do
      return ("", "")
  | 0b01100011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVSXD_GPR64_MEMd_0", "MOVSXD_GPR64_MEMd")
    | 2 => do
      return ("MOVSXD_GPRv_GPRz", "MOVSXD_GPRv_GPRz")
    | 3 => do
      return ("MOVSXD_GPRz_MEMz", "MOVSXD_GPRz_MEMz")
    | _ => do
      return ("", "")
  | 0b01101000 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_IMMz", "PUSH_IMMz")
    | _ => do
      return ("", "")
  | 0b01101001 => do
    match decoder_form_index with
    | 1 => do
      return ("IMUL_GPRv_GPRv_IMMz", "IMUL_GPRv_GPRv_IMMz")
    | 2 => do
      return ("IMUL_GPRv_MEMv_IMMz", "IMUL_GPRv_MEMv_IMMz")
    | _ => do
      return ("", "")
  | 0b01101010 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_IMMb", "PUSH_IMMb")
    | _ => do
      return ("", "")
  | 0b01101011 => do
    match decoder_form_index with
    | 1 => do
      return ("IMUL_GPRv_GPRv_IMMb", "IMUL_GPRv_GPRv_IMMb")
    | 2 => do
      return ("IMUL_GPRv_MEMv_IMMb", "IMUL_GPRv_MEMv_IMMb")
    | _ => do
      return ("", "")
  | 0b01101100 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_INSB_1", "REP_INSB")
    | 2 => do
      return ("REP_INSB_0", "REP_INSB")
    | 3 => do
      return ("INSB", "INSB")
    | _ => do
      return ("", "")
  | 0b01101101 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_INSD_6", "REP_INSD")
    | 2 => do
      return ("REP_INSD_7", "REP_INSD")
    | 3 => do
      return ("REP_INSW_5", "REP_INSW")
    | 4 => do
      return ("REP_INSD_2", "REP_INSD")
    | 5 => do
      return ("REP_INSD_3", "REP_INSD")
    | 6 => do
      return ("REP_INSW_2", "REP_INSW")
    | 7 => do
      return ("INSD_3", "INSD")
    | 8 => do
      return ("INSW_2", "INSW")
    | 9 => do
      return ("INSD_2", "INSD")
    | _ => do
      return ("", "")
  | 0b01101110 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_OUTSB_1", "REP_OUTSB")
    | 2 => do
      return ("REP_OUTSB_0", "REP_OUTSB")
    | 3 => do
      return ("OUTSB", "OUTSB")
    | _ => do
      return ("", "")
  | 0b01101111 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_OUTSD_6", "REP_OUTSD")
    | 2 => do
      return ("REP_OUTSD_7", "REP_OUTSD")
    | 3 => do
      return ("REP_OUTSW_5", "REP_OUTSW")
    | 4 => do
      return ("REP_OUTSD_2", "REP_OUTSD")
    | 5 => do
      return ("REP_OUTSD_3", "REP_OUTSD")
    | 6 => do
      return ("REP_OUTSW_2", "REP_OUTSW")
    | 7 => do
      return ("OUTSD_3", "OUTSD")
    | 8 => do
      return ("OUTSW_2", "OUTSW")
    | 9 => do
      return ("OUTSD_2", "OUTSD")
    | _ => do
      return ("", "")
  | 0b01110000 => do
    match decoder_form_index with
    | 1 => do
      return ("JO_RELBRb_0", "JO_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110001 => do
    match decoder_form_index with
    | 1 => do
      return ("JNO_RELBRb_0", "JNO_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110010 => do
    match decoder_form_index with
    | 1 => do
      return ("JB_RELBRb_0", "JB_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110011 => do
    match decoder_form_index with
    | 1 => do
      return ("JNB_RELBRb_0", "JNB_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110100 => do
    match decoder_form_index with
    | 1 => do
      return ("JZ_RELBRb_0", "JZ_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110101 => do
    match decoder_form_index with
    | 1 => do
      return ("JNZ_RELBRb_0", "JNZ_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110110 => do
    match decoder_form_index with
    | 1 => do
      return ("JBE_RELBRb_0", "JBE_RELBRb")
    | _ => do
      return ("", "")
  | 0b01110111 => do
    match decoder_form_index with
    | 1 => do
      return ("JNBE_RELBRb_0", "JNBE_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111000 => do
    match decoder_form_index with
    | 1 => do
      return ("JS_RELBRb_0", "JS_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111001 => do
    match decoder_form_index with
    | 1 => do
      return ("JNS_RELBRb_0", "JNS_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111010 => do
    match decoder_form_index with
    | 1 => do
      return ("JP_RELBRb_0", "JP_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111011 => do
    match decoder_form_index with
    | 1 => do
      return ("JNP_RELBRb_0", "JNP_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111100 => do
    match decoder_form_index with
    | 1 => do
      return ("JL_RELBRb_0", "JL_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111101 => do
    match decoder_form_index with
    | 1 => do
      return ("JNL_RELBRb_0", "JNL_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111110 => do
    match decoder_form_index with
    | 1 => do
      return ("JLE_RELBRb_0", "JLE_RELBRb")
    | _ => do
      return ("", "")
  | 0b01111111 => do
    match decoder_form_index with
    | 1 => do
      return ("JNLE_RELBRb_0", "JNLE_RELBRb")
    | _ => do
      return ("", "")
  | 0b10000000 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPR8_IMMb_80r0", "ADD_GPR8_IMMb_80r0")
    | 2 => do
      return ("ADD_MEMb_IMMb_80r0", "ADD_MEMb_IMMb_80r0")
    | 3 => do
      return ("ADD_LOCK_MEMb_IMMb_80r0", "ADD_LOCK_MEMb_IMMb_80r0")
    | 4 => do
      return ("ADC_GPR8_IMMb_80r2", "ADC_GPR8_IMMb_80r2")
    | 5 => do
      return ("ADC_MEMb_IMMb_80r2", "ADC_MEMb_IMMb_80r2")
    | 6 => do
      return ("ADC_LOCK_MEMb_IMMb_80r2", "ADC_LOCK_MEMb_IMMb_80r2")
    | 7 => do
      return ("SBB_GPR8_IMMb_80r3", "SBB_GPR8_IMMb_80r3")
    | 8 => do
      return ("SBB_MEMb_IMMb_80r3", "SBB_MEMb_IMMb_80r3")
    | 9 => do
      return ("SBB_LOCK_MEMb_IMMb_80r3", "SBB_LOCK_MEMb_IMMb_80r3")
    | 10 => do
      return ("XOR_GPR8_IMMb_80r6", "XOR_GPR8_IMMb_80r6")
    | 11 => do
      return ("XOR_MEMb_IMMb_80r6", "XOR_MEMb_IMMb_80r6")
    | 12 => do
      return ("XOR_LOCK_MEMb_IMMb_80r6", "XOR_LOCK_MEMb_IMMb_80r6")
    | 13 => do
      return ("SUB_GPR8_IMMb_80r5", "SUB_GPR8_IMMb_80r5")
    | 14 => do
      return ("SUB_MEMb_IMMb_80r5", "SUB_MEMb_IMMb_80r5")
    | 15 => do
      return ("SUB_LOCK_MEMb_IMMb_80r5", "SUB_LOCK_MEMb_IMMb_80r5")
    | 16 => do
      return ("CMP_GPR8_IMMb_80r7", "CMP_GPR8_IMMb_80r7")
    | 17 => do
      return ("CMP_MEMb_IMMb_80r7", "CMP_MEMb_IMMb_80r7")
    | 18 => do
      return ("AND_GPR8_IMMb_80r4", "AND_GPR8_IMMb_80r4")
    | 19 => do
      return ("AND_MEMb_IMMb_80r4", "AND_MEMb_IMMb_80r4")
    | 20 => do
      return ("AND_LOCK_MEMb_IMMb_80r4", "AND_LOCK_MEMb_IMMb_80r4")
    | 21 => do
      return ("OR_GPR8_IMMb_80r1", "OR_GPR8_IMMb_80r1")
    | 22 => do
      return ("OR_MEMb_IMMb_80r1", "OR_MEMb_IMMb_80r1")
    | 23 => do
      return ("OR_LOCK_MEMb_IMMb_80r1", "OR_LOCK_MEMb_IMMb_80r1")
    | _ => do
      return ("", "")
  | 0b10000001 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPRv_IMMz", "ADD_GPRv_IMMz")
    | 2 => do
      return ("ADD_MEMv_IMMz", "ADD_MEMv_IMMz")
    | 3 => do
      return ("ADD_LOCK_MEMv_IMMz", "ADD_LOCK_MEMv_IMMz")
    | 4 => do
      return ("ADC_GPRv_IMMz", "ADC_GPRv_IMMz")
    | 5 => do
      return ("ADC_MEMv_IMMz", "ADC_MEMv_IMMz")
    | 6 => do
      return ("ADC_LOCK_MEMv_IMMz", "ADC_LOCK_MEMv_IMMz")
    | 7 => do
      return ("SBB_GPRv_IMMz", "SBB_GPRv_IMMz")
    | 8 => do
      return ("SBB_MEMv_IMMz", "SBB_MEMv_IMMz")
    | 9 => do
      return ("SBB_LOCK_MEMv_IMMz", "SBB_LOCK_MEMv_IMMz")
    | 10 => do
      return ("XOR_GPRv_IMMz", "XOR_GPRv_IMMz")
    | 11 => do
      return ("XOR_MEMv_IMMz", "XOR_MEMv_IMMz")
    | 12 => do
      return ("XOR_LOCK_MEMv_IMMz", "XOR_LOCK_MEMv_IMMz")
    | 13 => do
      return ("SUB_GPRv_IMMz", "SUB_GPRv_IMMz")
    | 14 => do
      return ("SUB_MEMv_IMMz", "SUB_MEMv_IMMz")
    | 15 => do
      return ("SUB_LOCK_MEMv_IMMz", "SUB_LOCK_MEMv_IMMz")
    | 16 => do
      return ("CMP_GPRv_IMMz", "CMP_GPRv_IMMz")
    | 17 => do
      return ("CMP_MEMv_IMMz", "CMP_MEMv_IMMz")
    | 18 => do
      return ("AND_GPRv_IMMz", "AND_GPRv_IMMz")
    | 19 => do
      return ("AND_MEMv_IMMz", "AND_MEMv_IMMz")
    | 20 => do
      return ("AND_LOCK_MEMv_IMMz", "AND_LOCK_MEMv_IMMz")
    | 21 => do
      return ("OR_GPRv_IMMz", "OR_GPRv_IMMz")
    | 22 => do
      return ("OR_MEMv_IMMz", "OR_MEMv_IMMz")
    | 23 => do
      return ("OR_LOCK_MEMv_IMMz", "OR_LOCK_MEMv_IMMz")
    | _ => do
      return ("", "")
  | 0b10000011 => do
    match decoder_form_index with
    | 1 => do
      return ("ADD_GPRv_IMMb", "ADD_GPRv_IMMb")
    | 2 => do
      return ("ADD_MEMv_IMMb", "ADD_MEMv_IMMb")
    | 3 => do
      return ("ADD_LOCK_MEMv_IMMb", "ADD_LOCK_MEMv_IMMb")
    | 4 => do
      return ("ADC_GPRv_IMMb", "ADC_GPRv_IMMb")
    | 5 => do
      return ("ADC_MEMv_IMMb", "ADC_MEMv_IMMb")
    | 6 => do
      return ("ADC_LOCK_MEMv_IMMb", "ADC_LOCK_MEMv_IMMb")
    | 7 => do
      return ("SBB_GPRv_IMMb", "SBB_GPRv_IMMb")
    | 8 => do
      return ("SBB_MEMv_IMMb", "SBB_MEMv_IMMb")
    | 9 => do
      return ("SBB_LOCK_MEMv_IMMb", "SBB_LOCK_MEMv_IMMb")
    | 10 => do
      return ("XOR_GPRv_IMMb", "XOR_GPRv_IMMb")
    | 11 => do
      return ("XOR_MEMv_IMMb", "XOR_MEMv_IMMb")
    | 12 => do
      return ("XOR_LOCK_MEMv_IMMb", "XOR_LOCK_MEMv_IMMb")
    | 13 => do
      return ("SUB_GPRv_IMMb", "SUB_GPRv_IMMb")
    | 14 => do
      return ("SUB_MEMv_IMMb", "SUB_MEMv_IMMb")
    | 15 => do
      return ("SUB_LOCK_MEMv_IMMb", "SUB_LOCK_MEMv_IMMb")
    | 16 => do
      return ("CMP_GPRv_IMMb", "CMP_GPRv_IMMb")
    | 17 => do
      return ("CMP_MEMv_IMMb", "CMP_MEMv_IMMb")
    | 18 => do
      return ("AND_GPRv_IMMb", "AND_GPRv_IMMb")
    | 19 => do
      return ("AND_MEMv_IMMb", "AND_MEMv_IMMb")
    | 20 => do
      return ("AND_LOCK_MEMv_IMMb", "AND_LOCK_MEMv_IMMb")
    | 21 => do
      return ("OR_GPRv_IMMb", "OR_GPRv_IMMb")
    | 22 => do
      return ("OR_MEMv_IMMb", "OR_MEMv_IMMb")
    | 23 => do
      return ("OR_LOCK_MEMv_IMMb", "OR_LOCK_MEMv_IMMb")
    | _ => do
      return ("", "")
  | 0b10000100 => do
    match decoder_form_index with
    | 1 => do
      return ("TEST_GPR8_GPR8", "TEST_GPR8_GPR8")
    | 2 => do
      return ("TEST_MEMb_GPR8", "TEST_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b10000101 => do
    match decoder_form_index with
    | 1 => do
      return ("TEST_GPRv_GPRv", "TEST_GPRv_GPRv")
    | 2 => do
      return ("TEST_MEMv_GPRv", "TEST_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10000110 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_MEMb_GPR8_0", "XCHG_MEMb_GPR8")
    | 2 => do
      return ("XCHG_GPR8_GPR8", "XCHG_GPR8_GPR8")
    | 3 => do
      return ("XCHG_MEMb_GPR8_1", "XCHG_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b10000111 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_MEMv_GPRv_0", "XCHG_MEMv_GPRv")
    | 2 => do
      return ("XCHG_GPRv_GPRv", "XCHG_GPRv_GPRv")
    | 3 => do
      return ("XCHG_MEMv_GPRv_1", "XCHG_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10001000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_GPR8_88", "MOV_GPR8_GPR8_88")
    | 2 => do
      return ("MOV_MEMb_GPR8_1", "MOV_MEMb_GPR8")
    | _ => do
      return ("", "")
  | 0b10001001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_GPRv_89", "MOV_GPRv_GPRv_89")
    | 2 => do
      return ("MOV_MEMv_GPRv_1", "MOV_MEMv_GPRv")
    | _ => do
      return ("", "")
  | 0b10001010 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_GPR8_8A", "MOV_GPR8_GPR8_8A")
    | 2 => do
      return ("MOV_GPR8_MEMb_1", "MOV_GPR8_MEMb")
    | _ => do
      return ("", "")
  | 0b10001011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_GPRv_8B", "MOV_GPRv_GPRv_8B")
    | 2 => do
      return ("MOV_GPRv_MEMv_1", "MOV_GPRv_MEMv")
    | _ => do
      return ("", "")
  | 0b10001100 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_SEG", "MOV_GPRv_SEG")
    | 2 => do
      return ("MOV_MEMw_SEG", "MOV_MEMw_SEG")
    | _ => do
      return ("", "")
  | 0b10001101 => do
    match decoder_form_index with
    | 1 => do
      return ("LEA_GPRv_AGEN", "LEA_GPRv_AGEN")
    | _ => do
      return ("", "")
  | 0b10001110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_SEG_GPR16", "MOV_SEG_GPR16")
    | 2 => do
      return ("MOV_SEG_MEMw", "MOV_SEG_MEMw")
    | _ => do
      return ("", "")
  | 0b10001111 => do
    match decoder_form_index with
    | 1 => do
      return ("POP_GPRv_8F", "POP_GPRv_8F")
    | 2 => do
      return ("POP_MEMv", "POP_MEMv")
    | _ => do
      return ("", "")
  | 0b10010000 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | 2 => do
      return ("NOP_90", "NOP_90")
    | 3 => do
      return ("PAUSE", "PAUSE")
    | _ => do
      return ("", "")
  | 0b10010001 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10010010 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10010011 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10010100 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10010101 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10010110 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10010111 => do
    match decoder_form_index with
    | 1 => do
      return ("XCHG_GPRv_OrAX_0", "XCHG_GPRv_OrAX")
    | _ => do
      return ("", "")
  | 0b10011000 => do
    match decoder_form_index with
    | 1 => do
      return ("CBW_2", "CBW")
    | 2 => do
      return ("CDQE", "CDQE")
    | 3 => do
      return ("CWDE_2", "CWDE")
    | _ => do
      return ("", "")
  | 0b10011001 => do
    match decoder_form_index with
    | 1 => do
      return ("CDQ_2", "CDQ")
    | 2 => do
      return ("CQO", "CQO")
    | 3 => do
      return ("CWD_2", "CWD")
    | _ => do
      return ("", "")
  | 0b10011011 => do
    match decoder_form_index with
    | 1 => do
      return ("FWAIT", "FWAIT")
    | _ => do
      return ("", "")
  | 0b10011100 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSHFQ_0", "PUSHFQ")
    | 2 => do
      return ("PUSHFQ_1", "PUSHFQ")
    | 3 => do
      return ("PUSHF_2", "PUSHF")
    | _ => do
      return ("", "")
  | 0b10011101 => do
    match decoder_form_index with
    | 1 => do
      return ("POPF", "POPF")
    | 2 => do
      return ("POPFQ", "POPFQ")
    | _ => do
      return ("", "")
  | 0b10100000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_AL_MEMb", "MOV_AL_MEMb")
    | _ => do
      return ("", "")
  | 0b10100001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_OrAX_MEMv", "MOV_OrAX_MEMv")
    | _ => do
      return ("", "")
  | 0b10100010 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_MEMb_AL", "MOV_MEMb_AL")
    | _ => do
      return ("", "")
  | 0b10100011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_MEMv_OrAX", "MOV_MEMv_OrAX")
    | _ => do
      return ("", "")
  | 0b10100100 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_MOVSB_1", "REP_MOVSB")
    | 2 => do
      return ("REP_MOVSB_0", "REP_MOVSB")
    | 3 => do
      return ("MOVSB", "MOVSB")
    | _ => do
      return ("", "")
  | 0b10100101 => do
    match decoder_form_index with
    | 1 => do
      return ("MOVSD_2", "MOVSD")
    | 2 => do
      return ("REP_MOVSD_5", "REP_MOVSD")
    | 3 => do
      return ("REP_MOVSQ_1", "REP_MOVSQ")
    | 4 => do
      return ("REP_MOVSW_5", "REP_MOVSW")
    | 5 => do
      return ("REP_MOVSD_2", "REP_MOVSD")
    | 6 => do
      return ("REP_MOVSQ_0", "REP_MOVSQ")
    | 7 => do
      return ("REP_MOVSW_2", "REP_MOVSW")
    | 8 => do
      return ("MOVSQ", "MOVSQ")
    | 9 => do
      return ("MOVSW_2", "MOVSW")
    | _ => do
      return ("", "")
  | 0b10100110 => do
    match decoder_form_index with
    | 1 => do
      return ("CMPSB", "CMPSB")
    | 2 => do
      return ("REPE_CMPSB", "REPE_CMPSB")
    | 3 => do
      return ("REPNE_CMPSB", "REPNE_CMPSB")
    | _ => do
      return ("", "")
  | 0b10100111 => do
    match decoder_form_index with
    | 1 => do
      return ("CMPSW", "CMPSW")
    | 2 => do
      return ("CMPSD", "CMPSD")
    | 3 => do
      return ("CMPSQ", "CMPSQ")
    | 4 => do
      return ("REPE_CMPSW", "REPE_CMPSW")
    | 5 => do
      return ("REPE_CMPSD", "REPE_CMPSD")
    | 6 => do
      return ("REPE_CMPSQ", "REPE_CMPSQ")
    | 7 => do
      return ("REPNE_CMPSW", "REPNE_CMPSW")
    | 8 => do
      return ("REPNE_CMPSD", "REPNE_CMPSD")
    | 9 => do
      return ("REPNE_CMPSQ", "REPNE_CMPSQ")
    | _ => do
      return ("", "")
  | 0b10101000 => do
    match decoder_form_index with
    | 1 => do
      return ("TEST_AL_IMMb", "TEST_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b10101001 => do
    match decoder_form_index with
    | 1 => do
      return ("TEST_OrAX_IMMz", "TEST_OrAX_IMMz")
    | _ => do
      return ("", "")
  | 0b10101010 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_STOSB_1", "REP_STOSB")
    | 2 => do
      return ("REP_STOSB_0", "REP_STOSB")
    | 3 => do
      return ("STOSB", "STOSB")
    | _ => do
      return ("", "")
  | 0b10101011 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_STOSD_5", "REP_STOSD")
    | 2 => do
      return ("REP_STOSQ_1", "REP_STOSQ")
    | 3 => do
      return ("REP_STOSW_5", "REP_STOSW")
    | 4 => do
      return ("REP_STOSD_2", "REP_STOSD")
    | 5 => do
      return ("REP_STOSQ_0", "REP_STOSQ")
    | 6 => do
      return ("REP_STOSW_2", "REP_STOSW")
    | 7 => do
      return ("STOSQ", "STOSQ")
    | 8 => do
      return ("STOSW_2", "STOSW")
    | 9 => do
      return ("STOSD_2", "STOSD")
    | _ => do
      return ("", "")
  | 0b10101100 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_LODSB_1", "REP_LODSB")
    | 2 => do
      return ("REP_LODSB_0", "REP_LODSB")
    | 3 => do
      return ("LODSB", "LODSB")
    | _ => do
      return ("", "")
  | 0b10101101 => do
    match decoder_form_index with
    | 1 => do
      return ("REP_LODSD_5", "REP_LODSD")
    | 2 => do
      return ("REP_LODSQ_1", "REP_LODSQ")
    | 3 => do
      return ("REP_LODSW_5", "REP_LODSW")
    | 4 => do
      return ("REP_LODSD_2", "REP_LODSD")
    | 5 => do
      return ("REP_LODSQ_0", "REP_LODSQ")
    | 6 => do
      return ("REP_LODSW_2", "REP_LODSW")
    | 7 => do
      return ("LODSQ", "LODSQ")
    | 8 => do
      return ("LODSW_2", "LODSW")
    | 9 => do
      return ("LODSD_2", "LODSD")
    | _ => do
      return ("", "")
  | 0b10101110 => do
    match decoder_form_index with
    | 1 => do
      return ("REPNE_SCASB", "REPNE_SCASB")
    | 2 => do
      return ("REPE_SCASB", "REPE_SCASB")
    | 3 => do
      return ("SCASB", "SCASB")
    | _ => do
      return ("", "")
  | 0b10101111 => do
    match decoder_form_index with
    | 1 => do
      return ("REPNE_SCASD_2", "REPNE_SCASD")
    | 2 => do
      return ("REPNE_SCASQ", "REPNE_SCASQ")
    | 3 => do
      return ("REPNE_SCASW_2", "REPNE_SCASW")
    | 4 => do
      return ("REPE_SCASD_2", "REPE_SCASD")
    | 5 => do
      return ("REPE_SCASQ", "REPE_SCASQ")
    | 6 => do
      return ("REPE_SCASW_2", "REPE_SCASW")
    | 7 => do
      return ("SCASQ", "SCASQ")
    | 8 => do
      return ("SCASW_2", "SCASW")
    | 9 => do
      return ("SCASD_2", "SCASD")
    | _ => do
      return ("", "")
  | 0b10110000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110010 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110100 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110101 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10110111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_B0", "MOV_GPR8_IMMb_B0")
    | _ => do
      return ("", "")
  | 0b10111000 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111001 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111010 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111011 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111100 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111101 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b10111111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMv", "MOV_GPRv_IMMv")
    | _ => do
      return ("", "")
  | 0b11000000 => do
    match decoder_form_index with
    | 1 => do
      return ("SHL_GPR8_IMMb_C0r4", "SHL_GPR8_IMMb_C0r4")
    | 2 => do
      return ("SHL_MEMb_IMMb_C0r4", "SHL_MEMb_IMMb_C0r4")
    | 3 => do
      return ("SHR_GPR8_IMMb", "SHR_GPR8_IMMb")
    | 4 => do
      return ("SHR_MEMb_IMMb", "SHR_MEMb_IMMb")
    | 5 => do
      return ("SHL_GPR8_IMMb_C0r6", "SHL_GPR8_IMMb_C0r6")
    | 6 => do
      return ("SHL_MEMb_IMMb_C0r6", "SHL_MEMb_IMMb_C0r6")
    | 7 => do
      return ("SAR_GPR8_IMMb", "SAR_GPR8_IMMb")
    | 8 => do
      return ("SAR_MEMb_IMMb", "SAR_MEMb_IMMb")
    | 9 => do
      return ("ROL_GPR8_IMMb", "ROL_GPR8_IMMb")
    | 10 => do
      return ("ROL_MEMb_IMMb", "ROL_MEMb_IMMb")
    | 11 => do
      return ("ROR_GPR8_IMMb", "ROR_GPR8_IMMb")
    | 12 => do
      return ("ROR_MEMb_IMMb", "ROR_MEMb_IMMb")
    | 13 => do
      return ("RCL_GPR8_IMMb", "RCL_GPR8_IMMb")
    | 14 => do
      return ("RCL_MEMb_IMMb", "RCL_MEMb_IMMb")
    | 15 => do
      return ("RCR_GPR8_IMMb", "RCR_GPR8_IMMb")
    | 16 => do
      return ("RCR_MEMb_IMMb", "RCR_MEMb_IMMb")
    | _ => do
      return ("", "")
  | 0b11000001 => do
    match decoder_form_index with
    | 1 => do
      return ("SHL_GPRv_IMMb_C1r4", "SHL_GPRv_IMMb_C1r4")
    | 2 => do
      return ("SHL_MEMv_IMMb_C1r4", "SHL_MEMv_IMMb_C1r4")
    | 3 => do
      return ("SHR_GPRv_IMMb", "SHR_GPRv_IMMb")
    | 4 => do
      return ("SHR_MEMv_IMMb", "SHR_MEMv_IMMb")
    | 5 => do
      return ("SHL_GPRv_IMMb_C1r6", "SHL_GPRv_IMMb_C1r6")
    | 6 => do
      return ("SHL_MEMv_IMMb_C1r6", "SHL_MEMv_IMMb_C1r6")
    | 7 => do
      return ("SAR_GPRv_IMMb", "SAR_GPRv_IMMb")
    | 8 => do
      return ("SAR_MEMv_IMMb", "SAR_MEMv_IMMb")
    | 9 => do
      return ("ROL_GPRv_IMMb", "ROL_GPRv_IMMb")
    | 10 => do
      return ("ROL_MEMv_IMMb", "ROL_MEMv_IMMb")
    | 11 => do
      return ("ROR_GPRv_IMMb", "ROR_GPRv_IMMb")
    | 12 => do
      return ("ROR_MEMv_IMMb", "ROR_MEMv_IMMb")
    | 13 => do
      return ("RCL_GPRv_IMMb", "RCL_GPRv_IMMb")
    | 14 => do
      return ("RCL_MEMv_IMMb", "RCL_MEMv_IMMb")
    | 15 => do
      return ("RCR_GPRv_IMMb", "RCR_GPRv_IMMb")
    | 16 => do
      return ("RCR_MEMv_IMMb", "RCR_MEMv_IMMb")
    | _ => do
      return ("", "")
  | 0b11000010 => do
    match decoder_form_index with
    | 1 => do
      return ("RET_NEAR_IMMw", "RET_NEAR_IMMw")
    | _ => do
      return ("", "")
  | 0b11000011 => do
    match decoder_form_index with
    | 1 => do
      return ("RET_NEAR", "RET_NEAR")
    | _ => do
      return ("", "")
  | 0b11000110 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPR8_IMMb_C6r0", "MOV_GPR8_IMMb_C6r0")
    | 2 => do
      return ("MOV_MEMb_IMMb_1", "MOV_MEMb_IMMb")
    | _ => do
      return ("", "")
  | 0b11000111 => do
    match decoder_form_index with
    | 1 => do
      return ("MOV_GPRv_IMMz", "MOV_GPRv_IMMz")
    | 2 => do
      return ("MOV_MEMv_IMMz_1", "MOV_MEMv_IMMz")
    | _ => do
      return ("", "")
  | 0b11001000 => do
    match decoder_form_index with
    | 1 => do
      return ("ENTER_IMMw_IMMb", "ENTER_IMMw_IMMb")
    | _ => do
      return ("", "")
  | 0b11001001 => do
    match decoder_form_index with
    | 1 => do
      return ("LEAVE", "LEAVE")
    | _ => do
      return ("", "")
  | 0b11001010 => do
    match decoder_form_index with
    | 1 => do
      return ("RET_FAR_IMMw", "RET_FAR_IMMw")
    | _ => do
      return ("", "")
  | 0b11001011 => do
    match decoder_form_index with
    | 1 => do
      return ("RET_FAR", "RET_FAR")
    | _ => do
      return ("", "")
  | 0b11001100 => do
    match decoder_form_index with
    | 1 => do
      return ("INT3", "INT3")
    | _ => do
      return ("", "")
  | 0b11001101 => do
    match decoder_form_index with
    | 1 => do
      return ("INT_IMMb", "INT_IMMb")
    | _ => do
      return ("", "")
  | 0b11001111 => do
    match decoder_form_index with
    | 1 => do
      return ("IRETD_2", "IRETD")
    | 2 => do
      return ("IRETQ", "IRETQ")
    | 3 => do
      return ("IRET_2", "IRET")
    | _ => do
      return ("", "")
  | 0b11010000 => do
    match decoder_form_index with
    | 1 => do
      return ("SHL_GPR8_ONE_D0r4", "SHL_GPR8_ONE_D0r4")
    | 2 => do
      return ("SHL_MEMb_ONE_D0r4", "SHL_MEMb_ONE_D0r4")
    | 3 => do
      return ("SHR_GPR8_ONE", "SHR_GPR8_ONE")
    | 4 => do
      return ("SHR_MEMb_ONE", "SHR_MEMb_ONE")
    | 5 => do
      return ("SHL_GPR8_ONE_D0r6", "SHL_GPR8_ONE_D0r6")
    | 6 => do
      return ("SHL_MEMb_ONE_D0r6", "SHL_MEMb_ONE_D0r6")
    | 7 => do
      return ("SAR_GPR8_ONE", "SAR_GPR8_ONE")
    | 8 => do
      return ("SAR_MEMb_ONE", "SAR_MEMb_ONE")
    | 9 => do
      return ("ROL_GPR8_ONE", "ROL_GPR8_ONE")
    | 10 => do
      return ("ROL_MEMb_ONE", "ROL_MEMb_ONE")
    | 11 => do
      return ("ROR_GPR8_ONE", "ROR_GPR8_ONE")
    | 12 => do
      return ("ROR_MEMb_ONE", "ROR_MEMb_ONE")
    | 13 => do
      return ("RCL_GPR8_ONE", "RCL_GPR8_ONE")
    | 14 => do
      return ("RCL_MEMb_ONE", "RCL_MEMb_ONE")
    | 15 => do
      return ("RCR_GPR8_ONE", "RCR_GPR8_ONE")
    | 16 => do
      return ("RCR_MEMb_ONE", "RCR_MEMb_ONE")
    | _ => do
      return ("", "")
  | 0b11010001 => do
    match decoder_form_index with
    | 1 => do
      return ("SHL_GPRv_ONE_D1r4", "SHL_GPRv_ONE_D1r4")
    | 2 => do
      return ("SHL_MEMv_ONE_D1r4", "SHL_MEMv_ONE_D1r4")
    | 3 => do
      return ("SHR_GPRv_ONE", "SHR_GPRv_ONE")
    | 4 => do
      return ("SHR_MEMv_ONE", "SHR_MEMv_ONE")
    | 5 => do
      return ("SHL_GPRv_ONE_D1r6", "SHL_GPRv_ONE_D1r6")
    | 6 => do
      return ("SHL_MEMv_ONE_D1r6", "SHL_MEMv_ONE_D1r6")
    | 7 => do
      return ("SAR_GPRv_ONE", "SAR_GPRv_ONE")
    | 8 => do
      return ("SAR_MEMv_ONE", "SAR_MEMv_ONE")
    | 9 => do
      return ("ROL_GPRv_ONE", "ROL_GPRv_ONE")
    | 10 => do
      return ("ROL_MEMv_ONE", "ROL_MEMv_ONE")
    | 11 => do
      return ("ROR_GPRv_ONE", "ROR_GPRv_ONE")
    | 12 => do
      return ("ROR_MEMv_ONE", "ROR_MEMv_ONE")
    | 13 => do
      return ("RCL_GPRv_ONE", "RCL_GPRv_ONE")
    | 14 => do
      return ("RCL_MEMv_ONE", "RCL_MEMv_ONE")
    | 15 => do
      return ("RCR_GPRv_ONE", "RCR_GPRv_ONE")
    | 16 => do
      return ("RCR_MEMv_ONE", "RCR_MEMv_ONE")
    | _ => do
      return ("", "")
  | 0b11010010 => do
    match decoder_form_index with
    | 1 => do
      return ("SHL_GPR8_CL_D2r4", "SHL_GPR8_CL_D2r4")
    | 2 => do
      return ("SHL_MEMb_CL_D2r4", "SHL_MEMb_CL_D2r4")
    | 3 => do
      return ("SHR_GPR8_CL", "SHR_GPR8_CL")
    | 4 => do
      return ("SHR_MEMb_CL", "SHR_MEMb_CL")
    | 5 => do
      return ("SHL_GPR8_CL_D2r6", "SHL_GPR8_CL_D2r6")
    | 6 => do
      return ("SHL_MEMb_CL_D2r6", "SHL_MEMb_CL_D2r6")
    | 7 => do
      return ("SAR_GPR8_CL", "SAR_GPR8_CL")
    | 8 => do
      return ("SAR_MEMb_CL", "SAR_MEMb_CL")
    | 9 => do
      return ("ROL_GPR8_CL", "ROL_GPR8_CL")
    | 10 => do
      return ("ROL_MEMb_CL", "ROL_MEMb_CL")
    | 11 => do
      return ("ROR_GPR8_CL", "ROR_GPR8_CL")
    | 12 => do
      return ("ROR_MEMb_CL", "ROR_MEMb_CL")
    | 13 => do
      return ("RCL_GPR8_CL", "RCL_GPR8_CL")
    | 14 => do
      return ("RCL_MEMb_CL", "RCL_MEMb_CL")
    | 15 => do
      return ("RCR_GPR8_CL", "RCR_GPR8_CL")
    | 16 => do
      return ("RCR_MEMb_CL", "RCR_MEMb_CL")
    | _ => do
      return ("", "")
  | 0b11010011 => do
    match decoder_form_index with
    | 1 => do
      return ("SHL_GPRv_CL_D3r4", "SHL_GPRv_CL_D3r4")
    | 2 => do
      return ("SHL_MEMv_CL_D3r4", "SHL_MEMv_CL_D3r4")
    | 3 => do
      return ("SHR_GPRv_CL", "SHR_GPRv_CL")
    | 4 => do
      return ("SHR_MEMv_CL", "SHR_MEMv_CL")
    | 5 => do
      return ("SHL_GPRv_CL_D3r6", "SHL_GPRv_CL_D3r6")
    | 6 => do
      return ("SHL_MEMv_CL_D3r6", "SHL_MEMv_CL_D3r6")
    | 7 => do
      return ("SAR_GPRv_CL", "SAR_GPRv_CL")
    | 8 => do
      return ("SAR_MEMv_CL", "SAR_MEMv_CL")
    | 9 => do
      return ("ROL_GPRv_CL", "ROL_GPRv_CL")
    | 10 => do
      return ("ROL_MEMv_CL", "ROL_MEMv_CL")
    | 11 => do
      return ("ROR_GPRv_CL", "ROR_GPRv_CL")
    | 12 => do
      return ("ROR_MEMv_CL", "ROR_MEMv_CL")
    | 13 => do
      return ("RCL_GPRv_CL", "RCL_GPRv_CL")
    | 14 => do
      return ("RCL_MEMv_CL", "RCL_MEMv_CL")
    | 15 => do
      return ("RCR_GPRv_CL", "RCR_GPRv_CL")
    | 16 => do
      return ("RCR_MEMv_CL", "RCR_MEMv_CL")
    | _ => do
      return ("", "")
  | 0b11010110 => do
    match decoder_form_index with
    | 1 => do
      return ("UDB", "UDB")
    | _ => do
      return ("", "")
  | 0b11010111 => do
    match decoder_form_index with
    | 1 => do
      return ("XLAT", "XLAT")
    | _ => do
      return ("", "")
  | 0b11011000 => do
    match decoder_form_index with
    | 1 => do
      return ("FADD_MEMmem32real", "FADD_MEMmem32real")
    | 2 => do
      return ("FADD_ST0_X87", "FADD_ST0_X87")
    | 3 => do
      return ("FSUB_ST0_MEMmem32real", "FSUB_ST0_MEMmem32real")
    | 4 => do
      return ("FSUB_ST0_X87", "FSUB_ST0_X87")
    | 5 => do
      return ("FMUL_ST0_MEMmem32real", "FMUL_ST0_MEMmem32real")
    | 6 => do
      return ("FMUL_ST0_X87", "FMUL_ST0_X87")
    | 7 => do
      return ("FCOM_ST0_MEMmem32real", "FCOM_ST0_MEMmem32real")
    | 8 => do
      return ("FCOMP_ST0_MEMmem32real", "FCOMP_ST0_MEMmem32real")
    | 9 => do
      return ("FCOM_ST0_X87", "FCOM_ST0_X87")
    | 10 => do
      return ("FCOMP_ST0_X87", "FCOMP_ST0_X87")
    | 11 => do
      return ("FSUBR_ST0_MEMmem32real", "FSUBR_ST0_MEMmem32real")
    | 12 => do
      return ("FSUBR_ST0_X87", "FSUBR_ST0_X87")
    | 13 => do
      return ("FDIV_ST0_MEMmem32real", "FDIV_ST0_MEMmem32real")
    | 14 => do
      return ("FDIV_ST0_X87", "FDIV_ST0_X87")
    | 15 => do
      return ("FDIVR_ST0_MEMmem32real", "FDIVR_ST0_MEMmem32real")
    | 16 => do
      return ("FDIVR_ST0_X87", "FDIVR_ST0_X87")
    | _ => do
      return ("", "")
  | 0b11011001 => do
    match decoder_form_index with
    | 1 => do
      return ("F2XM1", "F2XM1")
    | 2 => do
      return ("FSIN", "FSIN")
    | 3 => do
      return ("FCOS", "FCOS")
    | 4 => do
      return ("FPTAN", "FPTAN")
    | 5 => do
      return ("FSINCOS", "FSINCOS")
    | 6 => do
      return ("FPATAN", "FPATAN")
    | 7 => do
      return ("FYL2X", "FYL2X")
    | 8 => do
      return ("FYL2XP1", "FYL2XP1")
    | 9 => do
      return ("FNSTENV_MEMmem14_2", "FNSTENV_MEMmem14")
    | 10 => do
      return ("FNSTENV_MEMmem28_2", "FNSTENV_MEMmem28")
    | 11 => do
      return ("FNSTENV_MEMmem28_3", "FNSTENV_MEMmem28")
    | 12 => do
      return ("FST_MEMmem32real_ST0", "FST_MEMmem32real_ST0")
    | 13 => do
      return ("FSTP_MEMmem32real_ST0", "FSTP_MEMmem32real_ST0")
    | 14 => do
      return ("FSTPNCE_X87_ST0", "FSTPNCE_X87_ST0")
    | 15 => do
      return ("FLD_ST0_MEMmem32real", "FLD_ST0_MEMmem32real")
    | 16 => do
      return ("FLD_ST0_X87", "FLD_ST0_X87")
    | 17 => do
      return ("FLD1", "FLD1")
    | 18 => do
      return ("FLDL2T", "FLDL2T")
    | 19 => do
      return ("FLDL2E", "FLDL2E")
    | 20 => do
      return ("FLDPI", "FLDPI")
    | 21 => do
      return ("FLDLG2", "FLDLG2")
    | 22 => do
      return ("FLDLN2", "FLDLN2")
    | 23 => do
      return ("FLDZ", "FLDZ")
    | 24 => do
      return ("FLDCW_MEMmem16", "FLDCW_MEMmem16")
    | 25 => do
      return ("FNSTCW_MEMmem16", "FNSTCW_MEMmem16")
    | 26 => do
      return ("FCHS", "FCHS")
    | 27 => do
      return ("FXCH_ST0_X87", "FXCH_ST0_X87")
    | 28 => do
      return ("FABS", "FABS")
    | 29 => do
      return ("FDECSTP", "FDECSTP")
    | 30 => do
      return ("FINCSTP", "FINCSTP")
    | 31 => do
      return ("FNOP", "FNOP")
    | 32 => do
      return ("FTST", "FTST")
    | 33 => do
      return ("FXAM", "FXAM")
    | 34 => do
      return ("FRNDINT", "FRNDINT")
    | 35 => do
      return ("FSCALE", "FSCALE")
    | 36 => do
      return ("FXTRACT", "FXTRACT")
    | 37 => do
      return ("FLDENV_MEMmem14_2", "FLDENV_MEMmem14")
    | 38 => do
      return ("FLDENV_MEMmem28_2", "FLDENV_MEMmem28")
    | 39 => do
      return ("FLDENV_MEMmem28_3", "FLDENV_MEMmem28")
    | 40 => do
      return ("FSQRT", "FSQRT")
    | 41 => do
      return ("FPREM", "FPREM")
    | 42 => do
      return ("FPREM1", "FPREM1")
    | _ => do
      return ("", "")
  | 0b11011010 => do
    match decoder_form_index with
    | 1 => do
      return ("FIADD_ST0_MEMmem32int", "FIADD_ST0_MEMmem32int")
    | 2 => do
      return ("FISUB_ST0_MEMmem32int", "FISUB_ST0_MEMmem32int")
    | 3 => do
      return ("FIMUL_ST0_MEMmem32int", "FIMUL_ST0_MEMmem32int")
    | 4 => do
      return ("FCMOVB_ST0_X87", "FCMOVB_ST0_X87")
    | 5 => do
      return ("FCMOVE_ST0_X87", "FCMOVE_ST0_X87")
    | 6 => do
      return ("FCMOVBE_ST0_X87", "FCMOVBE_ST0_X87")
    | 7 => do
      return ("FCMOVU_ST0_X87", "FCMOVU_ST0_X87")
    | 8 => do
      return ("FUCOMPP", "FUCOMPP")
    | 9 => do
      return ("FICOM_ST0_MEMmem32int", "FICOM_ST0_MEMmem32int")
    | 10 => do
      return ("FICOMP_ST0_MEMmem32int", "FICOMP_ST0_MEMmem32int")
    | 11 => do
      return ("FISUBR_ST0_MEMmem32int", "FISUBR_ST0_MEMmem32int")
    | 12 => do
      return ("FIDIV_ST0_MEMmem32int", "FIDIV_ST0_MEMmem32int")
    | 13 => do
      return ("FIDIVR_ST0_MEMmem32int", "FIDIVR_ST0_MEMmem32int")
    | _ => do
      return ("", "")
  | 0b11011011 => do
    match decoder_form_index with
    | 1 => do
      return ("FUCOMI_ST0_X87", "FUCOMI_ST0_X87")
    | 2 => do
      return ("FCOMI_ST0_X87", "FCOMI_ST0_X87")
    | 3 => do
      return ("FIST_MEMmem32int_ST0", "FIST_MEMmem32int_ST0")
    | 4 => do
      return ("FISTP_MEMmem32int_ST0", "FISTP_MEMmem32int_ST0")
    | 5 => do
      return ("FSTP_MEMmem80real_ST0", "FSTP_MEMmem80real_ST0")
    | 6 => do
      return ("FILD_ST0_MEMmem32int", "FILD_ST0_MEMmem32int")
    | 7 => do
      return ("FLD_ST0_MEMmem80real", "FLD_ST0_MEMmem80real")
    | 8 => do
      return ("FNCLEX", "FNCLEX")
    | 9 => do
      return ("FNINIT", "FNINIT")
    | 10 => do
      return ("FCMOVNB_ST0_X87", "FCMOVNB_ST0_X87")
    | 11 => do
      return ("FCMOVNE_ST0_X87", "FCMOVNE_ST0_X87")
    | 12 => do
      return ("FCMOVNBE_ST0_X87", "FCMOVNBE_ST0_X87")
    | 13 => do
      return ("FCMOVNU_ST0_X87", "FCMOVNU_ST0_X87")
    | 14 => do
      return ("FENI8087_NOP", "FENI8087_NOP")
    | 15 => do
      return ("FDISI8087_NOP", "FDISI8087_NOP")
    | 16 => do
      return ("FSETPM287_NOP", "FSETPM287_NOP")
    | _ => do
      return ("", "")
  | 0b11011100 => do
    match decoder_form_index with
    | 1 => do
      return ("FADD_MEMm64real", "FADD_MEMm64real")
    | 2 => do
      return ("FADD_X87_ST0", "FADD_X87_ST0")
    | 3 => do
      return ("FSUB_ST0_MEMm64real", "FSUB_ST0_MEMm64real")
    | 4 => do
      return ("FSUB_X87_ST0", "FSUB_X87_ST0")
    | 5 => do
      return ("FMUL_ST0_MEMm64real", "FMUL_ST0_MEMm64real")
    | 6 => do
      return ("FMUL_X87_ST0", "FMUL_X87_ST0")
    | 7 => do
      return ("FCOM_ST0_MEMm64real", "FCOM_ST0_MEMm64real")
    | 8 => do
      return ("FCOMP_ST0_MEMm64real", "FCOMP_ST0_MEMm64real")
    | 9 => do
      return ("FCOM_ST0_X87_DCD0", "FCOM_ST0_X87_DCD0")
    | 10 => do
      return ("FCOMP_ST0_X87_DCD1", "FCOMP_ST0_X87_DCD1")
    | 11 => do
      return ("FSUBR_ST0_MEMm64real", "FSUBR_ST0_MEMm64real")
    | 12 => do
      return ("FSUBR_X87_ST0", "FSUBR_X87_ST0")
    | 13 => do
      return ("FDIV_ST0_MEMm64real", "FDIV_ST0_MEMm64real")
    | 14 => do
      return ("FDIV_X87_ST0", "FDIV_X87_ST0")
    | 15 => do
      return ("FDIVR_ST0_MEMm64real", "FDIVR_ST0_MEMm64real")
    | 16 => do
      return ("FDIVR_X87_ST0", "FDIVR_X87_ST0")
    | _ => do
      return ("", "")
  | 0b11011101 => do
    match decoder_form_index with
    | 1 => do
      return ("FNSAVE_MEMmem108_2", "FNSAVE_MEMmem108")
    | 2 => do
      return ("FNSAVE_MEMmem108_3", "FNSAVE_MEMmem108")
    | 3 => do
      return ("FNSAVE_MEMmem94_2", "FNSAVE_MEMmem94")
    | 4 => do
      return ("FST_MEMm64real_ST0", "FST_MEMm64real_ST0")
    | 5 => do
      return ("FSTP_MEMm64real_ST0", "FSTP_MEMm64real_ST0")
    | 6 => do
      return ("FST_X87_ST0", "FST_X87_ST0")
    | 7 => do
      return ("FSTP_X87_ST0", "FSTP_X87_ST0")
    | 8 => do
      return ("FLD_ST0_MEMm64real", "FLD_ST0_MEMm64real")
    | 9 => do
      return ("FXCH_ST0_X87_DDC1", "FXCH_ST0_X87_DDC1")
    | 10 => do
      return ("FFREE_X87", "FFREE_X87")
    | 11 => do
      return ("FNSTSW_MEMmem16", "FNSTSW_MEMmem16")
    | 12 => do
      return ("FUCOM_ST0_X87", "FUCOM_ST0_X87")
    | 13 => do
      return ("FUCOMP_ST0_X87", "FUCOMP_ST0_X87")
    | 14 => do
      return ("FRSTOR_MEMmem108_2", "FRSTOR_MEMmem108")
    | 15 => do
      return ("FRSTOR_MEMmem108_3", "FRSTOR_MEMmem108")
    | 16 => do
      return ("FRSTOR_MEMmem94_2", "FRSTOR_MEMmem94")
    | _ => do
      return ("", "")
  | 0b11011110 => do
    match decoder_form_index with
    | 1 => do
      return ("FIADD_ST0_MEMmem16int", "FIADD_ST0_MEMmem16int")
    | 2 => do
      return ("FADDP_X87_ST0", "FADDP_X87_ST0")
    | 3 => do
      return ("FISUB_ST0_MEMmem16int", "FISUB_ST0_MEMmem16int")
    | 4 => do
      return ("FSUBP_X87_ST0", "FSUBP_X87_ST0")
    | 5 => do
      return ("FIMUL_ST0_MEMmem16int", "FIMUL_ST0_MEMmem16int")
    | 6 => do
      return ("FMULP_X87_ST0", "FMULP_X87_ST0")
    | 7 => do
      return ("FCOMPP", "FCOMPP")
    | 8 => do
      return ("FCOMP_ST0_X87_DED0", "FCOMP_ST0_X87_DED0")
    | 9 => do
      return ("FICOM_ST0_MEMmem16int", "FICOM_ST0_MEMmem16int")
    | 10 => do
      return ("FICOMP_ST0_MEMmem16int", "FICOMP_ST0_MEMmem16int")
    | 11 => do
      return ("FISUBR_ST0_MEMmem16int", "FISUBR_ST0_MEMmem16int")
    | 12 => do
      return ("FSUBRP_X87_ST0", "FSUBRP_X87_ST0")
    | 13 => do
      return ("FIDIV_ST0_MEMmem16int", "FIDIV_ST0_MEMmem16int")
    | 14 => do
      return ("FDIVP_X87_ST0", "FDIVP_X87_ST0")
    | 15 => do
      return ("FIDIVR_ST0_MEMmem16int", "FIDIVR_ST0_MEMmem16int")
    | 16 => do
      return ("FDIVRP_X87_ST0", "FDIVRP_X87_ST0")
    | _ => do
      return ("", "")
  | 0b11011111 => do
    match decoder_form_index with
    | 1 => do
      return ("FBLD_ST0_MEMmem80dec", "FBLD_ST0_MEMmem80dec")
    | 2 => do
      return ("FBSTP_MEMmem80dec_ST0", "FBSTP_MEMmem80dec_ST0")
    | 3 => do
      return ("FUCOMIP_ST0_X87", "FUCOMIP_ST0_X87")
    | 4 => do
      return ("FCOMIP_ST0_X87", "FCOMIP_ST0_X87")
    | 5 => do
      return ("FIST_MEMmem16int_ST0", "FIST_MEMmem16int_ST0")
    | 6 => do
      return ("FISTP_MEMmem16int_ST0", "FISTP_MEMmem16int_ST0")
    | 7 => do
      return ("FISTP_MEMm64int_ST0", "FISTP_MEMm64int_ST0")
    | 8 => do
      return ("FSTP_X87_ST0_DFD0", "FSTP_X87_ST0_DFD0")
    | 9 => do
      return ("FSTP_X87_ST0_DFD1", "FSTP_X87_ST0_DFD1")
    | 10 => do
      return ("FILD_ST0_MEMmem16int", "FILD_ST0_MEMmem16int")
    | 11 => do
      return ("FILD_ST0_MEMm64int", "FILD_ST0_MEMm64int")
    | 12 => do
      return ("FXCH_ST0_X87_DFC1", "FXCH_ST0_X87_DFC1")
    | 13 => do
      return ("FFREEP_X87", "FFREEP_X87")
    | 14 => do
      return ("FNSTSW_AX", "FNSTSW_AX")
    | _ => do
      return ("", "")
  | 0b11100000 => do
    match decoder_form_index with
    | 1 => do
      return ("LOOPNE_RELBRb_2", "LOOPNE_RELBRb")
    | _ => do
      return ("", "")
  | 0b11100001 => do
    match decoder_form_index with
    | 1 => do
      return ("LOOPE_RELBRb_2", "LOOPE_RELBRb")
    | _ => do
      return ("", "")
  | 0b11100010 => do
    match decoder_form_index with
    | 1 => do
      return ("LOOP_RELBRb", "LOOP_RELBRb")
    | _ => do
      return ("", "")
  | 0b11100011 => do
    match decoder_form_index with
    | 1 => do
      return ("JCXZ_RELBRb", "JCXZ_RELBRb")
    | 2 => do
      return ("JECXZ_RELBRb_1", "JECXZ_RELBRb")
    | 3 => do
      return ("JRCXZ_RELBRb", "JRCXZ_RELBRb")
    | _ => do
      return ("", "")
  | 0b11100100 => do
    match decoder_form_index with
    | 1 => do
      return ("IN_AL_IMMb", "IN_AL_IMMb")
    | _ => do
      return ("", "")
  | 0b11100101 => do
    match decoder_form_index with
    | 1 => do
      return ("IN_OeAX_IMMb", "IN_OeAX_IMMb")
    | _ => do
      return ("", "")
  | 0b11100110 => do
    match decoder_form_index with
    | 1 => do
      return ("OUT_IMMb_AL", "OUT_IMMb_AL")
    | _ => do
      return ("", "")
  | 0b11100111 => do
    match decoder_form_index with
    | 1 => do
      return ("OUT_IMMb_OeAX", "OUT_IMMb_OeAX")
    | _ => do
      return ("", "")
  | 0b11101000 => do
    match decoder_form_index with
    | 1 => do
      return ("CALL_NEAR_RELBRd", "CALL_NEAR_RELBRd")
    | _ => do
      return ("", "")
  | 0b11101001 => do
    match decoder_form_index with
    | 1 => do
      return ("JMP_RELBRd", "JMP_RELBRd")
    | _ => do
      return ("", "")
  | 0b11101011 => do
    match decoder_form_index with
    | 1 => do
      return ("JMP_RELBRb_1", "JMP_RELBRb")
    | _ => do
      return ("", "")
  | 0b11101100 => do
    match decoder_form_index with
    | 1 => do
      return ("IN_AL_DX", "IN_AL_DX")
    | _ => do
      return ("", "")
  | 0b11101101 => do
    match decoder_form_index with
    | 1 => do
      return ("IN_OeAX_DX", "IN_OeAX_DX")
    | _ => do
      return ("", "")
  | 0b11101110 => do
    match decoder_form_index with
    | 1 => do
      return ("OUT_DX_AL", "OUT_DX_AL")
    | _ => do
      return ("", "")
  | 0b11101111 => do
    match decoder_form_index with
    | 1 => do
      return ("OUT_DX_OeAX", "OUT_DX_OeAX")
    | _ => do
      return ("", "")
  | 0b11110001 => do
    match decoder_form_index with
    | 1 => do
      return ("INT1", "INT1")
    | _ => do
      return ("", "")
  | 0b11110100 => do
    match decoder_form_index with
    | 1 => do
      return ("HLT", "HLT")
    | _ => do
      return ("", "")
  | 0b11110101 => do
    match decoder_form_index with
    | 1 => do
      return ("CMC", "CMC")
    | _ => do
      return ("", "")
  | 0b11110110 => do
    match decoder_form_index with
    | 1 => do
      return ("IMUL_GPR8", "IMUL_GPR8")
    | 2 => do
      return ("IMUL_MEMb", "IMUL_MEMb")
    | 3 => do
      return ("MUL_GPR8", "MUL_GPR8")
    | 4 => do
      return ("MUL_MEMb", "MUL_MEMb")
    | 5 => do
      return ("DIV_GPR8", "DIV_GPR8")
    | 6 => do
      return ("DIV_MEMb", "DIV_MEMb")
    | 7 => do
      return ("NEG_GPR8", "NEG_GPR8")
    | 8 => do
      return ("NEG_MEMb", "NEG_MEMb")
    | 9 => do
      return ("NEG_LOCK_MEMb", "NEG_LOCK_MEMb")
    | 10 => do
      return ("IDIV_GPR8", "IDIV_GPR8")
    | 11 => do
      return ("IDIV_MEMb", "IDIV_MEMb")
    | 12 => do
      return ("NOT_GPR8", "NOT_GPR8")
    | 13 => do
      return ("NOT_MEMb", "NOT_MEMb")
    | 14 => do
      return ("NOT_LOCK_MEMb", "NOT_LOCK_MEMb")
    | 15 => do
      return ("TEST_GPR8_IMMb_F6r0", "TEST_GPR8_IMMb_F6r0")
    | 16 => do
      return ("TEST_MEMb_IMMb_F6r0", "TEST_MEMb_IMMb_F6r0")
    | 17 => do
      return ("TEST_GPR8_IMMb_F6r1", "TEST_GPR8_IMMb_F6r1")
    | 18 => do
      return ("TEST_MEMb_IMMb_F6r1", "TEST_MEMb_IMMb_F6r1")
    | _ => do
      return ("", "")
  | 0b11110111 => do
    match decoder_form_index with
    | 1 => do
      return ("IMUL_GPRv", "IMUL_GPRv")
    | 2 => do
      return ("IMUL_MEMv", "IMUL_MEMv")
    | 3 => do
      return ("MUL_GPRv", "MUL_GPRv")
    | 4 => do
      return ("MUL_MEMv", "MUL_MEMv")
    | 5 => do
      return ("DIV_GPRv", "DIV_GPRv")
    | 6 => do
      return ("DIV_MEMv", "DIV_MEMv")
    | 7 => do
      return ("NEG_GPRv", "NEG_GPRv")
    | 8 => do
      return ("NEG_MEMv", "NEG_MEMv")
    | 9 => do
      return ("NEG_LOCK_MEMv", "NEG_LOCK_MEMv")
    | 10 => do
      return ("IDIV_GPRv", "IDIV_GPRv")
    | 11 => do
      return ("IDIV_MEMv", "IDIV_MEMv")
    | 12 => do
      return ("NOT_GPRv", "NOT_GPRv")
    | 13 => do
      return ("NOT_MEMv", "NOT_MEMv")
    | 14 => do
      return ("NOT_LOCK_MEMv", "NOT_LOCK_MEMv")
    | 15 => do
      return ("TEST_GPRv_IMMz_F7r0", "TEST_GPRv_IMMz_F7r0")
    | 16 => do
      return ("TEST_MEMv_IMMz_F7r0", "TEST_MEMv_IMMz_F7r0")
    | 17 => do
      return ("TEST_GPRv_IMMz_F7r1", "TEST_GPRv_IMMz_F7r1")
    | 18 => do
      return ("TEST_MEMv_IMMz_F7r1", "TEST_MEMv_IMMz_F7r1")
    | _ => do
      return ("", "")
  | 0b11111000 => do
    match decoder_form_index with
    | 1 => do
      return ("CLC", "CLC")
    | _ => do
      return ("", "")
  | 0b11111001 => do
    match decoder_form_index with
    | 1 => do
      return ("STC", "STC")
    | _ => do
      return ("", "")
  | 0b11111010 => do
    match decoder_form_index with
    | 1 => do
      return ("CLI", "CLI")
    | _ => do
      return ("", "")
  | 0b11111011 => do
    match decoder_form_index with
    | 1 => do
      return ("STI", "STI")
    | _ => do
      return ("", "")
  | 0b11111100 => do
    match decoder_form_index with
    | 1 => do
      return ("CLD", "CLD")
    | _ => do
      return ("", "")
  | 0b11111101 => do
    match decoder_form_index with
    | 1 => do
      return ("STD", "STD")
    | _ => do
      return ("", "")
  | 0b11111110 => do
    match decoder_form_index with
    | 1 => do
      return ("DEC_GPR8", "DEC_GPR8")
    | 2 => do
      return ("DEC_MEMb", "DEC_MEMb")
    | 3 => do
      return ("DEC_LOCK_MEMb", "DEC_LOCK_MEMb")
    | 4 => do
      return ("INC_GPR8", "INC_GPR8")
    | 5 => do
      return ("INC_MEMb", "INC_MEMb")
    | 6 => do
      return ("INC_LOCK_MEMb", "INC_LOCK_MEMb")
    | _ => do
      return ("", "")
  | 0b11111111 => do
    match decoder_form_index with
    | 1 => do
      return ("PUSH_GPRv_FFr6", "PUSH_GPRv_FFr6")
    | 2 => do
      return ("PUSH_MEMv", "PUSH_MEMv")
    | 3 => do
      return ("CALL_NEAR_GPRv", "CALL_NEAR_GPRv")
    | 4 => do
      return ("CALL_NEAR_MEMv", "CALL_NEAR_MEMv")
    | 5 => do
      return ("CALL_FAR_MEMp2", "CALL_FAR_MEMp2")
    | 6 => do
      return ("JMP_FAR_MEMp2", "JMP_FAR_MEMp2")
    | 7 => do
      return ("JMP_GPRv", "JMP_GPRv")
    | 8 => do
      return ("JMP_MEMv", "JMP_MEMv")
    | 9 => do
      return ("DEC_GPRv_FFr1", "DEC_GPRv_FFr1")
    | 10 => do
      return ("DEC_MEMv", "DEC_MEMv")
    | 11 => do
      return ("DEC_LOCK_MEMv", "DEC_LOCK_MEMv")
    | 12 => do
      return ("INC_GPRv_FFr0", "INC_GPRv_FFr0")
    | 13 => do
      return ("INC_MEMv", "INC_MEMv")
    | 14 => do
      return ("INC_LOCK_MEMv", "INC_LOCK_MEMv")
    | _ => do
      return ("", "")
  | _ => do
    return ("", "")

@[noinline, nospecialize]
def Decode_Legacy_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  if context.rex2_prefix_present then
    Runtime.liftTotal (Unimplemented_Feature "unselected REX2 instruction form" false true)
  else
    let opcode : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)
    -- Intel SDM 325462-093, PUSH Vol.2B4-522 (PDF1811)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 6) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, POP Vol.2B4-398-399 (PDF1687-1688)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 7) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, PUSH Vol.2B4-522 (PDF1811)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 14) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, PUSH Vol.2B4-522 (PDF1811)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 22) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, POP Vol.2B4-398-399 (PDF1687-1688)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 23) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, PUSH Vol.2B4-522 (PDF1811)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 30) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, POP Vol.2B4-398-399 (PDF1687-1688)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 31) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, DAA Vol.2A3-258-259 (PDF962-963)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 39) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, DAS Vol.2A3-260-261 (PDF964-965)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 47) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, AAA Vol.2A3-1-2 (PDF705-706)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 55) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, AAS Vol.2A3-7-8 (PDF711-712)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 63) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, PUSHA/PUSHAD Vol.2B4-526-527 (PDF1815-1816)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 96) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, POPA/POPAD Vol.2B4-403-404 (PDF1692-1693)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 97) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, CALL Vol.2A3-121/137 (PDF825/841)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 154) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, INTO Vol.2A3-467/471 (PDF1171/1175)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 206) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, AAM Vol.2A3-5-6 (PDF709-710)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 212) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, JMP Vol.2A3-504/512 (PDF1208/1216)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 234) then
      liftM (Report_Invalid_Opcode)
    -- Intel SDM 325462-093, one-byte opcode map 82 i64 (PDF2994-2995)
    if ((← Runtime.liftTotal (In_64Bit_Mode)) and opcode == 130) then
      liftM (Report_Invalid_Opcode)
    match Unsigned opcode with
    | 0b00000000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_00 ip context)
    | 0b00000001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_01 ip context)
    | 0b00000010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_02 ip context)
    | 0b00000011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_03 ip context)
    | 0b00000100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_04 ip context)
    | 0b00000101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_05 ip context)
    | 0b00001000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_08 ip context)
    | 0b00001001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_09 ip context)
    | 0b00001010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_0A ip context)
    | 0b00001011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_0B ip context)
    | 0b00001100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_0C ip context)
    | 0b00001101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_0D ip context)
    | 0b00010000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_10 ip context)
    | 0b00010001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_11 ip context)
    | 0b00010010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_12 ip context)
    | 0b00010011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_13 ip context)
    | 0b00010100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_14 ip context)
    | 0b00010101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_15 ip context)
    | 0b00011000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_18 ip context)
    | 0b00011001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_19 ip context)
    | 0b00011010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_1A ip context)
    | 0b00011011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_1B ip context)
    | 0b00011100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_1C ip context)
    | 0b00011101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_1D ip context)
    | 0b00100000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_20 ip context)
    | 0b00100001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_21 ip context)
    | 0b00100010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_22 ip context)
    | 0b00100011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_23 ip context)
    | 0b00100100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_24 ip context)
    | 0b00100101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_25 ip context)
    | 0b00101000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_28 ip context)
    | 0b00101001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_29 ip context)
    | 0b00101010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_2A ip context)
    | 0b00101011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_2B ip context)
    | 0b00101100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_2C ip context)
    | 0b00101101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_2D ip context)
    | 0b00110000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_30 ip context)
    | 0b00110001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_31 ip context)
    | 0b00110010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_32 ip context)
    | 0b00110011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_33 ip context)
    | 0b00110100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_34 ip context)
    | 0b00110101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_35 ip context)
    | 0b00111000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_38 ip context)
    | 0b00111001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_39 ip context)
    | 0b00111010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_3A ip context)
    | 0b00111011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_3B ip context)
    | 0b00111100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_3C ip context)
    | 0b00111101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_3D ip context)
    | 0b01010000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_50 ip context opcode)
    | 0b01010001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_51 ip context opcode)
    | 0b01010010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_52 ip context opcode)
    | 0b01010011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_53 ip context opcode)
    | 0b01010100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_54 ip context opcode)
    | 0b01010101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_55 ip context opcode)
    | 0b01010110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_56 ip context opcode)
    | 0b01010111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_57 ip context opcode)
    | 0b01011000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_58 ip context opcode)
    | 0b01011001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_59 ip context opcode)
    | 0b01011010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_5A ip context opcode)
    | 0b01011011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_5B ip context opcode)
    | 0b01011100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_5C ip context opcode)
    | 0b01011101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_5D ip context opcode)
    | 0b01011110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_5E ip context opcode)
    | 0b01011111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_5F ip context opcode)
    | 0b01100011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_63 ip context)
    | 0b01101000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_68 ip context)
    | 0b01101001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_69 ip context)
    | 0b01101010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_6A ip context)
    | 0b01101011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_6B ip context)
    | 0b01101100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_6C ip context)
    | 0b01101101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_6D ip context)
    | 0b01101110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_6E ip context)
    | 0b01101111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_6F ip context)
    | 0b01110000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_70 ip context opcode)
    | 0b01110001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_71 ip context opcode)
    | 0b01110010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_72 ip context opcode)
    | 0b01110011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_73 ip context opcode)
    | 0b01110100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_74 ip context opcode)
    | 0b01110101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_75 ip context opcode)
    | 0b01110110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_76 ip context opcode)
    | 0b01110111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_77 ip context opcode)
    | 0b01111000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_78 ip context opcode)
    | 0b01111001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_79 ip context opcode)
    | 0b01111010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_7A ip context opcode)
    | 0b01111011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_7B ip context opcode)
    | 0b01111100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_7C ip context opcode)
    | 0b01111101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_7D ip context opcode)
    | 0b01111110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_7E ip context opcode)
    | 0b01111111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_7F ip context opcode)
    | 0b10000000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_80 ip context)
    | 0b10000001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_81 ip context)
    | 0b10000011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_83 ip context)
    | 0b10000100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_84 ip context)
    | 0b10000101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_85 ip context)
    | 0b10000110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_86 ip context)
    | 0b10000111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_87 ip context)
    | 0b10001000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_88 ip context)
    | 0b10001001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_89 ip context)
    | 0b10001010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_8A ip context)
    | 0b10001011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_8B ip context)
    | 0b10001100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_8C ip context)
    | 0b10001101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_8D ip context)
    | 0b10001110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_8E ip context)
    | 0b10001111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_8F ip context)
    | 0b10010000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_90 ip context opcode)
    | 0b10010001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_91 ip context opcode)
    | 0b10010010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_92 ip context opcode)
    | 0b10010011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_93 ip context opcode)
    | 0b10010100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_94 ip context opcode)
    | 0b10010101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_95 ip context opcode)
    | 0b10010110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_96 ip context opcode)
    | 0b10010111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_97 ip context opcode)
    | 0b10011000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_98 ip context)
    | 0b10011001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_99 ip context)
    | 0b10011011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_9B ip context)
    | 0b10011100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_9C ip context)
    | 0b10011101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_9D ip context)
    | 0b10100000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A0 ip context)
    | 0b10100001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A1 ip context)
    | 0b10100010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A2 ip context)
    | 0b10100011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A3 ip context)
    | 0b10100100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A4 ip context)
    | 0b10100101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A5 ip context)
    | 0b10100110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A6 ip context)
    | 0b10100111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A7 ip context)
    | 0b10101000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A8 ip context)
    | 0b10101001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_A9 ip context)
    | 0b10101010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_AA ip context)
    | 0b10101011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_AB ip context)
    | 0b10101100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_AC ip context)
    | 0b10101101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_AD ip context)
    | 0b10101110 => do
      Decode_Legacy_0_Opcode_AE ip context
    | 0b10101111 => do
      Decode_Legacy_0_Opcode_AF ip context
    | 0b10110000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B0 ip context opcode)
    | 0b10110001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B1 ip context opcode)
    | 0b10110010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B2 ip context opcode)
    | 0b10110011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B3 ip context opcode)
    | 0b10110100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B4 ip context opcode)
    | 0b10110101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B5 ip context opcode)
    | 0b10110110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B6 ip context opcode)
    | 0b10110111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B7 ip context opcode)
    | 0b10111000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B8 ip context opcode)
    | 0b10111001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_B9 ip context opcode)
    | 0b10111010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_BA ip context opcode)
    | 0b10111011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_BB ip context opcode)
    | 0b10111100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_BC ip context opcode)
    | 0b10111101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_BD ip context opcode)
    | 0b10111110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_BE ip context opcode)
    | 0b10111111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_BF ip context opcode)
    | 0b11000000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C0 ip context)
    | 0b11000001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C1 ip context)
    | 0b11000010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C2 ip context)
    | 0b11000011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C3 ip context)
    | 0b11000110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C6 ip context)
    | 0b11000111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C7 ip context)
    | 0b11001000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C8 ip context)
    | 0b11001001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_C9 ip context)
    | 0b11001010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_CA ip context)
    | 0b11001011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_CB ip context)
    | 0b11001100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_CC ip context)
    | 0b11001101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_CD ip context)
    | 0b11001111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_CF ip context)
    | 0b11010000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_D0 ip context)
    | 0b11010001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_D1 ip context)
    | 0b11010010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_D2 ip context)
    | 0b11010011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_D3 ip context)
    | 0b11010110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_D6 ip context)
    | 0b11010111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_D7 ip context)
    | 0b11011000 => do
      Decode_Legacy_0_Opcode_D8 ip context opcode
    | 0b11011001 => do
      Decode_Legacy_0_Opcode_D9 ip context opcode
    | 0b11011010 => do
      Decode_Legacy_0_Opcode_DA ip context opcode
    | 0b11011011 => do
      Decode_Legacy_0_Opcode_DB ip context opcode
    | 0b11011100 => do
      Decode_Legacy_0_Opcode_DC ip context opcode
    | 0b11011101 => do
      Decode_Legacy_0_Opcode_DD ip context opcode
    | 0b11011110 => do
      Decode_Legacy_0_Opcode_DE ip context opcode
    | 0b11011111 => do
      Decode_Legacy_0_Opcode_DF ip context opcode
    | 0b11100000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E0 ip context)
    | 0b11100001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E1 ip context)
    | 0b11100010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E2 ip context)
    | 0b11100011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E3 ip context)
    | 0b11100100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E4 ip context)
    | 0b11100101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E5 ip context)
    | 0b11100110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E6 ip context)
    | 0b11100111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E7 ip context)
    | 0b11101000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E8 ip context)
    | 0b11101001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_E9 ip context)
    | 0b11101011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_EB ip context)
    | 0b11101100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_EC ip context)
    | 0b11101101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_ED ip context)
    | 0b11101110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_EE ip context)
    | 0b11101111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_EF ip context)
    | 0b11110001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F1 ip context)
    | 0b11110100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F4 ip context)
    | 0b11110101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F5 ip context)
    | 0b11110110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F6 ip context)
    | 0b11110111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F7 ip context)
    | 0b11111000 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F8 ip context)
    | 0b11111001 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_F9 ip context)
    | 0b11111010 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_FA ip context)
    | 0b11111011 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_FB ip context)
    | 0b11111100 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_FC ip context)
    | 0b11111101 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_FD ip context)
    | 0b11111110 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_FE ip context)
    | 0b11111111 => do
      Runtime.liftTotal (Decode_Legacy_0_Opcode_FF ip context)
    | _ => do
      Runtime.liftTotal (Unimplemented_Feature "unselected legacy map 0 instruction" false true)

end X86.Helpers

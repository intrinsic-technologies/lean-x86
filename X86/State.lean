-- Generated from data/definitions.xml.gz: shared architectural globals; local ISA specifications; do not edit.
-- Source SHA256: 011f34bc3991d7f747a273ddbb336ea48ef71606078fa8b9ea9de1504c69383a
import X86.Runtime
import X86.Config
import X86.Helpers.Asynchronous_Event_Type
import X86.Helpers.Concurrent_Exception_Record
import X86.Helpers.Descriptor_Table_Register
import X86.Helpers.Event_Blocked_Record
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Taken
import X86.Helpers.F80_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Instruction_Ended
import X86.Helpers.Memory_Type
import X86.Helpers.Random_Value
import X86.Helpers.Segment
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Thread_Status_Type
import X86.Helpers.VMX_Operation_Type

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

abbrev RFLAGS_Type := Bits 64

def RFLAGS_Type.CF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def RFLAGS_Type.setCF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 0 1 value

def RFLAGS_Type.PF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def RFLAGS_Type.setPF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 2 1 value

def RFLAGS_Type.AF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def RFLAGS_Type.setAF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 4 1 value

def RFLAGS_Type.ZF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def RFLAGS_Type.setZF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 6 1 value

def RFLAGS_Type.SF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def RFLAGS_Type.setSF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 7 1 value

def RFLAGS_Type.TF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def RFLAGS_Type.setTF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 8 1 value

def RFLAGS_Type.IF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def RFLAGS_Type.setIF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 9 1 value

def RFLAGS_Type.DF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def RFLAGS_Type.setDF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 10 1 value

def RFLAGS_Type.OF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def RFLAGS_Type.setOF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 11 1 value

def RFLAGS_Type.IOPL (bits : RFLAGS_Type) : Bits 2 :=
  BitVec.extractLsb' 12 2 bits

def RFLAGS_Type.setIOPL (bits : RFLAGS_Type) (value : Bits 2) : RFLAGS_Type :=
  setSlice bits 12 2 value

def RFLAGS_Type.NT (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 14 1 bits

def RFLAGS_Type.setNT (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 14 1 value

def RFLAGS_Type.RF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 16 1 bits

def RFLAGS_Type.setRF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 16 1 value

def RFLAGS_Type.VM (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 17 1 bits

def RFLAGS_Type.setVM (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 17 1 value

def RFLAGS_Type.AC (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 18 1 bits

def RFLAGS_Type.setAC (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 18 1 value

def RFLAGS_Type.VIF (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 19 1 bits

def RFLAGS_Type.setVIF (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 19 1 value

def RFLAGS_Type.VIP (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 20 1 bits

def RFLAGS_Type.setVIP (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 20 1 value

def RFLAGS_Type.ID (bits : RFLAGS_Type) : Runtime.Bit :=
  BitVec.extractLsb' 21 1 bits

def RFLAGS_Type.setID (bits : RFLAGS_Type) (value : Runtime.Bit) : RFLAGS_Type :=
  setSlice bits 21 1 value

abbrev CR0_Type := Bits 64

def CR0_Type.PE (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def CR0_Type.setPE (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 0 1 value

def CR0_Type.MP (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def CR0_Type.setMP (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 1 1 value

def CR0_Type.EM (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def CR0_Type.setEM (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 2 1 value

def CR0_Type.TS (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def CR0_Type.setTS (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 3 1 value

def CR0_Type.ET (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def CR0_Type.setET (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 4 1 value

def CR0_Type.NE (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def CR0_Type.setNE (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 5 1 value

def CR0_Type.WP (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 16 1 bits

def CR0_Type.setWP (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 16 1 value

def CR0_Type.AM (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 18 1 bits

def CR0_Type.setAM (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 18 1 value

def CR0_Type.NW (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 29 1 bits

def CR0_Type.setNW (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 29 1 value

def CR0_Type.CD (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 30 1 bits

def CR0_Type.setCD (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 30 1 value

def CR0_Type.PG (bits : CR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 31 1 bits

def CR0_Type.setPG (bits : CR0_Type) (value : Runtime.Bit) : CR0_Type :=
  setSlice bits 31 1 value

def CR0_Type.RESERVED (bits : CR0_Type) : Bits 53 :=
  BitVec.append (BitVec.append (BitVec.append (BitVec.extractLsb' 32 32 bits) (BitVec.extractLsb' 19 10 bits)) (BitVec.extractLsb' 17 1 bits)) (BitVec.extractLsb' 6 10 bits)

def CR0_Type.setRESERVED (bits : CR0_Type) (value : Bits 53) : CR0_Type :=
  let bits := setSlice bits 6 10 (BitVec.extractLsb' 0 10 value)
  let bits := setSlice bits 17 1 (BitVec.extractLsb' 10 1 value)
  let bits := setSlice bits 19 10 (BitVec.extractLsb' 11 10 value)
  setSlice bits 32 32 (BitVec.extractLsb' 21 32 value)

abbrev CR3_Type := Bits 64

def CR3_Type.PWT (bits : CR3_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def CR3_Type.setPWT (bits : CR3_Type) (value : Runtime.Bit) : CR3_Type :=
  setSlice bits 3 1 value

def CR3_Type.PCD (bits : CR3_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def CR3_Type.setPCD (bits : CR3_Type) (value : Runtime.Bit) : CR3_Type :=
  setSlice bits 4 1 value

def CR3_Type.LAM_U57 (bits : CR3_Type) : Runtime.Bit :=
  BitVec.extractLsb' 61 1 bits

def CR3_Type.setLAM_U57 (bits : CR3_Type) (value : Runtime.Bit) : CR3_Type :=
  setSlice bits 61 1 value

def CR3_Type.LAM_U48 (bits : CR3_Type) : Runtime.Bit :=
  BitVec.extractLsb' 62 1 bits

def CR3_Type.setLAM_U48 (bits : CR3_Type) (value : Runtime.Bit) : CR3_Type :=
  setSlice bits 62 1 value

abbrev CR4_Type := Bits 64

def CR4_Type.VME (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def CR4_Type.setVME (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 0 1 value

def CR4_Type.PVI (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def CR4_Type.setPVI (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 1 1 value

def CR4_Type.TSD (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def CR4_Type.setTSD (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 2 1 value

def CR4_Type.DE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def CR4_Type.setDE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 3 1 value

def CR4_Type.PSE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def CR4_Type.setPSE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 4 1 value

def CR4_Type.PAE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def CR4_Type.setPAE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 5 1 value

def CR4_Type.MCE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def CR4_Type.setMCE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 6 1 value

def CR4_Type.PGE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def CR4_Type.setPGE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 7 1 value

def CR4_Type.PCE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def CR4_Type.setPCE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 8 1 value

def CR4_Type.OSFXSR (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 9 1 bits

def CR4_Type.setOSFXSR (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 9 1 value

def CR4_Type.OSXMMEXCPT (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def CR4_Type.setOSXMMEXCPT (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 10 1 value

def CR4_Type.UMIP (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def CR4_Type.setUMIP (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 11 1 value

def CR4_Type.LA57 (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 12 1 bits

def CR4_Type.setLA57 (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 12 1 value

def CR4_Type.VMXE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 13 1 bits

def CR4_Type.setVMXE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 13 1 value

def CR4_Type.SMXE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 14 1 bits

def CR4_Type.setSMXE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 14 1 value

def CR4_Type.FSGSBASE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 16 1 bits

def CR4_Type.setFSGSBASE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 16 1 value

def CR4_Type.PCIDE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 17 1 bits

def CR4_Type.setPCIDE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 17 1 value

def CR4_Type.OSXSAVE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 18 1 bits

def CR4_Type.setOSXSAVE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 18 1 value

def CR4_Type.KL (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 19 1 bits

def CR4_Type.setKL (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 19 1 value

def CR4_Type.SMEP (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 20 1 bits

def CR4_Type.setSMEP (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 20 1 value

def CR4_Type.SMAP (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 21 1 bits

def CR4_Type.setSMAP (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 21 1 value

def CR4_Type.PKE (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 22 1 bits

def CR4_Type.setPKE (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 22 1 value

def CR4_Type.CET (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 23 1 bits

def CR4_Type.setCET (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 23 1 value

def CR4_Type.PKS (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 24 1 bits

def CR4_Type.setPKS (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 24 1 value

def CR4_Type.UINTR (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 25 1 bits

def CR4_Type.setUINTR (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 25 1 value

def CR4_Type.LASS (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 27 1 bits

def CR4_Type.setLASS (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 27 1 value

def CR4_Type.LAM_SUP (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 28 1 bits

def CR4_Type.setLAM_SUP (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 28 1 value

def CR4_Type.FRED (bits : CR4_Type) : Runtime.Bit :=
  BitVec.extractLsb' 32 1 bits

def CR4_Type.setFRED (bits : CR4_Type) (value : Runtime.Bit) : CR4_Type :=
  setSlice bits 32 1 value

def CR4_Type.RESERVED (bits : CR4_Type) : Bits 36 :=
  BitVec.append (BitVec.append (BitVec.append (BitVec.extractLsb' 33 31 bits) (BitVec.extractLsb' 29 3 bits)) (BitVec.extractLsb' 26 1 bits)) (BitVec.extractLsb' 15 1 bits)

def CR4_Type.setRESERVED (bits : CR4_Type) (value : Bits 36) : CR4_Type :=
  let bits := setSlice bits 15 1 (BitVec.extractLsb' 0 1 value)
  let bits := setSlice bits 26 1 (BitVec.extractLsb' 1 1 value)
  let bits := setSlice bits 29 3 (BitVec.extractLsb' 2 3 value)
  setSlice bits 33 31 (BitVec.extractLsb' 5 31 value)

structure EFER_Inputs where
  SCE : Runtime.Bit
  LME : Runtime.Bit
  LMA : Runtime.Bit
  NXE : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

abbrev XCR0_Type := Bits 64

def XCR0_Type.SSE (bits : XCR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def XCR0_Type.setSSE (bits : XCR0_Type) (value : Runtime.Bit) : XCR0_Type :=
  setSlice bits 1 1 value

def XCR0_Type.AVX (bits : XCR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def XCR0_Type.setAVX (bits : XCR0_Type) (value : Runtime.Bit) : XCR0_Type :=
  setSlice bits 2 1 value

def XCR0_Type.ZMM_Hi256 (bits : XCR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def XCR0_Type.setZMM_Hi256 (bits : XCR0_Type) (value : Runtime.Bit) : XCR0_Type :=
  setSlice bits 6 1 value

def XCR0_Type.Hi16_ZMM (bits : XCR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def XCR0_Type.setHi16_ZMM (bits : XCR0_Type) (value : Runtime.Bit) : XCR0_Type :=
  setSlice bits 7 1 value

def XCR0_Type.APX_F (bits : XCR0_Type) : Runtime.Bit :=
  BitVec.extractLsb' 19 1 bits

def XCR0_Type.setAPX_F (bits : XCR0_Type) (value : Runtime.Bit) : XCR0_Type :=
  setSlice bits 19 1 value

structure AET_EVENT_CTRL_Inputs where
  ENABLE : Runtime.Bit
  CODE_BREAKPOINT : Runtime.Bit
  DATA_BREAKPOINT : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

abbrev DR6_Inputs := Bits 64

def DR6_Inputs.B (bits : DR6_Inputs) : Bits 4 :=
  BitVec.extractLsb' 0 4 bits

def DR6_Inputs.setB (bits : DR6_Inputs) (value : Bits 4) : DR6_Inputs :=
  setSlice bits 0 4 value

def DR6_Inputs.BLD (bits : DR6_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def DR6_Inputs.setBLD (bits : DR6_Inputs) (value : Runtime.Bit) : DR6_Inputs :=
  setSlice bits 11 1 value

def DR6_Inputs.BD (bits : DR6_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 13 1 bits

def DR6_Inputs.setBD (bits : DR6_Inputs) (value : Runtime.Bit) : DR6_Inputs :=
  setSlice bits 13 1 value

def DR6_Inputs.BS (bits : DR6_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 14 1 bits

def DR6_Inputs.setBS (bits : DR6_Inputs) (value : Runtime.Bit) : DR6_Inputs :=
  setSlice bits 14 1 value

def DR6_Inputs.BT (bits : DR6_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 15 1 bits

def DR6_Inputs.setBT (bits : DR6_Inputs) (value : Runtime.Bit) : DR6_Inputs :=
  setSlice bits 15 1 value

structure Pin_Based_VM_Exec_Controls_Inputs where
  NMI_Exiting : Runtime.Bit
  Virtual_NMIs : Runtime.Bit
  External_Interrupt_Exiting : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure VM_Exec_Controls1_Inputs where
  Use_MSR_Bitmaps : Runtime.Bit
  Use_IO_Bitmaps : Runtime.Bit
  Unconditional_IO_Exiting : Runtime.Bit
  INVLPG_Exiting : Runtime.Bit
  RDTSC_Exiting : Runtime.Bit
  HLT_Exiting : Runtime.Bit
  CR3_Load_Exiting : Runtime.Bit
  CR3_Store_Exiting : Runtime.Bit
  CR8_Load_Exiting : Runtime.Bit
  CR8_Store_Exiting : Runtime.Bit
  MOV_DR_Exiting : Runtime.Bit
  Use_TPR_Shadow : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure PLATFORM_INFO_Inputs where
  CPUID_FAULTING_EN : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure FEATURE_ENABLES_Inputs where
  CPUID_GP_ON_CPL_GT_0 : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure IA32_MISC_ENABLE_Inputs where
  LIMIT_CPUID_MAXVAL : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

abbrev MXCSR_Type := Bits 32

def MXCSR_Type.Exception_Flags (bits : MXCSR_Type) : Bits 6 :=
  BitVec.extractLsb' 0 6 bits

def MXCSR_Type.setException_Flags (bits : MXCSR_Type) (value : Bits 6) : MXCSR_Type :=
  setSlice bits 0 6 value

def MXCSR_Type.DAZ (bits : MXCSR_Type) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def MXCSR_Type.setDAZ (bits : MXCSR_Type) (value : Runtime.Bit) : MXCSR_Type :=
  setSlice bits 6 1 value

def MXCSR_Type.Exception_Masks (bits : MXCSR_Type) : Bits 6 :=
  BitVec.extractLsb' 7 6 bits

def MXCSR_Type.setException_Masks (bits : MXCSR_Type) (value : Bits 6) : MXCSR_Type :=
  setSlice bits 7 6 value

def MXCSR_Type.OM (bits : MXCSR_Type) : Runtime.Bit :=
  BitVec.extractLsb' 10 1 bits

def MXCSR_Type.setOM (bits : MXCSR_Type) (value : Runtime.Bit) : MXCSR_Type :=
  setSlice bits 10 1 value

def MXCSR_Type.UM (bits : MXCSR_Type) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def MXCSR_Type.setUM (bits : MXCSR_Type) (value : Runtime.Bit) : MXCSR_Type :=
  setSlice bits 11 1 value

def MXCSR_Type.RC (bits : MXCSR_Type) : Bits 2 :=
  BitVec.extractLsb' 13 2 bits

def MXCSR_Type.setRC (bits : MXCSR_Type) (value : Bits 2) : MXCSR_Type :=
  setSlice bits 13 2 value

def MXCSR_Type.FTZ (bits : MXCSR_Type) : Runtime.Bit :=
  BitVec.extractLsb' 15 1 bits

def MXCSR_Type.setFTZ (bits : MXCSR_Type) (value : Runtime.Bit) : MXCSR_Type :=
  setSlice bits 15 1 value

def MXCSR_Type.RESERVED (bits : MXCSR_Type) : Bits 16 :=
  BitVec.extractLsb' 16 16 bits

def MXCSR_Type.setRESERVED (bits : MXCSR_Type) (value : Bits 16) : MXCSR_Type :=
  setSlice bits 16 16 value

structure PRMRR_Phys_Mask_Inputs where
  VALID : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure BIOS_Done_Inputs where
  ENABLE_IA_UNTRUSTED : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

inductive Debug_Cause where
  | Debug_No_Exception
  | Debug_Instruction_Breakpoint
  | Debug_Trap
  | Debug_General_Detect
  deriving Repr, DecidableEq, Inhabited

abbrev IA32_DEBUGCTL_Inputs := Bits 64

def IA32_DEBUGCTL_Inputs.LBR (bits : IA32_DEBUGCTL_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def IA32_DEBUGCTL_Inputs.setLBR (bits : IA32_DEBUGCTL_Inputs) (value : Runtime.Bit) : IA32_DEBUGCTL_Inputs :=
  setSlice bits 0 1 value

def IA32_DEBUGCTL_Inputs.BTF (bits : IA32_DEBUGCTL_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def IA32_DEBUGCTL_Inputs.setBTF (bits : IA32_DEBUGCTL_Inputs) (value : Runtime.Bit) : IA32_DEBUGCTL_Inputs :=
  setSlice bits 1 1 value

def IA32_DEBUGCTL_Inputs.BUS_LOCK_DETECT (bits : IA32_DEBUGCTL_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def IA32_DEBUGCTL_Inputs.setBUS_LOCK_DETECT (bits : IA32_DEBUGCTL_Inputs) (value : Runtime.Bit) : IA32_DEBUGCTL_Inputs :=
  setSlice bits 2 1 value

structure MEMORY_CONTROL_Inputs where
  SPLIT_LOCK_DISABLE : Runtime.Bit
  UC_LOCK_DISABLE : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

abbrev DR7_Inputs := Bits 64

def DR7_Inputs.L0 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def DR7_Inputs.setL0 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 0 1 value

def DR7_Inputs.G0 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def DR7_Inputs.setG0 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 1 1 value

def DR7_Inputs.L1 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def DR7_Inputs.setL1 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 2 1 value

def DR7_Inputs.G1 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def DR7_Inputs.setG1 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 3 1 value

def DR7_Inputs.L2 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def DR7_Inputs.setL2 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 4 1 value

def DR7_Inputs.G2 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def DR7_Inputs.setG2 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 5 1 value

def DR7_Inputs.L3 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def DR7_Inputs.setL3 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 6 1 value

def DR7_Inputs.G3 (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def DR7_Inputs.setG3 (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 7 1 value

def DR7_Inputs.LE (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 8 1 bits

def DR7_Inputs.setLE (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 8 1 value

def DR7_Inputs.GD (bits : DR7_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 13 1 bits

def DR7_Inputs.setGD (bits : DR7_Inputs) (value : Runtime.Bit) : DR7_Inputs :=
  setSlice bits 13 1 value

def DR7_Inputs.RW0 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 16 2 bits

def DR7_Inputs.setRW0 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 16 2 value

def DR7_Inputs.LEN0 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 18 2 bits

def DR7_Inputs.setLEN0 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 18 2 value

def DR7_Inputs.RW1 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 20 2 bits

def DR7_Inputs.setRW1 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 20 2 value

def DR7_Inputs.LEN1 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 22 2 bits

def DR7_Inputs.setLEN1 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 22 2 value

def DR7_Inputs.RW2 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 24 2 bits

def DR7_Inputs.setRW2 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 24 2 value

def DR7_Inputs.LEN2 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 26 2 bits

def DR7_Inputs.setLEN2 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 26 2 value

def DR7_Inputs.RW3 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 28 2 bits

def DR7_Inputs.setRW3 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 28 2 value

def DR7_Inputs.LEN3 (bits : DR7_Inputs) : Bits 2 :=
  BitVec.extractLsb' 30 2 bits

def DR7_Inputs.setLEN3 (bits : DR7_Inputs) (value : Bits 2) : DR7_Inputs :=
  setSlice bits 30 2 value

structure IA32_VMX_EPT_VPID_CAP_Inputs where
  PLR_PREFIX_SIZE_0 : Runtime.Bit
  PLR_PREFIX_SIZE_5_1 : Bits 5
  SUPPORTS_EPT_EXECUTE_ONLY : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure VM_Exec_Controls2_Inputs where
  Unrestricted_Guest : Runtime.Bit
  Descriptor_Table_Exiting : Runtime.Bit
  WBINVD_Exiting : Runtime.Bit
  EPT_Violation_VE : Runtime.Bit
  Enable_EPT : Runtime.Bit
  Mode_Based_Execute_Control_For_EPT : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

structure VM_Exec_Controls3_Inputs where
  EPT_Paging_Write_Control : Runtime.Bit
  Enable_HLAT : Runtime.Bit
  deriving Repr, DecidableEq, Inhabited

abbrev EPTP_Inputs := Bits 64

def EPTP_Inputs.Memory_Type (bits : EPTP_Inputs) : Bits 3 :=
  BitVec.extractLsb' 0 3 bits

def EPTP_Inputs.setMemory_Type (bits : EPTP_Inputs) (value : Bits 3) : EPTP_Inputs :=
  setSlice bits 0 3 value

def EPTP_Inputs.EPT_Page_Walk_Length (bits : EPTP_Inputs) : Bits 3 :=
  BitVec.extractLsb' 3 3 bits

def EPTP_Inputs.setEPT_Page_Walk_Length (bits : EPTP_Inputs) (value : Bits 3) : EPTP_Inputs :=
  setSlice bits 3 3 value

def EPTP_Inputs.Enable_EPT_Accessed_And_Dirty_Flags (bits : EPTP_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def EPTP_Inputs.setEnable_EPT_Accessed_And_Dirty_Flags (bits : EPTP_Inputs) (value : Runtime.Bit) : EPTP_Inputs :=
  setSlice bits 6 1 value

def EPTP_Inputs.EPT_PML4_Or_PML5_Table_Physical_Address (bits : EPTP_Inputs) : Bits 40 :=
  BitVec.extractLsb' 12 40 bits

def EPTP_Inputs.setEPT_PML4_Or_PML5_Table_Physical_Address (bits : EPTP_Inputs) (value : Bits 40) : EPTP_Inputs :=
  setSlice bits 12 40 value

abbrev HLATP_Inputs := Bits 64

def HLATP_Inputs.PWT (bits : HLATP_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def HLATP_Inputs.setPWT (bits : HLATP_Inputs) (value : Runtime.Bit) : HLATP_Inputs :=
  setSlice bits 3 1 value

def HLATP_Inputs.PCD (bits : HLATP_Inputs) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def HLATP_Inputs.setPCD (bits : HLATP_Inputs) (value : Runtime.Bit) : HLATP_Inputs :=
  setSlice bits 4 1 value

abbrev SSP_Type := Bits 64

def SSP_Type.Busy (bits : SSP_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def SSP_Type.setBusy (bits : SSP_Type) (value : Runtime.Bit) : SSP_Type :=
  setSlice bits 0 1 value

def SSP_Type.Reserved (bits : SSP_Type) : Bits 2 :=
  BitVec.extractLsb' 1 2 bits

def SSP_Type.setReserved (bits : SSP_Type) (value : Bits 2) : SSP_Type :=
  setSlice bits 1 2 value

def SSP_Type.LinearAddress (bits : SSP_Type) : Bits 61 :=
  BitVec.extractLsb' 3 61 bits

def SSP_Type.setLinearAddress (bits : SSP_Type) (value : Bits 61) : SSP_Type :=
  setSlice bits 3 61 value

structure IA32_U_CET_Type where
  SH_STK_EN : Runtime.Bit
  ENDBR_EN : Runtime.Bit
  NO_TRACK_EN : Runtime.Bit
  SUPPRESS : Runtime.Bit
  TRACKER : Runtime.Bit
  LEG_IW_EN : Runtime.Bit
  SUPPRESS_DIS : Runtime.Bit
  EB_LEG_BITMAP_BASE : Bits 52
  deriving Repr, DecidableEq, Inhabited

inductive Exception where
  | Exception_Info (value : Exception_Info)
  | Instruction_Ended (value : Instruction_Ended)
  | Exception_Taken (value : Exception_Taken)
  deriving Repr, DecidableEq

instance : Coe Exception_Info Exception := ⟨Exception.Exception_Info⟩
instance : Coe Instruction_Ended Exception := ⟨Exception.Instruction_Ended⟩
instance : Coe Exception_Taken Exception := ⟨Exception.Exception_Taken⟩

abbrev Result (α : Type) := Except (Runtime.Error Exception) α

structure State (σ : Type) where
  Branch_Taken : Bool
  CET_Tracker_Updated : Bool
  CPL : Int
  CS : Segment
  Committed_To_Task_Switch : Bool
  Concurrent_Exception : Concurrent_Exception_Record
  Current_Event : Asynchronous_Event_Type
  Current_VMCS_Pointer : Bits 64
  DS : Segment
  Debug_Breakpoint_Trap_Detected : Bool
  Debug_Breakpoints_Matched : Bits 4
  Debug_Bus_Lock_Trap_Detected : Bool
  Debug_Single_Step_Trap_Detected : Bool
  Debug_Task_Switch_Trap_Detected : Bool
  Default_Error_Code : Selector_Error_Code
  Double_Fault_Contributory_Exception : Int
  ES : Segment
  Event_Blocked : Event_Blocked_Record
  FP87 : Runtime.Array 8 (F80_Type)
  FP87_Control : FP87_Control_Type
  FP87_FCS : Bits 16
  FP87_FDP : Bits 64
  FP87_FDS : Bits 16
  FP87_FIP : Bits 64
  FP87_FOP : Bits 11
  FP87_Status : FP87_Status_Type
  FP87_Tag_Word : Bits 16
  «FRED::Event_Delivery_In_Progress» : Bool
  FS : Segment
  GDTR : Descriptor_Table_Register
  GS : Segment
  IDTR : Descriptor_Table_Register
  Interrupt_Vector : Int
  LDTR : Segment
  «MSRLIST::In_Process» : Bool
  Next_IP : Bits 64
  «Random_Numbers::HW_NRND_GEN» : Random_Value
  Repeat_String_Operation : Bool
  Repeat_String_RF_Pending : Bool
  Repeat_String_RF_Pending_RIP : Bits 64
  SS : Segment
  Saving_Task_State_During_Task_Switch : Bool
  TR : Segment
  Thread_Status : Thread_Status_Type
  VMX_On_Pointer : Bits 64
  VMX_Operation_Mode : VMX_Operation_Type
  RFLAGS : RFLAGS_Type
  CR0 : CR0_Type
  CR3 : CR3_Type
  APIC_TPR : Bits 8
  CR4 : CR4_Type
  IA32_EFER : EFER_Inputs
  XCR0 : XCR0_Type
  RIP : Bits 64
  GPR : Runtime.Array 32 (Bits 64)
  ZMM : Runtime.Array 32 (Bits 512)
  K : Runtime.Array 8 (Bits 64)
  AET_EVENT_CTRL : AET_EVENT_CTRL_Inputs
  DR6 : DR6_Inputs
  CR2 : Bits 64
  IA32_INTERRUPT_SSP_TABLE_ADDR : Bits 64
  IA32_KERNEL_GS_BASE : Bits 64
  IA32_STAR : Bits 64
  IA32_LSTAR : Bits 64
  IA32_FMASK : Bits 64
  IA32_PL0_SSP : SSP_Type
  IA32_PL1_SSP : SSP_Type
  IA32_PL2_SSP : SSP_Type
  IA32_PL3_SSP : SSP_Type
  «Monitor::Address» : Bits 64
  «Monitor::Is_Armed» : Bool
  «Monitor::Is_User_Monitor» : Bool
  «SMM::In_SMM» : Bool
  «SMX::In_Measured_Environment» : Bool
  «TSX::HLE_Active» : Bool
  «TSX::HLE_Nest_Count» : Int
  «TSX::HLE_Restart_RIP» : Bits 64
  «TSX::MAX_HLE_NEST_COUNT» : Int
  «TSX::MAX_RTM_NEST_COUNT» : Int
  «TSX::RTM_Active» : Bool
  «TSX::RTM_Fallback_RIP» : Bits 64
  «TSX::RTM_Nest_Count» : Int
  «TSX::SUSLDTRK_Active» : Bool
  XINIT_BV : Bits 64
  «VMCS::Pin_Based_VM_Exec_Controls» : Pin_Based_VM_Exec_Controls_Inputs
  IA32_VMX_CR0_FIXED0 : Bits 64
  IA32_VMX_CR0_FIXED1 : Bits 64
  IA32_VMX_CR4_FIXED0 : Bits 64
  IA32_VMX_CR4_FIXED1 : Bits 64
  PLATFORM_INFO : PLATFORM_INFO_Inputs
  FEATURE_ENABLES : FEATURE_ENABLES_Inputs
  IA32_MISC_ENABLE : IA32_MISC_ENABLE_Inputs
  MXCSR : MXCSR_Type
  PRMRR_PHYS_MASK : PRMRR_Phys_Mask_Inputs
  BIOS_DONE : BIOS_Done_Inputs
  «VMCS::Address_Of_MSR_Bitmaps» : Bits 64
  FXSAVE_MXCSR_Mask : Bits 32
  Execution_Debug_Cause : Debug_Cause
  IA32_DEBUGCTL : IA32_DEBUGCTL_Inputs
  MEMORY_CONTROL : MEMORY_CONTROL_Inputs
  DR7 : DR7_Inputs
  DR0 : Bits 64
  DR1 : Bits 64
  DR2 : Bits 64
  DR3 : Bits 64
  PKRU : Bits 32
  IA32_PKRS : Bits 64
  IA32_VMX_EPT_VPID_CAP : IA32_VMX_EPT_VPID_CAP_Inputs
  «VMCS::EPTP» : EPTP_Inputs
  «VMCS::HLATP» : HLATP_Inputs
  SSP : SSP_Type
  IA32_U_CET : IA32_U_CET_Type
  IA32_S_CET : IA32_U_CET_Type
  «VMCS::Primary_VM_Exec_Controls» : Bits 32
  «VMCS::Secondary_VM_Exec_Controls» : Bits 32
  «VMCS::Tertiary_VM_Exec_Controls» : Bits 64
  IA32_PAT : Bits 64
  IA32_MTRR_DEF_TYPE : Bits 64
  MTRR_Fixed : Runtime.Array 11 (Bits 64)
  MTRR_Base : Runtime.Array 256 (Bits 64)
  MTRR_Mask : Runtime.Array 256 (Bits 64)
  IA32_SMRR_PHYSBASE : Bits 64
  IA32_SMRR_PHYSMASK : Bits 64
  external : σ
  oracle : Runtime.Oracle := {}
  -- Ordered host output; it does not alias architectural memory.
  diagnostics : String := ""
  -- Reverse source-event order; Runtime.traceEvents provides the ordered view.
  traceEventsRev : List (String × String) := []
  deriving Inhabited

variable {σ : Type}

instance : Runtime.HasDiagnostics (State σ) where
  output state := state.diagnostics
  withOutput state diagnostics := { state with diagnostics }

instance : Runtime.HasTrace (State σ) where
  eventsRev state := state.traceEventsRev
  withEventsRev state traceEventsRev := { state with traceEventsRev }

def CS.setselector (value : Segment_Selector) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CS := { s.CS with selector := value } }

def CS.setdescriptor (value : Runtime.InitializedBits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CS := { s.CS with descriptor := value } }

def CS.setdescriptor_valid (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CS := { s.CS with descriptor_valid := value } }

def CS.setis_code (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CS := { s.CS with is_code := value } }

def Concurrent_Exception.setvector (value : Int) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Concurrent_Exception := { s.Concurrent_Exception with vector := value } }

def Concurrent_Exception.setvalid (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Concurrent_Exception := { s.Concurrent_Exception with valid := value } }

def Debug_Breakpoints_Matched.setSlice (offset width : Int) (value : Bits width) :
    Runtime.SpecM Exception (State σ) Unit := do
  let updated ← setSliceChecked (← getThe (State σ)).Debug_Breakpoints_Matched offset width value
  modify ({ · with Debug_Breakpoints_Matched := updated })

def Default_Error_Code.EXT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).Default_Error_Code 0 1

def Default_Error_Code.setEXT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Default_Error_Code := setSlice s.Default_Error_Code 0 1 value }

def Default_Error_Code.IDT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).Default_Error_Code 1 1

def Default_Error_Code.setIDT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Default_Error_Code := setSlice s.Default_Error_Code 1 1 value }

def Default_Error_Code.TI : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).Default_Error_Code 2 1

def Default_Error_Code.setTI (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Default_Error_Code := setSlice s.Default_Error_Code 2 1 value }

def Default_Error_Code.Index : Runtime.SpecM Exception (State σ) (Bits 13) := do
  return ← slice (← get).Default_Error_Code 3 13

def Default_Error_Code.setIndex (value : Bits 13) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Default_Error_Code := setSlice s.Default_Error_Code 3 13 value }

def Default_Error_Code.RESERVED : Runtime.SpecM Exception (State σ) (Bits 16) := do
  return ← slice (← get).Default_Error_Code 16 16

def Default_Error_Code.setRESERVED (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Default_Error_Code := setSlice s.Default_Error_Code 16 16 value }

def Event_Blocked.setNMI_BLOCKED (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with NMI_BLOCKED := value } }

def Event_Blocked.setSMI_BLOCKED (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with SMI_BLOCKED := value } }

def Event_Blocked.setINTR_BLOCKED (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with INTR_BLOCKED := value } }

def Event_Blocked.setINIT_BLOCKED (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with INIT_BLOCKED := value } }

def Event_Blocked.setSTI_BLOCKING (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with STI_BLOCKING := value } }

def Event_Blocked.setMOVSS_BLOCKING (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with MOVSS_BLOCKING := value } }

def Event_Blocked.setVIRT_NMI_BLOCKED (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with Event_Blocked := { s.Event_Blocked with VIRT_NMI_BLOCKED := value } }

def FP87.get (index : Int) : Runtime.SpecM Exception (State σ) (F80_Type) := do
  Runtime.Array.get (← getThe (State σ)).FP87 index

def FP87.set (index : Int) (value : F80_Type) : Runtime.SpecM Exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).FP87 index value
  modify ({ · with FP87 := values })

def FP87_Control.IM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 0 1

def FP87_Control.setIM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 0 1 value }

def FP87_Control.DM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 1 1

def FP87_Control.setDM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 1 1 value }

def FP87_Control.ZM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 2 1

def FP87_Control.setZM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 2 1 value }

def FP87_Control.OM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 3 1

def FP87_Control.setOM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 3 1 value }

def FP87_Control.UM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 4 1

def FP87_Control.setUM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 4 1 value }

def FP87_Control.PM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 5 1

def FP87_Control.setPM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 5 1 value }

def FP87_Control.Exception_Masks : Runtime.SpecM Exception (State σ) (Bits 6) := do
  return ← slice (← get).FP87_Control 0 6

def FP87_Control.setException_Masks (value : Bits 6) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 0 6 value }

def FP87_Control.RESERVED_ONE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 6 1

def FP87_Control.setRESERVED_ONE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 6 1 value }

def FP87_Control.PC : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).FP87_Control 8 2

def FP87_Control.setPC (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 8 2 value }

def FP87_Control.RC : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).FP87_Control 10 2

def FP87_Control.setRC (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 10 2 value }

def FP87_Control.X : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Control 12 1

def FP87_Control.setX (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := setSlice s.FP87_Control 12 1 value }

def FP87_Control.RESERVED_ZERO : Runtime.SpecM Exception (State σ) (Bits 4) := do
  return FP87_Control_Type.RESERVED_ZERO (← get).FP87_Control

def FP87_Control.setRESERVED_ZERO (value : Bits 4) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Control := FP87_Control_Type.setRESERVED_ZERO s.FP87_Control value }

def FP87_Control.setSlice (offset width : Int) (value : Bits width) :
    Runtime.SpecM Exception (State σ) Unit := do
  let updated ← setSliceChecked (← getThe (State σ)).FP87_Control offset width value
  modify ({ · with FP87_Control := updated })

def FP87_Status.IE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 0 1

def FP87_Status.setIE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 0 1 value }

def FP87_Status.DE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 1 1

def FP87_Status.setDE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 1 1 value }

def FP87_Status.ZE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 2 1

def FP87_Status.setZE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 2 1 value }

def FP87_Status.OE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 3 1

def FP87_Status.setOE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 3 1 value }

def FP87_Status.UE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 4 1

def FP87_Status.setUE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 4 1 value }

def FP87_Status.PE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 5 1

def FP87_Status.setPE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 5 1 value }

def FP87_Status.Exception_Flags : Runtime.SpecM Exception (State σ) (Bits 6) := do
  return ← slice (← get).FP87_Status 0 6

def FP87_Status.setException_Flags (value : Bits 6) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 0 6 value }

def FP87_Status.SF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 6 1

def FP87_Status.setSF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 6 1 value }

def FP87_Status.ES : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 7 1

def FP87_Status.setES (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 7 1 value }

def FP87_Status.C0 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 8 1

def FP87_Status.setC0 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 8 1 value }

def FP87_Status.C1 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 9 1

def FP87_Status.setC1 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 9 1 value }

def FP87_Status.C2 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 10 1

def FP87_Status.setC2 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 10 1 value }

def FP87_Status.TOP : Runtime.SpecM Exception (State σ) (Bits 3) := do
  return ← slice (← get).FP87_Status 11 3

def FP87_Status.setTOP (value : Bits 3) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 11 3 value }

def FP87_Status.C3 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 14 1

def FP87_Status.setC3 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 14 1 value }

def FP87_Status.CC : Runtime.SpecM Exception (State σ) (Bits 4) := do
  return FP87_Status_Type.CC (← get).FP87_Status

def FP87_Status.setCC (value : Bits 4) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := FP87_Status_Type.setCC s.FP87_Status value }

def FP87_Status.B : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).FP87_Status 15 1

def FP87_Status.setB (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FP87_Status := setSlice s.FP87_Status 15 1 value }

def FP87_Tag_Word.setSlice (offset width : Int) (value : Bits width) :
    Runtime.SpecM Exception (State σ) Unit := do
  let updated ← setSliceChecked (← getThe (State σ)).FP87_Tag_Word offset width value
  modify ({ · with FP87_Tag_Word := updated })

def FS.setis_64bit_mode_data_segment (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with FS := { s.FS with is_64bit_mode_data_segment := value } }

def GDTR.setlimit (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with GDTR := { s.GDTR with limit := value } }

def GDTR.setbase (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with GDTR := { s.GDTR with base := value } }

def GS.setis_64bit_mode_data_segment (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with GS := { s.GS with is_64bit_mode_data_segment := value } }

def IDTR.setlimit (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IDTR := { s.IDTR with limit := value } }

def IDTR.setbase (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IDTR := { s.IDTR with base := value } }

def LDTR.setselector (value : Segment_Selector) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with LDTR := { s.LDTR with selector := value } }

def LDTR.setdescriptor (value : Runtime.InitializedBits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with LDTR := { s.LDTR with descriptor := value } }

def LDTR.setdescriptor_valid (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with LDTR := { s.LDTR with descriptor_valid := value } }

def «Random_Numbers::HW_NRND_GEN».setReady (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «Random_Numbers::HW_NRND_GEN» := { s.«Random_Numbers::HW_NRND_GEN» with Ready := value } }

def «Random_Numbers::HW_NRND_GEN».setData (value : Bits 384) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «Random_Numbers::HW_NRND_GEN» := { s.«Random_Numbers::HW_NRND_GEN» with Data := value } }

def SS.setselector (value : Segment_Selector) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SS := { s.SS with selector := value } }

def SS.setdescriptor (value : Runtime.InitializedBits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SS := { s.SS with descriptor := value } }

def SS.setdescriptor_valid (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SS := { s.SS with descriptor_valid := value } }

def SS.setis_stack (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SS := { s.SS with is_stack := value } }

def SS.setis_code (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SS := { s.SS with is_code := value } }

def SS.setis_64bit_mode_data_segment (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SS := { s.SS with is_64bit_mode_data_segment := value } }

def TR.setselector (value : Segment_Selector) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with TR := { s.TR with selector := value } }

def TR.setdescriptor (value : Runtime.InitializedBits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with TR := { s.TR with descriptor := value } }

def TR.setdescriptor_valid (value : Option (Bool)) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with TR := { s.TR with descriptor_valid := value } }

def RFLAGS.CF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 0 1

def RFLAGS.setCF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 0 1 value }

def RFLAGS.PF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 2 1

def RFLAGS.setPF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 2 1 value }

def RFLAGS.AF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 4 1

def RFLAGS.setAF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 4 1 value }

def RFLAGS.ZF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 6 1

def RFLAGS.setZF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 6 1 value }

def RFLAGS.SF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 7 1

def RFLAGS.setSF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 7 1 value }

def RFLAGS.TF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 8 1

def RFLAGS.setTF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 8 1 value }

def RFLAGS.IF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 9 1

def RFLAGS.setIF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 9 1 value }

def RFLAGS.DF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 10 1

def RFLAGS.setDF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 10 1 value }

def RFLAGS.OF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 11 1

def RFLAGS.setOF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 11 1 value }

def RFLAGS.IOPL : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).RFLAGS 12 2

def RFLAGS.setIOPL (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 12 2 value }

def RFLAGS.NT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 14 1

def RFLAGS.setNT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 14 1 value }

def RFLAGS.RF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 16 1

def RFLAGS.setRF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 16 1 value }

def RFLAGS.VM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 17 1

def RFLAGS.setVM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 17 1 value }

def RFLAGS.AC : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 18 1

def RFLAGS.setAC (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 18 1 value }

def RFLAGS.VIF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 19 1

def RFLAGS.setVIF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 19 1 value }

def RFLAGS.VIP : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 20 1

def RFLAGS.setVIP (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 20 1 value }

def RFLAGS.ID : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).RFLAGS 21 1

def RFLAGS.setID (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with RFLAGS := setSlice s.RFLAGS 21 1 value }

def RFLAGS.setSlice (offset width : Int) (value : Bits width) :
    Runtime.SpecM Exception (State σ) Unit := do
  let updated ← setSliceChecked (← getThe (State σ)).RFLAGS offset width value
  modify ({ · with RFLAGS := updated })

def CR0.PE {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 0 1

def CR0.setPE {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 0 1 value }

def CR0.MP {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 1 1

def CR0.setMP {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 1 1 value }

def CR0.EM {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 2 1

def CR0.setEM {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 2 1 value }

def CR0.TS {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 3 1

def CR0.setTS {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 3 1 value }

def CR0.ET {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 4 1

def CR0.setET {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 4 1 value }

def CR0.NE {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 5 1

def CR0.setNE {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 5 1 value }

def CR0.WP {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 16 1

def CR0.setWP {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 16 1 value }

def CR0.AM {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 18 1

def CR0.setAM {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 18 1 value }

def CR0.NW {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 29 1

def CR0.setNW {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 29 1 value }

def CR0.CD {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 30 1

def CR0.setCD {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 30 1 value }

def CR0.PG {exception : Type} : Runtime.SpecM exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR0 31 1

def CR0.setPG {exception : Type} (value : Runtime.Bit) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := setSlice s.CR0 31 1 value }

def CR0.RESERVED {exception : Type} : Runtime.SpecM exception (State σ) (Bits 53) := do
  return CR0_Type.RESERVED (← get).CR0

def CR0.setRESERVED {exception : Type} (value : Bits 53) : Runtime.SpecM exception (State σ) Unit :=
  modify fun s => { s with CR0 := CR0_Type.setRESERVED s.CR0 value }

def CR3.PWT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR3 3 1

def CR3.setPWT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR3 := setSlice s.CR3 3 1 value }

def CR3.PCD : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR3 4 1

def CR3.setPCD (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR3 := setSlice s.CR3 4 1 value }

def CR3.LAM_U57 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR3 61 1

def CR3.setLAM_U57 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR3 := setSlice s.CR3 61 1 value }

def CR3.LAM_U48 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR3 62 1

def CR3.setLAM_U48 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR3 := setSlice s.CR3 62 1 value }

def CR4.VME : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 0 1

def CR4.setVME (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 0 1 value }

def CR4.PVI : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 1 1

def CR4.setPVI (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 1 1 value }

def CR4.TSD : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 2 1

def CR4.setTSD (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 2 1 value }

def CR4.DE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 3 1

def CR4.setDE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 3 1 value }

def CR4.PSE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 4 1

def CR4.setPSE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 4 1 value }

def CR4.PAE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 5 1

def CR4.setPAE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 5 1 value }

def CR4.MCE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 6 1

def CR4.setMCE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 6 1 value }

def CR4.PGE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 7 1

def CR4.setPGE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 7 1 value }

def CR4.PCE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 8 1

def CR4.setPCE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 8 1 value }

def CR4.OSFXSR : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 9 1

def CR4.setOSFXSR (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 9 1 value }

def CR4.OSXMMEXCPT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 10 1

def CR4.setOSXMMEXCPT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 10 1 value }

def CR4.UMIP : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 11 1

def CR4.setUMIP (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 11 1 value }

def CR4.LA57 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 12 1

def CR4.setLA57 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 12 1 value }

def CR4.VMXE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 13 1

def CR4.setVMXE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 13 1 value }

def CR4.SMXE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 14 1

def CR4.setSMXE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 14 1 value }

def CR4.FSGSBASE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 16 1

def CR4.setFSGSBASE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 16 1 value }

def CR4.PCIDE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 17 1

def CR4.setPCIDE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 17 1 value }

def CR4.OSXSAVE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 18 1

def CR4.setOSXSAVE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 18 1 value }

def CR4.KL : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 19 1

def CR4.setKL (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 19 1 value }

def CR4.SMEP : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 20 1

def CR4.setSMEP (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 20 1 value }

def CR4.SMAP : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 21 1

def CR4.setSMAP (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 21 1 value }

def CR4.PKE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 22 1

def CR4.setPKE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 22 1 value }

def CR4.CET : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 23 1

def CR4.setCET (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 23 1 value }

def CR4.PKS : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 24 1

def CR4.setPKS (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 24 1 value }

def CR4.UINTR : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 25 1

def CR4.setUINTR (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 25 1 value }

def CR4.LASS : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 27 1

def CR4.setLASS (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 27 1 value }

def CR4.LAM_SUP : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 28 1

def CR4.setLAM_SUP (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 28 1 value }

def CR4.FRED : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).CR4 32 1

def CR4.setFRED (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := setSlice s.CR4 32 1 value }

def CR4.RESERVED : Runtime.SpecM Exception (State σ) (Bits 36) := do
  return CR4_Type.RESERVED (← get).CR4

def CR4.setRESERVED (value : Bits 36) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with CR4 := CR4_Type.setRESERVED s.CR4 value }

def IA32_EFER.setLMA (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_EFER := { s.IA32_EFER with LMA := value } }

def XCR0.SSE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).XCR0 1 1

def XCR0.setSSE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with XCR0 := setSlice s.XCR0 1 1 value }

def XCR0.AVX : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).XCR0 2 1

def XCR0.setAVX (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with XCR0 := setSlice s.XCR0 2 1 value }

def XCR0.ZMM_Hi256 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).XCR0 6 1

def XCR0.setZMM_Hi256 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with XCR0 := setSlice s.XCR0 6 1 value }

def XCR0.Hi16_ZMM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).XCR0 7 1

def XCR0.setHi16_ZMM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with XCR0 := setSlice s.XCR0 7 1 value }

def XCR0.APX_F : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).XCR0 19 1

def XCR0.setAPX_F (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with XCR0 := setSlice s.XCR0 19 1 value }

def RIP.setSlice (offset width : Int) (value : Bits width) :
    Runtime.SpecM Exception (State σ) Unit := do
  let updated ← setSliceChecked (← getThe (State σ)).RIP offset width value
  modify ({ · with RIP := updated })

def GPR.get (index : Int) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.Array.get (← getThe (State σ)).GPR index

def GPR.set (index : Int) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).GPR index value
  modify ({ · with GPR := values })

def ZMM.get (index : Int) : Runtime.SpecM Exception (State σ) (Bits 512) := do
  Runtime.Array.get (← getThe (State σ)).ZMM index

def ZMM.set (index : Int) (value : Bits 512) : Runtime.SpecM Exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).ZMM index value
  modify ({ · with ZMM := values })

def K.get (index : Int) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.Array.get (← getThe (State σ)).K index

def K.set (index : Int) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).K index value
  modify ({ · with K := values })

def DR6.B : Runtime.SpecM Exception (State σ) (Bits 4) := do
  return ← slice (← get).DR6 0 4

def DR6.setB (value : Bits 4) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR6 := setSlice s.DR6 0 4 value }

def DR6.BLD : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR6 11 1

def DR6.setBLD (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR6 := setSlice s.DR6 11 1 value }

def DR6.BD : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR6 13 1

def DR6.setBD (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR6 := setSlice s.DR6 13 1 value }

def DR6.BS : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR6 14 1

def DR6.setBS (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR6 := setSlice s.DR6 14 1 value }

def DR6.BT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR6 15 1

def DR6.setBT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR6 := setSlice s.DR6 15 1 value }

def IA32_PL0_SSP.Busy : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_PL0_SSP 0 1

def IA32_PL0_SSP.setBusy (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL0_SSP := setSlice s.IA32_PL0_SSP 0 1 value }

def IA32_PL0_SSP.Reserved : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).IA32_PL0_SSP 1 2

def IA32_PL0_SSP.setReserved (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL0_SSP := setSlice s.IA32_PL0_SSP 1 2 value }

def IA32_PL0_SSP.LinearAddress : Runtime.SpecM Exception (State σ) (Bits 61) := do
  return ← slice (← get).IA32_PL0_SSP 3 61

def IA32_PL0_SSP.setLinearAddress (value : Bits 61) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL0_SSP := setSlice s.IA32_PL0_SSP 3 61 value }

def IA32_PL1_SSP.Busy : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_PL1_SSP 0 1

def IA32_PL1_SSP.setBusy (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL1_SSP := setSlice s.IA32_PL1_SSP 0 1 value }

def IA32_PL1_SSP.Reserved : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).IA32_PL1_SSP 1 2

def IA32_PL1_SSP.setReserved (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL1_SSP := setSlice s.IA32_PL1_SSP 1 2 value }

def IA32_PL1_SSP.LinearAddress : Runtime.SpecM Exception (State σ) (Bits 61) := do
  return ← slice (← get).IA32_PL1_SSP 3 61

def IA32_PL1_SSP.setLinearAddress (value : Bits 61) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL1_SSP := setSlice s.IA32_PL1_SSP 3 61 value }

def IA32_PL2_SSP.Busy : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_PL2_SSP 0 1

def IA32_PL2_SSP.setBusy (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL2_SSP := setSlice s.IA32_PL2_SSP 0 1 value }

def IA32_PL2_SSP.Reserved : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).IA32_PL2_SSP 1 2

def IA32_PL2_SSP.setReserved (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL2_SSP := setSlice s.IA32_PL2_SSP 1 2 value }

def IA32_PL2_SSP.LinearAddress : Runtime.SpecM Exception (State σ) (Bits 61) := do
  return ← slice (← get).IA32_PL2_SSP 3 61

def IA32_PL2_SSP.setLinearAddress (value : Bits 61) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL2_SSP := setSlice s.IA32_PL2_SSP 3 61 value }

def IA32_PL3_SSP.Busy : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_PL3_SSP 0 1

def IA32_PL3_SSP.setBusy (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL3_SSP := setSlice s.IA32_PL3_SSP 0 1 value }

def IA32_PL3_SSP.Reserved : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).IA32_PL3_SSP 1 2

def IA32_PL3_SSP.setReserved (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL3_SSP := setSlice s.IA32_PL3_SSP 1 2 value }

def IA32_PL3_SSP.LinearAddress : Runtime.SpecM Exception (State σ) (Bits 61) := do
  return ← slice (← get).IA32_PL3_SSP 3 61

def IA32_PL3_SSP.setLinearAddress (value : Bits 61) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_PL3_SSP := setSlice s.IA32_PL3_SSP 3 61 value }

def XINIT_BV.setSlice (offset width : Int) (value : Bits width) :
    Runtime.SpecM Exception (State σ) Unit := do
  let updated ← setSliceChecked (← getThe (State σ)).XINIT_BV offset width value
  modify ({ · with XINIT_BV := updated })

def MXCSR.Exception_Flags : Runtime.SpecM Exception (State σ) (Bits 6) := do
  return ← slice (← get).MXCSR 0 6

def MXCSR.setException_Flags (value : Bits 6) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 0 6 value }

def MXCSR.DAZ : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).MXCSR 6 1

def MXCSR.setDAZ (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 6 1 value }

def MXCSR.Exception_Masks : Runtime.SpecM Exception (State σ) (Bits 6) := do
  return ← slice (← get).MXCSR 7 6

def MXCSR.setException_Masks (value : Bits 6) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 7 6 value }

def MXCSR.OM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).MXCSR 10 1

def MXCSR.setOM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 10 1 value }

def MXCSR.UM : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).MXCSR 11 1

def MXCSR.setUM (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 11 1 value }

def MXCSR.RC : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).MXCSR 13 2

def MXCSR.setRC (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 13 2 value }

def MXCSR.FTZ : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).MXCSR 15 1

def MXCSR.setFTZ (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 15 1 value }

def MXCSR.RESERVED : Runtime.SpecM Exception (State σ) (Bits 16) := do
  return ← slice (← get).MXCSR 16 16

def MXCSR.setRESERVED (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with MXCSR := setSlice s.MXCSR 16 16 value }

def IA32_DEBUGCTL.LBR : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_DEBUGCTL 0 1

def IA32_DEBUGCTL.setLBR (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_DEBUGCTL := setSlice s.IA32_DEBUGCTL 0 1 value }

def IA32_DEBUGCTL.BTF : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_DEBUGCTL 1 1

def IA32_DEBUGCTL.setBTF (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_DEBUGCTL := setSlice s.IA32_DEBUGCTL 1 1 value }

def IA32_DEBUGCTL.BUS_LOCK_DETECT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).IA32_DEBUGCTL 2 1

def IA32_DEBUGCTL.setBUS_LOCK_DETECT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_DEBUGCTL := setSlice s.IA32_DEBUGCTL 2 1 value }

def DR7.L0 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 0 1

def DR7.setL0 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 0 1 value }

def DR7.G0 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 1 1

def DR7.setG0 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 1 1 value }

def DR7.L1 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 2 1

def DR7.setL1 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 2 1 value }

def DR7.G1 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 3 1

def DR7.setG1 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 3 1 value }

def DR7.L2 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 4 1

def DR7.setL2 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 4 1 value }

def DR7.G2 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 5 1

def DR7.setG2 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 5 1 value }

def DR7.L3 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 6 1

def DR7.setL3 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 6 1 value }

def DR7.G3 : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 7 1

def DR7.setG3 (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 7 1 value }

def DR7.LE : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 8 1

def DR7.setLE (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 8 1 value }

def DR7.GD : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).DR7 13 1

def DR7.setGD (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 13 1 value }

def DR7.RW0 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 16 2

def DR7.setRW0 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 16 2 value }

def DR7.LEN0 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 18 2

def DR7.setLEN0 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 18 2 value }

def DR7.RW1 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 20 2

def DR7.setRW1 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 20 2 value }

def DR7.LEN1 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 22 2

def DR7.setLEN1 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 22 2 value }

def DR7.RW2 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 24 2

def DR7.setRW2 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 24 2 value }

def DR7.LEN2 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 26 2

def DR7.setLEN2 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 26 2 value }

def DR7.RW3 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 28 2

def DR7.setRW3 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 28 2 value }

def DR7.LEN3 : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).DR7 30 2

def DR7.setLEN3 (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with DR7 := setSlice s.DR7 30 2 value }

def «VMCS::EPTP».Memory_Type : Runtime.SpecM Exception (State σ) (Bits 3) := do
  return ← slice (← get).«VMCS::EPTP» 0 3

def «VMCS::EPTP».setMemory_Type (value : Bits 3) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «VMCS::EPTP» := setSlice s.«VMCS::EPTP» 0 3 value }

def «VMCS::EPTP».EPT_Page_Walk_Length : Runtime.SpecM Exception (State σ) (Bits 3) := do
  return ← slice (← get).«VMCS::EPTP» 3 3

def «VMCS::EPTP».setEPT_Page_Walk_Length (value : Bits 3) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «VMCS::EPTP» := setSlice s.«VMCS::EPTP» 3 3 value }

def «VMCS::EPTP».Enable_EPT_Accessed_And_Dirty_Flags : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).«VMCS::EPTP» 6 1

def «VMCS::EPTP».setEnable_EPT_Accessed_And_Dirty_Flags (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «VMCS::EPTP» := setSlice s.«VMCS::EPTP» 6 1 value }

def «VMCS::EPTP».EPT_PML4_Or_PML5_Table_Physical_Address : Runtime.SpecM Exception (State σ) (Bits 40) := do
  return ← slice (← get).«VMCS::EPTP» 12 40

def «VMCS::EPTP».setEPT_PML4_Or_PML5_Table_Physical_Address (value : Bits 40) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «VMCS::EPTP» := setSlice s.«VMCS::EPTP» 12 40 value }

def «VMCS::HLATP».PWT : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).«VMCS::HLATP» 3 1

def «VMCS::HLATP».setPWT (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «VMCS::HLATP» := setSlice s.«VMCS::HLATP» 3 1 value }

def «VMCS::HLATP».PCD : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).«VMCS::HLATP» 4 1

def «VMCS::HLATP».setPCD (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with «VMCS::HLATP» := setSlice s.«VMCS::HLATP» 4 1 value }

def SSP.Busy : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  return ← slice (← get).SSP 0 1

def SSP.setBusy (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SSP := setSlice s.SSP 0 1 value }

def SSP.Reserved : Runtime.SpecM Exception (State σ) (Bits 2) := do
  return ← slice (← get).SSP 1 2

def SSP.setReserved (value : Bits 2) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SSP := setSlice s.SSP 1 2 value }

def SSP.LinearAddress : Runtime.SpecM Exception (State σ) (Bits 61) := do
  return ← slice (← get).SSP 3 61

def SSP.setLinearAddress (value : Bits 61) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with SSP := setSlice s.SSP 3 61 value }

def IA32_S_CET.setSUPPRESS (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_S_CET := { s.IA32_S_CET with SUPPRESS := value } }

def IA32_S_CET.setTRACKER (value : Runtime.Bit) : Runtime.SpecM Exception (State σ) Unit :=
  modify fun s => { s with IA32_S_CET := { s.IA32_S_CET with TRACKER := value } }

def MTRR_Fixed.get {exception : Type} (index : Int) : Runtime.SpecM exception (State σ) (Bits 64) := do
  Runtime.Array.get (← getThe (State σ)).MTRR_Fixed index

def MTRR_Fixed.set {exception : Type} (index : Int) (value : Bits 64) : Runtime.SpecM exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).MTRR_Fixed index value
  modify ({ · with MTRR_Fixed := values })

def MTRR_Base.get {exception : Type} (index : Int) : Runtime.SpecM exception (State σ) (Bits 64) := do
  Runtime.Array.get (← getThe (State σ)).MTRR_Base index

def MTRR_Base.set {exception : Type} (index : Int) (value : Bits 64) : Runtime.SpecM exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).MTRR_Base index value
  modify ({ · with MTRR_Base := values })

def MTRR_Mask.get {exception : Type} (index : Int) : Runtime.SpecM exception (State σ) (Bits 64) := do
  Runtime.Array.get (← getThe (State σ)).MTRR_Mask index

def MTRR_Mask.set {exception : Type} (index : Int) (value : Bits 64) : Runtime.SpecM exception (State σ) Unit := do
  let values ← Runtime.Array.set (← getThe (State σ)).MTRR_Mask index value
  modify ({ · with MTRR_Mask := values })

def CPL.assign (value : Int) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with CPL := value })

def CS.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with CS := value })

def Current_VMCS_Pointer.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with Current_VMCS_Pointer := value })

def DS.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with DS := value })

def Default_Error_Code.assign (value : Selector_Error_Code) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with Default_Error_Code := value })

def Double_Fault_Contributory_Exception.assign (value : Int) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with Double_Fault_Contributory_Exception := value })

def ES.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with ES := value })

def FP87_Control.assign (value : FP87_Control_Type) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_Control := value })

def FP87_FCS.assign (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_FCS := value })

def FP87_FDP.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_FDP := value })

def FP87_FDS.assign (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_FDS := value })

def FP87_FIP.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_FIP := value })

def FP87_FOP.assign (value : Bits 11) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_FOP := value })

def FP87_Status.assign (value : FP87_Status_Type) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_Status := value })

def FP87_Tag_Word.assign (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FP87_Tag_Word := value })

def FS.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with FS := value })

def GS.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with GS := value })

def LDTR.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with LDTR := value })

def Next_IP.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with Next_IP := value })

def Repeat_String_Operation.assign (value : Bool) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with Repeat_String_Operation := value })

def Repeat_String_RF_Pending_RIP.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with Repeat_String_RF_Pending_RIP := value })

def SS.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with SS := value })

def TR.assign (value : Segment) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with TR := value })

def VMX_On_Pointer.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with VMX_On_Pointer := value })

def RFLAGS.assign (value : RFLAGS_Type) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with RFLAGS := value })

def CR3.assign (value : CR3_Type) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with CR3 := value })

def APIC_TPR.assign (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with APIC_TPR := value })

def RIP.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with RIP := value })

def CR2.assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with CR2 := value })

def IA32_PL3_SSP.assign (value : SSP_Type) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with IA32_PL3_SSP := value })

def «Monitor::Address».assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «Monitor::Address» := value })

def «TSX::HLE_Restart_RIP».assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «TSX::HLE_Restart_RIP» := value })

def «TSX::RTM_Fallback_RIP».assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «TSX::RTM_Fallback_RIP» := value })

def «VMCS::EPTP».assign (value : EPTP_Inputs) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «VMCS::EPTP» := value })

def SSP.assign (value : SSP_Type) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with SSP := value })

def «VMCS::Primary_VM_Exec_Controls».assign (value : Bits 32) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «VMCS::Primary_VM_Exec_Controls» := value })

def «VMCS::Secondary_VM_Exec_Controls».assign (value : Bits 32) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «VMCS::Secondary_VM_Exec_Controls» := value })

def «VMCS::Tertiary_VM_Exec_Controls».assign (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit :=
  modify ({ · with «VMCS::Tertiary_VM_Exec_Controls» := value })

def UNSPECIFIED {exception : Type} {size : Int} : Runtime.SpecM exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)
  let s ← get
  let (value, oracle) := s.oracle.take size.toNat
  set { s with oracle }
  return value

-- The caller supplies a binding for this source declaration, which has no body.
class IA32_MTRRCAP.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] IA32_MTRRCAP.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Exception_Bitmap.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 32)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Exception_Bitmap.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Page_Fault_Error_Code_Mask.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 32)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Page_Fault_Error_Code_Mask.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Page_Fault_Error_Code_Match.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 32)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Page_Fault_Error_Code_Match.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Reset_Registers.Binding (σ : Type) where
  call (is_cold_reset : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Reset_Registers.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Reset_MSRs.Binding (σ : Type) where
  call (is_cold_reset : Bool) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Reset_MSRs.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class __Trace_Next_Cycle.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] __Trace_Next_Cycle.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class VM_Exec_Controls1.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (VM_Exec_Controls1_Inputs)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] VM_Exec_Controls1.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR0_Guest_Host_Mask.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (CR0_Type)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR0_Guest_Host_Mask.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR0_Read_Shadow.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (CR0_Type)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR0_Read_Shadow.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR4_Guest_Host_Mask.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (CR4_Type)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR4_Guest_Host_Mask.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR4_Read_Shadow.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (CR4_Type)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR4_Read_Shadow.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR3_Target_Count.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 32)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR3_Target_Count.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR3_Target_Value0.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR3_Target_Value0.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR3_Target_Value1.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR3_Target_Value1.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR3_Target_Value2.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR3_Target_Value2.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class CR3_Target_Value3.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] CR3_Target_Value3.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class __Fuzz_Next_Mem_Write.Binding (σ : Type) where
  call (field : String) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] __Fuzz_Next_Mem_Write.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Read_MXCSR_DAZ16.Binding (σ : Type) where
  call (value : MXCSR_Type) :
    Runtime.SpecM Empty (State σ) (Runtime.Bit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Read_MXCSR_DAZ16.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Read_MXCSR_FTZ16.Binding (σ : Type) where
  call (value : MXCSR_Type) :
    Runtime.SpecM Empty (State σ) (Runtime.Bit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Read_MXCSR_FTZ16.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Address_Of_IO_Bitmap_A.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Address_Of_IO_Bitmap_A.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Address_Of_IO_Bitmap_B.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Address_Of_IO_Bitmap_B.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Invalidate_Translation_Caches.Binding (σ : Type) where
  call (pcid : Bits 12) (linear_address : Bits 64) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Invalidate_Translation_Caches.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class __Physical_Mem_Fetch.Binding (σ : Type) where
  call (address : Bits 64) (memory_type : Memory_Type) :
    Runtime.SpecM Empty (State σ) (Bits 8)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] __Physical_Mem_Fetch.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class __Trace_Physical_Mem.Binding (σ : Type) where
  call {size : Int} (is_read : Bool) (operation : String) (address : Bits 64) (memory_type : Memory_Type) (value : Bits size) :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] __Trace_Physical_Mem.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class VM_Exec_Controls2.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (VM_Exec_Controls2_Inputs)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] VM_Exec_Controls2.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class VM_Exec_Controls3.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (VM_Exec_Controls3_Inputs)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] VM_Exec_Controls3.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class EPTP_Index.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 16)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] EPTP_Index.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class HLAT_PLR_Prefix_Size.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 6)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] HLAT_PLR_Prefix_Size.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Virtualization_Exception_Information_Address.Binding (σ : Type) where
  call (index : Bits 64) :
    Runtime.SpecM Empty (State σ) (Bits 64)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Virtualization_Exception_Information_Address.Binding

-- The caller supplies a binding for this source declaration, which has no body.
class Invalidate_All_Translation_Caches.Binding (σ : Type) where
  call  :
    Runtime.SpecM Empty (State σ) (Unit)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Invalidate_All_Translation_Caches.Binding

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.CR0_Guest_Host_Mask.Binding σ]
  [X86.CR0_Read_Shadow.Binding σ]
  [X86.CR3_Target_Count.Binding σ]
  [X86.CR3_Target_Value0.Binding σ]
  [X86.CR3_Target_Value1.Binding σ]
  [X86.CR3_Target_Value2.Binding σ]
  [X86.CR3_Target_Value3.Binding σ]
  [X86.CR4_Guest_Host_Mask.Binding σ]
  [X86.CR4_Read_Shadow.Binding σ]
  [X86.EPTP_Index.Binding σ]
  [X86.Exception_Bitmap.Binding σ]
  [X86.HLAT_PLR_Prefix_Size.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.Invalidate_All_Translation_Caches.Binding σ]
  [X86.Invalidate_Translation_Caches.Binding σ]
  [X86.Page_Fault_Error_Code_Mask.Binding σ]
  [X86.Page_Fault_Error_Code_Match.Binding σ]
  [X86.Read_MXCSR_DAZ16.Binding σ]
  [X86.Read_MXCSR_FTZ16.Binding σ]
  [X86.Reset_MSRs.Binding σ]
  [X86.Reset_Registers.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]
  [X86.__Fuzz_Next_Mem_Write.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Next_Cycle.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]

-- Read_CR calls this getter; XML omits its declaration and TPR access behavior.
def CR8  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← Std.Bits.Zero_Extend (source_size := 4) (← sliceInclusive (← get).APIC_TPR 7 4) 64)

def IA32_MTRRCAP  : Runtime.SpecM Empty (State σ) (Bits 64) := do
  IA32_MTRRCAP.Binding.call

-- The XML uses these getters and hooks but omits their declarations and bodies.
def Exception_Bitmap (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 32) := do
  Runtime.liftNoSourceException (Exception_Bitmap.Binding.call index)

def Page_Fault_Error_Code_Mask
    (index : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 32) := do
  Runtime.liftNoSourceException (Page_Fault_Error_Code_Mask.Binding.call index)

def Page_Fault_Error_Code_Match
    (index : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 32) := do
  Runtime.liftNoSourceException (Page_Fault_Error_Code_Match.Binding.call index)

def Reset_Registers (is_cold_reset : Bool) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Reset_Registers.Binding.call is_cold_reset)

def Reset_MSRs (is_cold_reset : Bool) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Reset_MSRs.Binding.call is_cold_reset)

def __Trace_Next_Cycle  : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (__Trace_Next_Cycle.Binding.call)

def VM_Exec_Controls1  : Runtime.SpecM Exception (State σ) (VM_Exec_Controls1_Inputs) := do
  Runtime.liftNoSourceException (VM_Exec_Controls1.Binding.call)

def CR0_Guest_Host_Mask (index : Bits 64) : Runtime.SpecM Exception (State σ) (CR0_Type) := do
  Runtime.liftNoSourceException (CR0_Guest_Host_Mask.Binding.call index)

def CR0_Read_Shadow (index : Bits 64) : Runtime.SpecM Exception (State σ) (CR0_Type) := do
  Runtime.liftNoSourceException (CR0_Read_Shadow.Binding.call index)

def CR4_Guest_Host_Mask (index : Bits 64) : Runtime.SpecM Exception (State σ) (CR4_Type) := do
  Runtime.liftNoSourceException (CR4_Guest_Host_Mask.Binding.call index)

def CR4_Read_Shadow (index : Bits 64) : Runtime.SpecM Exception (State σ) (CR4_Type) := do
  Runtime.liftNoSourceException (CR4_Read_Shadow.Binding.call index)

def CR3_Target_Count (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 32) := do
  Runtime.liftNoSourceException (CR3_Target_Count.Binding.call index)

def CR3_Target_Value0 (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (CR3_Target_Value0.Binding.call index)

def CR3_Target_Value1 (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (CR3_Target_Value1.Binding.call index)

def CR3_Target_Value2 (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (CR3_Target_Value2.Binding.call index)

def CR3_Target_Value3 (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (CR3_Target_Value3.Binding.call index)

-- The source uses this erratum hook only in real-address or virtual-8086 mode.
-- Its effect must come from a binding; it is not a no-op in the translation.
def __Fuzz_Next_Mem_Write (field : String) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (__Fuzz_Next_Mem_Write.Binding.call field)

def Read_MXCSR_DAZ16 (value : MXCSR_Type) : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  Runtime.liftNoSourceException (Read_MXCSR_DAZ16.Binding.call value)

def Read_MXCSR_FTZ16 (value : MXCSR_Type) : Runtime.SpecM Exception (State σ) (Runtime.Bit) := do
  Runtime.liftNoSourceException (Read_MXCSR_FTZ16.Binding.call value)

-- VMCS I/O bitmap addresses are supplied by the selected virtual machine.
def Address_Of_IO_Bitmap_A (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (Address_Of_IO_Bitmap_A.Binding.call index)

def Address_Of_IO_Bitmap_B (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (Address_Of_IO_Bitmap_B.Binding.call index)

-- INVLPG: invalidate the current PCID's mappings for this page and all global
-- mappings for this page. Also invalidate all paging-structure-cache entries
-- for this PCID, regardless of address (SDM Vol. 3, section 5.10.4.1).
def Invalidate_Translation_Caches
    (pcid : Bits 12) (linear_address : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.liftNoSourceException (Invalidate_Translation_Caches.Binding.call pcid linear_address)

-- Mem_Fetch calls these external hooks; their declarations are absent from XML.
def __Physical_Mem_Fetch
    (address : Bits 64) (memory_type : Memory_Type) :
    Runtime.SpecM Exception (State σ) (Bits 8) := do
  Runtime.liftNoSourceException (__Physical_Mem_Fetch.Binding.call address memory_type)

def __Trace_Physical_Mem {size : Int}
    (is_read : Bool) (operation : String) (address : Bits 64) (memory_type : Memory_Type) (value : Bits size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  Runtime.liftNoSourceException (__Trace_Physical_Mem.Binding.call (size := size) is_read operation address memory_type value)

def VM_Exec_Controls2  : Runtime.SpecM Exception (State σ) (VM_Exec_Controls2_Inputs) := do
  Runtime.liftNoSourceException (VM_Exec_Controls2.Binding.call)

def VM_Exec_Controls3  : Runtime.SpecM Exception (State σ) (VM_Exec_Controls3_Inputs) := do
  Runtime.liftNoSourceException (VM_Exec_Controls3.Binding.call)

def EPTP_Index (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 16) := do
  Runtime.liftNoSourceException (EPTP_Index.Binding.call index)

def HLAT_PLR_Prefix_Size (index : Bits 64) : Runtime.SpecM Exception (State σ) (Bits 6) := do
  Runtime.liftNoSourceException (HLAT_PLR_Prefix_Size.Binding.call index)

def Virtualization_Exception_Information_Address
    (index : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.liftNoSourceException (Virtualization_Exception_Information_Address.Binding.call index)

-- WRMSR to an MTRR invalidates all translations, including global entries.
def Invalidate_All_Translation_Caches  : Runtime.SpecM Empty (State σ) Unit := do
  Invalidate_All_Translation_Caches.Binding.call

end X86

-- Generated from X86.State by the register generator; do not edit.
import X86.State
import Init.Data.Order.Ord

namespace X86

inductive SegmentRegister where
  | es
  | cs
  | ss
  | ds
  | fs
  | gs
  | ldtr
  | tr
  deriving DecidableEq

private abbrev SegmentRegister.ordering : SegmentRegister → SegmentRegister → Ordering :=
  (compareOn SegmentRegister.ctorIdx)

instance : Ord SegmentRegister := ⟨SegmentRegister.ordering⟩

instance : Std.TransOrd SegmentRegister := inferInstanceAs (Std.TransCmp SegmentRegister.ordering)

instance : Std.LawfulEqOrd SegmentRegister where
  compare_self := by intro a; exact Std.ReflCmp.compare_self (cmp := SegmentRegister.ordering)
  eq_of_compare := by
    intro a b h
    change SegmentRegister.ordering a b = .eq at h
    simp only [SegmentRegister.ordering, compareOn, Std.compare_eq_iff_eq] at h
    cases a <;> cases b <;> simp_all [SegmentRegister.ctorIdx]

inductive ControlRegister where
  | cr0
  | cr2
  | cr3
  | cr4
  | cr8
  deriving DecidableEq

private abbrev ControlRegister.ordering : ControlRegister → ControlRegister → Ordering :=
  (compareOn ControlRegister.ctorIdx)

instance : Ord ControlRegister := ⟨ControlRegister.ordering⟩

instance : Std.TransOrd ControlRegister := inferInstanceAs (Std.TransCmp ControlRegister.ordering)

instance : Std.LawfulEqOrd ControlRegister where
  compare_self := by intro a; exact Std.ReflCmp.compare_self (cmp := ControlRegister.ordering)
  eq_of_compare := by
    intro a b h
    change ControlRegister.ordering a b = .eq at h
    simp only [ControlRegister.ordering, compareOn, Std.compare_eq_iff_eq] at h
    cases a <;> cases b <;> simp_all [ControlRegister.ctorIdx]

inductive DebugRegister where
  | dr0
  | dr1
  | dr2
  | dr3
  | dr6
  | dr7
  deriving DecidableEq

private abbrev DebugRegister.ordering : DebugRegister → DebugRegister → Ordering :=
  (compareOn DebugRegister.ctorIdx)

instance : Ord DebugRegister := ⟨DebugRegister.ordering⟩

instance : Std.TransOrd DebugRegister := inferInstanceAs (Std.TransCmp DebugRegister.ordering)

instance : Std.LawfulEqOrd DebugRegister where
  compare_self := by intro a; exact Std.ReflCmp.compare_self (cmp := DebugRegister.ordering)
  eq_of_compare := by
    intro a b h
    change DebugRegister.ordering a b = .eq at h
    simp only [DebugRegister.ordering, compareOn, Std.compare_eq_iff_eq] at h
    cases a <;> cases b <;> simp_all [DebugRegister.ctorIdx]

inductive Msr where
  | efer
  | star
  | lstar
  | fmask
  | kernelGsBase
  | pl0Ssp
  | pl1Ssp
  | pl2Ssp
  | pl3Ssp
  | interruptSspTable
  | uCet
  | sCet
  | pkrs
  | debugctl
  | pat
  | mtrrDefType
  | mtrrFixed (index : Fin 11)
  | mtrrBase (index : Fin 256)
  | mtrrMask (index : Fin 256)
  | smrrPhysBase
  | smrrPhysMask
  | prmrrPhysMask
  | biosDone
  | platformInfo
  | featureEnables
  | miscEnable
  | memoryControl
  | aetEventCtrl
  | vmxCr0Fixed0
  | vmxCr0Fixed1
  | vmxCr4Fixed0
  | vmxCr4Fixed1
  | vmxEptVpidCap
  deriving DecidableEq

private abbrev Msr.ordering : Msr → Msr → Ordering :=
  (compareLex (compareOn Msr.ctorIdx) (compareLex (compareOn (fun r : Msr => match r with | .mtrrFixed i => (some i : Option (Fin 11)) | _ => none)) (compareLex (compareOn (fun r : Msr => match r with | .mtrrBase i => (some i : Option (Fin 256)) | _ => none)) (compareOn (fun r : Msr => match r with | .mtrrMask i => (some i : Option (Fin 256)) | _ => none)))))

instance : Ord Msr := ⟨Msr.ordering⟩

instance : Std.TransOrd Msr := inferInstanceAs (Std.TransCmp Msr.ordering)

instance : Std.LawfulEqOrd Msr where
  compare_self := by intro a; exact Std.ReflCmp.compare_self (cmp := Msr.ordering)
  eq_of_compare := by
    intro a b h
    change Msr.ordering a b = .eq at h
    simp only [Msr.ordering, compareLex_eq_eq, compareOn, Std.compare_eq_iff_eq] at h
    cases a <;> cases b <;> simp_all [Msr.ctorIdx]

inductive Register where
  | gpr (register : Fin 32)
  | rip
  | rflags
  | zmm (register : Fin 32)
  | mask (register : Fin 8)
  | st (register : Fin 8)
  | fpuControl
  | fpuStatus
  | fpuTag
  | fip
  | fdp
  | fop
  | fcs
  | fds
  | mxcsr
  | pkru
  | ssp
  | xcr0
  | segment (register : SegmentRegister)
  | gdtr
  | idtr
  | control (register : ControlRegister)
  | debug (register : DebugRegister)
  | msr (register : Msr)
  deriving DecidableEq

private abbrev Register.ordering : Register → Register → Ordering :=
  (compareLex (compareOn Register.ctorIdx) (compareLex (compareOn (fun r : Register => match r with | .gpr i => (some i : Option (Fin 32)) | _ => none)) (compareLex (compareOn (fun r : Register => match r with | .zmm i => (some i : Option (Fin 32)) | _ => none)) (compareLex (compareOn (fun r : Register => match r with | .mask i => (some i : Option (Fin 8)) | _ => none)) (compareLex (compareOn (fun r : Register => match r with | .st i => (some i : Option (Fin 8)) | _ => none)) (compareLex (compareOn (fun r : Register => match r with | .segment i => (some i : Option (SegmentRegister)) | _ => none)) (compareLex (compareOn (fun r : Register => match r with | .control i => (some i : Option (ControlRegister)) | _ => none)) (compareLex (compareOn (fun r : Register => match r with | .debug i => (some i : Option (DebugRegister)) | _ => none)) (compareOn (fun r : Register => match r with | .msr i => (some i : Option (Msr)) | _ => none))))))))))

instance : Ord Register := ⟨Register.ordering⟩

instance : Std.TransOrd Register := inferInstanceAs (Std.TransCmp Register.ordering)

instance : Std.LawfulEqOrd Register where
  compare_self := by intro a; exact Std.ReflCmp.compare_self (cmp := Register.ordering)
  eq_of_compare := by
    intro a b h
    change Register.ordering a b = .eq at h
    simp only [Register.ordering, compareLex_eq_eq, compareOn, Std.compare_eq_iff_eq] at h
    cases a <;> cases b <;> simp_all [Register.ctorIdx]

abbrev Msr.Value : Msr → Type
  | .efer => X86.EFER_Inputs
  | .star => BitVec 64
  | .lstar => BitVec 64
  | .fmask => BitVec 64
  | .kernelGsBase => BitVec 64
  | .pl0Ssp => BitVec 64
  | .pl1Ssp => BitVec 64
  | .pl2Ssp => BitVec 64
  | .pl3Ssp => BitVec 64
  | .interruptSspTable => BitVec 64
  | .uCet => X86.IA32_U_CET_Type
  | .sCet => X86.IA32_U_CET_Type
  | .pkrs => BitVec 64
  | .debugctl => BitVec 64
  | .pat => BitVec 64
  | .mtrrDefType => BitVec 64
  | .mtrrFixed _ => BitVec 64
  | .mtrrBase _ => BitVec 64
  | .mtrrMask _ => BitVec 64
  | .smrrPhysBase => BitVec 64
  | .smrrPhysMask => BitVec 64
  | .prmrrPhysMask => X86.PRMRR_Phys_Mask_Inputs
  | .biosDone => X86.BIOS_Done_Inputs
  | .platformInfo => X86.PLATFORM_INFO_Inputs
  | .featureEnables => X86.FEATURE_ENABLES_Inputs
  | .miscEnable => X86.IA32_MISC_ENABLE_Inputs
  | .memoryControl => X86.MEMORY_CONTROL_Inputs
  | .aetEventCtrl => X86.AET_EVENT_CTRL_Inputs
  | .vmxCr0Fixed0 => BitVec 64
  | .vmxCr0Fixed1 => BitVec 64
  | .vmxCr4Fixed0 => BitVec 64
  | .vmxCr4Fixed1 => BitVec 64
  | .vmxEptVpidCap => X86.IA32_VMX_EPT_VPID_CAP_Inputs

def Msr.read {σ : Type} (s : X86.State σ) : (m : Msr) → m.Value
  | .efer => s.IA32_EFER
  | .star => s.IA32_STAR
  | .lstar => s.IA32_LSTAR
  | .fmask => s.IA32_FMASK
  | .kernelGsBase => s.IA32_KERNEL_GS_BASE
  | .pl0Ssp => s.IA32_PL0_SSP
  | .pl1Ssp => s.IA32_PL1_SSP
  | .pl2Ssp => s.IA32_PL2_SSP
  | .pl3Ssp => s.IA32_PL3_SSP
  | .interruptSspTable => s.IA32_INTERRUPT_SSP_TABLE_ADDR
  | .uCet => s.IA32_U_CET
  | .sCet => s.IA32_S_CET
  | .pkrs => s.IA32_PKRS
  | .debugctl => s.IA32_DEBUGCTL
  | .pat => s.IA32_PAT
  | .mtrrDefType => s.IA32_MTRR_DEF_TYPE
  | .mtrrFixed i => s.MTRR_Fixed[i.val]
  | .mtrrBase i => s.MTRR_Base[i.val]
  | .mtrrMask i => s.MTRR_Mask[i.val]
  | .smrrPhysBase => s.IA32_SMRR_PHYSBASE
  | .smrrPhysMask => s.IA32_SMRR_PHYSMASK
  | .prmrrPhysMask => s.PRMRR_PHYS_MASK
  | .biosDone => s.BIOS_DONE
  | .platformInfo => s.PLATFORM_INFO
  | .featureEnables => s.FEATURE_ENABLES
  | .miscEnable => s.IA32_MISC_ENABLE
  | .memoryControl => s.MEMORY_CONTROL
  | .aetEventCtrl => s.AET_EVENT_CTRL
  | .vmxCr0Fixed0 => s.IA32_VMX_CR0_FIXED0
  | .vmxCr0Fixed1 => s.IA32_VMX_CR0_FIXED1
  | .vmxCr4Fixed0 => s.IA32_VMX_CR4_FIXED0
  | .vmxCr4Fixed1 => s.IA32_VMX_CR4_FIXED1
  | .vmxEptVpidCap => s.IA32_VMX_EPT_VPID_CAP

abbrev Register.Value : Register → Type
  | .gpr _ => BitVec 64
  | .rip => BitVec 64
  | .rflags => BitVec 64
  | .zmm _ => BitVec 512
  | .mask _ => BitVec 64
  | .st _ => BitVec 80
  | .fpuControl => BitVec 16
  | .fpuStatus => BitVec 16
  | .fpuTag => BitVec 16
  | .fip => BitVec 64
  | .fdp => BitVec 64
  | .fop => BitVec 11
  | .fcs => BitVec 16
  | .fds => BitVec 16
  | .mxcsr => BitVec 32
  | .pkru => BitVec 32
  | .ssp => BitVec 64
  | .xcr0 => BitVec 64
  | .segment .es => X86.Helpers.Segment
  | .segment .cs => X86.Helpers.Segment
  | .segment .ss => X86.Helpers.Segment
  | .segment .ds => X86.Helpers.Segment
  | .segment .fs => X86.Helpers.Segment
  | .segment .gs => X86.Helpers.Segment
  | .segment .ldtr => X86.Helpers.Segment
  | .segment .tr => X86.Helpers.Segment
  | .gdtr => X86.Helpers.Descriptor_Table_Register
  | .idtr => X86.Helpers.Descriptor_Table_Register
  | .control .cr0 => BitVec 64
  | .control .cr2 => BitVec 64
  | .control .cr3 => BitVec 64
  | .control .cr4 => BitVec 64
  | .control .cr8 => BitVec 8
  | .debug .dr0 => BitVec 64
  | .debug .dr1 => BitVec 64
  | .debug .dr2 => BitVec 64
  | .debug .dr3 => BitVec 64
  | .debug .dr6 => BitVec 64
  | .debug .dr7 => BitVec 64
  | .msr m => m.Value

def Register.read (r : Register) {σ : Type} (s : X86.State σ) : r.Value :=
  match r with
  | .gpr i => s.GPR[i.val]
  | .rip => s.RIP
  | .rflags => s.RFLAGS
  | .zmm i => s.ZMM[i.val]
  | .mask i => s.K[i.val]
  | .st i => s.FP87[i.val]
  | .fpuControl => s.FP87_Control
  | .fpuStatus => s.FP87_Status
  | .fpuTag => s.FP87_Tag_Word
  | .fip => s.FP87_FIP
  | .fdp => s.FP87_FDP
  | .fop => s.FP87_FOP
  | .fcs => s.FP87_FCS
  | .fds => s.FP87_FDS
  | .mxcsr => s.MXCSR
  | .pkru => s.PKRU
  | .ssp => s.SSP
  | .xcr0 => s.XCR0
  | .segment .es => s.ES
  | .segment .cs => s.CS
  | .segment .ss => s.SS
  | .segment .ds => s.DS
  | .segment .fs => s.FS
  | .segment .gs => s.GS
  | .segment .ldtr => s.LDTR
  | .segment .tr => s.TR
  | .gdtr => s.GDTR
  | .idtr => s.IDTR
  | .control .cr0 => s.CR0
  | .control .cr2 => s.CR2
  | .control .cr3 => s.CR3
  | .control .cr4 => s.CR4
  | .control .cr8 => s.APIC_TPR
  | .debug .dr0 => s.DR0
  | .debug .dr1 => s.DR1
  | .debug .dr2 => s.DR2
  | .debug .dr3 => s.DR3
  | .debug .dr6 => s.DR6
  | .debug .dr7 => s.DR7
  | .msr m => m.read s

@[noinline] private def Register.captureValues
    (GPR : X86.Runtime.Array 32 (BitVec 64))
    (RIP : BitVec 64)
    (RFLAGS : BitVec 64)
    (ZMM : X86.Runtime.Array 32 (BitVec 512))
    (K : X86.Runtime.Array 8 (BitVec 64))
    (FP87 : X86.Runtime.Array 8 (BitVec 80))
    (FP87_Control : BitVec 16)
    (FP87_Status : BitVec 16)
    (FP87_Tag_Word : BitVec 16)
    (FP87_FIP : BitVec 64)
    (FP87_FDP : BitVec 64)
    (FP87_FOP : BitVec 11)
    (FP87_FCS : BitVec 16)
    (FP87_FDS : BitVec 16)
    (MXCSR : BitVec 32)
    (PKRU : BitVec 32)
    (SSP : BitVec 64)
    (XCR0 : BitVec 64)
    (ES : X86.Helpers.Segment)
    (CS : X86.Helpers.Segment)
    (SS : X86.Helpers.Segment)
    (DS : X86.Helpers.Segment)
    (FS : X86.Helpers.Segment)
    (GS : X86.Helpers.Segment)
    (LDTR : X86.Helpers.Segment)
    (TR : X86.Helpers.Segment)
    (GDTR : X86.Helpers.Descriptor_Table_Register)
    (IDTR : X86.Helpers.Descriptor_Table_Register)
    (CR0 : BitVec 64)
    (CR2 : BitVec 64)
    (CR3 : BitVec 64)
    (CR4 : BitVec 64)
    (APIC_TPR : BitVec 8)
    (DR0 : BitVec 64)
    (DR1 : BitVec 64)
    (DR2 : BitVec 64)
    (DR3 : BitVec 64)
    (DR6 : BitVec 64)
    (DR7 : BitVec 64)
    (IA32_EFER : X86.EFER_Inputs)
    (IA32_STAR : BitVec 64)
    (IA32_LSTAR : BitVec 64)
    (IA32_FMASK : BitVec 64)
    (IA32_KERNEL_GS_BASE : BitVec 64)
    (IA32_PL0_SSP : BitVec 64)
    (IA32_PL1_SSP : BitVec 64)
    (IA32_PL2_SSP : BitVec 64)
    (IA32_PL3_SSP : BitVec 64)
    (IA32_INTERRUPT_SSP_TABLE_ADDR : BitVec 64)
    (IA32_U_CET : X86.IA32_U_CET_Type)
    (IA32_S_CET : X86.IA32_U_CET_Type)
    (IA32_PKRS : BitVec 64)
    (IA32_DEBUGCTL : BitVec 64)
    (IA32_PAT : BitVec 64)
    (IA32_MTRR_DEF_TYPE : BitVec 64)
    (MTRR_Fixed : X86.Runtime.Array 11 (BitVec 64))
    (MTRR_Base : X86.Runtime.Array 256 (BitVec 64))
    (MTRR_Mask : X86.Runtime.Array 256 (BitVec 64))
    (IA32_SMRR_PHYSBASE : BitVec 64)
    (IA32_SMRR_PHYSMASK : BitVec 64)
    (PRMRR_PHYS_MASK : X86.PRMRR_Phys_Mask_Inputs)
    (BIOS_DONE : X86.BIOS_Done_Inputs)
    (PLATFORM_INFO : X86.PLATFORM_INFO_Inputs)
    (FEATURE_ENABLES : X86.FEATURE_ENABLES_Inputs)
    (IA32_MISC_ENABLE : X86.IA32_MISC_ENABLE_Inputs)
    (MEMORY_CONTROL : X86.MEMORY_CONTROL_Inputs)
    (AET_EVENT_CTRL : X86.AET_EVENT_CTRL_Inputs)
    (IA32_VMX_CR0_FIXED0 : BitVec 64)
    (IA32_VMX_CR0_FIXED1 : BitVec 64)
    (IA32_VMX_CR4_FIXED0 : BitVec 64)
    (IA32_VMX_CR4_FIXED1 : BitVec 64)
    (IA32_VMX_EPT_VPID_CAP : X86.IA32_VMX_EPT_VPID_CAP_Inputs)
    : (r : Register) → r.Value
  | .gpr i => GPR[i.val]
  | .rip => RIP
  | .rflags => RFLAGS
  | .zmm i => ZMM[i.val]
  | .mask i => K[i.val]
  | .st i => FP87[i.val]
  | .fpuControl => FP87_Control
  | .fpuStatus => FP87_Status
  | .fpuTag => FP87_Tag_Word
  | .fip => FP87_FIP
  | .fdp => FP87_FDP
  | .fop => FP87_FOP
  | .fcs => FP87_FCS
  | .fds => FP87_FDS
  | .mxcsr => MXCSR
  | .pkru => PKRU
  | .ssp => SSP
  | .xcr0 => XCR0
  | .segment .es => ES
  | .segment .cs => CS
  | .segment .ss => SS
  | .segment .ds => DS
  | .segment .fs => FS
  | .segment .gs => GS
  | .segment .ldtr => LDTR
  | .segment .tr => TR
  | .gdtr => GDTR
  | .idtr => IDTR
  | .control .cr0 => CR0
  | .control .cr2 => CR2
  | .control .cr3 => CR3
  | .control .cr4 => CR4
  | .control .cr8 => APIC_TPR
  | .debug .dr0 => DR0
  | .debug .dr1 => DR1
  | .debug .dr2 => DR2
  | .debug .dr3 => DR3
  | .debug .dr6 => DR6
  | .debug .dr7 => DR7
  | .msr .efer => IA32_EFER
  | .msr .star => IA32_STAR
  | .msr .lstar => IA32_LSTAR
  | .msr .fmask => IA32_FMASK
  | .msr .kernelGsBase => IA32_KERNEL_GS_BASE
  | .msr .pl0Ssp => IA32_PL0_SSP
  | .msr .pl1Ssp => IA32_PL1_SSP
  | .msr .pl2Ssp => IA32_PL2_SSP
  | .msr .pl3Ssp => IA32_PL3_SSP
  | .msr .interruptSspTable => IA32_INTERRUPT_SSP_TABLE_ADDR
  | .msr .uCet => IA32_U_CET
  | .msr .sCet => IA32_S_CET
  | .msr .pkrs => IA32_PKRS
  | .msr .debugctl => IA32_DEBUGCTL
  | .msr .pat => IA32_PAT
  | .msr .mtrrDefType => IA32_MTRR_DEF_TYPE
  | .msr (.mtrrFixed i) => MTRR_Fixed[i.val]
  | .msr (.mtrrBase i) => MTRR_Base[i.val]
  | .msr (.mtrrMask i) => MTRR_Mask[i.val]
  | .msr .smrrPhysBase => IA32_SMRR_PHYSBASE
  | .msr .smrrPhysMask => IA32_SMRR_PHYSMASK
  | .msr .prmrrPhysMask => PRMRR_PHYS_MASK
  | .msr .biosDone => BIOS_DONE
  | .msr .platformInfo => PLATFORM_INFO
  | .msr .featureEnables => FEATURE_ENABLES
  | .msr .miscEnable => IA32_MISC_ENABLE
  | .msr .memoryControl => MEMORY_CONTROL
  | .msr .aetEventCtrl => AET_EVENT_CTRL
  | .msr .vmxCr0Fixed0 => IA32_VMX_CR0_FIXED0
  | .msr .vmxCr0Fixed1 => IA32_VMX_CR0_FIXED1
  | .msr .vmxCr4Fixed0 => IA32_VMX_CR4_FIXED0
  | .msr .vmxCr4Fixed1 => IA32_VMX_CR4_FIXED1
  | .msr .vmxEptVpidCap => IA32_VMX_EPT_VPID_CAP

/-- Capture architectural field values without retaining the source machine state. -/
@[macro_inline] def Register.capture {σ : Type} (s : X86.State σ) : (r : Register) → r.Value :=
  Register.captureValues
    s.GPR
    s.RIP
    s.RFLAGS
    s.ZMM
    s.K
    s.FP87
    s.FP87_Control
    s.FP87_Status
    s.FP87_Tag_Word
    s.FP87_FIP
    s.FP87_FDP
    s.FP87_FOP
    s.FP87_FCS
    s.FP87_FDS
    s.MXCSR
    s.PKRU
    s.SSP
    s.XCR0
    s.ES
    s.CS
    s.SS
    s.DS
    s.FS
    s.GS
    s.LDTR
    s.TR
    s.GDTR
    s.IDTR
    s.CR0
    s.CR2
    s.CR3
    s.CR4
    s.APIC_TPR
    s.DR0
    s.DR1
    s.DR2
    s.DR3
    s.DR6
    s.DR7
    s.IA32_EFER
    s.IA32_STAR
    s.IA32_LSTAR
    s.IA32_FMASK
    s.IA32_KERNEL_GS_BASE
    s.IA32_PL0_SSP
    s.IA32_PL1_SSP
    s.IA32_PL2_SSP
    s.IA32_PL3_SSP
    s.IA32_INTERRUPT_SSP_TABLE_ADDR
    s.IA32_U_CET
    s.IA32_S_CET
    s.IA32_PKRS
    s.IA32_DEBUGCTL
    s.IA32_PAT
    s.IA32_MTRR_DEF_TYPE
    s.MTRR_Fixed
    s.MTRR_Base
    s.MTRR_Mask
    s.IA32_SMRR_PHYSBASE
    s.IA32_SMRR_PHYSMASK
    s.PRMRR_PHYS_MASK
    s.BIOS_DONE
    s.PLATFORM_INFO
    s.FEATURE_ENABLES
    s.IA32_MISC_ENABLE
    s.MEMORY_CONTROL
    s.AET_EVENT_CTRL
    s.IA32_VMX_CR0_FIXED0
    s.IA32_VMX_CR0_FIXED1
    s.IA32_VMX_CR4_FIXED0
    s.IA32_VMX_CR4_FIXED1
    s.IA32_VMX_EPT_VPID_CAP

abbrev RegisterCell := (r : Register) × r.Value

def Msr.all : List Msr :=
  [.efer] ++
  [.star] ++
  [.lstar] ++
  [.fmask] ++
  [.kernelGsBase] ++
  [.pl0Ssp] ++
  [.pl1Ssp] ++
  [.pl2Ssp] ++
  [.pl3Ssp] ++
  [.interruptSspTable] ++
  [.uCet] ++
  [.sCet] ++
  [.pkrs] ++
  [.debugctl] ++
  [.pat] ++
  [.mtrrDefType] ++
  [.smrrPhysBase] ++
  [.smrrPhysMask] ++
  [.prmrrPhysMask] ++
  [.biosDone] ++
  [.platformInfo] ++
  [.featureEnables] ++
  [.miscEnable] ++
  [.memoryControl] ++
  [.aetEventCtrl] ++
  [.vmxCr0Fixed0] ++
  [.vmxCr0Fixed1] ++
  [.vmxCr4Fixed0] ++
  [.vmxCr4Fixed1] ++
  [.vmxEptVpidCap] ++
  (List.finRange 11).map .mtrrFixed ++
  (List.finRange 256).map .mtrrBase ++
  (List.finRange 256).map .mtrrMask

def Register.all : List Register :=
  (List.finRange 32).map .gpr ++
  [.rip] ++
  [.rflags] ++
  (List.finRange 32).map .zmm ++
  (List.finRange 8).map .mask ++
  (List.finRange 8).map .st ++
  [.fpuControl] ++
  [.fpuStatus] ++
  [.fpuTag] ++
  [.fip] ++
  [.fdp] ++
  [.fop] ++
  [.fcs] ++
  [.fds] ++
  [.mxcsr] ++
  [.pkru] ++
  [.ssp] ++
  [.xcr0] ++
  [.segment .es] ++
  [.segment .cs] ++
  [.segment .ss] ++
  [.segment .ds] ++
  [.segment .fs] ++
  [.segment .gs] ++
  [.segment .ldtr] ++
  [.segment .tr] ++
  [.gdtr] ++
  [.idtr] ++
  [.control .cr0] ++
  [.control .cr2] ++
  [.control .cr3] ++
  [.control .cr4] ++
  [.control .cr8] ++
  [.debug .dr0] ++
  [.debug .dr1] ++
  [.debug .dr2] ++
  [.debug .dr3] ++
  [.debug .dr6] ++
  [.debug .dr7] ++
  Msr.all.map .msr

end X86

import X86.UserProcess.Error
import X86.UserProcess.StateConversion
import X86.Helpers.Instruction_Context
import X86.Helpers.Current_Mode
import X86.Helpers.In_64Bit_Mode
import X86.Machine.Processor
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector

namespace X86.UserProcess

open X86.Machine

/-- The privilege level of user code. -/
def userPrivilege : BitVec 2 := 3
/-- The privilege level of kernel code. -/
def kernelPrivilege : BitVec 2 := 0

/--
The selector index of the profile's user code segment. This is the profile's choice, not Linux's
`GDT_ENTRY_DEFAULT_USER_CS`; `InitialSegments.user` loads the segment without a descriptor table.
-/
def userCodeIndex : BitVec 13 := 1
/--
The selector index of the profile's user data segment. This is the profile's choice, not Linux's
`GDT_ENTRY_DEFAULT_USER_DS`; `InitialSegments.user` loads the segment without a descriptor table.
-/
def userDataIndex : BitVec 13 := 2
/--
Linux's 64-bit `GDT_ENTRY_KERNEL_CS`, which equals `GDT_ENTRY_BOOT_CS`. Its selector is the boot
protocol's `__BOOT_CS` (0x10).
-/
def kernelCodeIndex : BitVec 13 := 2
/--
Linux's 64-bit `GDT_ENTRY_KERNEL_DS`, which equals `GDT_ENTRY_BOOT_DS`. Its selector is the boot
protocol's `__BOOT_DS` (0x18).
-/
def kernelDataIndex : BitVec 13 := 3

open X86.Helpers in
/-- A GDT selector for `index`, requesting privilege `rpl`. -/
def gdtSelector (index : BitVec 13) (rpl : BitVec 2) : Segment_Selector :=
  ((0 : Segment_Selector).setIndex index).setRPL rpl

open X86.Helpers in
/-- Present and accessed, at `dpl`, with base zero and the largest limit in 4-KiB units. -/
def flatDescriptor (dpl : BitVec 2) : Segment_Descriptor :=
  ((((((0 : Segment_Descriptor).setLimit (~~~0)).setG 1).setS 1).setP 1).setA 1).setDPL dpl

open X86.Helpers in
/-- A readable 64-bit code descriptor at `dpl`. -/
def codeDescriptor (dpl : BitVec 2) : Segment_Descriptor :=
  (((flatDescriptor dpl).setCode 1).setR 1).setL 1

open X86.Helpers in
/-- A writable data descriptor at `dpl` with a 32-bit default size. -/
def dataDescriptor (dpl : BitVec 2) : Segment_Descriptor :=
  ((flatDescriptor dpl).setW 1).setBig 1

/-- A loaded flat code segment. -/
def flatCodeSegment (selector : X86.Helpers.Segment_Selector) (dpl : BitVec 2) :
    X86.Helpers.Segment := {
  selector
  descriptor := X86.Runtime.InitializedBits.ofValue (codeDescriptor dpl)
  descriptor_high := X86.Runtime.InitializedBits.ofValue 0
  descriptor_valid := true
  is_stack := false
  is_code := true
  is_64bit_mode_data_segment := true }

/-- A flat data descriptor loaded as the stack segment (SS). -/
def flatStackSegment (selector : X86.Helpers.Segment_Selector) (dpl : BitVec 2) :
    X86.Helpers.Segment := {
  selector
  descriptor := X86.Runtime.InitializedBits.ofValue (dataDescriptor dpl)
  descriptor_high := X86.Runtime.InitializedBits.ofValue 0
  descriptor_valid := true
  is_stack := true
  is_code := false
  is_64bit_mode_data_segment := true }

/-- Flat user code: present, readable, DPL3, long-mode descriptor. -/
def userCodeSegment : X86.Helpers.Segment :=
  flatCodeSegment (gdtSelector userCodeIndex userPrivilege) userPrivilege

/-- Flat user stack: the DPL3 data descriptor at `userDataIndex`, loaded as SS. -/
def userStackSegment : X86.Helpers.Segment :=
  flatStackSegment (gdtSelector userDataIndex userPrivilege) userPrivilege

/-- Flat kernel code: present, readable, DPL0, long-mode descriptor. -/
def kernelCodeSegment : X86.Helpers.Segment :=
  flatCodeSegment (gdtSelector kernelCodeIndex kernelPrivilege) kernelPrivilege

/-- Flat kernel stack: the DPL0 data descriptor at `kernelDataIndex`, loaded as SS. -/
def kernelStackSegment : X86.Helpers.Segment :=
  flatStackSegment (gdtSelector kernelDataIndex kernelPrivilege) kernelPrivilege

/--
A base decode context using the current source mode and segment state.
Consumers populate instruction-specific sizes and effective segment overrides.
-/
def instructionContext : Action X86.Helpers.Instruction_Context := do
  let mode ← liftSource X86.Helpers.Current_Mode
  let is_mode64 ← liftSource X86.Helpers.In_64Bit_Mode
  let state ← get
  return {
    (default : X86.Helpers.Instruction_Context) with
    segment := state.DS
    seg_prefix_present := false
    mode
    is_mode64
    operand_size := 64
    address_size := 64 }

namespace Profile

open X86.Helpers

def writeEntry (memory : Ram) (address : Nat) (value : BitVec 64) : Ram :=
  Machine.store64Image memory (BitVec.ofNat 64 address) value

/--
The segment registers and GDTR of an initial state. The CPL is the RPL of the code selector. A
CPL0 start shares this profile with a CPL3 start because the two differ only in these fields;
`Runner.run` in `X86.UserProcess` remains user-mode.
-/
structure InitialSegments where
  code : Segment
  stack : Segment
  /-- The DS, ES, FS and GS registers. -/
  data : Segment := {stack with is_stack := false}
  gdtr : Descriptor_Table_Register
  deriving Repr

/-- CPL3 with flat user segments loaded directly, without a descriptor table. -/
def InitialSegments.user : InitialSegments :=
  { code := userCodeSegment, stack := userStackSegment, gdtr := {base := 0, limit := 0} }

/--
CPL0 with flat kernel segments at `kernelCodeIndex` and `kernelDataIndex`, the selectors of
Linux's 64-bit boot protocol. Execution reads only the loaded segment state. A caller that claims
a loaded GDT must place the code descriptor of `kernelCodeSegment` at `kernelCodeIndex` and the
data descriptor of `kernelStackSegment` at `kernelDataIndex` in the table that `gdtr` describes.
-/
def InitialSegments.kernel (gdtr : Descriptor_Table_Register) : InitialSegments :=
  { code := kernelCodeSegment, stack := kernelStackSegment, gdtr }

/--
The initial state of the profile at the privilege that `segments` selects, over any memory. `bits`
supplies the unspecified bits from index `position`.
-/
def initialState {σ : Type} (segments : InitialSegments) (bits : Nat → Bool) (memory : σ)
    (regs : Vector (BitVec 64) 16) (rip : BitVec 64) (flags : Flags) (cr3 : BitVec 64)
    (position : Nat) : X86.State σ :=
  {
    -- Choose an initialized WB memory map; these are not architectural reset values.
    IA32_PAT := 0x0606060606060606
    IA32_MTRR_DEF_TYPE := 0x806
    MTRR_Fixed := Vector.replicate 11 0
    MTRR_Base := Vector.replicate 256 0
    MTRR_Mask := Vector.replicate 256 0
    IA32_SMRR_PHYSBASE := 0
    IA32_SMRR_PHYSMASK := 0
    -- This fixture chooses zero vector/x87 contents and empty x87 tags, not reset values.
    ZMM := Vector.replicate 32 0
    -- Choose masked SSE exceptions, nearest rounding, and DAZ/FTZ disabled.
    MXCSR := 0x1f80
    -- The mask includes the supplied DAZ field; OSFXSR enables SIMD saving.
    FXSAVE_MXCSR_Mask := 0xffff
    K := Vector.replicate 8 0
    FP87 := Vector.replicate 8 0
    -- Mask x87 exceptions in this execution fixture.
    FP87_Control := 0x037f
    FP87_Status := 0
    -- This fixture begins without a previous x87 instruction.
    FP87_FCS := 0
    FP87_FDS := 0
    FP87_FIP := 0
    FP87_FDP := 0
    FP87_FOP := 0
    «VMCS::Address_Of_MSR_Bitmaps» := 0
    FP87_Tag_Word := 0xffff
    GPR := embedGPR regs
    RFLAGS := packFlags flags ||| (2 : BitVec 64)
    CS := segments.code
    SS := segments.stack
    DS := segments.data
    ES := segments.data
    FS := segments.data
    GS := segments.data
    IA32_KERNEL_GS_BASE := 0
    CPL := (Segment_Selector.RPL segments.code.selector).toNat
    RIP := rip
    Next_IP := rip
    Branch_Taken := false
    Execution_Debug_Cause := .Debug_No_Exception
    -- Enable protected paging and write protection; retain the fixed CR0.ET bit.
    CR0 := 0x80010011
    APIC_TPR := 0 -- Enabled local APIC; no priority threshold.
    CR3 := cr3
    CR4 := 0x20 -- PAE enables the profile's four-level page tables.
    IA32_EFER := {LME := 1, LMA := 1, NXE := 0, SCE := 0}
    -- This profile permits CPUID and leaves its input leaf unchanged.
    PLATFORM_INFO := ⟨0⟩
    FEATURE_ENABLES := ⟨0⟩
    IA32_MISC_ENABLE := ⟨0⟩
    -- SYSCALL is disabled; its destination MSRs are dormant profile inputs.
    IA32_STAR := 0
    IA32_LSTAR := 0
    IA32_FMASK := 0
    PRMRR_PHYS_MASK := {VALID := 0}
    BIOS_DONE := {ENABLE_IA_UNTRUSTED := 0}
    Default_Error_Code := 0
    IA32_DEBUGCTL := 0
    MEMORY_CONTROL := {SPLIT_LOCK_DISABLE := 0, UC_LOCK_DISABLE := 0}
    DR0 := 0
    DR1 := 0
    DR2 := 0
    DR3 := 0
    DR7 := 0x400 -- All breakpoints disabled; bit 10 is fixed at one.
    Debug_Breakpoint_Trap_Detected := false
    Debug_Breakpoints_Matched := 0
    Debug_Bus_Lock_Trap_Detected := false
    PKRU := 0
    IA32_PKRS := 0
    -- Dormant VMX inputs are explicit fixture values, not hardware MSR defaults.
    IA32_VMX_CR0_FIXED0 := 0
    IA32_VMX_CR0_FIXED1 := 0
    IA32_VMX_CR4_FIXED0 := 0
    IA32_VMX_CR4_FIXED1 := 0
    VMX_Operation_Mode := .Outside_VMX_Operation
    Current_VMCS_Pointer := 0
    IA32_VMX_EPT_VPID_CAP := {
      PLR_PREFIX_SIZE_0 := 0, PLR_PREFIX_SIZE_5_1 := 0,
      SUPPORTS_EPT_EXECUTE_ONLY := 0}
    «VMCS::EPTP» := 0
    -- XCR0 retains its mandatory x87 enable bit.
    XCR0 := 1
    «VMCS::HLATP» := 0
    SSP := 0
    IA32_U_CET := {
      SH_STK_EN := 0, ENDBR_EN := 0, NO_TRACK_EN := 0, SUPPRESS := 0, TRACKER := 0,
      LEG_IW_EN := 0, SUPPRESS_DIS := 0, EB_LEG_BITMAP_BASE := 0}
    IA32_S_CET := {
      SH_STK_EN := 0, ENDBR_EN := 0, NO_TRACK_EN := 0, SUPPRESS := 0, TRACKER := 0,
      LEG_IW_EN := 0, SUPPRESS_DIS := 0, EB_LEG_BITMAP_BASE := 0}
    CET_Tracker_Updated := false
    -- Fixed fixture inputs for facilities outside this profile. These values
    -- do not implement reset or claim architectural power-on defaults.
    Event_Blocked := {
      NMI_BLOCKED := false, SMI_BLOCKED := false, INTR_BLOCKED := false,
      INIT_BLOCKED := false, STI_BLOCKING := false, MOVSS_BLOCKING := false,
      VIRT_NMI_BLOCKED := false }
    Thread_Status := .THREAD_ACTIVE
    Current_Event := .No_Event
    Repeat_String_Operation := false
    Repeat_String_RF_Pending := false
    Repeat_String_RF_Pending_RIP := 0
    «MSRLIST::In_Process» := false
    Concurrent_Exception := {vector := 0, valid := false}
    «FRED::Event_Delivery_In_Progress» := false
    Committed_To_Task_Switch := false
    Saving_Task_State_During_Task_Switch := false
    Debug_Single_Step_Trap_Detected := false
    Debug_Task_Switch_Trap_Detected := false
    AET_EVENT_CTRL := {ENABLE := 0, CODE_BREAKPOINT := 0, DATA_BREAKPOINT := 0}
    DR6 := 0xffff0ff0
    Interrupt_Vector := 0
    «Monitor::Address» := 0
    «Monitor::Is_Armed» := false
    «Monitor::Is_User_Monitor» := false
    -- System segments are unloaded; their descriptors are explicitly invalid.
    LDTR := {userStackSegment with
      selector := 0, descriptor := X86.Runtime.InitializedBits.ofValue 0, descriptor_valid := false, is_stack := false}
    TR := {userStackSegment with
      selector := 0, descriptor := X86.Runtime.InitializedBits.ofValue 0, descriptor_valid := false, is_stack := false}
    GDTR := segments.gdtr
    IDTR := {base := 0, limit := 0}
    «Random_Numbers::HW_NRND_GEN» := {Ready := false, Data := 0}
    «SMM::In_SMM» := false
    «SMX::In_Measured_Environment» := false
    «TSX::HLE_Active» := false
    «TSX::HLE_Nest_Count» := 0
    «TSX::HLE_Restart_RIP» := 0
    -- Intel Reset_Core chooses seven; transactions remain inactive here.
    «TSX::MAX_HLE_NEST_COUNT» := 7
    «TSX::MAX_RTM_NEST_COUNT» := 7
    «TSX::RTM_Active» := false
    «TSX::RTM_Fallback_RIP» := 0
    «TSX::RTM_Nest_Count» := 0
    «TSX::SUSLDTRK_Active» := false
    XINIT_BV := 1
    VMX_On_Pointer := 0
    «VMCS::Primary_VM_Exec_Controls» := 0
    «VMCS::Secondary_VM_Exec_Controls» := 0
    «VMCS::Tertiary_VM_Exec_Controls» := 0
    «VMCS::Pin_Based_VM_Exec_Controls» := {NMI_Exiting := 0, Virtual_NMIs := 0, External_Interrupt_Exiting := 0}
    IA32_INTERRUPT_SSP_TABLE_ADDR := 0
    IA32_PL0_SSP := 0
    IA32_PL1_SSP := 0
    IA32_PL2_SSP := 0
    IA32_PL3_SSP := 0
    Double_Fault_Contributory_Exception := 0
    CR2 := 0
    external := memory
    oracle := {bits, position} }

/-- CPUID.80000001H:EDX[26] advertises 1-GiB pages. -/
def page1GBFeature : X86.CPUID_Feature :=
  { leaf := 0x80000001, subleaf := 0, register := 3, bit := 26 }

/--
Build an initial state at the privilege that `segments` selects and the table layout for the
requested coverage. The selected processor must support 1-GiB pages. Program/stack allocation and
entry-point coverage are caller obligations. Use `processor` in the execution bindings.

Reject table bytes that `input.mem` reports as occupied. Later writes to mapped table bytes are
allowed; the caller must prove that execution preserves the tables and paging controls.
-/
def initializeMapped {σ : Type} [IdentityMap.TableStorage σ] (processor : Machine.Processor)
    (segments : InitialSegments) (regions : List IdentityMap.Region) (tableBase : Nat)
    (bits : Nat → Bool) (input : StateView σ) :
    Except Error (X86.State σ × IdentityMap.Layout) := do
  let layout ← (IdentityMap.build processor.config.Max_Physical_Address.toNat regions tableBase)
    |>.mapError Error.identityMap
  let memory ← (layout.install input.mem).mapError Error.identityMap
  let state := initialState segments bits memory input.regs input.rip input.flags
    (BitVec.ofNat 64 layout.tableBase) input.oraclePos
  let _ := processor.cpuidBinding (σ := σ)
  let supported ← ((X86.Read_CPUID_Feature page1GBFeature).run state).1
    |>.mapError (Error.semantics ∘ X86.Runtime.Error.widen)
  unless supported do throw (.identityMap .unsupportedPageSize)
  return (state, layout)

end Profile
end X86.UserProcess

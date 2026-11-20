import Prelude.Bindings.Contract
import Prelude.Bindings.MemoryAccess
import X86.Machine.Bindings.MemoryType
import X86.Machine.Bindings.Fxsave
import X86.Helpers.Check_MXCSR_Reserved_Bits

namespace Prelude.Bindings.Fxsave

open X86

open Prelude.Bindings.Contract

/-- Source gates OSFXSR-clear MXCSR and XMM choices independently and enforces mandatory fields. -/
def optionalFieldsContract {σ : Type} : Contract (X86.State σ) X86.Machine.Bindings.Fxsave.Input (BitVec 2) :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- Source calls this only with enabled user-mode alignment checking and a misaligned image. -/
def alignmentContract {σ : Type} : Contract (X86.State σ) X86.Machine.Bindings.Fxsave.Input Bool :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- Selection cannot create a fault or omit required checks; source retains real page-walk effects. -/
def pageFaultPriorityContract {σ : Type} : Contract (X86.State σ) X86.Machine.Bindings.Fxsave.PageFaultPriorityInput Bool :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- The bit layout restricts choices to reserved values and adjacent bounded store widths. -/
def reservedHeaderContract {σ : Type} : Contract (X86.State σ) X86.Machine.Bindings.Fxsave.Input (BitVec 48) :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- The selector controls only reserved bytes after the source-owned 80-bit payload. -/
def reservedSlotContract {σ : Type} :
    Contract (X86.State σ) X86.Machine.Bindings.Fxsave.SlotInput (BitVec 49) :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- Enabling write swaps is unconstrained here; `SatisfiesWriteOrder` requires every
changed order to have WB stores. -/
def scheduleDomainContract {σ : Type} :
    Contract (X86.State σ) X86.Machine.Bindings.Fxsave.Input Bool :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- Adjacent swaps select only a finite permutation of source-owned checks and stores. -/
def writeSwapContract {σ : Type} : Contract (X86.State σ) X86.Machine.Bindings.Fxsave.WriteSwapInput Bool :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

/-- Local selector laws. -/
def SatisfiesSelectors {σ : Type} (implementation : X86.Machine.Bindings.Fxsave σ) : Prop :=
  optionalFieldsContract.Satisfies (m := Id) (fun input => implementation.optionalFields.call input.wide input.linearAddress) ∧
  alignmentContract.Satisfies (m := Id) (fun input => implementation.alignment.call input.wide input.linearAddress) ∧
  pageFaultPriorityContract.Satisfies (m := Id) (fun input => implementation.pageFaultPriority.call
    input.wide input.linearAddress input.faultVector) ∧
  reservedHeaderContract.Satisfies (m := Id) (fun input => implementation.reservedHeader.call input.wide input.linearAddress) ∧
  reservedSlotContract.Satisfies (m := Id) (fun input => implementation.reservedSlot.call
    input.wide input.linearAddress input.slot) ∧
  scheduleDomainContract.Satisfies (m := Id) (fun input =>
    implementation.scheduleDomain.call input.wide input.linearAddress) ∧
  writeSwapContract.Satisfies (m := Id) (fun input => implementation.writeSwap.call
    input.wide input.linearAddress input.first input.second)

/-- Values accepted by the actual generated LDMXCSR/FXRSTOR reserved-bit gate.
This gate accepts DAZ independently of the FXSAVE report. -/
def generatedMxcsrAccepted (value : BitVec 32) : Prop :=
  X86.Helpers.Check_MXCSR_Reserved_Bits value = .ok ()

/-- SDM Vol. 1 11.6.6: a zero report denotes the fallback mask FFBFH. -/
def effectiveMxcsrMask (reported : BitVec 32) : BitVec 32 :=
  if reported = 0 then 0xffbf else reported

/-- The reported mask advertises no reserved high bits and agrees with the values
the generated reserved-bit gate accepts. -/
def MxcsrMaskCoherent {σ : Type} (state : X86.State σ) : Prop :=
  effectiveMxcsrMask state.FXSAVE_MXCSR_Mask &&& 0xffff0000 = 0 ∧
    ∀ value, generatedMxcsrAccepted value ↔
      value &&& ~~~(effectiveMxcsrMask state.FXSAVE_MXCSR_Mask) = 0

structure SaveWriteInput where
  wide : Bool
  segment : X86.Helpers.Segment
  offset : BitVec 64
  addressSize : Int

attribute [local instance_reducible, local instance] X86.Machine.Processor.config

local instance {σ : Type} [processor : X86.Machine.Processor] : X86.Get_CPUID_Value.Binding σ :=
  processor.cpuidBinding

variable {σ : Type}

variable
  [processor : X86.Machine.Processor]
  [X86.EPTP_Index.Binding σ]
  [X86.HLAT_PLR_Prefix_Size.Binding σ]
  [X86.Helpers.EPT.Get_Exit_Qualification.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Read_EPT.Binding σ]
  [X86.Helpers.Physical_Mem_Read_PTW.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Physical_Mem_Write_PTW.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]
  [X86.Machine.Bindings.Fxsave σ]

/-- Guard the exact generated selected continuation, checking both split packets.
Each physical write delegates once. Memory types use the fixed interpretation.
Architectural faults remain admitted; unsupported and non-WB accesses cannot certify admission. -/
def selectedWritesWriteBack [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : SaveWriteInput) (first last : X86.Helpers.Address_Translation)
    (reserved : BitVec 48) (padding : BitVec 392) (fields : BitVec 2) (order : BitVec 216)
    (postSelection : X86.State σ) : Prop :=
  let guarded := MemoryAccess.guardedPhysicalWrite
    (inferInstance : X86.Helpers.Physical_Mem_Write.Binding σ)
  letI : X86.Helpers.Physical_Mem_Write.Binding σ := guarded
  letI := processor.processorTypeBinding
  letI := processor.cacheControlBinding (σ := σ)
  letI := X86.Helpers.Translate_Linear_To_Physical.defaultSemantics (σ := σ)
  let (outcome, _) := (X86.Helpers.Emulate_FXSAVE_Write_Transfer input.wide
    input.segment input.offset input.addressSize first last reserved padding fields order).run postSelection
  MemoryAccess.completedOrTypedFault outcome

/-- The finite generated plan determines the exact continuation and its state.
A changed permutation requires observed WB writes and coherent actual memory-type queries. -/
def writeOrderAdmission [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl] (input : SaveWriteInput) (before : X86.State σ) : Prop :=
  letI := processor.processorTypeBinding
  letI := processor.cacheControlBinding (σ := σ)
  letI := X86.Helpers.Translate_Linear_To_Physical.defaultSemantics (σ := σ)
  match (X86.Helpers.Emulate_FXSAVE_Write_Plan input.wide input.segment
    input.offset input.addressSize).run before with
  | (.ok (first, last, reserved, padding, fields, order), postSelection) =>
    match X86.Helpers.Emulate_FXSAVE_Source_Order with
    | .ok sourceOrder => order ≠ sourceOrder →
        selectedWritesWriteBack input first last reserved padding fields order postSelection
    | .error _ => False
  | (.error _, _) => True

/-- Every 64-bit-mode invocation passes the observed continuation admission. Plan
failures that are not selector failures are not attributed to the binding. -/
def SatisfiesWriteOrder [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl] : Prop :=
  ∀ input (before : X86.State σ), (input.addressSize = 32 ∨ input.addressSize = 64) →
      writeOrderAdmission input before

/-- Local selector laws and write-order admission under the machine's memory configuration.
This states no guarantee about unmodeled interleavings or full SDM conformance. -/
def Satisfies [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl] (implementation : X86.Machine.Bindings.Fxsave σ) : Prop :=
  letI : X86.Machine.Bindings.Fxsave σ := implementation
  SatisfiesSelectors implementation ∧ SatisfiesWriteOrder (σ := σ)

end Prelude.Bindings.Fxsave

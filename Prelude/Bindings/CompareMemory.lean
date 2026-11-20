import Prelude.Bindings.Contract
import Prelude.Bindings.MemoryAccess
import X86.Machine.Bindings.MemoryType
import X86.Machine.Bindings.CompareMemory

set_option autoImplicit false

namespace Prelude.Bindings.CompareMemory

open X86

open Prelude.Bindings.Contract

open X86.Helpers X86.Runtime

open X86.Machine.Bindings.CompareMemory (OrderInput FaultInput ProbeInput)

def supportedOperandSize (size : Int) : Prop := size = 8 ∨ size = 16 ∨ size = 32 ∨ size = 64

def executionFault (fault : Exception_Info) : Prop :=
  fault.vector = 14 ∨ fault.vector = 17 ∨ fault.vector = 13 ∨ fault.vector = 12

/-- Selectors complete, leave the state unchanged and return a bounded decision.
The generated local body computes operand addresses before asking for order. -/
def orderContract {σ : Type} : Contract (X86.State σ) OrderInput Bool :=
  Contract.mk (fun _ input => supportedOperandSize input.operandSize) (fun _ _ _ => True)

/-- The local body supplies two real faults from checks of the required operands.
The callback cannot raise an exception or directly change memory or registers. -/
def faultContract {σ : Type} : Contract (X86.State σ) FaultInput Bool :=
  Contract.mk (fun _ input => executionFault input.firstFault ∧ executionFault input.secondFault)
    (fun _ _ _ => True)

/-- A false probe decision preserves immediate first-fault termination. A true decision
permits only the real checks of the other required operand, retaining their effects. -/
def probeContract {σ : Type} : Contract (X86.State σ) ProbeInput Bool :=
  Contract.mk (fun _ input => supportedOperandSize input.operandSize ∧ executionFault input.firstFault)
    (fun _ _ _ => True)

def SatisfiesSelectors {σ : Type} (implementation : X86.Machine.Bindings.CompareMemory σ) : Prop :=
  orderContract.Satisfies (m := Id) (fun input => implementation.order.call input.operandSize
    input.sourceSegment input.source input.destinationSegment input.destination) ∧
  faultContract.Satisfies (m := Id) (fun input => implementation.fault.call input.firstFault input.secondFault) ∧
  probeContract.Satisfies (m := Id) (fun input => implementation.probe.call input.operandSize
    input.firstFault input.secondSegment input.second)

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
  [X86.Helpers.Select_Compare_Memory_Order.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Fault.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Probe.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]

/-- Observe the generated reversed continuation. The guard checks actual physical
read packets and delegates each read once; no speculative replay supplies WB evidence.
Real architectural faults are admitted, while runtime/binding failures are rejected. -/
def reverseReadsWriteBack [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : OrderInput) (postSelection : X86.State σ) : Prop :=
  let guarded := MemoryAccess.guardedPhysicalRead (inferInstance : Physical_Mem_Read.Binding σ)
  letI : Physical_Mem_Read.Binding σ := guarded
  letI := processor.processorTypeBinding
  letI := processor.cacheControlBinding (σ := σ)
  letI := X86.Helpers.Translate_Linear_To_Physical.defaultSemantics (σ := σ)
  let (outcome, _) := (Emulate_Compare_Memory_Transfer input.operandSize
    input.sourceSegment input.source input.destinationSegment input.destination true).run postSelection
  MemoryAccess.completedOrTypedFault outcome

/-- The exact selection result determines admission of the exact generated continuation.
Source-first execution has no extra WB requirement. Reverse choices require actual WB
read packets and coherent PAT/MTRR interpretation, including both split fragments.
Selector failures are excluded by `SatisfiesSelectors`. -/
def readOrderAdmission [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : OrderInput) (before : X86.State σ) : Prop :=
  match (X86.Helpers.Select_Compare_Memory_Order input.operandSize input.sourceSegment input.source
    input.destinationSegment input.destination).run before with
  | (.ok reverse, postSelection) =>
    reverse = true → reverseReadsWriteBack input postSelection
  | (.error _, _) => True

/-- Every invocation with a supported operand size passes the observed continuation
admission. The ordinary memory and paging bindings retain their own contracts. -/
def SatisfiesReadOrder [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl] : Prop :=
  ∀ input (before : X86.State σ), supportedOperandSize input.operandSize → readOrderAdmission input before

def Satisfies [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (implementation : X86.Machine.Bindings.CompareMemory σ) : Prop :=
  letI : X86.Helpers.Select_Compare_Memory_Order.Binding σ := implementation.order
  letI : X86.Helpers.Select_Compare_Memory_Fault.Binding σ := implementation.fault
  letI : X86.Helpers.Select_Compare_Memory_Probe.Binding σ := implementation.probe
  SatisfiesSelectors implementation ∧ SatisfiesReadOrder (σ := σ)

end Prelude.Bindings.CompareMemory

import Prelude.Bindings.Contract
import Prelude.Bindings.MemoryAccess
import X86.Machine.Bindings.MemoryType
import X86.Helpers.Emulate_Buffered_Stack_Return_Header
import X86.Machine.Bindings.StackReturn

set_option autoImplicit false

namespace Prelude.Bindings.StackReturn

open X86

open Prelude.Bindings.Contract

open X86.Helpers X86.Runtime Prelude.Bindings.MemoryAccess

def swapContract {σ : Type} :
    Contract (X86.State σ) X86.Machine.Bindings.StackReturn.SwapInput Bool :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

def validationContract {σ : Type} :
    Contract (X86.State σ) X86.Machine.Bindings.StackReturn.ValidationInput Bool :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

def SatisfiesSelectors {σ : Type} (implementation : X86.Machine.Bindings.StackReturn σ) : Prop :=
  swapContract.Satisfies (m := Id) (fun input =>
    implementation.swap.call input.group input.operandSize input.first input.second) ∧
  validationContract.Satisfies (m := Id) (fun input =>
    implementation.validation.call input.group input.reason input.knownValue
      input.readFault input.validationFault)

structure HeaderReadInput where
  operandSize : Int
  stackSegment : Segment
  stackPointer : BitVec 64

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
  [X86.Helpers.Select_Buffered_Stack_Return_Swap.Binding σ]
  [X86.Helpers.Select_Stack_Return_Validation_Fault.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]

/-- Requests come from the actual finite header plan, rather than an admission builder. -/
def reorderedHeaderReadsWriteBack [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : HeaderReadInput) (first second third : X86.Helpers.Stack_Return_Read_Request)
    (postSelection : X86.State σ) : Prop :=
  let guarded := guardedPhysicalRead (inferInstance : Physical_Mem_Read.Binding σ)
  letI : Physical_Mem_Read.Binding σ := guarded
  letI := processor.processorTypeBinding
  letI := processor.cacheControlBinding (σ := σ)
  letI := X86.Helpers.Translate_Linear_To_Physical.defaultSemantics (σ := σ)
  let (outcome, _) := (Emulate_Buffered_Stack_Return_Header_Transfer input.operandSize
    input.stackSegment input.stackPointer first second third).run postSelection
  completedOrTypedFault outcome

/-- Only a final nonidentity permutation needs additional WB admission. The plan
executes the actual swap callbacks once and derives the continuation's state. -/
def headerReadAdmission [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : HeaderReadInput) (before : X86.State σ) : Prop :=
  match (Emulate_Buffered_Stack_Return_Header_Plan input.operandSize
    input.stackSegment input.stackPointer).run before with
  | (.ok (changed, first, second, third), postSelection) =>
    changed = true → reorderedHeaderReadsWriteBack input first second third postSelection
  | (.error _, _) => True

structure TailReadInput where
  operandSize : Int
  stackSegment : Segment
  stackPointer : BitVec 64
  newCS : Segment
  newRIP : BitVec 64

/-- The actual tail continuation retains known SS and target RIP checks. -/
def swappedTailReadsWriteBack [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : TailReadInput) (postSelection : X86.State σ) : Prop :=
  let guarded := guardedPhysicalRead (inferInstance : Physical_Mem_Read.Binding σ)
  letI : Physical_Mem_Read.Binding σ := guarded
  letI := processor.processorTypeBinding
  letI := processor.cacheControlBinding (σ := σ)
  letI := X86.Helpers.Translate_Linear_To_Physical.defaultSemantics (σ := σ)
  let (outcome, _) := (Emulate_Buffered_Stack_Return_Target_Transfer .IRET_Stack
    input.operandSize input.stackSegment input.stackPointer true
    input.newCS input.newRIP).run postSelection
  completedOrTypedFault outcome

/-- The instruction prefix establishes the required tail and loaded CS/RIP context. -/
def tailReadAdmission [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (input : TailReadInput) (before : X86.State σ) : Prop :=
  match (Emulate_Buffered_Stack_Return_Pair_Plan .IRET_Stack input.operandSize
    input.stackSegment input.stackPointer).run before with
  | (.ok reverse, postSelection) =>
    reverse = true → swappedTailReadsWriteBack input postSelection
  | (.error _, _) => True

def supportedOperandSize (size : Int) : Prop := size = 16 ∨ size = 32 ∨ size = 64

/-- Every invocation with a supported operand size passes the observed continuation
admission. Plan failures that are not selector failures are not attributed to the binding. -/
def SatisfiesReadOrder [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl] : Prop :=
  (∀ input (before : X86.State σ), supportedOperandSize input.operandSize →
      headerReadAdmission input before) ∧
    (∀ input (before : X86.State σ), supportedOperandSize input.operandSize →
      tailReadAdmission input before)

def Satisfies [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (implementation : X86.Machine.Bindings.StackReturn σ) : Prop :=
  letI : Select_Buffered_Stack_Return_Swap.Binding σ := implementation.swap
  letI : Select_Stack_Return_Validation_Fault.Binding σ := implementation.validation
  SatisfiesSelectors implementation ∧
    SatisfiesReadOrder (σ := σ)

end Prelude.Bindings.StackReturn

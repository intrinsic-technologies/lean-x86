import X86.Helpers.Emulate_Compare_Memory_Operands

namespace X86.Machine.Bindings

structure CompareMemory.OrderInput where
  operandSize : Int
  sourceSegment : Helpers.Segment
  source : Runtime.Bits 64
  destinationSegment : Helpers.Segment
  destination : Runtime.Bits 64

structure CompareMemory.ProbeInput where
  operandSize : Int
  firstFault : Helpers.Exception_Info
  secondSegment : Helpers.Segment
  second : Runtime.Bits 64

structure CompareMemory.FaultInput where
  firstFault : Helpers.Exception_Info
  secondFault : Helpers.Exception_Info

/-- CMPS implementations choose read order, competing checks and actual fault priority.
These callbacks alone assert no SDM conformance; CompareMemory contracts supply it. -/
class CompareMemory (σ : Type) where
  order : X86.Helpers.Select_Compare_Memory_Order.Binding σ
  fault : X86.Helpers.Select_Compare_Memory_Fault.Binding σ
  probe : X86.Helpers.Select_Compare_Memory_Probe.Binding σ

attribute [instance_reducible, instance] CompareMemory.order CompareMemory.fault CompareMemory.probe

/-- Each implementation function sees the pre-callback state. -/
@[instance_reducible]
def CompareMemory.ofFunctions {σ : Type}
    (order : State σ → CompareMemory.OrderInput → Bool)
    (fault : State σ → CompareMemory.FaultInput → Bool)
    (probe : State σ → CompareMemory.ProbeInput → Bool) : CompareMemory σ where
  order.call operandSize sourceSegment source destinationSegment destination := do
    return order (← read) {operandSize, sourceSegment, source, destinationSegment, destination}
  fault.call firstFault secondFault := do
    return fault (← read) {firstFault, secondFault}
  probe.call operandSize firstFault secondSegment second := do
    return probe (← read) {operandSize, firstFault, secondSegment, second}

@[instance_reducible]
def CompareMemory.fixed {σ : Type} (order fault probe : Bool) : CompareMemory σ :=
  CompareMemory.ofFunctions (fun _ _ => order) (fun _ _ => fault) (fun _ _ => probe)

end X86.Machine.Bindings

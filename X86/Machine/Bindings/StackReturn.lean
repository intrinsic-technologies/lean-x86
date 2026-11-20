import X86.Helpers.Emulate_Buffered_Stack_Return_Header

set_option autoImplicit false

namespace X86.Machine.Bindings

structure StackReturn.SwapInput where
  group : Helpers.Buffered_Stack_Return_Group
  operandSize : Int
  first : Helpers.Stack_Return_Read_Request
  second : Helpers.Stack_Return_Read_Request

structure StackReturn.ValidationInput where
  group : Helpers.Buffered_Stack_Return_Group
  reason : Helpers.Stack_Return_Validation_Reason
  knownValue : BitVec 64
  readFault : Helpers.Exception_Info
  validationFault : Helpers.Exception_Info

/-- Explicit local IRET choices; the source fixes required accesses and commit points. -/
class StackReturn (σ : Type) where
  swap : Helpers.Select_Buffered_Stack_Return_Swap.Binding σ
  validation : Helpers.Select_Stack_Return_Validation_Fault.Binding σ

attribute [instance_reducible, instance] StackReturn.swap StackReturn.validation

@[instance_reducible]
def StackReturn.ofFunctions {σ : Type}
    (swap : State σ → StackReturn.SwapInput → Bool)
    (validation : State σ → StackReturn.ValidationInput → Bool) : StackReturn σ where
  swap := ⟨fun group operandSize first second => do
    return swap (← read) ⟨group, operandSize, first, second⟩⟩
  validation := ⟨fun group reason knownValue readFault validationFault => do
    return validation (← read) ⟨group, reason, knownValue, readFault, validationFault⟩⟩

@[instance_reducible]
def StackReturn.fixed {σ : Type} (swap validation : Bool) : StackReturn σ :=
  StackReturn.ofFunctions (fun _ _ => swap) (fun _ _ => validation)

end X86.Machine.Bindings

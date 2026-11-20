import X86.Helpers.Physical_Mem_Read
import X86.Helpers.Physical_Mem_Write

set_option autoImplicit false

namespace Prelude.Bindings.MemoryAccess

open X86

open X86.Helpers X86.Runtime

/-- Only the translations actually used by a data read must be WB. -/
def packetWriteBack (packet : Address_Translation) : Bool :=
  packet.translation1.memory_type == .Memory_Type_Write_Back &&
    (!packet.is_split_access || packet.translation2.memory_type == .Memory_Type_Write_Back)

/-- A conformance-only guard around the actual physical delegate. It observes existing
translations without another query, page walk or choice. Never install it in runtime bindings. -/
@[instance_reducible]
def guardedPhysicalRead {σ : Type} (delegate : Physical_Mem_Read.Binding σ) :
    Physical_Mem_Read.Binding σ where
  call packet size := do
    if !packetWriteBack packet then
      throw (.externalFailure "memory read-order admission: inadmissible physical packet")
    delegate.call packet size

/-- A conformance-only guard around the actual physical write delegate. -/
@[instance_reducible]
def guardedPhysicalWrite {σ : Type} (delegate : Physical_Mem_Write.Binding σ) :
    Physical_Mem_Write.Binding σ where
  call packet size value := do
    if !packetWriteBack packet then
      throw (.externalFailure "memory write-order admission: inadmissible physical packet")
    delegate.call packet size value

/-- Actual architectural faults before or between data accesses remain admitted.
Guard rejection, runtime failures and source control exits cannot certify admission. -/
def completedOrTypedFault {α : Type} (outcome : X86.Result α) : Prop :=
  match outcome with
  | .ok _ => True
  | .error (.raised (.Exception_Info _)) => True
  | _ => False

end Prelude.Bindings.MemoryAccess

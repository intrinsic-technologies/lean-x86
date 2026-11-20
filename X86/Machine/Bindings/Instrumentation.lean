import X86.State

namespace X86.Machine.Bindings.Instrumentation

variable {σ : Type}

private def unsupported {exception α : Type} (operation : String) :
    X86.Runtime.SpecM exception (X86.State σ) α :=
  throw (.externalFailure s!"unsupported instrumentation operation: {operation}")

-- Intel's trace hooks. This machine records no trace for them and leaves the state unchanged.
instance : X86.__Trace_Physical_Mem.Binding σ where
  call _ _ _ _ _ := pure ()

instance : X86.__Trace_Next_Cycle.Binding σ where
  call := pure ()

-- Intel's fault-injection hook for x87 erratum 047, which may corrupt the next memory write. It
-- occurs only in real-address or virtual-8086 mode. This 64-bit machine supplies no fault model
-- and rejects it.
instance : X86.__Fuzz_Next_Mem_Write.Binding σ where
  call _ := unsupported "__Fuzz_Next_Mem_Write"

end X86.Machine.Bindings.Instrumentation

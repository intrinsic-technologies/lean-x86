import X86.Machine.Cpuid

namespace X86.Machine.Bindings.Cpuid

/-- Answer CPUID from a caller query and the live XCR0 and CR4.OSXSAVE. -/
@[instance_reducible]
def ofQuery {σ : Type} (query : X86.Machine.Cpuid.Query) : X86.Get_CPUID_Value.Binding σ where
  call eax ecx := do
    match X86.Machine.Cpuid.queryAtState query (← get) eax.toNat ecx.toNat with
    | .ok value => pure value
    | .error message => throw (.externalFailure message)

end X86.Machine.Bindings.Cpuid

import Prelude.Bindings.Contract
import X86.Machine.Bindings.CacheControl

set_option autoImplicit false

namespace Prelude.Bindings.CacheControl

open X86.Helpers

/-- The local memory-type model delegates the remaining CD=1 cases to the binding.
Its Atom, disabled-MTRR and SMRR rules stay in the ISA source. -/
def RequiresBinding (inputs : Memory_Type_Inputs) (address : BitVec 64)
    (patIndex : BitVec 3) : Prop :=
  match Emulate_Get_Memory_Type inputs address patIndex with
  | .ok selection => selection.Requires_Binding = true
  | .error _ => False

/-- The entire implemented physical address space has MTRR type UC, including
fixed/variable precedence and overlaps. SDM 093 §14.5.3 requires UC semantics
with CD=1 for this map, independently of the PAT and the binding. -/
def MtrrsAreUC (inputs : Memory_Type_Inputs) : Prop :=
  let physicalMask := BitVec.ofNat 64 (2 ^ inputs.Memory_Physical_Address_Bits.toNat - 1)
  ∀ address : BitVec 64, address &&& ~~~physicalMask = 0 →
    Emulate_Memory.MTRR_Type inputs address = .ok .Memory_Type_Strong_Uncacheable

/-- UC guarantees for CD=1. The SMRR type takes precedence within SMRAM;
outside SMM, SMRR accesses are UC regardless of its type field.
SDM 093 §§14.5.3, 14.11.2.4. -/
def RequiresUC (inputs : Memory_Type_Inputs) (address : BitVec 64) : Prop :=
  inputs.Processor_Is_Atom = true ∨
    match Emulate_Memory.SMRR_Matches inputs.IA32_MTRRCAP inputs.IA32_SMRR_PHYSBASE
        inputs.IA32_SMRR_PHYSMASK address with
    | .ok true => inputs.In_SMM = false ∨ inputs.IA32_SMRR_PHYSBASE.extractLsb' 0 8 = 0
    | .ok false => MtrrsAreUC inputs
    | .error _ => False

/-- CD=1 result constraints. UC precedence follows SDM 093 §§14.5.1–14.5.2;
the WC/WP restrictions apply §14.11.6's coherent-remapping guidance by analogy.
The normal-caching selector supplies the configured type with SMRR priority.
These constraints are not an exhaustive processor policy. -/
def PermittedResult (inputs : Memory_Type_Inputs) (address : BitVec 64)
    (patIndex : BitVec 3) (result : Memory_Type) : Prop :=
  result ≠ .Memory_Type_Unknown ∧
  (result = .Memory_Type_Write_Combining → inputs.IA32_MTRRCAP.getLsbD 10 = true) ∧
  (result = .Memory_Type_Uncacheable →
    inputs.IA32_PAT.extractLsb' (patIndex.toNat * 8) 8 = 7) ∧
  (RequiresUC inputs address → result = .Memory_Type_Strong_Uncacheable) ∧
  match Emulate_Get_Memory_Type
      {inputs with CR0 := X86.CR0_Type.setNW (X86.CR0_Type.setCD inputs.CR0 0) 0}
      address patIndex with
  | .ok selection =>
      (selection.Known_Type = .Memory_Type_Strong_Uncacheable →
        result = .Memory_Type_Strong_Uncacheable) ∧
      (result = .Memory_Type_Write_Combining →
        selection.Known_Type = .Memory_Type_Write_Combining) ∧
      (selection.Known_Type = .Memory_Type_Write_Protected →
        result = .Memory_Type_Write_Protected ∨ result = .Memory_Type_Strong_Uncacheable)
  | .error _ => True

structure Input where
  address : BitVec 64
  patIndex : BitVec 3
  deriving DecidableEq, Repr

/-- Every query delegated by the generated selector must complete with a result
that satisfies the documented SDM constraints. Admission depends on the inputs
and selector, independently of binding success. Configurations rejected by the
selector are outside this domain.
These necessary constraints do not establish a particular processor's policy. -/
def contract : Contract Memory_Type_Inputs Input Memory_Type :=
  Contract.mk
    (fun inputs request => RequiresBinding inputs request.address request.patIndex)
    (fun inputs request result => PermittedResult inputs request.address request.patIndex result)

/-- SDM laws for the pure binding. Table 14-5 and §14.5.1 make NW immaterial
with CD=1 on the selected Intel 64 families. Every admitted query must succeed;
its successful type cannot depend on NW. A hardware claim must additionally
justify the processor-specific results and coverage of its reachable queries,
which can be stated using `Contract`. These laws concern memory typing, not
cache contents, flushing or coherence. -/
structure Satisfies (implementation : X86.Machine.Bindings.CacheControl) : Prop where
  result : ∀ cpuid, contract.Satisfies (m := Id)
    (fun request inputs => implementation.disabledMemoryType cpuid inputs request.address request.patIndex)
  nwIgnored : ∀ cpuid inputs address patIndex, RequiresBinding inputs address patIndex →
    let withoutNW := {inputs with CR0 := X86.CR0_Type.setNW inputs.CR0 0}
    (implementation.disabledMemoryType cpuid inputs address patIndex).toOption =
      (implementation.disabledMemoryType cpuid withoutNW address patIndex).toOption

end Prelude.Bindings.CacheControl

/-!
# Accelerated helpers

An accelerated helper `Foo` is generated as Intel's body `Foo.source` and a wrapper `Foo` that runs
`accelerated Foo.source`. Each `Accelerate` instance carries a proof that it is `Foo.source`. Write
the default instance inline, `⟨Foo.source, rfl⟩`, so Lean specializes `Foo.source` into callers.
-/

namespace X86

/-- An implementation of `f`, with the proof that it is `f`. -/
class Accelerate {α : Type} (f : α) where
  fast : α
  fast_eq : fast = f

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Accelerate

/-- `f`, run with the supplied implementation. -/
@[inline] def accelerated {α : Type} (f : α) [Accelerate f] : α := Accelerate.fast f

end X86

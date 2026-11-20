import Prelude.Bindings
import Prelude.Float
import Prelude.Memory
import Prelude.Execution
import Prelude.Invariant
import Prelude.Bytes
import Prelude.ImageSections

/-!
Common objects for defining statements about x86 programs: memory regions,
stack conditions, execution assumptions and outcome predicates. Downstream
projects combine these with their own program-specific specifications.
-/

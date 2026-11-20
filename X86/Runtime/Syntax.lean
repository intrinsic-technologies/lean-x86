import X86.Runtime.Bits
import X86.Runtime.Integer

namespace X86.Runtime.Syntax

-- Intel's plain Boolean operators evaluate both operands, unlike Lean's &&/||.
-- One notation uses Lean's standard classes for both Boolean and bitvector operands.
scoped instance : AndOp Bool := ⟨strictAnd⟩
scoped instance : OrOp Bool := ⟨strictOr⟩
scoped infixl:35 " and " => HAnd.hAnd
scoped infixl:30 " or " => HOr.hOr
scoped infixl:32 " xor " => HXor.hXor

-- Backtrack the whole range so ordinary for binders keep their Lean grammar.
-- No space before '..': spaced dots overlap Lean's argument ellipsis syntax.
scoped syntax:50 (name := rangeMembership)
  term:51 atomic(" in " "{" term noWs ".." term "}") : term
scoped macro_rules (kind := rangeMembership)
  | `($value in {$lo..$hi}) => `(X86.Runtime.inRange $value $lo $hi)

-- Intel bit and slice notation denotes the same checked monadic operation.
-- Keep its scope explicit: ordinary Lean indexing still has its usual meaning.
scoped syntax:max (name := checkedInclusiveSlice)
  term:max noWs "[" term ":" term "]" : term
scoped syntax:max (name := checkedSlice)
  term:max noWs "[" term " +: " term "]" : term
scoped syntax:max (name := checkedHighSlice)
  term:max noWs "[" term " -: " term "]" : term
scoped syntax:max (name := checkedElement)
  term:max noWs "[" term " *: " term "]" : term

scoped macro_rules (kind := checkedInclusiveSlice)
  | `($x[$hi : $lo]) => `(X86.Runtime.sliceInclusive $x $hi $lo)
scoped macro_rules (kind := checkedSlice)
  | `($x[$lo +: $width]) => `(X86.Runtime.CheckedSlice.read $x $lo $width)
scoped macro_rules (kind := checkedHighSlice)
  | `($x[$hi -: $width]) => `(X86.Runtime.sliceHigh $x $hi $width)
scoped macro_rules (kind := checkedElement)
  | `($x[$index *: $width]) => `(X86.Runtime.sliceElement $x $width $index)

end X86.Runtime.Syntax

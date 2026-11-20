import X86.Syntax.Instruction

namespace X86.Decode

open X86.Syntax

/-- CPU feature inputs used by the generated legacy form selector. -/
structure DecodeFeatures where
  lzcnt : Bool
  mmx : Bool
  sse : Bool
  sse2 : Bool
  cet : Bool
  cmpxchg16b : Bool
  deriving Repr, BEq, Inhabited

/--
A typed XED instruction at an address. Register and operand shapes come from
pinned XED tables. Width/prefix correlations are checked by XED when exporting;
the types alone do not establish a valid encoding or agreement with execution.
The payload stores variable explicit operands and variable implicit registers.
Fixed operands and XED-suppressed operands are described in the generated schema;
they are not a complete operand list here. For example, RET has no payload.
Original bytes remain the input to execution, including instruction-fetch faults.
-/
structure DecodedInstruction where
  address : BitVec 64
  bytes : Array UInt8
  operandWidth : Width
  addressWidth : Width
  prefixes : Array UInt8
  instruction : Instruction
  deriving Repr, Inhabited

def DecodedInstruction.length (instruction : DecodedInstruction) : Nat :=
  instruction.bytes.size

/-- Find the instruction stored at an exact start address. -/
def instructionAt (instructions : Array DecodedInstruction) (address : BitVec 64) :
    Option DecodedInstruction :=
  instructions.find? (·.address == address)

end X86.Decode

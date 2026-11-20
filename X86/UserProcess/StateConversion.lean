import X86.UserProcess.StateView
import X86.Machine.State

namespace X86.UserProcess

/--
The decoder names sixteen GPRs. The remaining source registers are initialized
once; the machine retains all thirty-two entries in the generated state.
-/
def embedGPR (registers : Vector (BitVec 64) 16) : X86.Runtime.Array 32 (BitVec 64) :=
  Vector.ofFn fun index => if h : index.val < 16 then registers[index.val] else 0

def projectGPR (registers : X86.Runtime.Array 32 (BitVec 64)) : Vector (BitVec 64) 16 :=
  Vector.ofFn fun index => registers[index.val]

def packFlags (flags : Flags) : BitVec 64 :=
  [(0, flags.cf), (2, flags.pf), (4, flags.af), (6, flags.zf),
    (7, flags.sf), (10, flags.df), (11, flags.of)]
    |>.foldl (fun value (bit, flag) =>
      value ||| ((BitVec.ofBool flag).setWidth 64 <<< bit)) 0

def unpackFlags (value : BitVec 64) : Flags := {
  cf := value.getLsbD 0
  pf := value.getLsbD 2
  af := value.getLsbD 4
  zf := value.getLsbD 6
  sf := value.getLsbD 7
  df := value.getLsbD 10
  of := value.getLsbD 11 }

/--
An observation for existing ABI and program specifications. The machine never
reconstructs architectural state from this projection. Memory is physical.
-/
def view (state : Machine.RamState) : StateView := {
  regs := projectGPR state.GPR
  rip := state.RIP
  flags := unpackFlags state.RFLAGS
  mem := state.external
  oraclePos := state.oracle.position }

end X86.UserProcess

-- Generated from pinned Intel XED operand tables and selected SDM forms; do not edit.
import Std

namespace X86.Syntax

-- These are XED register identifiers, not register storage or read/write operations.
-- Register domains collect possible table outputs. XED checks correlations
-- between prefixes, widths and register choices; these types do not.

inductive Registers.CR where
  | CR0
  | CR2
  | CR3
  | CR4
  | CR8
  deriving Repr, BEq, Inhabited

inductive Registers.DR where
  | DR0
  | DR1
  | DR2
  | DR3
  | DR4
  | DR5
  | DR6
  | DR7
  deriving Repr, BEq, Inhabited

inductive Registers.GPR16 where
  | AX
  | BP
  | BX
  | CX
  | DI
  | DX
  | R10W
  | R11W
  | R12W
  | R13W
  | R14W
  | R15W
  | R16W
  | R17W
  | R18W
  | R19W
  | R20W
  | R21W
  | R22W
  | R23W
  | R24W
  | R25W
  | R26W
  | R27W
  | R28W
  | R29W
  | R30W
  | R31W
  | R8W
  | R9W
  | SI
  | SP
  deriving Repr, BEq, Inhabited

inductive Registers.GPR32 where
  | EAX
  | EBP
  | EBX
  | ECX
  | EDI
  | EDX
  | ESI
  | ESP
  | R10D
  | R11D
  | R12D
  | R13D
  | R14D
  | R15D
  | R16D
  | R17D
  | R18D
  | R19D
  | R20D
  | R21D
  | R22D
  | R23D
  | R24D
  | R25D
  | R26D
  | R27D
  | R28D
  | R29D
  | R30D
  | R31D
  | R8D
  | R9D
  deriving Repr, BEq, Inhabited

inductive Registers.GPR64 where
  | R10
  | R11
  | R12
  | R13
  | R14
  | R15
  | R16
  | R17
  | R18
  | R19
  | R20
  | R21
  | R22
  | R23
  | R24
  | R25
  | R26
  | R27
  | R28
  | R29
  | R30
  | R31
  | R8
  | R9
  | RAX
  | RBP
  | RBX
  | RCX
  | RDI
  | RDX
  | RSI
  | RSP
  deriving Repr, BEq, Inhabited

inductive Registers.GPR8 where
  | AH
  | AL
  | BH
  | BL
  | BPL
  | CH
  | CL
  | DH
  | DIL
  | DL
  | R10B
  | R11B
  | R12B
  | R13B
  | R14B
  | R15B
  | R16B
  | R17B
  | R18B
  | R19B
  | R20B
  | R21B
  | R22B
  | R23B
  | R24B
  | R25B
  | R26B
  | R27B
  | R28B
  | R29B
  | R30B
  | R31B
  | R8B
  | R9B
  | SIL
  | SPL
  deriving Repr, BEq, Inhabited

inductive Registers.GPRv where
  | AX
  | BP
  | BX
  | CX
  | DI
  | DX
  | EAX
  | EBP
  | EBX
  | ECX
  | EDI
  | EDX
  | ESI
  | ESP
  | R10
  | R10D
  | R10W
  | R11
  | R11D
  | R11W
  | R12
  | R12D
  | R12W
  | R13
  | R13D
  | R13W
  | R14
  | R14D
  | R14W
  | R15
  | R15D
  | R15W
  | R16
  | R16D
  | R16W
  | R17
  | R17D
  | R17W
  | R18
  | R18D
  | R18W
  | R19
  | R19D
  | R19W
  | R20
  | R20D
  | R20W
  | R21
  | R21D
  | R21W
  | R22
  | R22D
  | R22W
  | R23
  | R23D
  | R23W
  | R24
  | R24D
  | R24W
  | R25
  | R25D
  | R25W
  | R26
  | R26D
  | R26W
  | R27
  | R27D
  | R27W
  | R28
  | R28D
  | R28W
  | R29
  | R29D
  | R29W
  | R30
  | R30D
  | R30W
  | R31
  | R31D
  | R31W
  | R8
  | R8D
  | R8W
  | R9
  | R9D
  | R9W
  | RAX
  | RBP
  | RBX
  | RCX
  | RDI
  | RDX
  | RSI
  | RSP
  | SI
  | SP
  deriving Repr, BEq, Inhabited

inductive Registers.GPRz where
  | AX
  | BP
  | BX
  | CX
  | DI
  | DX
  | EAX
  | EBP
  | EBX
  | ECX
  | EDI
  | EDX
  | ESI
  | ESP
  | R10D
  | R10W
  | R11D
  | R11W
  | R12D
  | R12W
  | R13D
  | R13W
  | R14D
  | R14W
  | R15D
  | R15W
  | R16D
  | R16W
  | R17D
  | R17W
  | R18D
  | R18W
  | R19D
  | R19W
  | R20D
  | R20W
  | R21D
  | R21W
  | R22D
  | R22W
  | R23D
  | R23W
  | R24D
  | R24W
  | R25D
  | R25W
  | R26D
  | R26W
  | R27D
  | R27W
  | R28D
  | R28W
  | R29D
  | R29W
  | R30D
  | R30W
  | R31D
  | R31W
  | R8D
  | R8W
  | R9D
  | R9W
  | SI
  | SP
  deriving Repr, BEq, Inhabited

inductive Registers.MMX where
  | MMX0
  | MMX1
  | MMX2
  | MMX3
  | MMX4
  | MMX5
  | MMX6
  | MMX7
  deriving Repr, BEq, Inhabited

inductive Registers.OeAX where
  | AX
  | EAX
  deriving Repr, BEq, Inhabited

inductive Registers.OrAX where
  | AX
  | EAX
  | RAX
  deriving Repr, BEq, Inhabited

inductive Registers.SEG where
  | CS
  | DS
  | ES
  | FS
  | GS
  | SS
  deriving Repr, BEq, Inhabited

inductive Registers.SEG_MOV where
  | DS
  | ES
  | FS
  | GS
  | SS
  deriving Repr, BEq, Inhabited

inductive Registers.X87 where
  | ST0
  | ST1
  | ST2
  | ST3
  | ST4
  | ST5
  | ST6
  | ST7
  deriving Repr, BEq, Inhabited

inductive Registers.XMM where
  | XMM0
  | XMM1
  | XMM10
  | XMM11
  | XMM12
  | XMM13
  | XMM14
  | XMM15
  | XMM2
  | XMM3
  | XMM4
  | XMM5
  | XMM6
  | XMM7
  | XMM8
  | XMM9
  deriving Repr, BEq, Inhabited

end X86.Syntax

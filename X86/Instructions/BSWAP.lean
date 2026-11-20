-- Generated from data/instruction/BSWAP.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 70e8d734c060d63001ae69177c9bb47a507e9e339371e7c61ce279564705b949
-- Description: data/sdm/BSWAP.docbook
-- Reverses the byte order of a 32-bit or 64-bit (destination) register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=BSWAP)
import X86.Runtime
import X86.Helpers.Byte_Reverse
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_GPR
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

-- Retain checked width facts for dependent casts; their proofs are erased.
def Instructions.Operations.BSWAP
    (operand_size : Int) (src : Bits operand_size) :
    Except (Runtime.Error Empty) (Bits operand_size) := do
  let ⟨width_domain⟩ ← Runtime.assertWithProof (operand_size == 16 || operand_size == 32 || operand_size == 64)

  have width_eq : Int.toNat operand_size = Int.toNat ((8 : Int) * (operand_size / 8)) := by
    simp_all only [Bool.or_eq_true, beq_iff_eq] <;> omega
  let result : Bits ((8 : Int) * (operand_size / 8)) ← do
    if operand_size == 16 then
      pure (BitVec.cast width_eq (← Std.Bits.Zero operand_size))
    else
      (do
        let ⟨N, N_result⟩ ← liftM (Runtime.remember (Std.Integer.Positive_Divide operand_size 8 : Except (Runtime.Error Empty) Int))
        have N_value := Runtime.positiveDivide_eq_of_ok N_result
        have width_eq_1 : Int.toNat operand_size = Int.toNat ((8 : Int) * N) := by
          simp_all only [Bool.or_eq_true, beq_iff_eq] <;> omega
        have width_eq_2 : Int.toNat ((8 : Int) * N) = Int.toNat ((8 : Int) * (operand_size / 8)) := by
          simp_all only [Bool.or_eq_true, beq_iff_eq] <;> omega
        return BitVec.cast width_eq_2 (← Byte_Reverse (x := BitVec.cast width_eq_1 src) (N := N)))
  return BitVec.cast width_eq.symm result

-- BSWAP_GPRv: 0F c8+r
def Instructions.BSWAP_GPRv
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.BSWAP operand_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) result

end X86

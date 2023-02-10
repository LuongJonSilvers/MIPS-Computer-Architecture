# MIPS-Computer-Architecture

This repo contains verilog code used to create a MIPS-"like" architectured processor. 
It shares many similarities with the MIPS R2000 described in the 
Computer Organization and Design The Hardware/Software Interface Fifth Edition by 
David A. Patterson and John L. Hennessy textbook. 
The major differences are a smaller instruction set and 16-bit words. 
Similarities include a load/store architecture and three fixed-length instruction formats.
This architecture follows a Harvard architecture, where instructions and data are located 
in different phyiscal memories. This repo contains the constraint requirements for this archieture in 
addition to two processors I designed.  One is a unpieplined version and the second is a pipelined version 
with 5 stages similar to the one in the MIPS R2000(Instruction Fetch, Instruction Decode/Register Fetch,
execute/Address Calculation, Memory Access, and a Write Back stage) along with a forwarding unit.

Registers
There are eight user registers, R0-R7. Unlike the MIPS R2000, R0 is not always zero. Register
R7 is used as the link register for JAL or JALR instructions. The program counter is separate
from the user register file. A special register named EPC is used to save the current PC upon an
exception or interrupt invocation.

Within each of these directories is the instruction set that is included with the processors.
Down below is more explanation of the different formats of each processor. I suggest looking at the data path 
of the unpipelined processor, and the ALU control unit before looking at the pipelined version.

Formats:
This archetecture supports instructions in four different formats: J-format, 2 I-formats, and the
R-format. These are described below.

The J-format is used for jump instructions that need a large displacement.
J-Format
5 bits 11 bits
Op Code Displacement
Jump Instructions
The Jump instruction loads the PC with the value found by adding the PC of the next instruction
(PC+2, not PC+4 as in MIPS) to the sign-extended displacement.
The Jump-And-Link instruction loads the PC with the same value and also saves the address of
the next sequential instruction (i.e., PC+2) in the link register R7.
The syntax of the jump instructions is:
● J displacement
● JAL displacement

I-format
I-format instructions use either a destination register, a source register, and a 5-bit immediate
value; or a destination register and an 8-bit immediate value. The two types of I-format
instructions are described below.
I-format 1 Instructions
I-format 1
5 bits 3 bits 3 bits 5 bits
Op Code Rs Rd Immediate
The I-format 1 instructions include XOR-Immediate, ANDN-Immediate, Add-Immediate,
Subtract-Immediate, Rotate-Left-Immediate, Shift-Left-Logical-Immediate,
Rotate-Right-Immediate, Shift-Right-Logical-Immediate, Load, Store, and Store with Update.
The ANDNI instruction loads register Rd with the value of the register Rs AND-ed with the one's
complement of the zero-extended immediate value. (It may be thought of as a bit-clear
instruction.) ADDI loads register Rd with the sum of the value of the register Rs plus the
sign-extended immediate value. SUBI loads register Rd with the result of subtracting register
Rs from the sign-extended immediate value. (That is, immed - Rs, not Rs - immed.) Similar
instructions have similar semantics, i.e. the logical instructions have zero-extended values and
the arithmetic instructions have sign-extended values.
For Load and Store instructions, the effective address of the operand to be read or written is
calculated by adding the value in register Rs with the sign-extended immediate value. The
value is loaded to or stored from register Rd. The STU instruction, Store with Update, acts like
Store but also writes Rs with the effective address.
The syntax of the I-format 1 instructions is:
● ADDI Rd, Rs, immediate
● SUBI Rd, Rs, immediate
● XORI Rd, Rs, immediate
● ANDNI Rd, Rs, immediate
● ROLI Rd, Rs, immediate
● SLLI Rd, Rs, immediate
● RORI Rd, Rs, immediate
● SRLI Rd, Rs, immediate
● ST Rd, Rs, immediate
● LD Rd, Rs, immediate
● STU Rd, Rs, immediate

I-format 2 Instructions
I-format 2
5 bits 3 bits 8 bits
Op Code Rs Immediate
The Load Byte Immediate instruction loads Rs with a sign-extended 8 bit immediate value.
The Shift-and-Load-Byte-Immediate instruction shifts Rs 8 bits to the left, and replaces the lower
8 bits with the immediate value.
The format of these instructions is:
● LBI Rs, signed immediate
● SLBI Rs, unsigned immediate
The Jump-Register instruction loads the PC with the value of register Rs + signed immediate.
The Jump-And-Link-Register instruction does the same and also saves the return address (i.e.,
the address of the JALR instruction plus one) in the link register R7. The format of these
instructions is
● JR Rs, immediate
● JALR Rs, immediate
●
The branch instructions test a general purpose register for some condition. The available
conditions are: equal to zero, not equal to zero, less than zero, and greater than or equal to
zero. If the condition holds, the signed immediate is added to the address of the next sequential
instruction and loaded into the PC. The format of the branch instructions is
● BEQZ Rs, signed immediate
● BNEZ Rs, signed immediate
● BLTZ Rs, signed immediate
● BGEZ Rs, signed immediate

R-format
R-format instructions use only registers for operands.
R-format
5 bits 3 bits 3 bits 3 bits 2 bits
Op Code Rs Rt Rd Op Code Extension
ALU and Shift Instructions
The ALU and shift R-format instrucions are similiar to I-format 1 instructions, but do not require
an immediate value. In each case, the value of Rt is used in place of the immediate. No
extension of its value is required. In the case of shift instructions, all but the 4
least-significant bits of Rt are ignored.
The ADD instruction performs signed addition. The SUB instruction subtracts Rs from Rt. (Not
Rs - Rt.) The set instructions SEQ, SLT, SLE instructions compare the values in Rs and Rt and
set the destination register Rd to 0x1 if the comparison is true, and 0x0 if the comparison is
false. SLT checks for Rs less than Rt, and SLE checks for Rs less than or equal to Rt. (Rs and
Rt are two's complement numbers.) The set instruction SCO will set Rd to 0x1 if Rs plus Rt
would generate a carry-out from the most significant bit; otherwise it sets Rd to 0x0. The
Bit-Reverse instruction, BTR, takes a single operand Rs and copies it to Rd, but with a left-right
reversal of each bit; i.e. bit 0 goes to bit 15, bit 1 goes to bit 14, etc.
The syntax of the R-format ALU and shift instructions is:
● ADD Rd, Rs, Rt
● SUB Rd, Rs, Rt
● ANDN Rd, Rs, Rt
● ROL Rd, Rs, Rt
● SLL Rd, Rs, Rt
● ROR Rd, Rs, Rt
● SRL Rd, Rs, Rt
● SEQ Rd, Rs, Rt
● SLT Rd, Rs, Rt
● SLE Rd, Rs, Rt
● SCO Rd, Rs, Rt
● BTR Rd, Rs

Special Instructions
Special instructions use the R-format. The HALT instruction halts the processor. The HALT
instruction and all older instructions execute normally, but the instruction after the halt will never
execute. The PC is left pointing to the instruction directly after the halt.
The No-operation instruction occupies a position in the pipeline, but does nothing.
The syntax of these instructions is:
● HALT
● NOP
The SIIC and RTI instructions are extra credit and can be deferred for later. They will be not
tested until the final demo.
The SIIC instruction is an illegal instruction and should trigger the exception handler. EPC
should be set to PC + 2, and control should be transferred to the exception handler which is at
PC 0x02.
The syntax of this instruction is:
● SIIC Rs
The source register name must be ignored. The syntax is specified this way with a dummy
source register, to reuse some components from our existing assembler. The RTI instruction
should remain equivalent to NOP until the rest of the design has been completed and
thoroughly tested.
RTI returns from an exception by loading the PC from the value in the EPC register.
The syntax of this instruction is:
● RTI




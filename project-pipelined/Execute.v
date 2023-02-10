// module Execute(clk,rst,ForwardA,ForwardB,PC_add2_in,PC_add2_out,Reg1_Data,Reg2_Data, Immediate_dec, ALUSRC, Rd_out, rd75,rd42,rs,rt,EXMEM_RegRd,MEMWB_RegRd, MEMWB_RegWrite,EXMEM_ALU_in, EXMEM_RegWrite,REGDST,ALUSRC,EXFLUSH,MEMWRITE_mem,MEMREAD_mem,MEMWRITE_dec,MEMREAD_dec, MEMTOREG_dec,MEMTOREG_mem,Instruction_dec,ZERO,REGWRITE_dec,REGWRITE_mem, ALU_operand2before,ALU_out,MEMWB_out);
// input clk,rst,MEMWB_RegWrite, EXMEM_RegWrite,ALUSRC,EXFLUSH,MEMWRITE_dec,MEMREAD_dec,MEMTOREG_dec,REGWRITE_dec;
// input [15:0] Reg1_Data, Reg2_Data, PC_add2_in,EXMEM_ALU_in, Instruction_dec,Immediate_dec, MEMWB_out;
// input [2:0] rd75, rd42,rs,rt, EXMEM_RegRd, MEMWB_RegRd;
// input [1:0] REGDST,ForwardA,ForwardB;
// output MEMWRITE_mem, MEMREAD_mem, MEMTOREG_mem, ZERO, REGWRITE_mem;
// output [15:0] ALU_operand2before,ALU_out,PC_add2_out;
// output [2:0]  Rd_out;

// wire [15:0] ALU_operand1,ALU_operand2;









module Execute(clk,
                     rst,
                     BRANCH_in,
                    BRANCH_AND_ZERO,
                     Reg1_Data,
                     Reg2_Data,
                    Immediate_in,
                     //.PC_add2_in(),
                     //.PC_add2_out(),
                     ALUSRC,
                     //.Rd_in(Rd_ex),
                     //.Rd_out(Rd_ex),
                     //.rd75(Rd75_ex),
                     //.rd42(Rd42_ex),
                     //.rs(Rs108_ex),
                     //.rt(Rt75_dec),
                     //.EXMEM_RegRd(),//
                     //.MEMWB_RegRd(),//
                     //.MEMWB_RegWrite(),//
                     EXMEM_ALU_in,
                     //.EXMEM_RegWrite(),//
                     //.ALUSRC(ALUSRC_ex),
                     //.EXFLUSH(),
                     Instruction_in,
                     //.ZERO(ZERO_out_execute),
                     ALU_operand2before,
                     ALU_out,
                     MEMWB_out,
                     ForwardA,
                     ForwardB
                     );
input clk,rst, ALUSRC, BRANCH_in;
input [1:0] ForwardA, ForwardB;
output BRANCH_AND_ZERO;
input [15:0] Reg1_Data, Reg2_Data, Instruction_in,Immediate_in,MEMWB_out,EXMEM_ALU_in;
output [15:0] ALU_operand2before, ALU_out;
wire [15:0] ALU_operand1, ALU_operand2;
wire ZERO;

assign BRANCH_AND_ZERO = ZERO & BRANCH_in;
unpipeline_alu aluUnit(.reg1(ALU_operand1),.reg2(ALU_operand2),.out(ALU_out),.Zero(ZERO),.Instruction(Instruction_in));
assign ALU_operand2 = (ALUSRC) ? Immediate_in : ALU_operand2before;
assign ALU_operand1 = (ForwardA[1]) ? (ForwardA[0]) ? 16'h0000 : EXMEM_ALU_in : (ForwardA[0]) ? MEMWB_out: Reg1_Data ;
assign ALU_operand2before = (ForwardB[1]) ? (ForwardB[0]) ? 16'h0000 : EXMEM_ALU_in : (ForwardB[0]) ? MEMWB_out: Reg2_Data ;






endmodule

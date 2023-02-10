module EXMEMpip(PC_add2_in,MEMWRITE_ex,HALT_mem,Rd_mem,MEMREAD_mem,MEMWRITE_mem, REGWRITE_mem,TOWRITEDATA_mem, MEMTOREG_mem, JUMP_mem, BRANCH_mem, JALR_mem,PC_add2_out, ALU_out_mem, branchAddr_mem, ALU_operand2before_mem,Rd_ex,branchAddr_ex,ALU_out_ex, ALU_operand2before_ex,clk,rst,HALT_ex, MEMREAD_ex,REGWRITE_ex,TOWRITEDATA_ex,MEMTOREG_ex, JUMP_ex, BRANCH_ex, JALR_ex);

input [15:0] PC_add2_in,branchAddr_ex,ALU_out_ex, ALU_operand2before_ex;
input clk,rst,HALT_ex, MEMREAD_ex,REGWRITE_ex,TOWRITEDATA_ex,MEMTOREG_ex, MEMWRITE_ex,JUMP_ex, BRANCH_ex, JALR_ex;
input [2:0] Rd_ex;
output [15:0] PC_add2_out, ALU_out_mem, branchAddr_mem, ALU_operand2before_mem;
output HALT_mem,MEMREAD_mem,MEMWRITE_mem, REGWRITE_mem,TOWRITEDATA_mem, MEMTOREG_mem, JUMP_mem, BRANCH_mem, JALR_mem;
output [2:0] Rd_mem;


dff_pipe PC_plus_2[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(PC_add2_in), .q(PC_add2_out));
dff_pipe branchAddr[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(branchAddr_ex), .q(branchAddr_mem));
dff_pipe ALU_out[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(ALU_out_ex), .q(ALU_out_mem));
dff_pipe ALU_operand2[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(ALU_operand2before_ex), .q(ALU_operand2before_mem));
dff_pipe HALT( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(HALT_ex), .q(HALT_mem));
dff_pipe MEMREAD( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMREAD_ex), .q(MEMREAD_mem));
dff_pipe MEMWRITE( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMWRITE_ex), .q(MEMWRITE_mem));
dff_pipe REGWRITE( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(REGWRITE_ex), .q(REGWRITE_mem));
dff_pipe TOWRITEDATA( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(TOWRITEDATA_ex), .q(TOWRITEDATA_mem));
dff_pipe MEMTOREG( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMTOREG_ex), .q(MEMTOREG_mem));
dff_pipe JUMP( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(JUMP_ex), .q(JUMP_mem));
dff_pipe BRANCH( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(BRANCH_ex), .q(BRANCH_mem));
dff_pipe JALR( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(JALR_ex), .q(JALR_mem));
dff_pipe rd[2:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Rd_ex), .q(Rd_mem));











endmodule
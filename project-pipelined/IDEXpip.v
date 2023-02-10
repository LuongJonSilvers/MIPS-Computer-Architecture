module IDEXpip(clk, Rt7_5_dec, Rt7_5_ex, Rs10_8_dec, Rs10_8_ex,Rd_dec,Rd_ex,MEMREAD_ex,MEMTOREG_dec,MEMTOREG_ex, MEMWRITE_ex, REGWRITE_ex, BRANCH_dec,BRANCH_ex, TOWRITEDATA_ex, ALUSRC_ex, HALT_ex, JALR_ex, JUMP_ex,rst, MEMREAD_dec, MEMWRITE_dec, REGWRITE_dec, TOWRITEDATA_dec, ALUSRC_dec, HALT_dec, JALR_dec, JUMP_dec,Instruction_dec, PC_add2_dec,Immediate_dec,reg1_data_dec, reg2_data_dec, branchAddr_dec,Instruction_ex, PC_add2_ex, Immediate_ex, reg1_data_ex, reg2_data_ex, branchAddr_ex);
input [15:0] Instruction_dec, PC_add2_dec,Immediate_dec,reg1_data_dec, reg2_data_dec, branchAddr_dec;
output [15:0] Instruction_ex, PC_add2_ex, Immediate_ex, reg1_data_ex, reg2_data_ex, branchAddr_ex;
input clk, rst, MEMREAD_dec, MEMWRITE_dec,MEMTOREG_dec, REGWRITE_dec, TOWRITEDATA_dec, ALUSRC_dec, HALT_dec, JALR_dec, BRANCH_dec,JUMP_dec;
input [2:0] Rd_dec, Rt7_5_dec, Rs10_8_dec;
output MEMREAD_ex, MEMWRITE_ex, REGWRITE_ex, MEMTOREG_ex,TOWRITEDATA_ex, BRANCH_ex,ALUSRC_ex, HALT_ex, JALR_ex, JUMP_ex;
output [2:0] Rd_ex, Rt7_5_ex, Rs10_8_ex;

dff_pipe ins[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Instruction_dec), .q(Instruction_ex));

dff_pipe PC_plus_2[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(PC_add2_dec), .q(PC_add2_ex));

dff_pipe imm[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Immediate_dec), .q(Immediate_ex));

dff_pipe Rd[2:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Rd_dec), .q(Rd_ex));

dff_pipe MEMREAD( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMREAD_dec), .q(MEMREAD_ex));

dff_pipe MEMWRITE( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMWRITE_dec), .q(MEMWRITE_ex));

dff_pipe REGWRITE( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(REGWRITE_dec), .q(REGWRITE_ex));

dff_pipe TOWRITEDATA( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(TOWRITEDATA_dec), .q(TOWRITEDATA_ex));

dff_pipe MEMTOREG( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMTOREG_dec), .q(MEMTOREG_ex));

dff_pipe ALUSRC( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(ALUSRC_dec), .q(ALUSRC_ex));

dff_pipe REG1[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(reg1_data_dec), .q(reg1_data_ex));

dff_pipe REG2[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(reg2_data_dec), .q(reg2_data_ex));

dff_pipe HALT( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(HALT_dec), .q(HALT_ex));

dff_pipe JALR( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(JALR_dec), .q(JALR_ex));

dff_pipe JUMP( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(JUMP_dec), .q(JUMP_ex));

dff_pipe branch( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(BRANCH_dec), .q(BRANCH_ex));

dff_pipe BranchADDY[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(branchAddr_dec), .q(branchAddr_ex));

dff_pipe Rt75[2:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Rt7_5_dec), .q(Rt7_5_ex));

dff_pipe Rs108[2:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Rs10_8_dec), .q(Rs10_8_ex));






endmodule
module MEMWBpip(clk,rst, REGWRITE_mem,TOWRITEDATA_mem,MEMTOREG_mem, HALT_mem, JALR_mem, JUMP_mem, BRANCH_mem,alu_out_mem,pc_add2_mem,branchAddr_mem,memData_out_mem,Rd_mem,REGWRITE_wb,MEMTOREG_wb,HALT_wb,JALR_wb,JUMP_wb,BRANCH_wb,TOWRITEDATA_wb,Rd_wb,alu_out_wb, pc_add2_wb,memData_out_wb,branchAddr_wb);
input clk,rst, REGWRITE_mem,TOWRITEDATA_mem,MEMTOREG_mem, HALT_mem, JALR_mem, JUMP_mem, BRANCH_mem;
input [15:0] alu_out_mem,pc_add2_mem,branchAddr_mem,memData_out_mem;
input [2:0] Rd_mem;
output REGWRITE_wb,MEMTOREG_wb,HALT_wb,JALR_wb,JUMP_wb,BRANCH_wb,TOWRITEDATA_wb;
output [2:0] Rd_wb;
output [15:0] alu_out_wb, pc_add2_wb,memData_out_wb,branchAddr_wb;


dff_pipe Regwrite( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(REGWRITE_mem), .q(REGWRITE_wb));

dff_pipe towritedata( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(TOWRITEDATA_mem), .q(TOWRITEDATA_wb));

dff_pipe memtoreg( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(MEMTOREG_mem), .q(MEMTOREG_wb));


dff_pipe halt( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(HALT_mem), .q(HALT_wb));

dff_pipe jalr( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(JALR_mem), .q(JALR_wb));

dff_pipe jump( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(JUMP_mem), .q(JUMP_wb));

dff_pipe branch( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(BRANCH_mem), .q(BRANCH_wb));

dff_pipe branchAddr[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(branchAddr_mem), .q(branchAddr_wb));

dff_pipe pc_add2[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(pc_add2_mem), .q(pc_add2_wb));

dff_pipe alu[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(alu_out_mem), .q(alu_out_wb));

dff_pipe memdata[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(memData_out_mem), .q(memData_out_wb));

dff_pipe rd[2:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .d(Rd_mem), .q(Rd_wb));






endmodule
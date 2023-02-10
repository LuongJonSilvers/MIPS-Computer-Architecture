module Writeback(clk,rst,memData_in,alu_in,pc_add2_in,writeData_out,MEMTOREG,TOWRITEDATA);
input clk,rst, MEMTOREG, TOWRITEDATA;
input [15:0] memData_in, alu_in, pc_add2_in;
output [15:0] writeData_out;
wire [15:0] outData;

assign outData = MEMTOREG ? memData_in: alu_in;
assign writeData_out = MEMTOREG? pc_add2_in: outData;




endmodule
//WriteBackStage

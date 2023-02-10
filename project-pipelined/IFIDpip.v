module IFIDpip(clk,rst,instr_if,instr_id,pc_add2_if,pc_add2_id,stall);
input [15:0] instr_if,pc_add2_if;
output [15:0] pc_add2_id, instr_id;
input clk, rst,stall;

    dff_pipe instruction[15:0](.clk(clk), .rst(rst), .flush(1'b0), .stall(stall), .d(instr_if[15:0]), .q(instr_id[15:0]));

    dff_pipe PC[15:0](.clk(clk), .rst(rst), .flush(1'b0), .stall(stall), .d(pc_add2_if), .q(pc_add2_id));
    
endmodule

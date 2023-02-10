module Memory(clk,
                     rst,
                     ALU_in,
                     alu_operand2before,
                     MEMWRITE,
                     MEMREAD,
                     HALT,
                     memData_out
                     );
input clk,rst, MEMWRITE,MEMREAD,HALT;
input [15:0] ALU_in, alu_operand2before;
output [15:0]  memData_out;
wire en;
assign en = MEMREAD | MEMWRITE;

memory2c data_mem(.data_out(memData_out), .data_in(alu_operand2before), .addr(ALU_in), .enable(en), .wr(MEMWRITE), .createdump(HALT), .clk(clk), .rst(rst));




endmodule

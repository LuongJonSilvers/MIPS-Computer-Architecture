module bitReg16(clk,q,d,rst);
input clk, rst;
input [15:0] q;
output [15:0] d;


dff dff[15:0](.q(q),.d(d),.clk(clk),.rst(rst)); //create 16 bits 



endmodule

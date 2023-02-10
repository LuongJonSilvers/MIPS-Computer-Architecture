module zeroXtend70(in,out);
input [7:0] in;
output [15:0] out;

assign out = {{8{1'b0}},in[7:0]};


endmodule

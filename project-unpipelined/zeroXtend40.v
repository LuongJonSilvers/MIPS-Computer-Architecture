module zeroXtend40(in,out);
input [4:0] in;
output [15:0] out;

assign out = {{11{1'b0}},in[4:0]};


endmodule

module zeroXtend100(in,out);
input [10:0] in;
output [15:0] out;

assign out = {{5{1'b0}},in[10:0]};


endmodule

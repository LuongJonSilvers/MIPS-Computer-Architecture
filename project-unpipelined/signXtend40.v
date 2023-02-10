module signXtend40(in,out);
input [4:0] in;
output [15:0] out;

assign out = (in[4]) ? {{11{in[4]}},in[4:0]}: {{11{1'b0}},in[4:0]};


endmodule

module signXtend100(in,out);
input [10:0] in;
output [15:0] out;

assign out = (in[10]) ? {{5{in[10]}},in[10:0]}: {{5{1'b0}},in[10:0]};


endmodule

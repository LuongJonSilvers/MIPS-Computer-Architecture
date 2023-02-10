module dff_pipe (clk,rst,flush,stall,d,q);

input clk,rst,flush, stall,d;
output q;

dff ff(.clk(clk),.rst(rst | flush),.d(stall ? q : d), .q(q));

endmodule 
module unpipeline_fetch (clk, rst, err, instr,PC);

	input clk;
	input rst;
	output err;
	output [15:0] instr;
	//input enable;
	input [15:0] PC;
	
	//wire [15:0] PC, NextPC,immeAdd;
//wire garbage;
	// Your Code goes here
//assign err = 1'b0;

//bitReg16 PCcounter(.clk(clk),.rst(rst),.q(PC),.d(NextPC));
//fulladder16 fulladd(.A(PC),.B(immeAdd),.S(NextPC),.Cout(garbage));
memory2c memStruct(.data_out(instr), .data_in(), .addr(PC), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

//assign immeAdd= (enable)? (immed) : 16'd2;
endmodule

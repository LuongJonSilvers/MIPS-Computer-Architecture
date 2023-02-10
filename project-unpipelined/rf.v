/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel;
   input [2:0] read2regsel;
   input [2:0] writeregsel;
   input [15:0] writedata;
   input        write;

   output [15:0] read1data;
   output [15:0] read2data;
   output        err;
wire [15:0] inr [7:0];
wire [15:0] outr [7:0];





bitReg16 R0(.q(outr[0]),.d(inr[0]),.rst(rst),.clk(clk));
bitReg16 R1(.q(outr[1]),.d(inr[1]),.rst(rst),.clk(clk));
bitReg16 R2(.q(outr[2]),.d(inr[2]),.rst(rst),.clk(clk));
bitReg16 R3(.q(outr[3]),.d(inr[3]),.rst(rst),.clk(clk));
bitReg16 R4(.q(outr[4]),.d(inr[4]),.rst(rst),.clk(clk));
bitReg16 R5(.q(outr[5]),.d(inr[5]),.rst(rst),.clk(clk));
bitReg16 R6(.q(outr[6]),.d(inr[6]),.rst(rst),.clk(clk));
bitReg16 R7(.q(outr[7]),.d(inr[7]),.rst(rst),.clk(clk));

assign inr[0] = (writeregsel == 0) ? (write)? writedata: outr[0] : outr[0];
assign inr[1] = (writeregsel == 1) ? (write)? writedata: outr[1] : outr[1];
assign inr[2] = (writeregsel == 2) ? (write)? writedata: outr[2] : outr[2];
assign inr[3] = (writeregsel == 3) ? (write)? writedata: outr[3] : outr[3];
assign inr[4] = (writeregsel == 4) ? (write)? writedata: outr[4] : outr[4];
assign inr[5] = (writeregsel == 5) ? (write)? writedata: outr[5] : outr[5];
assign inr[6] = (writeregsel == 6) ? (write)? writedata: outr[6] : outr[6];
assign inr[7] = (writeregsel == 7) ? (write)? writedata: outr[7] : outr[7];


assign err = 1'b0;
assign read1data = outr[read1regsel];
assign read2data = outr[read2regsel];


endmodule 
// DUMMY LINE FOR REV CONTROL :1:

/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here */
   wire [15:0] Instruction, PC, NextPC,PC_add2,AfterPC_Adder,Write_DatatoRegFile,ImmeXtended_1L, garbage,AfterBranch,AfterBranch2,ImmeXtended,Write_DatafromMem,toWrite_Reg,SImmediate,ZImmediate;
wire [15:0] SImme40,SImme70,SImme100,ZImme40,ZImme70,ZImme100;
wire [15:0] Reg2IdExBefore,Reg2IdExAfter, ALU_output,MemReadData,Reg1IdEx;
wire [15:0] BJumpPC,JumpPC;
//CONTROL SIGNALS
	wire [1:0] REGDST, IMMCHOOSE;
	wire JUMP, BRANCH, MEMREADORWRITE, MEMREAD,MEMTOREG,MEMWRITE, ALUSRC, REGWRITE,SIGNORZERO,TOWRITEDATA,JALR,garbage2; 
//FROM ALU
	wire zeroCheck, HALT;

assign MEMREADORWRITE = MEMREAD | MEMWRITE;
memory2c InstrMemStruct(.data_out(Instruction), .data_in(), .addr(PC), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));
rf RegisterFile(.read1data(Reg1IdEx), .read2data(Reg2IdExBefore), .err(),.clk(clk), .rst(rst), .read1regsel(Instruction[10:8]), .read2regsel(Instruction[7:5]), .writeregsel(toWrite_Reg), .writedata(Write_DatatoRegFile), .write(REGWRITE));
bitReg16 PCcounter(.clk(clk),.rst(rst),.q(PC),.d(NextPC));
fulladder16 PCAdd2(.A(PC),.B(16'd2),.S(PC_add2),.Cin(1'b0),.Cout(garbage));
fulladder16 JumpAdd(.A(PC_add2),.B(BJumpPC),.S(JumpPC),.Cin(1'b0),.Cout(garbage));
fulladder16 BranchAdd(.A(PC_add2),.B(ImmeXtended_1L),.S(AfterPC_Adder),.Cin(1'b0),.Cout(garbage));
memory2c DataMemoryStruct(.data_out(MemReadData), .data_in(Reg2IdExBefore), .addr(ALU_output), .enable(MEMREADORWRITE), .wr(MEMWRITE), .createdump(1'b0), .clk(clk), .rst(rst));
alu_control control(.Instruction(Instruction[15:11]),.RegDst(REGDST),.Jump(JUMP),.Branch(BRANCH),.MemRead(MEMREAD),.MemToReg(MEMTOREG),.ALUop(garbage2),.MemWrite(MEMWRITE),.ALUsrc(ALUSRC),.RegWrite(REGWRITE),.SignOrZero(SIGNORZERO),.ImmChoose(IMMCHOOSE),.toWriteData(TOWRITEDATA),.Halt(HALT),.Jalr(JALR));
unpipeline_alu aluUnit(.reg1(Reg1IdEx),.reg2(Reg2IdExAfter),.out(ALU_output),.Zero(zeroCheck),.Instruction(Instruction[15:0]));


//sign and zero extensions
signXtend40 S40(.in(Instruction[4:0]),.out(SImme40));
signXtend70 S70(.in(Instruction[7:0]),.out(SImme70));
signXtend100 S100(.in(Instruction[10:0]),.out(SImme100));
zeroXtend40 Z40(.in(Instruction[4:0]),.out(ZImme40));
zeroXtend70 Z70(.in(Instruction[7:0]),.out(ZImme70));
zeroXtend100 Z100(.in(Instruction[10:0]),.out(ZImme100));



//shift instruction immediate by 1 and concatenate PC's 4 MSB to beginning
assign BJumpPC = {{5{Instruction[10]}},Instruction[10:0]};
assign BranchAnd = BRANCH & zeroCheck ;
assign AfterBranch2 = (JUMP) ? (JumpPC): AfterBranch; 
assign NextPC = (JALR) ? ALU_output : AfterBranch2;
//For Branch Mux
assign AfterBranch = (BranchAnd) ? AfterPC_Adder : PC_add2 ;
assign ImmeXtended_1L = {ImmeXtended[15:0]};
assign toWrite_Reg = (REGDST[1]) ?  (REGDST[0]) ? 3'b111 : Instruction[10:8] : (REGDST[0]) ? Instruction[4:2] : Instruction[7:5];
assign Write_DatatoRegFile = (TOWRITEDATA) ? PC_add2 : Write_DatafromMem;
assign Reg2IdExAfter = (ALUSRC) ? ImmeXtended : Reg2IdExBefore;
assign Write_DatafromMem = (MEMTOREG) ? MemReadData: ALU_output;
assign SImmediate = (IMMCHOOSE[1]) ? (IMMCHOOSE[0]) ? 16'h0000 : SImme100 : (IMMCHOOSE[0]) ? SImme70: SImme40 ;
assign ZImmediate = (IMMCHOOSE[1]) ? (IMMCHOOSE[0]) ? 16'h0000 : ZImme100 : (IMMCHOOSE[0]) ? ZImme70: ZImme40 ;




assign ImmeXtended = (SIGNORZERO) ? SImmediate: ZImmediate;




endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:

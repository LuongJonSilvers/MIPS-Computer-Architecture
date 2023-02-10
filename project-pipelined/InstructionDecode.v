module InstructionDecode(clk,
                           rst,
                           Reg1_dataOut,
                           Reg2_dataOut,
                           MEMWBRegRd,
                           ImmeXtended_out,
                           Rt7_5,
                           Rs10_8,
                           PC_add2,
                           Rd_out,
                           RegWrite_in,
                           Instruction,
                           branchAddr,
                           MEMWBOut,
                           JALR,
                           JUMP,
                           HALT,
                           BRANCH,
                           MEMREAD,
                           MEMTOREG,
                           ALUSRC,
                           MEMWRITE,
                           REGWRITE,
                           TOWRITEDATA,
                           siic,
                           rti,
                           epc);
input [15:0] PC_add2,Instruction,MEMWBOut;
input clk,rst,RegWrite_in;
input [2:0] MEMWBRegRd;
input [2:0] Rd_out; 
output [15:0] Reg1_dataOut,Reg2_dataOut,ImmeXtended_out,branchAddr,epc;
output [2:0] Rt7_5,Rs10_8;
output HALT,JALR,BRANCH,MEMREAD,MEMTOREG,ALUSRC,MEMWRITE,REGWRITE,TOWRITEDATA,JUMP,siic,rti;
assign Rt7_5 = Instruction[7:5];
assign Rs10_8 = Instruction[10:8];
wire SIGNORZERO;
wire [1:0] IMMCHOOSE,REGDST;
wire [15:0] Instr100S,Instr40S,Instr70S,Instr100Z,Instr40Z,Instr70Z,SImmediate,ZImmediate;
wire [2:0] Rt7_5,Rd7_5,Rd4_2,Rs10_8; 

rf RegFile(.read1data(Reg1_dataOut), .read2data(Reg2_dataOut), .err(),.clk(clk), .rst(rst), .read1regsel(Instruction[10:8]), .read2regsel(Instruction[7:5]), .writeregsel(MEMWBRegRd), .writedata(MEMWBOut), .write(RegWrite_in));
fulladder16 branchAdder(.A(PC_add2),.B(ImmeXtended_out),.S(branchAddr),.Cin(1'b0),.Cout());
alu_control controlunit(.Instruction(Instruction),.RegDst(REGDST),.Jump(JUMP),.Branch(BRANCH),.MemRead(MEMREAD),.MemToReg(MEMTOREG),.ALUop(),.MemWrite(MEMWRITE),.ALUsrc(ALUSRC),.RegWrite(REGWRITE),.SignOrZero(SIGNORZERO),.ImmChoose(IMMCHOOSE),.toWriteData(TOWRITEDATA),.Halt(HALT),.Jalr(JALR));

assign Rd_out = (REGDST[1]) ?  (REGDST[0]) ? 3'b111 : Rs10_8 : (REGDST[0]) ? Rd4_2 : Rd7_5;
    assign siic = (Instruction[15:11] == 5'b00010);

    assign rti = (Instruction[15:11] == 5'b00011);
    dff_pipe epc_ff[15:0]( .clk(clk), .rst(rst), .flush(1'b0), .stall(!siic), .d(PC_add2), .q(epc));



signXtend100 S100(.in(Instruction[10:0]),.out(Instr100S));
signXtend70 S70(.in(Instruction[7:0]),.out(Instr70S));
signXtend40 S40(.in(Instruction[4:0]),.out(Instr40S));
zeroXtend40 Z40(.in(Instruction[4:0]),.out(Instr40Z));
zeroXtend70 Z70(.in(Instruction[7:0]),.out(Instr70Z));
zeroXtend100 Z100(.in(Instruction[10:0]),.out(Instr100Z));

assign SImmediate = (IMMCHOOSE[1]) ? (IMMCHOOSE[0]) ? 16'h0000 : Instr100S : (IMMCHOOSE[0]) ? Instr70S: Instr40S ;
assign ZImmediate = (IMMCHOOSE[1]) ? (IMMCHOOSE[0]) ? 16'h0000 : Instr100Z : (IMMCHOOSE[0]) ? Instr70Z: Instr40Z ;
assign ImmeXtended_out = (SIGNORZERO) ? SImmediate: ZImmediate;

assign Rt7_5 = Instruction[7:5];
assign Rd7_5 = Instruction[7:5];
assign Rd4_2 = Instruction[4:2];
assign Rs10_8 = Instruction[10:8];


endmodule

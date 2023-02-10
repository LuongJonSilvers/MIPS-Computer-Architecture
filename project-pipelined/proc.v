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


wire stall_ifid, PC_stall,BRANCH_out_dec,BRANCH_ex,BRANCHZERO_ex,BRANCHZERO_mem,BRANCHZERO_wb,JUMP_out_dec,JUMP_mem,JUMP_wb,JALR_ex,JALR_mem,JALR_wb;
wire bypass,REGWRITE_ex,REGWRITE_mem,REGWRITE_wb,en_siic,en_rti, HALT_wb, JALR_out_dec,HALT_out_dec,MEMREAD_out_dec,MEMTOREG_out_dec,ALUSRC_out_dec;
wire MEMWRITE_out_dec,REGWRITE_out_dec,TOWRITEDATA_out_dec, MEMREAD_ex,MEMWRITE_ex,TOWRITEDATA_ex,MEMTOREG_ex,ALUSRC_ex,HALT_ex,JUMP_ex;
wire HALT_mem,MEMREAD_mem, MEMWRITE_mem, TOWRITEDATA_mem, MEMTOREG_mem, MEMTOREG_wb, TOWRITEDATA_wb;
wire [1:0] ForwardA,ForwardB;
wire [2:0] Rd_ex,Rd_mem, Rd_wb,Rd_dec; 
wire [15:0] Instruction_haz, Instruction_id,branchAddr_wb, ALU_wb, epc, pc_add2_if, Instruction_if,pc_add2_id, Reg1DataOut_dec,Reg2DataOut_dec, Immediate_dec,branchAddr_out_dec;
wire [15:0] WB_writeData,pc_add2_ex,Instruction_ex,Immediate_ex,Reg1DataOut_ex,Reg2DataOut_ex, branchAddr_ex, ALU_mem, ALU_operand2before_ex, ALU_ex, pc_add2_mem, branchAddr_mem;
wire [15:0] ALU_operand2before_mem, memData_mem, memData_wb, pc_add2_wb;


hazardDetection hazardDetectionUnit(.clk(clk),
                                    .rst(rst),
                                    .stall_ifid(stall_ifid),
                                    .Instruction_in(Instruction_haz),
                                    .Instruction_out(Instruction_id),
                                    .PC_stall(PC_stall),
                                    .BRANCH_dec(BRANCH_out_dec),
                                    .BRANCH_ex(BRANCH_ex),
                                    .BRANCHZERO_ex(BRANCHZERO_ex),
                                    .BRANCHZERO_mem(BRANCHZERO_mem),
                                    .BRANCHZERO_wb(BRANCHZERO_wb),
                                    .JUMP_dec(JUMP_out_dec),
                                    .JUMP_ex(JUMP_ex),
                                    .JUMP_mem(JUMP_mem),
                                    .JUMP_wb(JUMP_wb),
                                    .JALR_dec(JALR_out_dec),
                                    .JALR_ex(JALR_ex),
                                    .JALR_mem(JALR_mem),
                                    .JALR_wb(JALR_wb),
                                    .bypass(bypass),
                                    .write_reg_en_e(REGWRITE_ex),
                                    .write_reg_en_m(REGWRITE_mem),
                                    .write_reg_en_w(REGWRITE_wb),
                                    .write_reg_e(Rd_ex),
                                    .write_reg_m(Rd_mem),
                                    .write_reg_w(Rd_wb)               
                                    );

assign err = 1'b0;
//InstructionFetchStage
InstructionFetch fetchUnit(.clk(clk),
                           .rst(rst),
                           .siic(en_siic),
                           .rti(en_rti),
                           .branch(BRANCHZERO_wb),
                           .jump(JUMP_wb),
                           .jalr(JALR_wb),
                           .branchAddr(branchAddr_wb),
                           .jalrAddr(ALU_wb),
                           .epc(epc),
                           .pc_add2(pc_add2_if),
                           .instr(Instruction_if),
                           .stall(PC_stall),
                           .bypass(bypass),
                           .halt(HALT_wb)
                           );
//IFIDpipe
IFIDpip IFIDpipe(.clk(clk),
                  .rst(rst),
                  .instr_if(Instruction_if),
                  .instr_id(Instruction_haz),
                  .pc_add2_if(pc_add2_if),
                  .pc_add2_id(pc_add2_id),
                  .stall(stall_ifid));


//InstructionDecodeStage
InstructionDecode decodeUnit(.clk(clk),
                           .rst(rst),
                           .PC_add2(pc_add2_id),
                           .Reg1_dataOut(Reg1DataOut_dec),
                           .Reg2_dataOut(Reg2DataOut_dec),
                           .MEMWBRegRd(Rd_wb),
                           .ImmeXtended_out(Immediate_dec),
                           .Rt7_5(Rt75_dec),
                           .Rs10_8(Rs108_dec),
                           .Rd_out(Rd_dec),
                           .RegWrite_in(REGWRITE_wb),
                           .Instruction(Instruction_id),
                           .branchAddr(branchAddr_out_dec),
                           .MEMWBOut(WB_writeData),
                           .JALR(JALR_out_dec),
                           .JUMP(JUMP_out_dec),
                           .HALT(HALT_out_dec),
                           //.REGDST(REGDST_out_dec),
                           .BRANCH(BRANCH_out_dec),
                           .MEMREAD(MEMREAD_out_dec),
                           .MEMTOREG(MEMTOREG_out_dec),
                           .ALUSRC(ALUSRC_out_dec),
                           .MEMWRITE(MEMWRITE_out_dec),
                           .REGWRITE(REGWRITE_out_dec),
                           .TOWRITEDATA(TOWRITEDATA_out_dec),
                           //.IdExRegRd(),
                           .siic(en_siic),
                           .rti(en_rti),
                           .epc(epc));

//IDEXpipe
IDEXpip IDEXpipe(.clk(clk),
                  .rst(rst),
                  .PC_add2_dec(pc_add2_id),
                  .PC_add2_ex(pc_add2_ex),
                  .Instruction_dec(Instruction_id),
                  .Instruction_ex(Instruction_ex),
                  .Immediate_dec(Immediate_dec),
                  .Immediate_ex(Immediate_ex),
                  .Rd_dec(Rd_dec),
                  .Rd_ex(Rd_ex),
                  .Rt7_5_dec(Rt75_dec),
                  .Rs10_8_dec(Rs108_dec),
                  .Rt7_5_ex(Rt75_ex),
                  .Rs10_8_ex(Rs108_ex),
                  //.rt75_dec(Rt75_dec),
                  //.rt75_ex(Rt75_ex),
                  //.rd75_dec(Rd75_dec),
                  //.rd75_ex(Rd75_ex),
                  //.rd42_dec(Rd42_dec),
                  //.rd42_ex(Rd42_ex),
                  //.rs108_dec(Rs108_dec),
                  //.rs108_ex(Rs108_ex),
                  .MEMREAD_dec(MEMREAD_out_dec),
                  .MEMREAD_ex(MEMREAD_ex),
                  .MEMWRITE_dec(MEMWRITE_out_dec),
                  .MEMWRITE_ex(MEMWRITE_ex),
                  .REGWRITE_dec(REGWRITE_out_dec),
                  .REGWRITE_ex(REGWRITE_ex),
                  .TOWRITEDATA_dec(TOWRITEDATA_out_dec),
                  .TOWRITEDATA_ex(TOWRITEDATA_ex),
                  .MEMTOREG_dec(MEMTOREG_out_dec),
                  .MEMTOREG_ex(MEMTOREG_ex),
                  .ALUSRC_dec(ALUSRC_out_dec),
                  .ALUSRC_ex(ALUSRC_ex),
                  .reg1_data_dec(Reg1DataOut_dec),
                  .reg1_data_ex(Reg1DataOut_ex),
                  .reg2_data_dec(Reg2DataOut_dec),
                  .reg2_data_ex(Reg2DataOut_ex),
                  .HALT_dec(HALT_out_dec),
                  .HALT_ex(HALT_ex),
                  .JALR_dec(JALR_out_dec),
                  .JALR_ex(JALR_ex),
                  .JUMP_ex(JUMP_ex),
                  .JUMP_dec(JUMP_out_dec),
                  .BRANCH_dec(BRANCH_out_dec),
                  .BRANCH_ex(BRANCH_ex),
                  .branchAddr_dec(branchAddr_out_dec),
                  .branchAddr_ex(branchAddr_ex));
//ExecuteStage
Execute executeUnit(.clk(clk),
                     .rst(rst),
                     .BRANCH_in(BRANCH_ex),
                     .BRANCH_AND_ZERO(BRANCHZERO_ex),
                     .Reg1_Data(Reg1DataOut_ex),
                     .Reg2_Data(Reg2DataOut_ex),
                     .Immediate_in(Immediate_ex),
                     //.PC_add2_in(),
                     //.PC_add2_out(),
                     //.ALUSRC(ALUSRC_ex),
                     //.Rd_in(Rd_ex),
                     //.Rd_out(Rd_ex),
                     //.rd75(Rd75_ex),
                     //.rd42(Rd42_ex),
                     //.rs(Rs108_ex),
                     //.rt(Rt75_dec),
                     //.EXMEM_RegRd(),//
                     //.MEMWB_RegRd(),//
                     //.MEMWB_RegWrite(),//
                     .EXMEM_ALU_in(ALU_mem),
                     //.EXMEM_RegWrite(),//
                     .ALUSRC(ALUSRC_ex),
                     //.EXFLUSH(),
                     .Instruction_in(Instruction_ex),
                     //.ZERO(ZERO_out_execute),
                     .ALU_operand2before(ALU_operand2before_ex),
                     .ALU_out(ALU_ex),
                     .MEMWB_out(WB_writeData),
                     .ForwardA(ForwardA),
                     .ForwardB(ForwardB)
                     );


//EXMEMPipe
EXMEMpip EXMEMpipe(.clk(clk),
                     .rst(rst),
                     .PC_add2_in(pc_add2_ex),
                     .PC_add2_out(pc_add2_mem),
                     .HALT_ex(HALT_ex),
                     .HALT_mem(HALT_mem),
                     .MEMREAD_ex(MEMREAD_ex),
                     .MEMREAD_mem(MEMREAD_mem),
                     .MEMWRITE_mem(MEMWRITE_mem),
                     .MEMWRITE_ex(MEMWRITE_ex),
                     .REGWRITE_mem(REGWRITE_mem),
                     .REGWRITE_ex(REGWRITE_ex),
                     .TOWRITEDATA_mem(TOWRITEDATA_mem),
                     .TOWRITEDATA_ex(TOWRITEDATA_ex),
                     .MEMTOREG_mem(MEMTOREG_mem),
                     .MEMTOREG_ex(MEMTOREG_ex),
                     .Rd_ex(Rd_ex),
                     .Rd_mem(Rd_mem),
                     //.EXMEM_RegRd(EXMEM_RegRd),
                     .JUMP_ex(JUMP_ex),
                     .JUMP_mem(JUMP_mem),
                     .BRANCH_ex(BRANCHZERO_ex),
                     .BRANCH_mem(BRANCHZERO_mem),
                     //.ZERO_ex(ZERO_out_execute),
                     //.ZERO_mem(ZERO_mem),
                     .ALU_out_ex(ALU_ex),
                     .ALU_out_mem(ALU_mem),
                     .branchAddr_ex(branchAddr_ex),
                     .branchAddr_mem(branchAddr_mem),
                     .ALU_operand2before_ex(ALU_operand2before_ex),
                     .ALU_operand2before_mem(ALU_operand2before_mem),
                     .JALR_ex(JALR_ex),
                     .JALR_mem(JALR_mem));
//MemoryStage
Memory memoryUnit(.clk(clk),
                     .rst(rst),
                     .ALU_in(ALU_mem),
                     .alu_operand2before(ALU_operand2before_mem),
                     .MEMWRITE(MEMWRITE_mem),
                     .MEMREAD(MEMREAD_mem),
                     .HALT(HALT_mem),
                     .memData_out(memData_mem)
                     );
//MEMWBPipe
MEMWBpip MEMWBpipe(.clk(clk),
                  .rst(rst),
                  .REGWRITE_mem(REGWRITE_mem),
                  .REGWRITE_wb(REGWRITE_wb),
                  .memData_out_mem(memData_mem),
                  .memData_out_wb(memData_wb),
                  .alu_out_mem(ALU_mem),
                  .alu_out_wb(ALU_wb),
                  .pc_add2_mem(pc_add2_mem),
                  .pc_add2_wb(pc_add2_wb),
                  .TOWRITEDATA_mem(TOWRITEDATA_mem),
                  .TOWRITEDATA_wb(TOWRITEDATA_wb),
                  .MEMTOREG_mem(MEMTOREG_mem),
                  .MEMTOREG_wb(MEMTOREG_wb),
                  .Rd_mem(Rd_mem),
                  .Rd_wb(Rd_wb),
                  .HALT_mem(HALT_mem),
                  .HALT_wb(HALT_wb),
                  //.EXMEM_RegRd(EXMEM_RegRd),
                  //.MEMWB_RegRd(MEMWB_RegRd)
                  .JALR_mem(JALR_mem),
                  .JUMP_mem(JUMP_mem),
                  .BRANCH_mem(BRANCHZERO_mem),
                  .JALR_wb(JALR_wb),
                  .JUMP_wb(JUMP_wb),
                  .BRANCH_wb(BRANCHZERO_wb),
                  .branchAddr_wb(branchAddr_wb),
                  .branchAddr_mem(branchAddr_mem)
                  );
//WriteBackStage
Writeback writebackUnit(.clk(clk),
                           .rst(rst),
                           .memData_in(memData_wb),
                           .alu_in(ALU_wb),
                           .pc_add2_in(pc_add2_wb),
                           .writeData_out(WB_writeData),
                           .MEMTOREG(MEMTOREG_wb),
                           .TOWRITEDATA(TOWRITEDATA_wb)
                           );

forwardUnit forwardUnit(.clk(clk),.rst(rst),.ForwardA(ForwardA),.ForwardB(ForwardB),.EXMEM_RegWrite(REGWRITE_mem),.MEMWB_RegWrite(REGWRITE_wb), .MEMWB_RegRd(Rd_wb), .EXMEM_RegRd(Rd_mem), .IFIDrt(Rt75_ex), .IFIDrs(Rs108_ex));

endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:

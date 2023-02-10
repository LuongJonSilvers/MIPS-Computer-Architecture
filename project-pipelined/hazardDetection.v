module hazardDetection(clk,
                                    rst,
                                    stall_ifid,
                                    Instruction_in,
                                    Instruction_out,
                                    PC_stall,
                                    BRANCH_dec,
                                    BRANCH_ex,
                                    BRANCHZERO_ex,
                                    BRANCHZERO_wb,
                                    BRANCHZERO_mem,
                                    JUMP_dec,
                                    JUMP_ex,
                                    JUMP_mem,
                                    JUMP_wb,
                                    JALR_dec,
                                    JALR_ex,
                                    JALR_mem,
                                    JALR_wb,
                                    bypass,
                                    write_reg_en_e,
                                    write_reg_en_m,
                                    write_reg_en_w,
                                    write_reg_e,
                                    write_reg_m,
                                    write_reg_w
                                    );
input [15:0] Instruction_in;
input [2:0] write_reg_e, write_reg_m, write_reg_w;
input rst,clk, JUMP_dec, JUMP_ex, JUMP_mem, JUMP_wb,JALR_dec, JALR_mem, JALR_wb, JALR_ex, BRANCH_dec,BRANCH_ex, BRANCHZERO_ex, BRANCHZERO_mem, BRANCHZERO_wb, write_reg_en_e, write_reg_en_m, write_reg_en_w;
output [15:0] Instruction_out;
output PC_stall, bypass, stall_ifid;
wire j_haz, b_haz, nop, raw1, raw2, raw3;

    assign raw1 = write_reg_en_e & (Instruction_in[10:8] == write_reg_e | Instruction_in[7:5] == write_reg_e);
    assign raw2 = write_reg_en_m & (Instruction_in[10:8] == write_reg_m | Instruction_in[7:5] == write_reg_m);
    assign raw3 = write_reg_en_w & (Instruction_in[10:8] == write_reg_w | Instruction_in[7:5] == write_reg_w);

assign j_haz = JUMP_dec | JUMP_ex | JUMP_mem | JUMP_wb |JALR_dec | JALR_mem | JALR_wb | JALR_ex;
assign b_haz = BRANCH_dec | BRANCH_ex | BRANCHZERO_ex | BRANCHZERO_mem | BRANCHZERO_wb;
assign bypass = BRANCHZERO_wb | JUMP_wb | JALR_wb;
assign nop = raw1 | raw2 | raw3;
assign PC_stall =  b_haz | j_haz | nop;
assign stall_ifid =  b_haz | j_haz | nop;
dff jump_dff(.d(j_haz), .q(j_nop), .clk(clk), .rst(rst));
dff branch_dff(.d(b_haz), .q(b_nop), .clk(clk), .rst(rst));
assign Instruction_out = (b_nop | j_nop | nop)?  {5'b00001, Instruction_in[10:0]} : Instruction_in;
endmodule
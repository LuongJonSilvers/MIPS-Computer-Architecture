module InstructionFetch(clk,halt,rst,instr,pc_add2,rti,siic,epc,branch,branchAddr,jalr,jalrAddr,jump,stall,bypass);
input [15:0] epc, jalrAddr, branchAddr;
output [15:0] pc_add2, instr;
input clk, rst, halt,siic,rti,branch,jump,jalr,stall, bypass;

localparam zero = 16'b0000000000000000;
localparam two = 16'b0000000000000010;

wire [15:0] add_val,pc_siic,pc_siic_epc,PCff_in,PCff_out,instr_mem_out;
assign add_val = halt? zero : two;
assign pc_siic = (siic) ? 16'h0002 : PCff_out;
assign pc_siic_epc = (rti) ? epc : pc_siic;
assign PCff_in = (jump | branch) ? branchAddr
                    :(jalr)? jalrAddr
                    : pc_add2;

dff_pipe PC[15:0](.clk(clk), .rst(rst), .flush(1'b0), .stall(stall & !bypass),.d(PCff_in), .q(PCff_out));

memory2c instr_memory(.data_out(instr_mem_out), .data_in(), .addr(pc_siic_epc), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));
fulladder16 PCadder(.A(pc_siic_epc),.B(add_val),.S(pc_add2),.Cin(1'b0),.Cout());
    

assign instr = rst ? 16'h0800 : instr_mem_out;    
endmodule

module forwardUnit(clk,rst,ForwardA,ForwardB,EXMEM_RegWrite, MEMWB_RegWrite, MEMWB_RegRd, EXMEM_RegRd, IFIDrt, IFIDrs);
input clk,rst;
input EXMEM_RegWrite, MEMWB_RegWrite;
input [2:0] IFIDrt,IFIDrs, EXMEM_RegRd, MEMWB_RegRd;
output [1:0] ForwardA, ForwardB;

assign ForwardA[1] =  (EXMEM_RegWrite & EXMEM_RegRd != 0 & EXMEM_RegRd == IFIDrs)? 1'b1: 1'b0; 
assign ForwardB[1] =  (EXMEM_RegWrite & EXMEM_RegRd != 0 & EXMEM_RegRd == IFIDrt)? 1'b1: 1'b0;

assign ForwardA[0] = ((MEMWB_RegWrite & MEMWB_RegRd != 0) & ~(EXMEM_RegWrite & EXMEM_RegRd != 0 & EXMEM_RegRd != IFIDrs) & (MEMWB_RegRd == IFIDrs)) ? 1'b1:1'b0 ;
assign ForwardB[0] = (MEMWB_RegWrite & MEMWB_RegRd != 0 & ~(EXMEM_RegWrite & EXMEM_RegRd != 0 & EXMEM_RegRd != IFIDrt) & MEMWB_RegRd == IFIDrt) ? 1'b1:1'b0 ;


endmodule
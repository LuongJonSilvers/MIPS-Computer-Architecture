module unpipeline_alu(reg1,reg2,out,Zero,Instruction);
input [15:0] reg1,reg2,Instruction;
output reg [15:0] out;
//output reg [15:0] Rd;
      
output reg Zero;                   
wire carryIn;        
wire [15:0] btr, sum, subtracted, xored, anded_n, shifted;
wire Cout,Overflow;
wire RsEqualRt,RsLessRt,RsLessEqualRt,RsEqualZero,RsLessZero; //Condition checks
wire [3:0] shiftAmt;
reg [1:0] shiftOp;
wire [15:0] zero,garbage;
wire [16:0] reg1_signX, reg2_signX,diff;
assign fullones = 16'hffff;
assign shiftAmt = (Instruction[15:11]==5'b10010) ? 4'b1000 : reg2[3:0];
//assign shiftOpVariety = (Instruction[15:13] == 3'b101) ? Instruction[12:11] : Instruction[1:0];


//shiftopActual = (Instruction[15:11==10010])? shiftOp2 : shiftA
fulladder16 fulladd(.A(reg1),.B(reg2),.S(sum),.Cin(1'b0),.Cout(Cout));
fulladder16 fullsub(.A(reg2),.B(~reg1),.S(subtracted),.Cin(1'b1),.Cout(garbage)); //I - Rs
shifter shifterUnit(.In(reg1),.Cnt(shiftAmt),.Op(shiftOp),.Out(shifted));
assign xored = reg1 ^ reg2;
assign anded_n = reg1 & ~reg2;
assign reg2_signX = {{1{reg2[15]}},reg2};
assign reg1_signX = {{1{reg1[15]}},reg1};
assign diff = reg1_signX - reg2_signX;
assign RsEqualRt = (xored==16'h0000) ? 1'b1: 1'b0;//xore of two items yields 0 if they are equal
assign RsEqualZero = ((reg1 ^ 16'h0000)==16'h0000) ? 1'b1 : 1'b0; //xore of two items yields 0 if they are equal
assign RsLessEqualRt = (~(subtracted[15])) ? 1'b1 : 1'b0; //(Reg2 - Reg1)'s MSB would be 1 if RSGreaterRt want the opposite so negate it
assign RsLessZero = reg1[15] ? 1'b1 : 1'b0 ; //if the MSb of Reg1 is 1 then it is a negative number by rules of 2's complement does not include Overflow checks
//assign Overflow = (                          

assign btr = {reg1[0], reg1[1],reg1[2], reg1[3],reg1[4], reg1[5],reg1[6], reg1[7],reg1[8], reg1[9],reg1[10], reg1[11],reg1[12], reg1[13],reg1[14], reg1[15]};

always @ (*)
begin
   case(Instruction[15:11])
   5'b10010: shiftOp = 2'b01;
   default: 
   shiftOp = (Instruction[15:13] == 3'b101) ? Instruction[12:11] : Instruction[1:0];
   endcase
end

always @(*)
begin
   out = 1'b0;
   Zero = 1'b0; 
	case(Instruction[15:11])
        5'b01000:begin //ADDI Rd,Rs, immediate 	Rd <- Rs + I(sign ext.) 
            out = sum;
        end
        5'b01001:begin //SUBI Rd, Rs, immediate 	Rd <- I(sign ext.) - Rs 
            out = subtracted;
        end
        5'b01010:begin //XORI Rd, Rs, immediate 	Rd <- Rs XOR I(zero ext.) 
            out = xored;
        end
        5'b01011:begin //ANDNI Rd, Rs, immediate 	Rd <- Rs AND ~I(zero ext.) 
           out = anded_n;
        end
        5'b10100:begin //ROLI Rd, Rs, immediate 	Rd <- Rs <<(rotate) I(lowest 4 bits) 
           out = shifted;
        end
        5'b10101:begin //SLLI Rd, Rs, immediate 	Rd <- Rs << I(lowest 4 bits) 
           out = shifted;
        end
        5'b10101:begin //RORI Rd, Rs, immediate 	Rd <- Rs >>(rotate) I(lowest 4 bits) 
           out = shifted;
        end
        5'b10111:begin //SRLI Rd, Rs, immediate 	Rd <- Rs >> I(lowest 4 bits) 
           out = shifted;
        end
        5'b10000:begin //ST Rd, Rs, immediate 	Mem[Rs + I(sign ext.)] <- Rd 
           out = sum;
        end
        5'b10001:begin //LD Rd, Rs, immediate 	Rd <- Mem[Rs + I(sign ext.)] 
           out = sum;
        end
        5'b10011:begin //STU Rd, Rs, immediate 	Mem[Rs + I(sign ext.)] <- Rd Rs <- Rs + I(sign ext.) 
           out = sum;
        end
        5'b11011:begin //ADD Rd, Rs, Rt 	Rd <- Rs + Rt 
            case(Instruction[1:0])
               2'b00: out = reg1 + reg2;
               2'b01: out = subtracted;
               2'b10: out = xored;
               2'b11: out = anded_n;
               endcase
           //out = (Instruction[1]) ? (Instruction[0]) ? anded_n: xored: (Instruction[0]) ? subtracted: sum;
        end
        5'b11010:begin //ADD Rd, Rs, Rt 	Rd <- Rs + Rt 
         out = shifted;
        end
        5'b11100:begin //SEQ Rd, Rs, Rt 	if (Rs == Rt) then Rd <- 1 else Rd <- 0 
            out = (diff==17'd0) ? 16'h0001: 16'h0000;
        end
         5'b11001:begin //BTR
            out = btr;
        end
        5'b11101:begin //SLT Rd, Rs, Rt 	if (Rs < Rt) then Rd <- 1 else Rd <- 0 
            out = (diff[16]) ? 16'h0001: 16'h0000;
        end
        5'b11110:begin //SLE Rd, Rs, Rt 	if (Rs <= Rt) then Rd <- 1 else Rd <- 0 
            out = ((diff[16]) | (diff==17'd0)) ? 16'h0001: 16'h0000;
        end
        5'b11111:begin //SCO Rd, Rs, Rt 	if (Rs + Rt) generates carry out then Rd <- 1 else Rd <- 0 
           out = (Cout) ? 16'h0001: 16'h0000;
        end
        5'b01100:begin //BEQZ Rs, immediate 	if (Rs == 0) then PC <- PC + 2 + I(sign ext.) 
            out = 16'hxxxx;
            Zero = (RsEqualZero) ? 1'b1 : 1'b0;
        end
        5'b01101:begin //BNEZ Rs, immediate 	if (Rs != 0) then PC <- PC + 2 + I(sign ext.) 
            out = 16'hxxxx;
            Zero = (~(RsEqualZero)) ? 1'b1 : 1'b0;
        end
        5'b01110:begin //BLTZ Rs, immediate 	if (Rs < 0) then PC <- PC + 2 + I(sign ext.) 
            out = 16'hxxxx;
            Zero = (RsLessZero) ? 1'b1 : 1'b0;
        end
        5'b01111:begin //BGEZ Rs, immediate 	if (Rs >= 0) then PC <- PC + 2 + I(sign ext.) 
           out = 16'hxxxx;
            Zero = (~(RsLessZero)) ? 1'b1 : 1'b0;
        end
        5'b11000:begin //LBI Rs, immediate 	Rs <- I(sign ext.) 
            out = reg2;
        end
        5'b10010:begin //SLBI Rs, immediate 	Rs <- (Rs << 8) | I(zero ext.) 
            out = (shifted | reg2);
        end
        5'b00101:begin //JR Rs, immediate 	PC <- Rs + I(sign ext.) 
          out = sum;
        end
        5'b00111:begin //JALR Rs, immediate 	R7 <- PC + 2 PC <- Rs + I(sign ext.) 
           out = sum;
        end
















            


        

    endcase
end












endmodule
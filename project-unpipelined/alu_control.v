module alu_control(Instruction,RegDst,Jump,Branch,MemRead,MemToReg,ALUop,MemWrite,ALUsrc,RegWrite,SignOrZero,ImmChoose,toWriteData,Halt,Jalr);
output reg Jump,Branch,MemRead,ALUop,MemWrite,ALUsrc,RegWrite,SignOrZero,toWriteData,MemToReg,Halt,Jalr;
output reg [1:0] RegDst, ImmChoose;
input [4:0] Instruction;

always @(*)
begin
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'bx;
			Jalr = 1'b0;
	case(Instruction[4:0])
		5'b01000:begin //ADDI Rd, Rs, immediate 	Rd <- Rs + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01001: begin //SUBI Rd, Rs, immediate 	Rd <- I(sign ext.) - Rs 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01010: begin //XORI Rd, Rs, immediate 	Rd <- Rs XOR I(zero ext.) 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 1'b0;
			SignOrZero = 2'b00;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01011: begin //ANDNI Rd, Rs, immediate 	Rd <- Rs AND ~I(zero ext.) 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'b0;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10100: begin //ROLI Rd, Rs, immediate 	Rd <- Rs <<(rotate) I(lowest 4 bits) s
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10101: begin //SLLI Rd, Rs, immediate 	Rd <- Rs << I(lowest 4 bits) 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10110: begin //RORI Rd, Rs, immediate 	Rd <- Rs >>(rotate) I(lowest 4 bits) 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10111: begin //SRLI Rd, Rs, immediate 	Rd <- Rs >> I(lowest 4 bits) 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10000: begin //ST Rd, Rs, immediate 	Mem[Rs + I(sign ext.)] <- Rd 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b1;
			MemWrite = 1'b1;           
			ALUsrc = 1'b1;
			RegWrite = 1'b0;
			ImmChoose = 2'b00;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10001: begin //LD Rd, Rs, immediate 	Rd <- Mem[Rs + I(sign ext.)] 
			Halt = 1'b0;
			RegDst = 2'b00;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b1; 
			MemToReg = 1'b1;
			ALUop = 1'b1;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10011: begin //STU Rd, Rs, immediate 	Mem[Rs + I(sign ext.)] <- Rd Rs <- Rs + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'b10;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b1;
			MemWrite = 1'b1;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b00;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11011: begin //NEED LASt 2 bits for opcode
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11010: begin // Need Last 2 bits for opcode
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg =1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;       
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11100: begin // SEQ Rd, Rs, Rt 	if (Rs == Rt) then Rd <- 1 else Rd <- 0 
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11101: begin //SLT Rd, Rs, Rt 	if (Rs < Rt) then Rd <- 1 else Rd <- 0 
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11110: begin //SLE Rd, Rs, Rt 	if (Rs <= Rt) then Rd <- 1 else Rd <- 0 
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11111: begin //SCO Rd, Rs, Rt 	if (Rs + Rt) generates carry out then Rd <- 1 else Rd <- 0 
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01100: begin //BEQZ Rs, immediate 	if (Rs == 0) then PC <- PC + 2 + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01101: begin //BNEZ Rs, immediate 	if (Rs != 0) then PC <- PC + 2 + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01110: begin //BLTZ Rs, immediate 	if (Rs < 0) then PC <- PC + 2 + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b01111: begin //BGEZ Rs, immediate 	if (Rs >= 0) then PC <- PC + 2 + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b11000: begin //LBI Rs, immediate 	Rs <- I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'b10;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;    
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b10010: begin //SLBI Rs, immediate 	Rs <- (Rs << 8) | I(zero ext.) 
			Halt = 1'b0;
			RegDst = 2'b10;
			Jump = 1'b0;
			Branch = 1'b0; 
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b01;
			SignOrZero = 1'b0;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b00100: begin //J displacement 	PC <- PC + 2 + D(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b1;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'b10;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b00101: begin //JR Rs, immediate 	PC <- Rs + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b1;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'bx;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end
		5'b00110: begin //JAL displacement 	R7 <- PC + 2, PC <- PC + 2 + D(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'b11;
			Jump = 1'b1;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b1;
			ImmChoose = 2'b10;
			SignOrZero = 1'b1;
			toWriteData = 1'b1;
			Jalr = 1'b0;
		end
		5'b00111: begin //JALR Rs, immediate 	R7 <- PC + 2,PC <- Rs + I(sign ext.) 
			Halt = 1'b0;
			RegDst = 2'b11;
			Jump = 1'b1;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b1;
			RegWrite = 1'b1;
			ImmChoose = 2'b01;
			SignOrZero = 1'b1;
			toWriteData = 1'b1;
			Jalr = 1'b1;
		end
		5'b00000: begin //HALT Cease instruction issue, dump memory state to file 
			Halt = 1'b1;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'bx;
			Jalr = 1'b0;
		end
		5'b00001: begin //NOP 	None 
			Halt = 1'b0;
			RegDst = 2'bxx;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'bx;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'bx;
			RegWrite = 1'b0;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'bx;
			Jalr = 1'b0;
		end
		5'b11001: begin // BTR Rd, Rs 	Rd[bit i] <- Rs[bit 15-i] for i=0..15 
			Halt = 1'b0;
			RegDst = 2'b01;
			Jump = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0; 
			MemToReg = 1'b0;
			ALUop = 1'b0;
			MemWrite = 1'b0;           
			ALUsrc = 1'b0;
			RegWrite = 1'b1;
			ImmChoose = 2'bxx;
			SignOrZero = 1'bx;
			toWriteData = 1'b0;
			Jalr = 1'b0;
		end










	endcase
end










endmodule

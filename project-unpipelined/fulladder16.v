module fulladder16 (A,B,S,Cin,Cout);
input [15:0] A;
input [15:0] B;
input Cin;
output [15:0] S;
output Cout;

wire C12;
wire C23;
wire C34;

fulladder4 adder1 (.A(A[3:0]),.B(B[3:0]),.Cin(Cin),.S(S[3:0]),.Cout(C12));
fulladder4 adder2 (.A(A[7:4]),.B(B[7:4]),.Cin(C12),.S(S[7:4]),.Cout(C23));
fulladder4 adder3 (.A(A[11:8]),.B(B[11:8]),.Cin(C23),.S(S[11:8]),.Cout(C34));
fulladder4 adder4 (.A(A[15:12]),.B(B[15:12]),.Cin(C34),.S(S[15:12]),.Cout(Cout));










endmodule

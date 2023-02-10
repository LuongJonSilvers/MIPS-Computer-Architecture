module fulladder4 (A,B,Cin,S,Cout);
input [3:0] A;
input [3:0] B;
input Cin;
output [3:0] S;
output Cout;
wire C12;
wire C23;
wire C34;

fulladder1 adder1 (.A(A[0]),.B(B[0]),.Cin(Cin),.S(S[0]),.Cout(C12));
fulladder1 adder2 (.A(A[1]),.B(B[1]),.Cin(C12),.S(S[1]),.Cout(C23));
fulladder1 adder3 (.A(A[2]),.B(B[2]),.Cin(C23),.S(S[2]),.Cout(C34));
fulladder1 adder4 (.A(A[3]),.B(B[3]),.Cin(C34),.S(S[3]),.Cout(Cout));

endmodule 

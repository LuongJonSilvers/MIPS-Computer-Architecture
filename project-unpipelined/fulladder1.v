module fulladder1 (A,B,Cin,S,Cout);

input A;
input B;
input Cin;
output S;
output Cout;

assign S = (A ^ B) ^ Cin;

assign Cout = (A&B) | (B&Cin) | (Cin & A);



endmodule


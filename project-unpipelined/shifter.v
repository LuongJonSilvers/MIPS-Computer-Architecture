module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [1:0]  Op;
   output [15:0] Out;

   /*
   Your code goes here
   */
	
	wire [15:0] after8,after4,after2,after1;
	wire [15:0] after8andCnt,after4andCnt, after2andCnt, after1andCnt;

assign after8 = (Op==1) ? {In[7:0],8'b00000000} : 
		{Op==0} ? {In[7:0],In[15:8]} : 
		{Op==3} ? {8'b00000000,In[15:8]} : 
		{In[7:0],In[15:8]}; //
assign after8andCnt = Cnt[3] ? after8 : In[15:0];



assign after4 = (Op==1) ? {after8andCnt[11:0],4'b0000} : 
		{Op==0} ? {after8andCnt[11:0],after8andCnt[15:12]} : 
		{Op==3} ? {4'b0000,after8andCnt[15:4]} : 
		{after8andCnt[3:0],after8andCnt[15:4]};//
assign after4andCnt = Cnt[2] ? after4 : after8andCnt;



assign after2 = (Op==1) ? {after4andCnt[13:0],2'b00} : 
		{Op==0} ? {after4andCnt[13:0],after4andCnt[15:14]} : 
		{Op==3} ? {2'b00,after4andCnt[15:2]} : 
		{after4andCnt[1:0],after4andCnt[15:2]}; // 
assign after2andCnt = Cnt[1] ? after2 : after4andCnt;

assign after1 = (Op==1) ? {after2andCnt[14:0],1'b0} : //shift left logical 11
		{Op==0} ? {after2andCnt[14:0],after2andCnt[15]} : //rotate left 10
		{Op==3} ? {1'b0,after2andCnt[15:1]} :  //shift right logical 01
		{after2andCnt[0],after2andCnt[15:1]}; //rotate right 00
assign Out = Cnt[0] ? after1 : after2andCnt;



   
endmodule


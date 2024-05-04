module inv_single_round(state_in,state_out,key);
	input [127:0]state_in;
	input [127:0]key;
	output [127:0]state_out;
	
	wire [127:0]ISR; //output of Inverse Shift Rows
	wire [127:0] ISB; //output of Inverse Sub byte
	wire [127:0] IARK; // //output of add round key
	
	inv_shiftrows InvShfitRow(state_in, ISR);
	inv_sub_byte  InvSubByte(ISR,ISB);
	add_round_key ADD_KEY(ISB,key,IARK);
	inv_mix_column Inve_Col(IARK, state_out);
	
endmodule 
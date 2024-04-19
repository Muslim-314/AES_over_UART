module single_round(data_in,data_out,cr_key);
	input [127:0]data_in;
	input [127:0]cr_key; // key for the current round
	output [127:0]data_out;
	
	
	wire sb; //output of the substitute byte
	wire sr; //output of the shift row operation
	wire mc; //output of the mix column
	
	sub_byte s_b(data_in,sb);
	shift_rows s_r(sb,sr);
	Mix_column M_c(sr,mc);
	add_round_key ark(mc, key, data_out);
	
	
endmodule 
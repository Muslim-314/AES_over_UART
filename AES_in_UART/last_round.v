module last_round(data_in,data_out,cr_key);
	input [127:0]data_in;
	input [127:0]cr_key; // key for the current round
	output [127:0]data_out;
	
	wire [127:0]sb; //output of the substitute byte
	wire [127:0]sr; //output of the shift row operation
	
	sub_byte s_b(data_in,sb);
	shift_rows s_r(sb,sr);
	add_round_key ark(sr, cr_key, data_out);
	
	
endmodule 
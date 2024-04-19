module sub_byte(in_matrix, out_matrix);
	input [127:0] in_matrix;
	output[127:0] out_matrix;
	
	generate 
		genvar i;
		for( i = 0; i<=15 ; i = i+1)begin: Generate_Sbox
			sbox sb(in_matrix[(8*(i+1))-1:i*8] ,out_matrix[(8*(i+1))-1:i*8]);
		end
	endgenerate
	
endmodule	
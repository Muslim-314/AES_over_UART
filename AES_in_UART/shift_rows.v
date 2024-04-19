module shift_rows(in_matrix, out_matrix);
	input [127:0] in_matrix;
	output[127:0] out_matrix;
	
	//column 0
	assign out_matrix[7:0]     = in_matrix[7:0];
	assign out_matrix[15:8]    = in_matrix[47:40];
	assign out_matrix[23:16]   = in_matrix[87:80];
	assign out_matrix[31:24]   = in_matrix[127:120];
	//column 1
	assign out_matrix[39:32]   = in_matrix[39:32];
	assign out_matrix[47:40]   = in_matrix[79:72];
	assign out_matrix[55:48]   = in_matrix[119:112];
	assign out_matrix[63:56]   = in_matrix[31:24];
	//column 2
	assign out_matrix[71:64]   = in_matrix[71:64];
	assign out_matrix[79:72]   = in_matrix[111:104];
	assign out_matrix[87:80]   = in_matrix[23:16];
	assign out_matrix[95:88]   = in_matrix[63:56];
	//column 3
	assign out_matrix[103:96]   = in_matrix[103:96];
	assign out_matrix[111:104]  = in_matrix[15:8];
	assign out_matrix[119:112]  = in_matrix[35:48];
	assign out_matrix[127:120]  = in_matrix[95:88];
	
endmodule	
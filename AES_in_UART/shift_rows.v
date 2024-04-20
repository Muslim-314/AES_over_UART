module shift_rows(
    input [127:0] in_matrix,
    output reg [127:0] out_matrix
);

	always @* begin
	  out_matrix[127:120] = in_matrix[127:120];
	  out_matrix[119:112] = in_matrix[87:80];
	  out_matrix[111:104] = in_matrix[47:40];
	  out_matrix[103:96] =  in_matrix[7:0];
     	 
	  out_matrix[95:88] = in_matrix[95:88];
	  out_matrix[87:80] = in_matrix[55:48];
	  out_matrix[79:72] = in_matrix[15:8];
	  out_matrix[71:64] = in_matrix[103:96];
	 
	  out_matrix[63:56] = in_matrix[63:56];
	  out_matrix[55:48] = in_matrix[23:16];
	  out_matrix[47:40] = in_matrix[111:104];
	  out_matrix[39:32] = in_matrix[71:64];
	 
	  out_matrix[31:24] = in_matrix[31:24];
	  out_matrix[23:16] = in_matrix[119:112];
	  out_matrix[15:8] =  in_matrix[79:72];
	  out_matrix[7:0] = in_matrix[39:32];
	end

endmodule

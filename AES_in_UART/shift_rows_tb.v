module shift_rows_tb;
	reg [127:0]in_matrix;
	wire [127:0] out_matrix;
	shift_rows enc(in_matrix,out_matrix);
	initial begin
		in_matrix = 128'h0a0b030405050f0f090a0b0c0d0e0c00;
		#100;
	end
endmodule 
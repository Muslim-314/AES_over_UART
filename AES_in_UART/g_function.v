module g_function(w,w_prime,current_round);
	input [31:0] w;
	input [3:0] current_round;
	output[31:0]w_prime;
	wire [31:0] w_shifted,w_sboxed;
	reg [31:0]RC; //RC: round constant
	always@(*)begin
		case(current_round)
			1 : RC = 32'h01000000;
			2 : RC = 32'h02000000;
			3 : RC = 32'h04000000;
			4 : RC = 32'h08000000;
			5 : RC = 32'h10000000;
			6 : RC = 32'h20000000;
			7 : RC = 32'h40000000;
			8 : RC = 32'h80000000;
			9 : RC = 32'h1b000000;
		  10 : RC = 32'h36000000;
		endcase
	end
	
	assign w_shifted = {w[23:16],w[15:8],w[7:0],w[31:24]};
	//find the sbox value
	sbox sb1(w_shifted[31:24],w_sboxed[31:24]);
	sbox sb2(w_shifted[23:16],w_sboxed[23:16]);
	sbox sb3(w_shifted[15:8],w_sboxed[15:8]);
	sbox sb4(w_shifted[7:0],w_sboxed[7:0]);
	
	assign w_prime = w_sboxed ^ RC; 
	
endmodule 
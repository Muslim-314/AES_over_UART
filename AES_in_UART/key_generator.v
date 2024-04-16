module key_generator(
							key_text, 
							key_out,
							current_round);
							
	input [3:0]current_round;
	output reg [127:0]key_out;
	input  [127:0]key_text;
	wire [127:0]key_r0, key_r1, key_r2, key_r3;
	wire [127:0]key_r4, key_r5, key_r6, key_r7;
	wire [127:0]key_r8, key_r9, key_r10;
	wire [31:0]gout1,gout2,gout3,gout4,gout5,gout6,gout7,gout8,gout9,gout10;


	//round-0
	assign key_r0 = key_text;

	//round-1 (w4,w5,w6,w7)
	g_function g1(.w(key_r0[31:0]) , .w_prime(gout1),.current_round(1));
	assign key_r1[127:96] = gout1           ^  key_r0[127:96];
	assign key_r1[95:64]  = key_r1[127:96] ^  key_r0[95:64];
	assign key_r1[63:32]  = key_r1[95:64]  ^  key_r0[63:32];
	assign key_r1[31:0]  =  key_r1[63:32]  ^  key_r0[31:0];
	
	
	//round-2 (w8,w9,w10,w11)
	g_function g2(.w(key_r1[31:0]) , .w_prime(gout2),.current_round(2));
	assign key_r2[127:96] = gout2          ^  key_r1[127:96];
	assign key_r2[95:64]  = key_r2[127:96] ^  key_r1[95:64];
	assign key_r2[63:32]  = key_r2[95:64]  ^  key_r1[63:32];
	assign key_r2[31:0]  =  key_r2[63:32]  ^  key_r1[31:0];


	//round-3 (w12,w13,w14,w15)
	g_function g3(.w(key_r2[31:0]) , .w_prime(gout3), .current_round(3));
	assign key_r3[127:96] = gout3          ^  key_r2[127:96];
	assign key_r3[95:64]  = key_r3[127:96] ^  key_r2[95:64];
	assign key_r3[63:32]  = key_r3[95:64]  ^  key_r2[63:32];
	assign key_r3[31:0]  =  key_r3[63:32]  ^  key_r2[31:0];
	
	
	//round-4 (w16,w17,w18,w19)
	g_function g4(.w(key_r3[31:0]) , .w_prime(gout4), .current_round(4));
	assign key_r4[127:96] = gout4          ^  key_r3[127:96];
	assign key_r4[95:64]  = key_r4[127:96] ^  key_r3[95:64];
	assign key_r4[63:32]  = key_r4[95:64]  ^  key_r3[63:32];
	assign key_r4[31:0]  =  key_r4[63:32]  ^  key_r3[31:0];


	//round-5 (w20,w21,w22,w23)
	g_function g5(.w(key_r4[31:0]) , .w_prime(gout5), .current_round(5));
	assign key_r5[127:96] = gout5          ^  key_r4[127:96];
	assign key_r5[95:64]  = key_r5[127:96] ^  key_r4[95:64];
	assign key_r5[63:32]  = key_r5[95:64]  ^  key_r4[63:32];
	assign key_r5[31:0]  =  key_r5[63:32]  ^  key_r4[31:0];
	
	
	//round-6 (w24,w25,w26,w27)
	g_function g6(.w(key_r5[31:0]) , .w_prime(gout6), .current_round(6));
	assign key_r6[127:96] = gout6          ^  key_r5[127:96];
	assign key_r6[95:64]  = key_r6[127:96] ^  key_r5[95:64];
	assign key_r6[63:32]  = key_r6[95:64]  ^  key_r5[63:32];
	assign key_r6[31:0]  =  key_r6[63:32]  ^  key_r5[31:0];
	
	
	
	//round-7 (w28,w29,w30,w31)
	g_function g7(.w(key_r6[31:0]) , .w_prime(gout7), .current_round(7));
	assign key_r7[127:96] = gout7          ^  key_r6[127:96];
	assign key_r7[95:64]  = key_r7[127:96] ^  key_r6[95:64];
	assign key_r7[63:32]  = key_r7[95:64]  ^  key_r6[63:32];
	assign key_r7[31:0]  =  key_r7[63:32]  ^  key_r6[31:0];

	//round-8 (w32,w33,w34,w35)
	g_function g8(.w(key_r7[31:0]) , .w_prime(gout8), .current_round(8));
	assign key_r8[127:96] = gout8          ^  key_r7[127:96];
	assign key_r8[95:64]  = key_r8[127:96] ^  key_r7[95:64];
	assign key_r8[63:32]  = key_r8[95:64]  ^  key_r7[63:32];
	assign key_r8[31:0]  =  key_r8[63:32]  ^  key_r7[31:0];
	
	
	//round-9 (w36,w37,w38,w39)
	g_function g9(.w(key_r8[31:0]) , .w_prime(gout9), .current_round(9));
	assign key_r9[127:96] = gout9          ^  key_r8[127:96];
	assign key_r9[95:64]  = key_r9[127:96] ^  key_r8[95:64];
	assign key_r9[63:32]  = key_r9[95:64]  ^  key_r8[63:32];
	assign key_r9[31:0]  =  key_r9[63:32]  ^  key_r8[31:0];
	
	//round-10 (w40,w41,w42,w43)
	g_function g10(.w(key_r9[31:0]) , .w_prime(gout10), .current_round(10));
	assign key_r10[127:96] = gout10          ^  key_r9[127:96];
	assign key_r10[95:64]  = key_r10[127:96] ^  key_r9[95:64];
	assign key_r10[63:32]  = key_r10[95:64]  ^  key_r9[63:32];
	assign key_r10[31:0]  =  key_r10[63:32]  ^  key_r9[31:0];
	
	
	always@(*)begin
		case(current_round)
			0: key_out = key_r0;
			1: key_out = key_r1;
			2: key_out = key_r2;
			3: key_out = key_r3;
			4: key_out = key_r4;
			5: key_out = key_r5;
			6: key_out = key_r6;
			7: key_out = key_r7;
			8: key_out = key_r8;
			9: key_out = key_r9;
		  10: key_out = key_r10;
		endcase
		
	end
	
endmodule 
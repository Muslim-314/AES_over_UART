module encipher(plain_text,cipher_text);
	input [127:0] plain_text;
	output[127:0] cipher_text;
	
	
	/*----------------------
			KEY INPUT
	--------------------------*/
	wire [127:0] key_text;
	assign key_text = 128'h01020304050607080900900807060504;
	/*-------------------------------------------------------*/
	
	
	//round keys for each individual rounds kr0 is for first "add-round-key"
	wire [127:0] kr0,kr1,kr2,kr3,kr4,kr5,kr6,kr7,kr8,kr9,kr10; 
	
	//outputs for the each individual rounds - out_round0 is the output after first "add-round-key"
	wire [127:0]out_round0,out_round1,out_round2,out_round3,out_round4;
	wire [127:0]out_round5,out_round6,out_round7,out_round8,out_round9,out_round10;
	
	
	//round-0  post round
	key_generator kg0(key_text, kr0,4'd0);
	add_round_key add_r_k(plain_text, kr0,out_round0);
	
	//round-1
	key_generator kg1(key_text, kr1,4'd1);
	single_round sr1(out_round0,out_round1,kr1);
	
	//round-2
	key_generator kg2(key_text, kr2,4'd2);
	single_round sr2(out_round1,out_round2,kr2);
	
	//round-3
	key_generator kg3(key_text, kr3,4'd3);
	single_round sr3(out_round2,out_round3,kr3);
	
	//round-4
	key_generator kg4(key_text, kr4,4'd4);
	single_round sr4(out_round3,out_round4,kr4);
	
	//round-5
	key_generator kg5(key_text, kr5,4'd5);
	single_round sr5(out_round4,out_round5,kr5);
	
	//round-6
	key_generator kg6(key_text, kr6,4'd6);
	single_round sr6(out_round5,out_round6,kr6);

	//round-7
	key_generator kg7(key_text, kr7,4'd7);
	single_round sr7(out_round6,out_round7,kr7);

	//round-8
	key_generator kg8(key_text, kr8,4'd8);
	single_round sr8(out_round7,out_round8,kr8);	
	

	//round-9
	key_generator kg9(key_text, kr9,4'd9);
	single_round sr9(out_round8,out_round9,kr9);
	
	//last-round
	key_generator kg10(key_text, kr10,4'd10);
	last_round lr(out_round9,out_round10,kr10);
	
	assign cipher_text = out_round10; //cipher generated
	
	
endmodule 
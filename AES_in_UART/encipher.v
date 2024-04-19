module encipher(plain_text,cipher_text,key_text);
	input [127:0] plain_text;
	input [127:0] key_text;
	output[127:0] cipher_text;
	
	
	//round keys for each individual rounds kr0 is for first "add-round-key"
	wire [127:0] kr0,kr1,kr2,kr3,kr4,kr5,kr6,kr7,kr8,kr9,kr10; 
	
	//outputs for the each individual rounds - out_round0 is the output after first "add-round-key"
	wire [127:0]out_round0,out_round1,out_round2,out_round3,out_round4;
	wire [127:0]out_round5,out_round6,out_round7,out_round8,out_round9,out_round10;
	
	
	//round-0
	add_round_key add_r_k(plain_text, kr0,out_round0);
	
	//round-1
	single_round sr1(out_round0,out_round1,kr1);
	
	//round-2
	single_round sr2(out_round1,out_round2,kr2);
	
	//round-3
	single_round sr3(out_round2,out_round3,kr3);
	
	//round-4
	single_round sr4(out_round3,out_round4,kr4);
	
	//round-5
	single_round sr5(out_round4,out_round5,kr5);
	
	//round-6
	single_round sr6(out_round5,out_round6,kr6);

	//round-7
	single_round sr7(out_round6,out_round7,kr7);

	//round-8
	single_round sr8(out_round7,out_round8,kr8);	
	

	//round-9
	single_round sr9(out_round8,out_round9,kr9);
	
	//last-round
	last_round lr(out_round9,out_round10,kr10);
	
	assign cipher_text = out_round10; //cipher generated
	
	
endmodule 
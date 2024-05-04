module decipher(cipher_text,data);
	input [127:0]cipher_text;
	output [127:0]data;
	
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
	key_generator ikg0(key_text, kr0,4'd10);
	add_round_key iadd_r_k(cipher_text, kr0,out_round0);
	
	//round-1
	key_generator ikg1(key_text, kr1,4'd9);
	inv_single_round isr1(out_round0,out_round1,kr1);
	
	//round-2
	key_generator ikg2(key_text, kr2,4'd8);
	inv_single_round isr2(out_round1,out_round2,kr2);
	
	//round-3
	key_generator ikg3(key_text, kr3,4'd7);
	inv_single_round isr3(out_round2,out_round3,kr3);
	
	//round-4
	key_generator ikg4(key_text, kr4,4'd6);
	inv_single_round isr4(out_round3,out_round4,kr4);
	
	//round-5
	key_generator ikg5(key_text, kr5,4'd5);
	inv_single_round isr5(out_round4,out_round5,kr5);
	
	//round-6
	key_generator ikg6(key_text, kr6,4'd4);
	inv_single_round isr6(out_round5,out_round6,kr6);

	//round-7
	key_generator ikg7(key_text, kr7,4'd3);
	inv_single_round isr7(out_round6,out_round7,kr7);

	//round-8
	key_generator ikg8(key_text, kr8,4'd2);
	inv_single_round isr8(out_round7,out_round8,kr8);	
	
	//round-9
	key_generator ikg9(key_text, kr9,4'd1);
	inv_single_round isr9(out_round8,out_round9,kr9);
	
	//last-round
	key_generator ikg10(key_text, kr10,4'd0);
	inv_last_round ilr(out_round9,out_round10,kr10);
	
	assign data = out_round10; //data generated
endmodule 
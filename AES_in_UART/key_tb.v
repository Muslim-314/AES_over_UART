module key_tb;
	reg [127:0]key_text;
	wire [127:0]key_out;
	reg [3:0] current_round;
	key_generator kg1(key_text, key_out, current_round);
	initial begin
		key_text = 128'h01020304050607080900090807060504;
		current_round = 4'h1; #100;
		current_round = 4'h2; #100;
		current_round = 4'h3; #100;
		current_round = 4'h4; #100;
		current_round = 4'h5; #100;
		current_round = 4'h6; #100;
		current_round = 4'h7; #100;
		current_round = 4'h8; #100;
		current_round = 4'h9; #100;
		current_round = 4'ha; #100;
		$finish;
	end
	
endmodule 
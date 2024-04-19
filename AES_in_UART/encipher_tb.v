module encipher_tb;
	reg [127:0]plain_text;
	reg [127:0]key;
	wire [127:0] cipher;
	
	encipher enc(plain_text,cipher,key);
	
	initial begin
		key = 128'h0102030405060708090a0b0c0d0e0f00;
		plain_text = 128'h0a0b030405050f0f090a0b0c0d0e0c00;
	end
	

endmodule 
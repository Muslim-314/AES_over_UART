module encipher_tb;
	reg [127:0]plain_text;
	wire [127:0] cipher;
	encipher enc(plain_text,cipher);
	initial begin
		plain_text = 128'h0a0b030405050f0f090a0b0c0d0e0c00;
		#100;
	end
endmodule 
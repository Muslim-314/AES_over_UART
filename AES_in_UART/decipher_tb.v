module decipher_tb;
	reg [127:0]cipher_text;
	wire [127:0] data;
	decipher enc(cipher_text,data);
	initial begin
		cipher_text = 128'h355d23fc1fa6107a2f4f22646f5ac6b5;
		#100;
		$finish;
	end
endmodule 
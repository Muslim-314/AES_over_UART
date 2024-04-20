module add_round_key(data, key, out);
	input [127:0] data;
	input [127:0] key;
	output [127:0] out;
	assign out = key ^ data;
endmodule 
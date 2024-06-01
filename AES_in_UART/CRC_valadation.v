module CRC_valadation(input [127:0]data_with_crc,input En ,output [111:0]data, output data_valid);
	wire [15:0]crc_in;
	wire [15:0]crc_out;
	
	assign data = data_with_crc[127:16];
	assign crc_in = data_with_crc[15:0];
    CRC_MODULE crc_module (
        .data_in(data),
        .crc_en(En),
        .crc_out(crc_out)
    );
	assign data_valid = (crc_in == crc_out)? 1'b1 : 1'b0;
endmodule 
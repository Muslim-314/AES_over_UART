module TOP_Rx (
    input clk,
    input reset,
    input [7:0] serial_in,
    input crc_en,
    output valid,
	 output [111:0]data_out
);
    wire [127:0] sipo_data;
    wire sipo_full;
    wire [127:0] decipher_data;
    SIPO sipo (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parallel_out(sipo_data),
        .full(sipo_full)
    );
	 
    decipher decipher_inst (
        .cipher_text(sipo_data),
        .data(decipher_data)
    );
	 
	CRC_valadation CRC_VAL(.data_with_crc(decipher_data),
									.En(crc_en),
									.data(data_out), 
									.data_valid(valid)
									);	 
endmodule

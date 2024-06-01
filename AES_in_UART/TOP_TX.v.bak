module TOP_TX (
  input clk,
  input reset,
  input crc_en,
  input load,
  output [7:0] serial_out,
  output empty
);

  wire [127:0] data_in = 128'hDEADBEEFCAFEBABE1234567890ABCDEF;
  // Internal signals
  wire [15:0] crc_out;
  wire [127:0] padded_data;
  wire [127:0] enciphered_data;
  
  // Instantiate CRC_MODULE
  CRC_MODULE crc_inst (
    .data_in(data_in),
    .crc_en(crc_en),
    .crc_out(crc_out)
  );

  // Instantiate crc_padding
  crc_padding padding_inst (
    .data_in(data_in),
    .crc_in(crc_out),
    .tr_out(padded_data)
  );

  // Instantiate encipher
  encipher encipher_inst (
    .plain_text(padded_data),
    .cipher_text(enciphered_data)
  );

  // Instantiate PISO
  PISO piso_inst (
    .clk(clk),
    .reset(reset),
    .load(load),
    .parallel_in(enciphered_data),
    .serial_out(serial_out),
    .empty(empty)
  );

endmodule


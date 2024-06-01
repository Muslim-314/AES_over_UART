module TOP_TX (
  input clk,
  input start,
  input reset,
  output tx_out 
);
  wire [127:0] data_in = 128'hDEADBEEFCAFEBABE1234567890ABCDEF;
  
  wire [15:0]  crc_out;
  wire [127:0] padded_data;
  wire [127:0] enciphered_data;
  wire [7:0]   serial_out;
  wire [7:0]   UDR_OUT;     // Output of UDR register
  
  wire         PISO_empty;   // Flag for the empty state of PISO
  wire         Done;         // Asserted if the single 8-bit transaction is done
  wire         hold;         // Hold the data in PISO 
  wire         EnTx;         // Enable the UART Tx module
  wire         tx_start;     // Start the transaction
  wire         en_crc;       // Enable the CRC16 module
  wire         PISO_load;    // Load the computed message + CRC to the PISO
  wire         EN_UDR;       // Enable the UART DATA register
  wire         busy; 
  wire         PISO_reset;  
  
  // Clocks
  wire        rxclk;
  wire        txclk;
  
  controller controller_inst (
    .clk(clk),
    .reset(reset),
    .PISO_empty(PISO_empty),     
    .start(start),          
    .Done(Done),		
    .hold(hold),      
    .EnTx(EnTx),      
    .tx_start(tx_start),  
    .PISO_reset(PISO_reset),
    .en_crc(en_crc),    
    .PISO_load(PISO_load),  
    .EN_UDR(EN_UDR)     
  );
  
  // Instantiate CRC_MODULE
  CRC_MODULE crc_inst (
    .data_in(data_in),
    .crc_en(en_crc),
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
    .reset(PISO_reset || reset),
    .load(PISO_load),
    .hold(hold),
    .parallel_in(enciphered_data),
    .serial_out(serial_out),
    .empty(PISO_empty)
  );

  UDR UART_REG (
    .clk(clk),
    .reset(reset),
    .enable(EN_UDR),
    .data_in(serial_out),
    .data_out(UDR_OUT)
  );

  BaudRateGenerator BRG (
    .clk(clk), 
    .rxClk(rxclk), 
    .txClk(txclk) 
  );
  
  UART_Tx UTx (
    .clk(txclk),   // baud rate
    .en(EnTx),
    .start(tx_start), // start of transaction
    .in(UDR_OUT),    // data to transmit
    .out(tx_out),   // tx
    .done(Done),    // end of transaction
    .busy(busy)     // transaction is in process
  );
endmodule 

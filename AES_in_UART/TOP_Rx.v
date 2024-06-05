module TOP_Rx (
    input clk,
    input reset,
	 input tx_out, //recieved data from tx
    output valid,
	 output [111:0]data_out
);
    wire [127:0] sipo_data;        // Ouput of the SIPO memory 
    wire [127:0] decipher_data;    // Ouptut of Decryption Module 
	 wire [7:0]   serial_in;        // Data from UART to SIPO
	 
	 wire SIPO_full;
	 wire Done;
	 wire Wr;
	 wire EnRx;
	 wire crc_en;
	 wire SIPO_reset;
	 wire EnDec;
	 wire txclk;
	 wire rxclk;
	 wire busy;
	 wire err;
	 
   controller_rx CRX(
		.clk(clk),                   
		.full(SIPO_full),                  
		.Done(Done),                  
		.reset(reset),                 
		.tx_out(tx_out),               
		.Wr(Wr),               
		.EnRx(EnRx),            
		.En_valadation(crc_en),       
		.SIPO_reset(SIPO_reset),      
		.EnDec(EnDec)                 
    );
	 
    SIPO sipo (
        .clk(clk),
        .reset(SIPO_reset || reset),
		  .Wr(Wr),
        .serial_in(serial_in),
        .parallel_out(sipo_data),
        .full(SIPO_full)
    );
	 
    decipher decipher_inst (
        .cipher_text(sipo_data),
        .data(decipher_data)
    );
	 
	CRC_valadation CRC_VAL(
		.data_with_crc(decipher_data),
		.En(crc_en),
		.data(data_out), 
		.data_valid(valid)
	);	 
									
   BaudRateGenerator BRG_rx (
		 .clk(clk), 
		 .rxClk(rxclk), 
		 .txClk(txclk) 
	);
	
	UART_Rx URX(
    .clk(rxclk),  
    .en(EnRx),
    .in(tx_out), 
	 .busy(busy),  
	 .done(Done), 
	 .err(err),
    .out(serial_in)
    );
	 

endmodule

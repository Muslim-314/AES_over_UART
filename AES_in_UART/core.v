module core(
	input clk,
	input start,
	input reset,
	output valid,
	output [111:0]data_out
);
	wire tx_o;
	
  TOP_TX core_tx (
    .clk(clk), 
    .start(start), 
    .reset(reset), 
    .tx_out(tx_o)
  );
	
	TOP_Rx core_rx(
		 .clk(clk),
		 .reset(reset),
		 .tx_out(tx_o), //recieved data from tx
		 .valid(valid),
	    .data_out(data_out)
	);
endmodule 
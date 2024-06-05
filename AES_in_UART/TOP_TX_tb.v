`timescale 1ns / 1ps
module TOP_TX_tb;
  // Inputs
  reg clk;
  reg start;
  reg reset;
  // Outputs
  wire tx_out;
  // Instantiate the Unit Under Test (UUT)
  TOP_TX uut (
    .clk(clk), 
    .start(start), 
    .reset(reset), 
    .tx_out(tx_out)
  );
  // Clock generation
  initial begin
    clk = 0;
    forever #1 clk = ~clk; // 100MHz clock
  end
  // Test sequence
  initial begin
    // Initialize Inputs
    reset = 1;
	 start = 0;
	 #35000;
	 reset = 0;
	 start = 1;
	 #3000;
	 start = 0;	
    #1000000;		
    // End the simulation
    $finish;
  end

  // Monitor the output
  initial begin
    $monitor("Time: %0t, tx_out: %b", $time, tx_out);
  end

endmodule

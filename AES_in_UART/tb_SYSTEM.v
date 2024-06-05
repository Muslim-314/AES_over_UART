`timescale 1ns / 1ps

module tb_SYSTEM;
  // Inputs
  reg clk;
  reg start;
  reg reset;
  wire [111:0] data_out;
  wire valid;

  // Instantiate the SYSTEM module
  core uut (
    .clk(clk), 
    .reset(reset), 
    .start(start), 
    .valid(valid),
    .data_out(data_out)
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
    #50000000;      
    // End the simulation
    $finish;
  end

  // Monitor the output
  initial begin
    $monitor("Time: %0t, valid: %b, data_out: %b", $time, valid, data_out);
  end

endmodule

module TOP_TX_tb;
  // Inputs
  reg clk;
  reg reset;
  reg crc_en;
  reg load;
  // Outputs
  wire [7:0] serial_out;
  wire empty;

  // Instantiate the TOP_TX module
  TOP_TX uut (
    .clk(clk),
    .reset(reset),
    .crc_en(crc_en),
    .load(load),
    .serial_out(serial_out),
    .empty(empty)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    crc_en = 0;
    load = 0;
    #100;
    reset = 0;
    crc_en = 1;
    #20 load = 1; 
    #10 load = 0;
    #200;
    $finish;
  end



endmodule

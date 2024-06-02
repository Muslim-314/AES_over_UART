`timescale 1ns / 1ps

module Uart8Transmitter_tb;

// Testbench signals
reg clk;
reg en;
reg start;
reg [7:0] in;
wire out;
wire done;
wire busy;

// Instantiate the UART_Tx module
UART_Tx uut (
    .clk(clk),
    .en(en),
    .start(start),
    .in(in),
    .out(out),
    .done(done),
    .busy(busy)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Test procedure
initial begin
    // Initialize inputs
    en = 1;
    start = 0;
    in = 8'b0;

    // Wait for global reset
    #10;

    // Test case 1: Transmit 0x55 (01010101)
    in = 8'h55;
    start = 1;
    #10; // Apply start signal for one clock cycle
    start = 0;

    // Wait for transmission to complete
    wait (done);
    #10;

    // Test case 2: Transmit 0xA3 (10100011)
    in = 8'hA3;
    start = 1;
    #10; // Apply start signal for one clock cycle
    start = 0;

    // Wait for transmission to complete
    wait (done);
    #10;

    // Test case 3: Transmit 0xFF (11111111)
    in = 8'hFF;
    start = 1;
    #10; // Apply start signal for one clock cycle
    start = 0;

    // Wait for transmission to complete
    wait (done);
    #10;

    // End simulation
    $stop;
end

// Monitor the outputs
initial begin
    $monitor("Time: %0t | start: %b | in: %h | out: %b | done: %b | busy: %b", 
             $time, start, in, out, done, busy);
end

endmodule

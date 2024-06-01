`timescale 1ns / 1ps

module PISO_tb;
    // Inputs
    reg clk;
    reg reset;
    reg load;
    reg hold;
    reg [127:0] parallel_in;
    // Outputs
    wire [7:0] serial_out;
    wire empty;

    // Instantiate the Unit Under Test (UUT)
    PISO uut (
        .clk(clk), 
        .reset(reset), 
        .load(load), 
        .hold(hold), 
        .parallel_in(parallel_in), 
        .serial_out(serial_out), 
        .empty(empty)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus process
    initial begin
        // Initialize Inputs
        reset = 0;
        load = 0;
        hold = 1;
        parallel_in = 0;

        // Reset the design
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Load data into PISO
        parallel_in = 128'hFEDCBA9876543210_FEDCBA9876543210;
        load = 1;
        #10;
        load = 0;

       

        // Check empty signal
        if (empty !== 1) begin
            $display("Test failed: empty signal is not set after all data is shifted out.");
        end else begin
            $display("Test passed: empty signal is set correctly after all data is shifted out.");
        end

        $stop;
    end
      
endmodule

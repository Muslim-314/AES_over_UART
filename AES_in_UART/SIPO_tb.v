module SIO_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg [7:0] serial_in;
    wire [127:0] parallel_out;
    wire full;

    // Instantiate the module
    SIPO uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parallel_out(parallel_out),
        .full(full)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 100MHz clock
    end

    // Initial block for test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        serial_in = 8'b0;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Send serial data
        serial_in = 8'h01; #10;
        serial_in = 8'h23; #10;
        serial_in = 8'h45; #10;
        serial_in = 8'h67; #10;
        serial_in = 8'h89; #10;
        serial_in = 8'hAB; #10;
        serial_in = 8'hCD; #10;
        serial_in = 8'hEF; #10;
        serial_in = 8'hFE; #10;
        serial_in = 8'hDC; #10;
        serial_in = 8'hBA; #10;
        serial_in = 8'h98; #10;
        serial_in = 8'h76; #10;
        serial_in = 8'h54; #10;
        serial_in = 8'h32; #10;
        serial_in = 8'h10; #10;

        // Wait for full signal to be asserted
        wait(full);
        #10;

        // Finish the simulation
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t, Serial In: %0h, Parallel Out: %032h, Full: %b", $time, serial_in, parallel_out, full);
    end

endmodule

module tb_SIPO;

    reg clk;
    reg reset;
    reg Wr;
    reg [7:0] serial_in;
    wire [127:0] parallel_out;
    wire full;

    // Instantiate the SIPO module
    SIPO uut (
        .clk(clk),
        .reset(reset),
        .Wr(Wr),
        .serial_in(serial_in),
        .parallel_out(parallel_out),
        .full(full)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;
        Wr = 0;
        serial_in = 8'b0;

        // Apply reset
        #10 reset = 0;

        // Start writing data
        repeat (16) begin
            @(posedge clk);
            Wr = ~Wr;
            serial_in = $random;
        end

        @(posedge clk);
        Wr = 0;

        // Wait for some time to check the full signal
        #20;

        // Check results
        if (full == 1'b1 && parallel_out != 128'b0) begin
            $display("Test Passed!");
        end else begin
            $display("Test Failed!");
        end

        // Finish simulation
        $finish;
    end

endmodule

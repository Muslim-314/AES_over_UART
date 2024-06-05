`timescale 1ns / 1ps

module tb_UART_Rx;

    // Testbench signals
    reg clk;
    reg en;
    reg in;
    wire [7:0] out;
    wire done;
    wire busy;
    wire err;

    // Instantiate the UART_Rx module
    UART_Rx uart_rx (
        .clk(clk),
        .en(en),
        .in(in),
        .out(out),
        .done(done),
        .busy(busy),
        .err(err)
    );

    // Clock generation: 100 MHz clock for simulation purposes
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period (100 MHz)
    end

    // Test vectors
    initial begin
        // Initialize inputs
        en = 0;
        in = 1;

        // Apply reset
        #10 en = 1;

        // Wait for RESET state
        #100;

        // Transmit a byte (0x55 = 8'b01010101)
        // Start bit (0), 8 data bits, and stop bit (1)
        #10 send_byte(8'h55);

        // Wait for some time
        #200;

        // Transmit another byte (0xA3 = 8'b10100011)
        // Start bit (0), 8 data bits, and stop bit (1)
        #10 send_byte(8'hA3);

        // Wait for some time
        #200;

        // Test for error condition
        // Start bit (0), 8 data bits (0xFF), missing stop bit (0)
        #10 send_byte_with_error(8'hFF);

        // Wait for some time
        #200;

        // Disable UART
        en = 0;

        // Finish simulation
        #100 $finish;
    end

    // Task to send a byte (start bit, 8 data bits, stop bit)
    task send_byte;
        input [7:0] data;
        integer i;
        begin
            // Send start bit
            in = 0;
            #160; // 16 clock cycles for oversampling

            // Send data bits
            for (i = 0; i < 8; i = i + 1) begin
                in = data[i];
                #160; // 16 clock cycles for oversampling
            end

            // Send stop bit
            in = 1;
            #160; // 16 clock cycles for oversampling
        end
    endtask

    // Task to send a byte with error (start bit, 8 data bits, missing stop bit)
    task send_byte_with_error;
        input [7:0] data;
        integer i;
        begin
            // Send start bit
            in = 0;
            #160; // 16 clock cycles for oversampling

            // Send data bits
            for (i = 0; i < 8; i = i + 1) begin
                in = data[i];
                #160; // 16 clock cycles for oversampling
            end

            // Missing stop bit
            in = 0;
            #160; // 16 clock cycles for oversampling
        end
    endtask

    // Monitor signals
    initial begin
        $monitor("Time: %d, in: %b, out: %h, done: %b, busy: %b, err: %b", $time, in, out, done, busy, err);
    end

endmodule

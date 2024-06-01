module tb_TOP_Rx;
    reg clk;
    reg reset;
    reg [7:0] serial_in;
    reg crc_en;
    wire valid;
    wire [111:0] data_out;

    // Instantiate the module under test
    TOP_Rx uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .crc_en(crc_en),
        .valid(valid),
        .data_out(data_out)
    );

    
    always #5 clk = ~clk; 

    initial begin
        clk = 0;
        reset = 1;
        serial_in = 8'd0;
        crc_en = 0;
        #10;
        reset = 0;
        #10;
        reset = 1;
        send_serial_data(128'h1d5a6621527f5b226bf0e97205a66a71);
        #20;
        crc_en = 1;
        #100;
        $finish;
    end
    task send_serial_data(input [127:0] data);
        integer i;
        begin
            for (i = 15; i >= 0; i = i - 1) begin
                serial_in = data[i*8 +: 8];
                #10; // Wait for one clock cycle
            end
        end
    endtask

endmodule

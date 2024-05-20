module PISO_tb;
    reg clk;
    reg reset;
    reg load;
    reg [127:0] parallel_in;
    wire [7:0] serial_out;
    wire empty;
    PISO uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out),
        .empty(empty)
    );
    always begin
        #5 clk = ~clk;  
    end
    initial begin
        clk = 0;
        reset = 0;
        load = 0;
        parallel_in = 128'h0;
        reset = 1;
        #10;
        reset = 0;
        #10;
        parallel_in = 128'h0123456789ABCDEF_FEDCBA9876543210;
        load = 1;
        #10;
        load = 0;
        #1000;
    end
endmodule

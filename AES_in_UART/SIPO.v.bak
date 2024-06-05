module SIPO (
    input clk,
    input reset,
    input [7:0] serial_in,
    output reg [127:0] parallel_out,
    output reg full
);

    reg [3:0] count;  // 4-bit counter to count 16 shifts (128/8 = 16)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            parallel_out <= 128'b0;
            count <= 4'd0;
            full <= 1'b0;
        end else begin
            if (!full) begin
                parallel_out <= {parallel_out[119:0], serial_in};
                count <= count + 4'd1;
                if (count == 4'd15) begin
                    full <= 1'b1;
                end
            end
        end
    end

endmodule

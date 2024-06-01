module PISO (
	 input clk,
    input reset,
    input load,
	 input hold,
    input [127:0] parallel_in,
    output reg [7:0] serial_out,
    output reg empty
);
    reg [127:0] shift_reg;
    reg [3:0] count;  // 4-bit counter to count 16 shifts (128/8 = 16)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 128'b0;
            count <= 4'd0;
            serial_out <= 8'b0;
            empty <= 1'b1;
        end else if (load) begin
            shift_reg <= parallel_in;
            count <= 4'd0;
            empty <= 1'b0;
        end else if (!empty && !hold) begin
            serial_out <= shift_reg[127:120];
            shift_reg <= {shift_reg[119:0], 8'b0};
            count <= count + 4'd1;
            if (count == 4'd15) begin
                empty <= 1'b1;
            end
        end
    end
endmodule

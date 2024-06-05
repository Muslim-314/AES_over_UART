module controller_rx(
	input clk,                   //Golbal Clock 
	input full,                  //SIPO Full signal
	input Done,                  //Asserted when the single Uart packet is recieved
	input reset,                 //Global Reset
	input tx_out,                //Recieved seral data
	output reg Wr,               //SIPO Write Enable 
	output reg EnRx,             //Uart Reciever ENable
	output reg En_valadation,    //CRC valadation Enable
	output reg SIPO_reset,       //SIPO reset signal
	output reg EnDec             //Decryption module
);
 
 
	//states 
	localparam START_RX    = 3'b000;
	localparam SIPO_WRITE  = 3'b001;
	localparam WAIT_UNDONE = 3'b010;
   localparam EN_COMB     = 3'b011; //enables the combinational logic which inculdes Decryption and CRC valadation
	localparam IDEL        = 3'b100;
	
	reg [2:0]state;
	
	
	always@(posedge clk)begin
		case(state)
			START_RX: begin
				Wr            <= 0;
				EnRx          <= 1;
				En_valadation <= 1;
				SIPO_reset    <= 0;
				EnDec         <= 0;
				state         <= (Done)? SIPO_WRITE : START_RX;
			end
			SIPO_WRITE: begin
				Wr            <= 1;
				EnRx          <= 1;
				En_valadation <= 1;
				SIPO_reset    <= 0;
				EnDec         <= 0;
				state         <= (full)? EN_COMB : WAIT_UNDONE;
			end
			WAIT_UNDONE: begin
				Wr            <= 0;
				EnRx          <= 1;
				En_valadation <= 1;
				SIPO_reset    <= 0;
				EnDec         <= 0;
				state         <= (!Done) ? START_RX : WAIT_UNDONE;
			end
			EN_COMB: begin
				Wr            <= 0;
				EnRx          <= 0;
				En_valadation <= 1;
				SIPO_reset    <= 0;
				EnDec         <= 1;
				state         <= IDEL;https://github.com/TimRudy/uart-verilog?tab=readme-ov-file
			end
			IDEL: begin
				Wr            <= 0;
				EnRx          <= 0;
				En_valadation <= 1;
				SIPO_reset    <= 0;
				EnDec         <= 1;
				state         <= (!tx_out)? START_RX : IDEL;    //tx_out = 0 is the indication of start bit
			end
			default: state   <= IDEL;
		endcase
	end
endmodule 
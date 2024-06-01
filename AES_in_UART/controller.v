module controller(
	input clk,            //global clock signal
	input PISO_empty,     //Indicates if the SIPO is empty or not
	input start,          //Assert when want to start the FSM
	input Done,			    //Indicates if the current ttransaction is done or not
	output reg hold,       //Hold the data at the SIPO untill the current transaction is done
	output reg EnTx,      //Enable the UART Tx module
	output reg tx_start,  //Start the transaction
	output reg PISO_reset,//Reset signal for the parallel to serial converter
	output reg en_crc,    //enable the CRC16 module
	output reg PISO_load, //load the computed meaasge+CRC to the SIPO 
	output reg EN_UDR     //enable the Uart DATA  register
);
	//state 
	localparam RESET         =   3'b000;
	localparam LOAD          =   3'b001;
	localparam LoadByteToUDR =   3'b010;
	localparam START_UART_Tx =   3'b011;
	localparam CHECK_EMPTY   =   3'b100;
	localparam IDEL          =   3'b101;
	reg  [2:0] state;
	
	always@ (posedge clk)begin
		case(state)
			RESET: begin
				PISO_reset <= 1'b1;
				hold       <= 1'b1;
				EnTx       <= 1'b0;
				tx_start   <= 1'b0;
				state      <= (start) ?  LOAD : IDEL; 
			  end
			LOAD: begin
				PISO_load  <= 1'b1;
				state      <= LoadByteToUDR;
			  end
		   LoadByteToUDR: begin  //enable the UDR and load a byte for transmission
			   PISO_load  <= 1'b0;
			   EN_UDR     <= 1'b1;  
			   hold       <= 1'b0;
				state      <= START_UART_Tx;
			  end 
			START_UART_Tx: begin   
			   hold       <= 1'b1;
				EnTx       <= 1'b1;
				EN_UDR     <= 1'b0; 
				tx_start   <= 1'b1;
				state      <= (Done) ? CHECK_EMPTY : START_UART_Tx;
			  end
			CHECK_EMPTY: begin
				tx_start   <= 1'b0;
			   state      <= (PISO_empty)? IDEL : LoadByteToUDR;
			  end
			IDEL: begin
				hold       <= 1'b1;
				EnTx       <= 1'b0;
				tx_start   <= 1'b0;
				state      <= start ? LOAD : IDEL;
			 end
			default: begin
				state      <= IDEL;
			 end
		endcase
	end
endmodule 
module crc_padding(data_in , crc_in , tr_out);

input [111:0] data_in; //message //
input [15:0]  crc_in;   
output [127:0] tr_out;  //message to be transmitted

// pad crc with the message//

assign tr_out[15:0] = crc_in;
assign tr_out[127:16] = data_in;

endmodule 
//Author : Ismaeel Butt
// Data: 19-Aprail-24
// profile: https://github.com/Ismaeel53

module Mix_column( data_in  , data_out );


input [127:0] data_in;

output  [127:0]data_out;
wire [31:0] n1,n2,n3,n4;
wire [31:0] n_tmp_out1 , n_tmp_out2 , n_tmp_out3 , n_tmp_out4;
assign n1 = data_in [127:96];
assign n2 = data_in [95:64];
assign n3 = data_in [63:32];
assign n4 = data_in [31:0];


mul_32 m1(n1,n_tmp_out1);
mul_32 m2(n2,n_tmp_out2);
mul_32 m3(n3,n_tmp_out3);
mul_32 m4(n4,n_tmp_out4);


assign data_out = {n_tmp_out1,n_tmp_out2,n_tmp_out3,n_tmp_out4};

endmodule

//-----------------------------------------------------




module mul_2(data_in, data_out);
input [7:0] data_in;
output reg [7:0]data_out;

always @(*)
if (data_in[7] == 1) 
data_out = ((data_in << 1) ^ 8'h1b);

else 
data_out = (data_in << 1);

endmodule 

//---------------------------------------------------------

module mul_3(data_in, data_out);
input [7:0] data_in;
output [7:0]data_out;
wire [7:0] tmp_out;


mul_2 m1(data_in, tmp_out);

assign data_out = tmp_out ^ data_in;
 
endmodule 
 
//-------------------------------------------------------------

module mul_32(m_data_in, m_data_out);
input [31:0] m_data_in;
output [31:0] m_data_out;

wire [7:0] tmp1,tmp2,tmp3,tmp4;
wire [7:0] ma0,ma1,ma2,ma3;
wire [7:0] m2_tmp_out1,m2_tmp_out2,m2_tmp_out3,m2_tmp_out4;
wire [7:0] m3_tmp_out1,m3_tmp_out2,m3_tmp_out3,m3_tmp_out4;


assign  tmp1 = m_data_in [31:24];
assign  tmp2 = m_data_in [23:16];
assign  tmp3 = m_data_in [15:8];
assign  tmp4 = m_data_in [7:0];

mul_2 m1(tmp1, m2_tmp_out1);
mul_2 m2(tmp2, m2_tmp_out2);
mul_2 m3(tmp3, m2_tmp_out3);
mul_2 m4(tmp4, m2_tmp_out4);

mul_3 m6 (tmp1, m3_tmp_out1);
mul_3 m7 (tmp2, m3_tmp_out2);
mul_3 m8 (tmp3, m3_tmp_out3);
mul_3 m9 (tmp4, m3_tmp_out4);

assign ma0 = m2_tmp_out1 ^ m3_tmp_out2 ^ tmp3 ^ tmp4;
assign ma1 = tmp1 ^ m2_tmp_out2 ^ m3_tmp_out3 ^ tmp4;
assign ma2 = tmp1 ^ tmp2 ^ m2_tmp_out3 ^ m3_tmp_out4;
assign ma3 = m3_tmp_out1 ^ tmp2 ^ tmp3 ^ m2_tmp_out4;
assign m_data_out = {ma0 , ma1, ma2, ma3 };


endmodule 


//--------------------------------------------------------------------------


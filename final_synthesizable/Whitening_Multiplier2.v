module Whitening_Multiplier2(
En,clk,
V11,V12,V13,V14,
V21,V22,V23,V24,
V31,V32,V33,V34,
V41,V42,V43,V44,
X1, X2, X3, X4,
Z1, Z2, Z3, Z4
);

input En,clk;
input wire signed [25:0] V11,V12,V13,V14;
input wire signed [25:0] V21,V22,V23,V24;
input wire signed [25:0] V31,V32,V33,V34;
input wire signed [25:0] V41,V42,V43,V44;
input wire signed [25:0] X1,X2,X3,X4;
output wire signed [25:0] Z1,Z2,Z3,Z4;

reg signed [51:0] Z1_reg;
reg signed [51:0] Z2_reg;
reg signed [51:0] Z3_reg;
reg signed [51:0] Z4_reg;

assign Z1 = Z1_reg[38:13]; //Z1_reg[38:13]; 
assign Z2 = Z2_reg[38:13]; //Z2_reg[38:13];
assign Z3 = Z3_reg[38:13]; //Z3_reg[38:13];
assign Z4 = Z4_reg[38:13]; //Z4_reg[38:13];
reg signed [25:0] V11_reg,V12_reg,V13_reg,V14_reg;
reg signed [25:0] V21_reg,V22_reg,V23_reg,V24_reg;
reg signed [25:0] V31_reg,V32_reg,V33_reg,V34_reg;
reg signed [25:0] V41_reg,V42_reg,V43_reg,V44_reg;
reg [7:0] cnt;


always @(posedge clk) begin

    if(En) begin
        if(cnt==0) begin
        V11_reg<=V11; V12_reg<=V12; V13_reg<=V13; V14_reg<=V14; 
        V21_reg<=V21; V22_reg<=V22; V23_reg<=V23; V24_reg<=V24; 
        V31_reg<=V31; V32_reg<=V32; V33_reg<=V33; V34_reg<=V34; 
        V41_reg<=V41; V42_reg<=V42; V43_reg<=V43; V44_reg<=V44; 

        Z1_reg <= V11*X1 + V12*X2 + V13*X3 + V14*X4;
        Z2_reg <= V21*X1 + V22*X2 + V23*X3 + V24*X4;
        Z3_reg <= V31*X1 + V32*X2 + V33*X3 + V34*X4;
        Z4_reg <= V41*X1 + V42*X2 + V43*X3 + V44*X4;
/*
[V11] [V12] [V13] [V14] [X1] ~
[V21] [V22] [V23] [V24] [X2] ~
[V31] [V32] [V33] [V34] [X3] ~
[V41] [V42] [V43] [V44] [X4] ~
*/
        cnt<=cnt+1'b1;
        end
        else begin
            Z1_reg <= V11_reg*X1 + V12_reg*X2 + V13_reg*X3 + V14_reg*X4;
            Z2_reg <= V21_reg*X1 + V22_reg*X2 + V23_reg*X3 + V24_reg*X4;
            Z3_reg <= V31_reg*X1 + V32_reg*X2 + V33_reg*X3 + V34_reg*X4;
            Z4_reg <= V41_reg*X1 + V42_reg*X2 + V43_reg*X3 + V44_reg*X4;
        end
    end
    else begin
        Z1_reg<=0;
        Z2_reg<=0;
        Z3_reg<=0;
        Z4_reg<=0;
        cnt<=0;
    end
end
endmodule
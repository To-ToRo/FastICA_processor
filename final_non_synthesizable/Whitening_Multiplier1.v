module Whitening_Multiplier1(
En_WM1,CLK_WM1,
D_inv_sqrt11,D_inv_sqrt12,D_inv_sqrt13,D_inv_sqrt14,
D_inv_sqrt21,D_inv_sqrt22,D_inv_sqrt23,D_inv_sqrt24,
D_inv_sqrt31,D_inv_sqrt32,D_inv_sqrt33,D_inv_sqrt34,
D_inv_sqrt41,D_inv_sqrt42,D_inv_sqrt43,D_inv_sqrt44,
E_T11,E_T12,E_T13,E_T14,
E_T21,E_T22,E_T23,E_T24,
E_T31,E_T32,E_T33,E_T34,
E_T41,E_T42,E_T43,E_T44,
V11,V12,V13,V14,
V21,V22,V23,V24,
V31,V32,V33,V34,
V41,V42,V43,V44);

input En_WM1,CLK_WM1;
input wire signed [63:0] D_inv_sqrt11,D_inv_sqrt12,D_inv_sqrt13,D_inv_sqrt14;
input wire signed [63:0] D_inv_sqrt21,D_inv_sqrt22,D_inv_sqrt23,D_inv_sqrt24;
input wire signed [63:0] D_inv_sqrt31,D_inv_sqrt32,D_inv_sqrt33,D_inv_sqrt34;
input wire signed [63:0] D_inv_sqrt41,D_inv_sqrt42,D_inv_sqrt43,D_inv_sqrt44;
input wire signed [63:0] E_T11,E_T12,E_T13,E_T14,E_T21,E_T22,E_T23,E_T24,E_T31,E_T32,E_T33,E_T34,E_T41,E_T42,E_T43,E_T44;
output wire signed [25:0] V11,V12,V13,V14,V21,V22,V23,V24,V31,V32,V33,V34,V41,V42,V43,V44;

reg signed [127:0] V11_reg, V12_reg, V13_reg, V14_reg;
reg signed [127:0] V21_reg, V22_reg, V23_reg, V24_reg;
reg signed [127:0] V31_reg, V32_reg, V33_reg, V34_reg;
reg signed [127:0] V41_reg, V42_reg, V43_reg, V44_reg;


assign V11 = V11_reg[76:51];
assign V12 = V12_reg[76:51];
assign V13 = V13_reg[76:51];
assign V14 = V14_reg[76:51];
assign V21 = V21_reg[76:51];
assign V22 = V22_reg[76:51];
assign V23 = V23_reg[76:51];
assign V24 = V24_reg[76:51];
assign V31 = V31_reg[76:51];
assign V32 = V32_reg[76:51];
assign V33 = V33_reg[76:51];
assign V34 = V34_reg[76:51];
assign V41 = V41_reg[76:51];
assign V42 = V42_reg[76:51];
assign V43 = V43_reg[76:51];
assign V44 = V44_reg[76:51];


always @(posedge CLK_WM1) 
begin
    if(En_WM1) begin
        V11_reg <= D_inv_sqrt11*E_T11 + D_inv_sqrt12*E_T21 + D_inv_sqrt13*E_T31 + D_inv_sqrt14*E_T41;
        V12_reg <= D_inv_sqrt11*E_T12 + D_inv_sqrt12*E_T22 + D_inv_sqrt13*E_T32 + D_inv_sqrt14*E_T42;
        V13_reg <= D_inv_sqrt11*E_T13 + D_inv_sqrt12*E_T23 + D_inv_sqrt13*E_T33 + D_inv_sqrt14*E_T43;
        V14_reg <= D_inv_sqrt11*E_T14 + D_inv_sqrt12*E_T24 + D_inv_sqrt13*E_T34 + D_inv_sqrt14*E_T44;
        V21_reg <= D_inv_sqrt21*E_T11 + D_inv_sqrt22*E_T21 + D_inv_sqrt23*E_T31 + D_inv_sqrt24*E_T41;
        V22_reg <= D_inv_sqrt21*E_T12 + D_inv_sqrt22*E_T22 + D_inv_sqrt23*E_T32 + D_inv_sqrt24*E_T42;
        V23_reg <= D_inv_sqrt21*E_T13 + D_inv_sqrt22*E_T23 + D_inv_sqrt23*E_T33 + D_inv_sqrt24*E_T43;
        V24_reg <= D_inv_sqrt21*E_T14 + D_inv_sqrt22*E_T24 + D_inv_sqrt23*E_T34 + D_inv_sqrt24*E_T44;
        V31_reg <= D_inv_sqrt31*E_T11 + D_inv_sqrt32*E_T21 + D_inv_sqrt33*E_T31 + D_inv_sqrt34*E_T41;
        V32_reg <= D_inv_sqrt31*E_T12 + D_inv_sqrt32*E_T22 + D_inv_sqrt33*E_T32 + D_inv_sqrt34*E_T42;
        V33_reg <= D_inv_sqrt31*E_T13 + D_inv_sqrt32*E_T23 + D_inv_sqrt33*E_T33 + D_inv_sqrt34*E_T43;
        V34_reg <= D_inv_sqrt31*E_T14 + D_inv_sqrt32*E_T24 + D_inv_sqrt33*E_T34 + D_inv_sqrt34*E_T44;
        V41_reg <= D_inv_sqrt41*E_T11 + D_inv_sqrt42*E_T21 + D_inv_sqrt43*E_T31 + D_inv_sqrt44*E_T41;
        V42_reg <= D_inv_sqrt41*E_T12 + D_inv_sqrt42*E_T22 + D_inv_sqrt43*E_T32 + D_inv_sqrt44*E_T42;
        V43_reg <= D_inv_sqrt41*E_T13 + D_inv_sqrt42*E_T23 + D_inv_sqrt43*E_T33 + D_inv_sqrt44*E_T43;
        V44_reg <= D_inv_sqrt41*E_T14 + D_inv_sqrt42*E_T24 + D_inv_sqrt43*E_T34 + D_inv_sqrt44*E_T44;
    end
    else begin
        V11_reg <= 0;
        V12_reg <= 0;
        V13_reg <= 0;
        V14_reg <= 0;
        V21_reg <= 0;
        V22_reg <= 0;
        V23_reg <= 0;
        V24_reg <= 0;
        V31_reg <= 0;
        V32_reg <= 0;
        V33_reg <= 0;
        V34_reg <= 0;
        V41_reg <= 0;
        V42_reg <= 0;
        V43_reg <= 0;
        V44_reg <= 0;           
    end
end
endmodule
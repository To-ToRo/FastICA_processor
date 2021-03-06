`timescale 100ps/1ps

module TB_SYMM_ORTH;

reg clk_symm;
reg go_symm;

reg signed [25:0] b11, b12, b13, b14;
reg signed [25:0] b21, b22, b23, b24;
reg signed [25:0] b31, b32, b33, b34;
reg signed [25:0] b41, b42, b43, b44;

wire signed [25:0] w11, w12, w13, w14;
wire signed [25:0] w21, w22, w23, w24;
wire signed [25:0] w31, w32, w33, w34;
wire signed [25:0] w41, w42, w43, w44;

initial begin
    clk_symm = 1'b0;
    go_symm = 1'b0;

    b11 = 26'b1111111111111_1101100111001;
    b12 = 26'b1111111111111_0110100010110;
    b13 = 26'b0000000000000_0110000100100;
    b14 = 26'b1111111111111_1101001101001;
    b21 = 26'b0000000000010_0111001011110;
    b22 = 26'b1111111111111_0101100001101;
    b23 = 26'b1111111111111_1010101101110;
    b24 = 26'b1111111111111_0000101011101;
    b31 = 26'b0000000000000_0111100100011;
    b32 = 26'b1111111111110_1110101101011;
    b33 = 26'b1111111111111_1000000000001;
    b34 = 26'b0000000000001_0100101011100;
    b41 = 26'b0000000000000_0000111011110;
    b42 = 26'b1111111111111_1111001111001;
    b43 = 26'b1111111111111_1111001111001;
    b44 = 26'b0000000000000_0111000011100;
end

assign #10 clk_symm = ~clk_symm;
assign #5 go_symm = 1'b1;

SYMM_ORTH SYMM_ORTH_1 (
    .clk_symm(clk_symm),
    .go_symm(go_symm),

    .b11(b11), .b12(b12), .b13(b13), .b14(b14),
    .b21(b21), .b22(b22), .b23(b23), .b24(b24),
    .b31(b31), .b32(b32), .b33(b33), .b34(b34),
    .b41(b41), .b42(b42), .b43(b43), .b44(b44),

    .w11(w11), .w12(w12), .w13(w13), .w14(w14),
    .w21(w21), .w22(w22), .w23(w23), .w24(w24),
    .w31(w31), .w32(w32), .w33(w33), .w34(w34),
    .w41(w41), .w42(w42), .w43(w43), .w44(w44)
);
    
endmodule
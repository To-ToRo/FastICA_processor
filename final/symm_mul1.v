module SYMM_MUL1 (
    input clk_mul1,
    input en_mul1,

    input signed [25:0] b11, b12, b13, b14,
    input signed [25:0] b21, b22, b23, b24,
    input signed [25:0] b31, b32, b33, b34,
    input signed [25:0] b41, b42, b43, b44,

    output reg signed [25:0] w11, w12, w13, w14,
    output reg signed [25:0] w21, w22, w23, w24,
    output reg signed [25:0] w31, w32, w33, w34,
    output reg signed [25:0] w41, w42, w43, w44,

    output signed [25:0] w11_2, w12_2, w13_2, w14_2,
    output signed [25:0] w21_2, w22_2, w23_2, w24_2,
    output signed [25:0] w31_2, w32_2, w33_2, w34_2,
    output signed [25:0] w41_2, w42_2, w43_2, w44_2
);

reg [51:0] dot11, dot12, dot13, dot14,
           dot21, dot22, dot23, dot24,
           dot31, dot32, dot33, dot34,
           dot41, dot42, dot43, dot44;

assign w11_2 = dot11[38:13];
assign w12_2 = dot12[38:13];
assign w13_2 = dot13[38:13];
assign w14_2 = dot14[38:13];
assign w21_2 = dot21[38:13];
assign w22_2 = dot22[38:13];
assign w23_2 = dot23[38:13];
assign w24_2 = dot24[38:13];
assign w31_2 = dot31[38:13];
assign w32_2 = dot32[38:13];
assign w33_2 = dot33[38:13];
assign w34_2 = dot34[38:13];
assign w41_2 = dot41[38:13];
assign w42_2 = dot42[38:13];
assign w43_2 = dot43[38:13];
assign w44_2 = dot44[38:13];

always @(posedge clk_mul1) begin
    if (en_mul1) begin
        w11 <= b11; w12 <= b12; w13 <= b13; w14 <= b14;
        w21 <= b21; w22 <= b22; w23 <= b23; w24 <= b24;
        w31 <= b31; w32 <= b32; w33 <= b33; w34 <= b34;
        w41 <= b41; w42 <= b42; w43 <= b43; w44 <= b44;

        dot11 <= (b11 * b11) >>> 13; dot12 <= (b12 * b12) >>> 13; dot13 <= (b13 * b13) >>> 13; dot14 <= (b14 * b14) >>> 13;
        dot21 <= (b21 * b21) >>> 13; dot22 <= (b22 * b22) >>> 13; dot23 <= (b23 * b23) >>> 13; dot24 <= (b24 * b24) >>> 13;
        dot31 <= (b31 * b31) >>> 13; dot32 <= (b32 * b32) >>> 13; dot33 <= (b33 * b33) >>> 13; dot34 <= (b34 * b34) >>> 13;
        dot41 <= (b41 * b41) >>> 13; dot42 <= (b42 * b42) >>> 13; dot43 <= (b43 * b43) >>> 13; dot44 <= (b44 * b44) >>> 13;
    end else begin
        w11 <= b11; w12 <= b12; w13 <= b13; w14 <= b14;
        w21 <= b21; w22 <= b22; w23 <= b23; w24 <= b24;
        w31 <= b31; w32 <= b32; w33 <= b33; w34 <= b34;
        w41 <= b41; w42 <= b42; w43 <= b43; w44 <= b44;
    end
end
    
endmodule
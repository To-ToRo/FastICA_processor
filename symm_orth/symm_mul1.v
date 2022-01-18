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

    output reg signed [25:0] w11_2, w12_2, w13_2, w14_2,
    output reg signed [25:0] w21_2, w22_2, w23_2, w24_2,
    output reg signed [25:0] w31_2, w32_2, w33_2, w34_2,
    output reg signed [25:0] w41_2, w42_2, w43_2, w44_2
);

always @(posedge clk_mul1) begin
    if (en_mul1) begin
        w11 <= b11; w12 <= b12; w13 <= b13; w14 <= b14;
        w21 <= b21; w22 <= b22; w23 <= b23; w24 <= b24;
        w31 <= b31; w32 <= b32; w33 <= b33; w34 <= b34;
        w41 <= b41; w42 <= b42; w43 <= b43; w44 <= b44;

        w11_2 <= (b11 * b11) >>> 13; w12_2 <= (b12 * b12) >>> 13; w13_2 <= (b13 * b13) >>> 13; w14_2 <= (b14 * b14) >>> 13;
        w21_2 <= (b21 * b21) >>> 13; w22_2 <= (b22 * b22) >>> 13; w23_2 <= (b23 * b23) >>> 13; w24_2 <= (b24 * b24) >>> 13;
        w31_2 <= (b31 * b31) >>> 13; w32_2 <= (b32 * b32) >>> 13; w33_2 <= (b33 * b33) >>> 13; w34_2 <= (b34 * b34) >>> 13;
        w41_2 <= (b41 * b41) >>> 13; w42_2 <= (b42 * b42) >>> 13; w43_2 <= (b43 * b43) >>> 13; w44_2 <= (b44 * b44) >>> 13;
    end else begin
        w11 <= b11; w12 <= b12; w13 <= b13; w14 <= b14;
        w21 <= b21; w22 <= b22; w23 <= b23; w24 <= b24;
        w31 <= b31; w32 <= b32; w33 <= b33; w34 <= b34;
        w41 <= b41; w42 <= b42; w43 <= b43; w44 <= b44;
    end
end
    
endmodule
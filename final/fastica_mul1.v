module FASTICA_MUL1 (
    input clk_mul,
    input en_mul,

    input signed [25:0] w11, w12, w13, w14,
    input signed [25:0] w21, w22, w23, w24,
    input signed [25:0] w31, w32, w33, w34,
    input signed [25:0] w41, w42, w43, w44,

    input signed [25:0] z1, z2, z3, z4,

    output signed [25:0] y1, y2, y3, y4
);

reg signed [28:0] y1_reg, y2_reg, y3_reg, y4_reg;

assign y1 = y1_reg[28:3];
assign y2 = y2_reg[28:3];
assign y3 = y3_reg[28:3];
assign y4 = y4_reg[28:3];

always @(posedge clk_mul) begin
    if (en_mul) begin
        y1_reg <= (z1 * w11 + z2 * w12 + z3 * w13 + z4 * w14) >>> 13;
        y2_reg <= (z1 * w21 + z2 * w22 + z3 * w23 + z4 * w24) >>> 13;
        y3_reg <= (z1 * w31 + z2 * w32 + z3 * w33 + z4 * w34) >>> 13;
        y4_reg <= (z1 * w41 + z2 * w42 + z3 * w43 + z4 * w44) >>> 13;
    end
end
    
endmodule
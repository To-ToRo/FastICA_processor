/*
 * MUL 1
 * zw1(4x4) = z(4x1)*w1(1x4) zw2, zw3, zw4
 */
module MUL1 (
    input clk_mul,
    input en_mul,
    
    input signed [25:0] z1, z2, z3, z4,

    input signed [25:0] w11, w12, w13, w14,
    input signed [25:0] w21, w22, w23, w24,
    input signed [25:0] w31, w32, w33, w34,
    input signed [25:0] w41, w42, w43, w44,

    output reg signed [25:0] zo1, zo2, zo3, zo4,

    output signed [25:0] zw1_11, zw1_12, zw1_13, zw1_14,
    output signed [25:0] zw1_21, zw1_22, zw1_23, zw1_24,
    output signed [25:0] zw1_31, zw1_32, zw1_33, zw1_34,
    output signed [25:0] zw1_41, zw1_42, zw1_43, zw1_44,

    output signed [25:0] zw2_11, zw2_12, zw2_13, zw2_14,
    output signed [25:0] zw2_21, zw2_22, zw2_23, zw2_24,
    output signed [25:0] zw2_31, zw2_32, zw2_33, zw2_34,
    output signed [25:0] zw2_41, zw2_42, zw2_43, zw2_44,

    output signed [25:0] zw3_11, zw3_12, zw3_13, zw3_14,
    output signed [25:0] zw3_21, zw3_22, zw3_23, zw3_24,
    output signed [25:0] zw3_31, zw3_32, zw3_33, zw3_34,
    output signed [25:0] zw3_41, zw3_42, zw3_43, zw3_44,
                         
    output signed [25:0] zw4_11, zw4_12, zw4_13, zw4_14,
    output signed [25:0] zw4_21, zw4_22, zw4_23, zw4_24,
    output signed [25:0] zw4_31, zw4_32, zw4_33, zw4_34,
    output signed [25:0] zw4_41, zw4_42, zw4_43, zw4_44
);

reg signed [51:0] zw1_11_reg, zw1_12_reg, zw1_13_reg, zw1_14_reg;
reg signed [51:0] zw1_21_reg, zw1_22_reg, zw1_23_reg, zw1_24_reg;
reg signed [51:0] zw1_31_reg, zw1_32_reg, zw1_33_reg, zw1_34_reg;
reg signed [51:0] zw1_41_reg, zw1_42_reg, zw1_43_reg, zw1_44_reg;

reg signed [51:0] zw2_11_reg, zw2_12_reg, zw2_13_reg, zw2_14_reg;
reg signed [51:0] zw2_21_reg, zw2_22_reg, zw2_23_reg, zw2_24_reg;
reg signed [51:0] zw2_31_reg, zw2_32_reg, zw2_33_reg, zw2_34_reg;
reg signed [51:0] zw2_41_reg, zw2_42_reg, zw2_43_reg, zw2_44_reg;

reg signed [51:0] zw3_11_reg, zw3_12_reg, zw3_13_reg, zw3_14_reg;
reg signed [51:0] zw3_21_reg, zw3_22_reg, zw3_23_reg, zw3_24_reg;
reg signed [51:0] zw3_31_reg, zw3_32_reg, zw3_33_reg, zw3_34_reg;
reg signed [51:0] zw3_41_reg, zw3_42_reg, zw3_43_reg, zw3_44_reg;

reg signed [51:0] zw4_11_reg, zw4_12_reg, zw4_13_reg, zw4_14_reg;
reg signed [51:0] zw4_21_reg, zw4_22_reg, zw4_23_reg, zw4_24_reg;
reg signed [51:0] zw4_31_reg, zw4_32_reg, zw4_33_reg, zw4_34_reg;
reg signed [51:0] zw4_41_reg, zw4_42_reg, zw4_43_reg, zw4_44_reg;

assign zw1_11 = zw1_11_reg[38:13];
assign zw1_12 = zw1_12_reg[38:13];
assign zw1_13 = zw1_13_reg[38:13];
assign zw1_14 = zw1_14_reg[38:13];
assign zw1_21 = zw1_21_reg[38:13];
assign zw1_22 = zw1_22_reg[38:13];
assign zw1_23 = zw1_23_reg[38:13];
assign zw1_24 = zw1_24_reg[38:13];
assign zw1_31 = zw1_31_reg[38:13];
assign zw1_32 = zw1_32_reg[38:13];
assign zw1_33 = zw1_33_reg[38:13];
assign zw1_34 = zw1_34_reg[38:13];
assign zw1_41 = zw1_41_reg[38:13];
assign zw1_42 = zw1_42_reg[38:13];
assign zw1_43 = zw1_43_reg[38:13];
assign zw1_44 = zw1_44_reg[38:13];

assign zw2_11 = zw2_11_reg[38:13];
assign zw2_12 = zw2_12_reg[38:13];
assign zw2_13 = zw2_13_reg[38:13];
assign zw2_14 = zw2_14_reg[38:13];
assign zw2_21 = zw2_21_reg[38:13];
assign zw2_22 = zw2_22_reg[38:13];
assign zw2_23 = zw2_23_reg[38:13];
assign zw2_24 = zw2_24_reg[38:13];
assign zw2_31 = zw2_31_reg[38:13];
assign zw2_32 = zw2_32_reg[38:13];
assign zw2_33 = zw2_33_reg[38:13];
assign zw2_34 = zw2_34_reg[38:13];
assign zw2_41 = zw2_41_reg[38:13];
assign zw2_42 = zw2_42_reg[38:13];
assign zw2_43 = zw2_43_reg[38:13];
assign zw2_44 = zw2_44_reg[38:13];

assign zw3_11 = zw3_11_reg[38:13];
assign zw3_12 = zw3_12_reg[38:13];
assign zw3_13 = zw3_13_reg[38:13];
assign zw3_14 = zw3_14_reg[38:13];
assign zw3_21 = zw3_21_reg[38:13];
assign zw3_22 = zw3_22_reg[38:13];
assign zw3_23 = zw3_23_reg[38:13];
assign zw3_24 = zw3_24_reg[38:13];
assign zw3_31 = zw3_31_reg[38:13];
assign zw3_32 = zw3_32_reg[38:13];
assign zw3_33 = zw3_33_reg[38:13];
assign zw3_34 = zw3_34_reg[38:13];
assign zw3_41 = zw3_41_reg[38:13];
assign zw3_42 = zw3_42_reg[38:13];
assign zw3_43 = zw3_43_reg[38:13];
assign zw3_44 = zw3_44_reg[38:13];

assign zw4_11 = zw4_11_reg[38:13];
assign zw4_12 = zw4_12_reg[38:13];
assign zw4_13 = zw4_13_reg[38:13];
assign zw4_14 = zw4_14_reg[38:13];
assign zw4_21 = zw4_21_reg[38:13];
assign zw4_22 = zw4_22_reg[38:13];
assign zw4_23 = zw4_23_reg[38:13];
assign zw4_24 = zw4_24_reg[38:13];
assign zw4_31 = zw4_31_reg[38:13];
assign zw4_32 = zw4_32_reg[38:13];
assign zw4_33 = zw4_33_reg[38:13];
assign zw4_34 = zw4_34_reg[38:13];
assign zw4_41 = zw4_41_reg[38:13];
assign zw4_42 = zw4_42_reg[38:13];
assign zw4_43 = zw4_43_reg[38:13];
assign zw4_44 = zw4_44_reg[38:13];

always @(posedge clk_mul)
begin
    zo1 <= z1;
    zo2 <= z2;
    zo3 <= z3;
    zo4 <= z4;
    if (en_mul) begin
        // active
        zw1_11_reg <= z1 * w11;
        zw1_12_reg <= z1 * w12;
        zw1_13_reg <= z1 * w13;
        zw1_14_reg <= z1 * w14;
        zw1_21_reg <= z2 * w11;
        zw1_22_reg <= z2 * w12;
        zw1_23_reg <= z2 * w13;
        zw1_24_reg <= z2 * w14;
        zw1_31_reg <= z3 * w11;
        zw1_32_reg <= z3 * w12;
        zw1_33_reg <= z3 * w13;
        zw1_34_reg <= z3 * w14;
        zw1_41_reg <= z4 * w11;
        zw1_42_reg <= z4 * w12;
        zw1_43_reg <= z4 * w13;
        zw1_44_reg <= z4 * w14;

        zw2_11_reg <= z1 * w21;
        zw2_12_reg <= z1 * w22;
        zw2_13_reg <= z1 * w23;
        zw2_14_reg <= z1 * w24;
        zw2_21_reg <= z2 * w21;
        zw2_22_reg <= z2 * w22;
        zw2_23_reg <= z2 * w23;
        zw2_24_reg <= z2 * w24;
        zw2_31_reg <= z3 * w21;
        zw2_32_reg <= z3 * w22;
        zw2_33_reg <= z3 * w23;
        zw2_34_reg <= z3 * w24;
        zw2_41_reg <= z4 * w21;
        zw2_42_reg <= z4 * w22;
        zw2_43_reg <= z4 * w23;
        zw2_44_reg <= z4 * w24;

        zw3_11_reg <= z1 * w31;
        zw3_12_reg <= z1 * w32;
        zw3_13_reg <= z1 * w33;
        zw3_14_reg <= z1 * w34;
        zw3_21_reg <= z2 * w31;
        zw3_22_reg <= z2 * w32;
        zw3_23_reg <= z2 * w33;
        zw3_24_reg <= z2 * w34;
        zw3_31_reg <= z3 * w31;
        zw3_32_reg <= z3 * w32;
        zw3_33_reg <= z3 * w33;
        zw3_34_reg <= z3 * w34;
        zw3_41_reg <= z4 * w31;
        zw3_42_reg <= z4 * w32;
        zw3_43_reg <= z4 * w33;
        zw3_44_reg <= z4 * w34;

        zw4_11_reg <= z1 * w41;
        zw4_12_reg <= z1 * w42;
        zw4_13_reg <= z1 * w43;
        zw4_14_reg <= z1 * w44;
        zw4_21_reg <= z2 * w41;
        zw4_22_reg <= z2 * w42;
        zw4_23_reg <= z2 * w43;
        zw4_24_reg <= z2 * w44;
        zw4_31_reg <= z3 * w41;
        zw4_32_reg <= z3 * w42;
        zw4_33_reg <= z3 * w43;
        zw4_34_reg <= z3 * w44;
        zw4_41_reg <= z4 * w41;
        zw4_42_reg <= z4 * w42;
        zw4_43_reg <= z4 * w43;
        zw4_44_reg <= z4 * w44;
    end else begin
        zw1_11_reg <= w11;
        zw1_12_reg <= w12;
        zw1_13_reg <= w13;
        zw1_14_reg <= w14;
        zw1_21_reg <= w11;
        zw1_22_reg <= w12;
        zw1_23_reg <= w13;
        zw1_24_reg <= w14;
        zw1_31_reg <= w11;
        zw1_32_reg <= w12;
        zw1_33_reg <= w13;
        zw1_34_reg <= w14;
        zw1_41_reg <= w11;
        zw1_42_reg <= w12;
        zw1_43_reg <= w13;
        zw1_44_reg <= w14;

        zw2_11_reg <= w21;
        zw2_12_reg <= w22;
        zw2_13_reg <= w23;
        zw2_14_reg <= w24;
        zw2_21_reg <= w21;
        zw2_22_reg <= w22;
        zw2_23_reg <= w23;
        zw2_24_reg <= w24;
        zw2_31_reg <= w21;
        zw2_32_reg <= w22;
        zw2_33_reg <= w23;
        zw2_34_reg <= w24;
        zw2_41_reg <= w21;
        zw2_42_reg <= w22;
        zw2_43_reg <= w23;
        zw2_44_reg <= w24;

        zw3_11_reg <= w31;
        zw3_12_reg <= w32;
        zw3_13_reg <= w33;
        zw3_14_reg <= w34;
        zw3_21_reg <= w31;
        zw3_22_reg <= w32;
        zw3_23_reg <= w33;
        zw3_24_reg <= w34;
        zw3_31_reg <= w31;
        zw3_32_reg <= w32;
        zw3_33_reg <= w33;
        zw3_34_reg <= w34;
        zw3_41_reg <= w31;
        zw3_42_reg <= w32;
        zw3_43_reg <= w33;
        zw3_44_reg <= w34;

        zw4_11_reg <= w41;
        zw4_12_reg <= w42;
        zw4_13_reg <= w43;
        zw4_14_reg <= w44;
        zw4_21_reg <= w41;
        zw4_22_reg <= w42;
        zw4_23_reg <= w43;
        zw4_24_reg <= w44;
        zw4_31_reg <= w41;
        zw4_32_reg <= w42;
        zw4_33_reg <= w43;
        zw4_34_reg <= w44;
        zw4_41_reg <= w41;
        zw4_42_reg <= w42;
        zw4_43_reg <= w43;
        zw4_44_reg <= w44;
    end
end
    
endmodule
/*
 * MUL2
 * O1 = I1(4x4)^2, O2 = I2^2, O3 = I3^2, O4 = I4^2
 */

module MUL2 (
    input clk_mul,
    input en_mul,

    input signed [25:0] i1_11, i1_12, i1_13, i1_14,
    input signed [25:0] i1_21, i1_22, i1_23, i1_24,
    input signed [25:0] i1_31, i1_32, i1_33, i1_34,
    input signed [25:0] i1_41, i1_42, i1_43, i1_44,

    input signed [25:0] i2_11, i2_12, i2_13, i2_14,
    input signed [25:0] i2_21, i2_22, i2_23, i2_24,
    input signed [25:0] i2_31, i2_32, i2_33, i2_34,
    input signed [25:0] i2_41, i2_42, i2_43, i2_44,

    input signed [25:0] i3_11, i3_12, i3_13, i3_14,
    input signed [25:0] i3_21, i3_22, i3_23, i3_24,
    input signed [25:0] i3_31, i3_32, i3_33, i3_34,
    input signed [25:0] i3_41, i3_42, i3_43, i3_44,

    input signed [25:0] i4_11, i4_12, i4_13, i4_14,
    input signed [25:0] i4_21, i4_22, i4_23, i4_24,
    input signed [25:0] i4_31, i4_32, i4_33, i4_34,
    input signed [25:0] i4_41, i4_42, i4_43, i4_44,

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
    output signed [25:0] zw4_41, zw4_42, zw4_43, zw4_44,

    output signed [25:0] o1_11, o1_12, o1_13, o1_14,
    output signed [25:0] o1_21, o1_22, o1_23, o1_24,
    output signed [25:0] o1_31, o1_32, o1_33, o1_34,
    output signed [25:0] o1_41, o1_42, o1_43, o1_44,

    output signed [25:0] o2_11, o2_12, o2_13, o2_14,
    output signed [25:0] o2_21, o2_22, o2_23, o2_24,
    output signed [25:0] o2_31, o2_32, o2_33, o2_34,
    output signed [25:0] o2_41, o2_42, o2_43, o2_44,

    output signed [25:0] o3_11, o3_12, o3_13, o3_14,
    output signed [25:0] o3_21, o3_22, o3_23, o3_24,
    output signed [25:0] o3_31, o3_32, o3_33, o3_34,
    output signed [25:0] o3_41, o3_42, o3_43, o3_44,

    output signed [25:0] o4_11, o4_12, o4_13, o4_14,
    output signed [25:0] o4_21, o4_22, o4_23, o4_24,
    output signed [25:0] o4_31, o4_32, o4_33, o4_34,
    output signed [25:0] o4_41, o4_42, o4_43, o4_44
);

assign zw1_11 = i1_11;
assign zw1_12 = i1_12;
assign zw1_13 = i1_13;
assign zw1_14 = i1_14;
assign zw1_21 = i1_21;
assign zw1_22 = i1_22;
assign zw1_23 = i1_23;
assign zw1_24 = i1_24;
assign zw1_31 = i1_31;
assign zw1_32 = i1_32;
assign zw1_33 = i1_33;
assign zw1_34 = i1_34;
assign zw1_41 = i1_41;
assign zw1_42 = i1_42;
assign zw1_43 = i1_43;
assign zw1_44 = i1_44;

assign zw2_11 = i2_11;
assign zw2_12 = i2_12;
assign zw2_13 = i2_13;
assign zw2_14 = i2_14;
assign zw2_21 = i2_21;
assign zw2_22 = i2_22;
assign zw2_23 = i2_23;
assign zw2_24 = i2_24;
assign zw2_31 = i2_31;
assign zw2_32 = i2_32;
assign zw2_33 = i2_33;
assign zw2_34 = i2_34;
assign zw2_41 = i2_41;
assign zw2_42 = i2_42;
assign zw2_43 = i2_43;
assign zw2_44 = i2_44;

assign zw3_11 = i3_11;
assign zw3_12 = i3_12;
assign zw3_13 = i3_13;
assign zw3_14 = i3_14;
assign zw3_21 = i3_21;
assign zw3_22 = i3_22;
assign zw3_23 = i3_23;
assign zw3_24 = i3_24;
assign zw3_31 = i3_31;
assign zw3_32 = i3_32;
assign zw3_33 = i3_33;
assign zw3_34 = i3_34;
assign zw3_41 = i3_41;
assign zw3_42 = i3_42;
assign zw3_43 = i3_43;
assign zw3_44 = i3_44;

assign zw4_11 = i4_11;
assign zw4_12 = i4_12;
assign zw4_13 = i4_13;
assign zw4_14 = i4_14;
assign zw4_21 = i4_21;
assign zw4_22 = i4_22;
assign zw4_23 = i4_23;
assign zw4_24 = i4_24;
assign zw4_31 = i4_31;
assign zw4_32 = i4_32;
assign zw4_33 = i4_33;
assign zw4_34 = i4_34;
assign zw4_41 = i4_41;
assign zw4_42 = i4_42;
assign zw4_43 = i4_43;
assign zw4_44 = i4_44;

reg signed [51:0] o1_11_reg, o1_12_reg, o1_13_reg, o1_14_reg;
reg signed [51:0] o1_21_reg, o1_22_reg, o1_23_reg, o1_24_reg;
reg signed [51:0] o1_31_reg, o1_32_reg, o1_33_reg, o1_34_reg;
reg signed [51:0] o1_41_reg, o1_42_reg, o1_43_reg, o1_44_reg;

reg signed [51:0] o2_11_reg, o2_12_reg, o2_13_reg, o2_14_reg;
reg signed [51:0] o2_21_reg, o2_22_reg, o2_23_reg, o2_24_reg;
reg signed [51:0] o2_31_reg, o2_32_reg, o2_33_reg, o2_34_reg;
reg signed [51:0] o2_41_reg, o2_42_reg, o2_43_reg, o2_44_reg;

reg signed [51:0] o3_11_reg, o3_12_reg, o3_13_reg, o3_14_reg;
reg signed [51:0] o3_21_reg, o3_22_reg, o3_23_reg, o3_24_reg;
reg signed [51:0] o3_31_reg, o3_32_reg, o3_33_reg, o3_34_reg;
reg signed [51:0] o3_41_reg, o3_42_reg, o3_43_reg, o3_44_reg;

reg signed [51:0] o4_11_reg, o4_12_reg, o4_13_reg, o4_14_reg;
reg signed [51:0] o4_21_reg, o4_22_reg, o4_23_reg, o4_24_reg;
reg signed [51:0] o4_31_reg, o4_32_reg, o4_33_reg, o4_34_reg;
reg signed [51:0] o4_41_reg, o4_42_reg, o4_43_reg, o4_44_reg;


assign o1_11 = o1_11_reg[38:13];
assign o1_12 = o1_12_reg[38:13];
assign o1_13 = o1_13_reg[38:13];
assign o1_14 = o1_14_reg[38:13];
assign o1_21 = o1_21_reg[38:13];
assign o1_22 = o1_22_reg[38:13];
assign o1_23 = o1_23_reg[38:13];
assign o1_24 = o1_24_reg[38:13];
assign o1_31 = o1_31_reg[38:13];
assign o1_32 = o1_32_reg[38:13];
assign o1_33 = o1_33_reg[38:13];
assign o1_34 = o1_34_reg[38:13];
assign o1_41 = o1_41_reg[38:13];
assign o1_42 = o1_42_reg[38:13];
assign o1_43 = o1_43_reg[38:13];
assign o1_44 = o1_44_reg[38:13];

assign o2_11 = o2_11_reg[38:13];
assign o2_12 = o2_12_reg[38:13];
assign o2_13 = o2_13_reg[38:13];
assign o2_14 = o2_14_reg[38:13];
assign o2_21 = o2_21_reg[38:13];
assign o2_22 = o2_22_reg[38:13];
assign o2_23 = o2_23_reg[38:13];
assign o2_24 = o2_24_reg[38:13];
assign o2_31 = o2_31_reg[38:13];
assign o2_32 = o2_32_reg[38:13];
assign o2_33 = o2_33_reg[38:13];
assign o2_34 = o2_34_reg[38:13];
assign o2_41 = o2_41_reg[38:13];
assign o2_42 = o2_42_reg[38:13];
assign o2_43 = o2_43_reg[38:13];
assign o2_44 = o2_44_reg[38:13];

assign o3_11 = o3_11_reg[38:13];
assign o3_12 = o3_12_reg[38:13];
assign o3_13 = o3_13_reg[38:13];
assign o3_14 = o3_14_reg[38:13];
assign o3_21 = o3_21_reg[38:13];
assign o3_22 = o3_22_reg[38:13];
assign o3_23 = o3_23_reg[38:13];
assign o3_24 = o3_24_reg[38:13];
assign o3_31 = o3_31_reg[38:13];
assign o3_32 = o3_32_reg[38:13];
assign o3_33 = o3_33_reg[38:13];
assign o3_34 = o3_34_reg[38:13];
assign o3_41 = o3_41_reg[38:13];
assign o3_42 = o3_42_reg[38:13];
assign o3_43 = o3_43_reg[38:13];
assign o3_44 = o3_44_reg[38:13];

assign o4_11 = o4_11_reg[38:13];
assign o4_12 = o4_12_reg[38:13];
assign o4_13 = o4_13_reg[38:13];
assign o4_14 = o4_14_reg[38:13];
assign o4_21 = o4_21_reg[38:13];
assign o4_22 = o4_22_reg[38:13];
assign o4_23 = o4_23_reg[38:13];
assign o4_24 = o4_24_reg[38:13];
assign o4_31 = o4_31_reg[38:13];
assign o4_32 = o4_32_reg[38:13];
assign o4_33 = o4_33_reg[38:13];
assign o4_34 = o4_34_reg[38:13];
assign o4_41 = o4_41_reg[38:13];
assign o4_42 = o4_42_reg[38:13];
assign o4_43 = o4_43_reg[38:13];
assign o4_44 = o4_44_reg[38:13];

always @(posedge clk_mul)
begin
    if (en_mul) begin
        // (zTw)^2
        o1_11_reg <= i1_11 * i1_11 + i1_12 * i1_21 + i1_13 * i1_31 + i1_14 * i1_41;
        o1_12_reg <= i1_11 * i1_12 + i1_12 * i1_22 + i1_13 * i1_32 + i1_14 * i1_42;
        o1_13_reg <= i1_11 * i1_13 + i1_12 * i1_23 + i1_13 * i1_33 + i1_14 * i1_43;
        o1_14_reg <= i1_11 * i1_14 + i1_12 * i1_24 + i1_13 * i1_34 + i1_14 * i1_44;
        o1_21_reg <= i1_21 * i1_11 + i1_22 * i1_21 + i1_23 * i1_31 + i1_24 * i1_41;
        o1_22_reg <= i1_21 * i1_12 + i1_22 * i1_22 + i1_23 * i1_32 + i1_24 * i1_42;
        o1_23_reg <= i1_21 * i1_13 + i1_22 * i1_23 + i1_23 * i1_33 + i1_24 * i1_43;
        o1_24_reg <= i1_21 * i1_14 + i1_22 * i1_24 + i1_23 * i1_34 + i1_24 * i1_44;
        o1_31_reg <= i1_31 * i1_11 + i1_32 * i1_21 + i1_33 * i1_31 + i1_34 * i1_41;
        o1_32_reg <= i1_31 * i1_12 + i1_32 * i1_22 + i1_33 * i1_32 + i1_34 * i1_42;
        o1_33_reg <= i1_31 * i1_13 + i1_32 * i1_23 + i1_33 * i1_33 + i1_34 * i1_43;
        o1_34_reg <= i1_31 * i1_14 + i1_32 * i1_24 + i1_33 * i1_34 + i1_34 * i1_44;
        o1_41_reg <= i1_41 * i1_11 + i1_42 * i1_21 + i1_43 * i1_31 + i1_44 * i1_41;
        o1_42_reg <= i1_41 * i1_12 + i1_42 * i1_22 + i1_43 * i1_32 + i1_44 * i1_42;
        o1_43_reg <= i1_41 * i1_13 + i1_42 * i1_23 + i1_43 * i1_33 + i1_44 * i1_43;
        o1_44_reg <= i1_41 * i1_14 + i1_42 * i1_24 + i1_43 * i1_34 + i1_44 * i1_44;

        o2_11_reg <= i2_11 * i2_11 + i2_12 * i2_21 + i2_13 * i2_31 + i2_14 * i2_41;
        o2_12_reg <= i2_11 * i2_12 + i2_12 * i2_22 + i2_13 * i2_32 + i2_14 * i2_42;
        o2_13_reg <= i2_11 * i2_13 + i2_12 * i2_23 + i2_13 * i2_33 + i2_14 * i2_43;
        o2_14_reg <= i2_11 * i2_14 + i2_12 * i2_24 + i2_13 * i2_34 + i2_14 * i2_44;
        o2_21_reg <= i2_21 * i2_11 + i2_22 * i2_21 + i2_23 * i2_31 + i2_24 * i2_41;
        o2_22_reg <= i2_21 * i2_12 + i2_22 * i2_22 + i2_23 * i2_32 + i2_24 * i2_42;
        o2_23_reg <= i2_21 * i2_13 + i2_22 * i2_23 + i2_23 * i2_33 + i2_24 * i2_43;
        o2_24_reg <= i2_21 * i2_14 + i2_22 * i2_24 + i2_23 * i2_34 + i2_24 * i2_44;
        o2_31_reg <= i2_31 * i2_11 + i2_32 * i2_21 + i2_33 * i2_31 + i2_34 * i2_41;
        o2_32_reg <= i2_31 * i2_12 + i2_32 * i2_22 + i2_33 * i2_32 + i2_34 * i2_42;
        o2_33_reg <= i2_31 * i2_13 + i2_32 * i2_23 + i2_33 * i2_33 + i2_34 * i2_43;
        o2_34_reg <= i2_31 * i2_14 + i2_32 * i2_24 + i2_33 * i2_34 + i2_34 * i2_44;
        o2_41_reg <= i2_41 * i2_11 + i2_42 * i2_21 + i2_43 * i2_31 + i2_44 * i2_41;
        o2_42_reg <= i2_41 * i2_12 + i2_42 * i2_22 + i2_43 * i2_32 + i2_44 * i2_42;
        o2_43_reg <= i2_41 * i2_13 + i2_42 * i2_23 + i2_43 * i2_33 + i2_44 * i2_43;
        o2_44_reg <= i2_41 * i2_14 + i2_42 * i2_24 + i2_43 * i2_34 + i2_44 * i2_44;

        o3_11_reg <= i3_11 * i3_11 + i3_12 * i3_21 + i3_13 * i3_31 + i3_14 * i3_41;
        o3_12_reg <= i3_11 * i3_12 + i3_12 * i3_22 + i3_13 * i3_32 + i3_14 * i3_42;
        o3_13_reg <= i3_11 * i3_13 + i3_12 * i3_23 + i3_13 * i3_33 + i3_14 * i3_43;
        o3_14_reg <= i3_11 * i3_14 + i3_12 * i3_24 + i3_13 * i3_34 + i3_14 * i3_44;
        o3_21_reg <= i3_21 * i3_11 + i3_22 * i3_21 + i3_23 * i3_31 + i3_24 * i3_41;
        o3_22_reg <= i3_21 * i3_12 + i3_22 * i3_22 + i3_23 * i3_32 + i3_24 * i3_42;
        o3_23_reg <= i3_21 * i3_13 + i3_22 * i3_23 + i3_23 * i3_33 + i3_24 * i3_43;
        o3_24_reg <= i3_21 * i3_14 + i3_22 * i3_24 + i3_23 * i3_34 + i3_24 * i3_44;
        o3_31_reg <= i3_31 * i3_11 + i3_32 * i3_21 + i3_33 * i3_31 + i3_34 * i3_41;
        o3_32_reg <= i3_31 * i3_12 + i3_32 * i3_22 + i3_33 * i3_32 + i3_34 * i3_42;
        o3_33_reg <= i3_31 * i3_13 + i3_32 * i3_23 + i3_33 * i3_33 + i3_34 * i3_43;
        o3_34_reg <= i3_31 * i3_14 + i3_32 * i3_24 + i3_33 * i3_34 + i3_34 * i3_44;
        o3_41_reg <= i3_41 * i3_11 + i3_42 * i3_21 + i3_43 * i3_31 + i3_44 * i3_41;
        o3_42_reg <= i3_41 * i3_12 + i3_42 * i3_22 + i3_43 * i3_32 + i3_44 * i3_42;
        o3_43_reg <= i3_41 * i3_13 + i3_42 * i3_23 + i3_43 * i3_33 + i3_44 * i3_43;
        o3_44_reg <= i3_41 * i3_14 + i3_42 * i3_24 + i3_43 * i3_34 + i3_44 * i3_44;

        o4_11_reg <= i4_11 * i4_11 + i4_12 * i4_21 + i4_13 * i4_31 + i4_14 * i4_41;
        o4_12_reg <= i4_11 * i4_12 + i4_12 * i4_22 + i4_13 * i4_32 + i4_14 * i4_42;
        o4_13_reg <= i4_11 * i4_13 + i4_12 * i4_23 + i4_13 * i4_33 + i4_14 * i4_43;
        o4_14_reg <= i4_11 * i4_14 + i4_12 * i4_24 + i4_13 * i4_34 + i4_14 * i4_44;
        o4_21_reg <= i4_21 * i4_11 + i4_22 * i4_21 + i4_23 * i4_31 + i4_24 * i4_41;
        o4_22_reg <= i4_21 * i4_12 + i4_22 * i4_22 + i4_23 * i4_32 + i4_24 * i4_42;
        o4_23_reg <= i4_21 * i4_13 + i4_22 * i4_23 + i4_23 * i4_33 + i4_24 * i4_43;
        o4_24_reg <= i4_21 * i4_14 + i4_22 * i4_24 + i4_23 * i4_34 + i4_24 * i4_44;
        o4_31_reg <= i4_31 * i4_11 + i4_32 * i4_21 + i4_33 * i4_31 + i4_34 * i4_41;
        o4_32_reg <= i4_31 * i4_12 + i4_32 * i4_22 + i4_33 * i4_32 + i4_34 * i4_42;
        o4_33_reg <= i4_31 * i4_13 + i4_32 * i4_23 + i4_33 * i4_33 + i4_34 * i4_43;
        o4_34_reg <= i4_31 * i4_14 + i4_32 * i4_24 + i4_33 * i4_34 + i4_34 * i4_44;
        o4_41_reg <= i4_41 * i4_11 + i4_42 * i4_21 + i4_43 * i4_31 + i4_44 * i4_41;
        o4_42_reg <= i4_41 * i4_12 + i4_42 * i4_22 + i4_43 * i4_32 + i4_44 * i4_42;
        o4_43_reg <= i4_41 * i4_13 + i4_42 * i4_23 + i4_43 * i4_33 + i4_44 * i4_43;
        o4_44_reg <= i4_41 * i4_14 + i4_42 * i4_24 + i4_43 * i4_34 + i4_44 * i4_44;
    end
end
    
endmodule
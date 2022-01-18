module FASTICA (
    input clk_fast,
    input go_fast,

    input signed [25:0] z1, z2, z3, z4,

    input signed [25:0] w11_in, w12_in, w13_in, w14_in,
    input signed [25:0] w21_in, w22_in, w23_in, w24_in,
    input signed [25:0] w31_in, w32_in, w33_in, w34_in,
    input signed [25:0] w41_in, w42_in, w43_in, w44_in,

    output fast_busy,
    // E(Z(Z^TW)^3) - 3W
    output signed [25:0] w11_out, w12_out, w13_out, w14_out,
    output signed [25:0] w21_out, w22_out, w23_out, w24_out,
    output signed [25:0] w31_out, w32_out, w33_out, w34_out,
    output signed [25:0] w41_out, w42_out, w43_out, w44_out
);

// clk/en are generated from fast_controller
wire clk_b, clk_sub, clk_mul1, clk_mul2, clk_mul3, clk_mul4, clk_mul5, clk_mean;
wire en_b, en_sub, en_mul1, en_mul2, en_mul3, en_mul4, en_mul5, en_mean;
// Decided unmixing matrix W. output of B_decision, input of mul1.
wire signed [25:0] w11_d, w12_d, w13_d, w14_d;
wire signed [25:0] w21_d, w22_d, w23_d, w24_d;
wire signed [25:0] w31_d, w32_d, w33_d, w34_d;
wire signed [25:0] w41_d, w42_d, w43_d, w44_d;
// 3*W. output of mul5, input of subtractor
wire signed [25:0] w11_3, w12_3, w13_3, w14_3;
wire signed [25:0] w21_3, w22_3, w23_3, w24_3;
wire signed [25:0] w31_3, w32_3, w33_3, w34_3;
wire signed [25:0] w41_3, w42_3, w43_3, w44_3;
// E(Z(Z^TW)^3)
wire signed [25:0] mean11, mean12, mean13, mean14;
wire signed [25:0] mean21, mean22, mean23, mean24;
wire signed [25:0] mean31, mean32, mean33, mean34;
wire signed [25:0] mean41, mean42, mean43, mean44;
// Z^T*W1
wire signed [25:0] zw1_11, zw1_12, zw1_13, zw1_14;
wire signed [25:0] zw1_21, zw1_22, zw1_23, zw1_24;
wire signed [25:0] zw1_31, zw1_32, zw1_33, zw1_34;
wire signed [25:0] zw1_41, zw1_42, zw1_43, zw1_44;
// Z^T*W2
wire signed [25:0] zw2_11, zw2_12, zw2_13, zw2_14;
wire signed [25:0] zw2_21, zw2_22, zw2_23, zw2_24;
wire signed [25:0] zw2_31, zw2_32, zw2_33, zw2_34;
wire signed [25:0] zw2_41, zw2_42, zw2_43, zw2_44;
// Z^T*W3
wire signed [25:0] zw3_11, zw3_12, zw3_13, zw3_14;
wire signed [25:0] zw3_21, zw3_22, zw3_23, zw3_24;
wire signed [25:0] zw3_31, zw3_32, zw3_33, zw3_34;
wire signed [25:0] zw3_41, zw3_42, zw3_43, zw3_44;
// Z^T*W4
wire signed [25:0] zw4_11, zw4_12, zw4_13, zw4_14;
wire signed [25:0] zw4_21, zw4_22, zw4_23, zw4_24;
wire signed [25:0] zw4_31, zw4_32, zw4_33, zw4_34;
wire signed [25:0] zw4_41, zw4_42, zw4_43, zw4_44;
// Z^T*W1
wire signed [25:0] zw1_1_11, zw1_1_12, zw1_1_13, zw1_1_14;
wire signed [25:0] zw1_1_21, zw1_1_22, zw1_1_23, zw1_1_24;
wire signed [25:0] zw1_1_31, zw1_1_32, zw1_1_33, zw1_1_34;
wire signed [25:0] zw1_1_41, zw1_1_42, zw1_1_43, zw1_1_44;
// Z^T*W2
wire signed [25:0] zw2_1_11, zw2_1_12, zw2_1_13, zw2_1_14;
wire signed [25:0] zw2_1_21, zw2_1_22, zw2_1_23, zw2_1_24;
wire signed [25:0] zw2_1_31, zw2_1_32, zw2_1_33, zw2_1_34;
wire signed [25:0] zw2_1_41, zw2_1_42, zw2_1_43, zw2_1_44;
// Z^T*W3
wire signed [25:0] zw3_1_11, zw3_1_12, zw3_1_13, zw3_1_14;
wire signed [25:0] zw3_1_21, zw3_1_22, zw3_1_23, zw3_1_24;
wire signed [25:0] zw3_1_31, zw3_1_32, zw3_1_33, zw3_1_34;
wire signed [25:0] zw3_1_41, zw3_1_42, zw3_1_43, zw3_1_44;
// Z^T*W4
wire signed [25:0] zw4_1_11, zw4_1_12, zw4_1_13, zw4_1_14;
wire signed [25:0] zw4_1_21, zw4_1_22, zw4_1_23, zw4_1_24;
wire signed [25:0] zw4_1_31, zw4_1_32, zw4_1_33, zw4_1_34;
wire signed [25:0] zw4_1_41, zw4_1_42, zw4_1_43, zw4_1_44;
// (Z^T*W1)^2
wire signed [25:0] zw1_2_11, zw1_2_12, zw1_2_13, zw1_2_14;
wire signed [25:0] zw1_2_21, zw1_2_22, zw1_2_23, zw1_2_24;
wire signed [25:0] zw1_2_31, zw1_2_32, zw1_2_33, zw1_2_34;
wire signed [25:0] zw1_2_41, zw1_2_42, zw1_2_43, zw1_2_44;
// (Z^T*W2)^2
wire signed [25:0] zw2_2_11, zw2_2_12, zw2_2_13, zw2_2_14;
wire signed [25:0] zw2_2_21, zw2_2_22, zw2_2_23, zw2_2_24;
wire signed [25:0] zw2_2_31, zw2_2_32, zw2_2_33, zw2_2_34;
wire signed [25:0] zw2_2_41, zw2_2_42, zw2_2_43, zw2_2_44;
// (Z^T*W3)^2
wire signed [25:0] zw3_2_11, zw3_2_12, zw3_2_13, zw3_2_14;
wire signed [25:0] zw3_2_21, zw3_2_22, zw3_2_23, zw3_2_24;
wire signed [25:0] zw3_2_31, zw3_2_32, zw3_2_33, zw3_2_34;
wire signed [25:0] zw3_2_41, zw3_2_42, zw3_2_43, zw3_2_44;
// (Z^T*W4)^2
wire signed [25:0] zw4_2_11, zw4_2_12, zw4_2_13, zw4_2_14;
wire signed [25:0] zw4_2_21, zw4_2_22, zw4_2_23, zw4_2_24;
wire signed [25:0] zw4_2_31, zw4_2_32, zw4_2_33, zw4_2_34;
wire signed [25:0] zw4_2_41, zw4_2_42, zw4_2_43, zw4_2_44;
// (Z^T*W1)^3
wire signed [25:0] zw1_3_11, zw1_3_12, zw1_3_13, zw1_3_14;
wire signed [25:0] zw1_3_21, zw1_3_22, zw1_3_23, zw1_3_24;
wire signed [25:0] zw1_3_31, zw1_3_32, zw1_3_33, zw1_3_34;
wire signed [25:0] zw1_3_41, zw1_3_42, zw1_3_43, zw1_3_44;
// (Z^T*W2)^3
wire signed [25:0] zw2_3_11, zw2_3_12, zw2_3_13, zw2_3_14;
wire signed [25:0] zw2_3_21, zw2_3_22, zw2_3_23, zw2_3_24;
wire signed [25:0] zw2_3_31, zw2_3_32, zw2_3_33, zw2_3_34;
wire signed [25:0] zw2_3_41, zw2_3_42, zw2_3_43, zw2_3_44;
// (Z^T*W3)^3
wire signed [25:0] zw3_3_11, zw3_3_12, zw3_3_13, zw3_3_14;
wire signed [25:0] zw3_3_21, zw3_3_22, zw3_3_23, zw3_3_24;
wire signed [25:0] zw3_3_31, zw3_3_32, zw3_3_33, zw3_3_34;
wire signed [25:0] zw3_3_41, zw3_3_42, zw3_3_43, zw3_3_44;
// (Z^T*W4)^3
wire signed [25:0] zw4_3_11, zw4_3_12, zw4_3_13, zw4_3_14;
wire signed [25:0] zw4_3_21, zw4_3_22, zw4_3_23, zw4_3_24;
wire signed [25:0] zw4_3_31, zw4_3_32, zw4_3_33, zw4_3_34;
wire signed [25:0] zw4_3_41, zw4_3_42, zw4_3_43, zw4_3_44;
// Z(Z^T*W1)^3
wire signed [25:0] z_zw_3_11, z_zw_3_12, z_zw_3_13, z_zw_3_14;
wire signed [25:0] z_zw_3_21, z_zw_3_22, z_zw_3_23, z_zw_3_24;
wire signed [25:0] z_zw_3_31, z_zw_3_32, z_zw_3_33, z_zw_3_34;
wire signed [25:0] z_zw_3_41, z_zw_3_42, z_zw_3_43, z_zw_3_44;

wire signed [25:0] zmul1_1, zmul1_2, zmul1_3, zmul1_4;
wire signed [25:0] zmul2_1, zmul2_2, zmul2_3, zmul2_4;
wire signed [25:0] zmul3_1, zmul3_2, zmul3_3, zmul3_4;

FAST_CONTROLLER fast_controller (
    .clk_fast(clk_fast),
    .go_fast(go_fast),
    .fast_busy(fast_busy),

    .clk_b(clk_b),
    .clk_sub(clk_sub),
    .clk_mul1(clk_mul1),
    .clk_mul2(clk_mul2),
    .clk_mul3(clk_mul3),
    .clk_mul4(clk_mul4),
    .clk_mul5(clk_mul5),
    .clk_mean(clk_mean),

    .en_b(en_b),
    .en_sub(en_sub),
    .en_mul1(en_mul1),
    .en_mul2(en_mul2),
    .en_mul3(en_mul3),
    .en_mul4(en_mul4),
    .en_mul5(en_mul5),
    .en_mean(en_mean)
);

B_DECISION b_decision (
    .clk_b(clk_b),
    .en_b(en_b),

    .iw11(w11_in), .iw12(w12_in), .iw13(w13_in), .iw14(w14_in),
    .iw21(w21_in), .iw22(w22_in), .iw23(w23_in), .iw24(w24_in),
    .iw31(w31_in), .iw32(w32_in), .iw33(w33_in), .iw34(w34_in),
    .iw41(w41_in), .iw42(w42_in), .iw43(w43_in), .iw44(w44_in),

    .ow11(w11_d), .ow12(w12_d), .ow13(w13_d), .ow14(w14_d),
    .ow21(w21_d), .ow22(w22_d), .ow23(w23_d), .ow24(w24_d),
    .ow31(w31_d), .ow32(w32_d), .ow33(w33_d), .ow34(w34_d),
    .ow41(w41_d), .ow42(w42_d), .ow43(w43_d), .ow44(w44_d)
);

MUL1 mul1(
    .clk_mul(clk_mul1),
    .en_mul(en_mul1),
    
    .z1(z1), .z2(z2), .z3(z3), .z4(z4),

    .w11(w11_d), .w12(w12_d), .w13(w13_d), .w14(w14_d),
    .w21(w21_d), .w22(w22_d), .w23(w23_d), .w24(w24_d),
    .w31(w31_d), .w32(w32_d), .w33(w33_d), .w34(w34_d),
    .w41(w41_d), .w42(w42_d), .w43(w43_d), .w44(w44_d),

    .zo1(zmul1_1), .zo2(zmul1_2), .zo3(zmul1_3), .zo4(zmul1_4),

    .zw1_11(zw1_11), .zw1_12(zw1_12), .zw1_13(zw1_13), .zw1_14(zw1_14),
    .zw1_21(zw1_21), .zw1_22(zw1_22), .zw1_23(zw1_23), .zw1_24(zw1_24),
    .zw1_31(zw1_31), .zw1_32(zw1_32), .zw1_33(zw1_33), .zw1_34(zw1_34),
    .zw1_41(zw1_41), .zw1_42(zw1_42), .zw1_43(zw1_43), .zw1_44(zw1_44),

    .zw2_11(zw2_11), .zw2_12(zw2_12), .zw2_13(zw2_13), .zw2_14(zw2_14),
    .zw2_21(zw2_21), .zw2_22(zw2_22), .zw2_23(zw2_23), .zw2_24(zw2_24),
    .zw2_31(zw2_31), .zw2_32(zw2_32), .zw2_33(zw2_33), .zw2_34(zw2_34),
    .zw2_41(zw2_41), .zw2_42(zw2_42), .zw2_43(zw2_43), .zw2_44(zw2_44),

    .zw3_11(zw3_11), .zw3_12(zw3_12), .zw3_13(zw3_13), .zw3_14(zw3_14),
    .zw3_21(zw3_21), .zw3_22(zw3_22), .zw3_23(zw3_23), .zw3_24(zw3_24),
    .zw3_31(zw3_31), .zw3_32(zw3_32), .zw3_33(zw3_33), .zw3_34(zw3_34),
    .zw3_41(zw3_41), .zw3_42(zw3_42), .zw3_43(zw3_43), .zw3_44(zw3_44),

    .zw4_11(zw4_11), .zw4_12(zw4_12), .zw4_13(zw4_13), .zw4_14(zw4_14),
    .zw4_21(zw4_21), .zw4_22(zw4_22), .zw4_23(zw4_23), .zw4_24(zw4_24),
    .zw4_31(zw4_31), .zw4_32(zw4_32), .zw4_33(zw4_33), .zw4_34(zw4_34),
    .zw4_41(zw4_41), .zw4_42(zw4_42), .zw4_43(zw4_43), .zw4_44(zw4_44)
);

MUL2 mul2 (
    .clk_mul(clk_mul2),
    .en_mul(en_mul2),

    .zi1(zmul1_1), .zi2(zmul1_2), .zi3(zmul1_3), .zi4(zmul1_4),

    .i1_11(zw1_11), .i1_12(zw1_12), .i1_13(zw1_13), .i1_14(zw1_14),
    .i1_21(zw1_21), .i1_22(zw1_22), .i1_23(zw1_23), .i1_24(zw1_24),
    .i1_31(zw1_31), .i1_32(zw1_32), .i1_33(zw1_33), .i1_34(zw1_34),
    .i1_41(zw1_41), .i1_42(zw1_42), .i1_43(zw1_43), .i1_44(zw1_44),

    .i2_11(zw2_11), .i2_12(zw2_12), .i2_13(zw2_13), .i2_14(zw2_14),
    .i2_21(zw2_21), .i2_22(zw2_22), .i2_23(zw2_23), .i2_24(zw2_24),
    .i2_31(zw2_31), .i2_32(zw2_32), .i2_33(zw2_33), .i2_34(zw2_34),
    .i2_41(zw2_41), .i2_42(zw2_42), .i2_43(zw2_43), .i2_44(zw2_44),

    .i3_11(zw3_11), .i3_12(zw3_12), .i3_13(zw3_13), .i3_14(zw3_14),
    .i3_21(zw3_21), .i3_22(zw3_22), .i3_23(zw3_23), .i3_24(zw3_24),
    .i3_31(zw3_31), .i3_32(zw3_32), .i3_33(zw3_33), .i3_34(zw3_34),
    .i3_41(zw3_41), .i3_42(zw3_42), .i3_43(zw3_43), .i3_44(zw3_44),

    .i4_11(zw4_11), .i4_12(zw4_12), .i4_13(zw4_13), .i4_14(zw4_14),
    .i4_21(zw4_21), .i4_22(zw4_22), .i4_23(zw4_23), .i4_24(zw4_24),
    .i4_31(zw4_31), .i4_32(zw4_32), .i4_33(zw4_33), .i4_34(zw4_34),
    .i4_41(zw4_41), .i4_42(zw4_42), .i4_43(zw4_43), .i4_44(zw4_44),

    .zo1(zmul2_1), .zo2(zmul2_2), .zo3(zmul2_3), .zo4(zmul2_4),

    .zw1_11(zw1_1_11), .zw1_12(zw1_1_12), .zw1_13(zw1_1_13), .zw1_14(zw1_1_14),
    .zw1_21(zw1_1_21), .zw1_22(zw1_1_22), .zw1_23(zw1_1_23), .zw1_24(zw1_1_24),
    .zw1_31(zw1_1_31), .zw1_32(zw1_1_32), .zw1_33(zw1_1_33), .zw1_34(zw1_1_34),
    .zw1_41(zw1_1_41), .zw1_42(zw1_1_42), .zw1_43(zw1_1_43), .zw1_44(zw1_1_44),

    .zw2_11(zw2_1_11), .zw2_12(zw2_1_12), .zw2_13(zw2_1_13), .zw2_14(zw2_1_14),
    .zw2_21(zw2_1_21), .zw2_22(zw2_1_22), .zw2_23(zw2_1_23), .zw2_24(zw2_1_24),
    .zw2_31(zw2_1_31), .zw2_32(zw2_1_32), .zw2_33(zw2_1_33), .zw2_34(zw2_1_34),
    .zw2_41(zw2_1_41), .zw2_42(zw2_1_42), .zw2_43(zw2_1_43), .zw2_44(zw2_1_44),

    .zw3_11(zw3_1_11), .zw3_12(zw3_1_12), .zw3_13(zw3_1_13), .zw3_14(zw3_1_14),
    .zw3_21(zw3_1_21), .zw3_22(zw3_1_22), .zw3_23(zw3_1_23), .zw3_24(zw3_1_24),
    .zw3_31(zw3_1_31), .zw3_32(zw3_1_32), .zw3_33(zw3_1_33), .zw3_34(zw3_1_34),
    .zw3_41(zw3_1_41), .zw3_42(zw3_1_42), .zw3_43(zw3_1_43), .zw3_44(zw3_1_44),

    .zw4_11(zw4_1_11), .zw4_12(zw4_1_12), .zw4_13(zw4_1_13), .zw4_14(zw4_1_14),
    .zw4_21(zw4_1_21), .zw4_22(zw4_1_22), .zw4_23(zw4_1_23), .zw4_24(zw4_1_24),
    .zw4_31(zw4_1_31), .zw4_32(zw4_1_32), .zw4_33(zw4_1_33), .zw4_34(zw4_1_34),
    .zw4_41(zw4_1_41), .zw4_42(zw4_1_42), .zw4_43(zw4_1_43), .zw4_44(zw4_1_44),

    .o1_11(zw1_2_11), .o1_12(zw1_2_12), .o1_13(zw1_2_13), .o1_14(zw1_2_14),
    .o1_21(zw1_2_21), .o1_22(zw1_2_22), .o1_23(zw1_2_23), .o1_24(zw1_2_24),
    .o1_31(zw1_2_31), .o1_32(zw1_2_32), .o1_33(zw1_2_33), .o1_34(zw1_2_34),
    .o1_41(zw1_2_41), .o1_42(zw1_2_42), .o1_43(zw1_2_43), .o1_44(zw1_2_44),

    .o2_11(zw2_2_11), .o2_12(zw2_2_12), .o2_13(zw2_2_13), .o2_14(zw2_2_14),
    .o2_21(zw2_2_21), .o2_22(zw2_2_22), .o2_23(zw2_2_23), .o2_24(zw2_2_24),
    .o2_31(zw2_2_31), .o2_32(zw2_2_32), .o2_33(zw2_2_33), .o2_34(zw2_2_34),
    .o2_41(zw2_2_41), .o2_42(zw2_2_42), .o2_43(zw2_2_43), .o2_44(zw2_2_44),

    .o3_11(zw3_2_11), .o3_12(zw3_2_12), .o3_13(zw3_2_13), .o3_14(zw3_2_14),
    .o3_21(zw3_2_21), .o3_22(zw3_2_22), .o3_23(zw3_2_23), .o3_24(zw3_2_24),
    .o3_31(zw3_2_31), .o3_32(zw3_2_32), .o3_33(zw3_2_33), .o3_34(zw3_2_34),
    .o3_41(zw3_2_41), .o3_42(zw3_2_42), .o3_43(zw3_2_43), .o3_44(zw3_2_44),

    .o4_11(zw4_2_11), .o4_12(zw4_2_12), .o4_13(zw4_2_13), .o4_14(zw4_2_14),
    .o4_21(zw4_2_21), .o4_22(zw4_2_22), .o4_23(zw4_2_23), .o4_24(zw4_2_24),
    .o4_31(zw4_2_31), .o4_32(zw4_2_32), .o4_33(zw4_2_33), .o4_34(zw4_2_34),
    .o4_41(zw4_2_41), .o4_42(zw4_2_42), .o4_43(zw4_2_43), .o4_44(zw4_2_44)
);

MUL3 mul3 (
    .clk_mul(clk_mul3),
    .en_mul(en_mul3),

    .zi1(zmul2_1), .zi2(zmul2_2), .zi3(zmul2_3), .zi4(zmul2_4),

    .zw1_11(zw1_1_11), .zw1_12(zw1_1_12), .zw1_13(zw1_1_13), .zw1_14(zw1_1_14),
    .zw1_21(zw1_1_21), .zw1_22(zw1_1_22), .zw1_23(zw1_1_23), .zw1_24(zw1_1_24),
    .zw1_31(zw1_1_31), .zw1_32(zw1_1_32), .zw1_33(zw1_1_33), .zw1_34(zw1_1_34),
    .zw1_41(zw1_1_41), .zw1_42(zw1_1_42), .zw1_43(zw1_1_43), .zw1_44(zw1_1_44),

    .zw2_11(zw2_1_11), .zw2_12(zw2_1_12), .zw2_13(zw2_1_13), .zw2_14(zw2_1_14),
    .zw2_21(zw2_1_21), .zw2_22(zw2_1_22), .zw2_23(zw2_1_23), .zw2_24(zw2_1_24),
    .zw2_31(zw2_1_31), .zw2_32(zw2_1_32), .zw2_33(zw2_1_33), .zw2_34(zw2_1_34),
    .zw2_41(zw2_1_41), .zw2_42(zw2_1_42), .zw2_43(zw2_1_43), .zw2_44(zw2_1_44),

    .zw3_11(zw3_1_11), .zw3_12(zw3_1_12), .zw3_13(zw3_1_13), .zw3_14(zw3_1_14),
    .zw3_21(zw3_1_21), .zw3_22(zw3_1_22), .zw3_23(zw3_1_23), .zw3_24(zw3_1_24),
    .zw3_31(zw3_1_31), .zw3_32(zw3_1_32), .zw3_33(zw3_1_33), .zw3_34(zw3_1_34),
    .zw3_41(zw3_1_41), .zw3_42(zw3_1_42), .zw3_43(zw3_1_43), .zw3_44(zw3_1_44),

    .zw4_11(zw4_1_11), .zw4_12(zw4_1_12), .zw4_13(zw4_1_13), .zw4_14(zw4_1_14),
    .zw4_21(zw4_1_21), .zw4_22(zw4_1_22), .zw4_23(zw4_1_23), .zw4_24(zw4_1_24),
    .zw4_31(zw4_1_31), .zw4_32(zw4_1_32), .zw4_33(zw4_1_33), .zw4_34(zw4_1_34),
    .zw4_41(zw4_1_41), .zw4_42(zw4_1_42), .zw4_43(zw4_1_43), .zw4_44(zw4_1_44),

    .i1_11(zw1_2_11), .i1_12(zw1_2_12), .i1_13(zw1_2_13), .i1_14(zw1_2_14),
    .i1_21(zw1_2_21), .i1_22(zw1_2_22), .i1_23(zw1_2_23), .i1_24(zw1_2_24),
    .i1_31(zw1_2_31), .i1_32(zw1_2_32), .i1_33(zw1_2_33), .i1_34(zw1_2_34),
    .i1_41(zw1_2_41), .i1_42(zw1_2_42), .i1_43(zw1_2_43), .i1_44(zw1_2_44),

    .i2_11(zw2_2_11), .i2_12(zw2_2_12), .i2_13(zw2_2_13), .i2_14(zw2_2_14),
    .i2_21(zw2_2_21), .i2_22(zw2_2_22), .i2_23(zw2_2_23), .i2_24(zw2_2_24),
    .i2_31(zw2_2_31), .i2_32(zw2_2_32), .i2_33(zw2_2_33), .i2_34(zw2_2_34),
    .i2_41(zw2_2_41), .i2_42(zw2_2_42), .i2_43(zw2_2_43), .i2_44(zw2_2_44),

    .i3_11(zw3_2_11), .i3_12(zw3_2_12), .i3_13(zw3_2_13), .i3_14(zw3_2_14),
    .i3_21(zw3_2_21), .i3_22(zw3_2_22), .i3_23(zw3_2_23), .i3_24(zw3_2_24),
    .i3_31(zw3_2_31), .i3_32(zw3_2_32), .i3_33(zw3_2_33), .i3_34(zw3_2_34),
    .i3_41(zw3_2_41), .i3_42(zw3_2_42), .i3_43(zw3_2_43), .i3_44(zw3_2_44),

    .i4_11(zw4_2_11), .i4_12(zw4_2_12), .i4_13(zw4_2_13), .i4_14(zw4_2_14),
    .i4_21(zw4_2_21), .i4_22(zw4_2_22), .i4_23(zw4_2_23), .i4_24(zw4_2_24),
    .i4_31(zw4_2_31), .i4_32(zw4_2_32), .i4_33(zw4_2_33), .i4_34(zw4_2_34),
    .i4_41(zw4_2_41), .i4_42(zw4_2_42), .i4_43(zw4_2_43), .i4_44(zw4_2_44),

    .zo1(zmul3_1), .zo2(zmul3_2), .zo3(zmul3_3), .zo4(zmul3_4),
    
    .zTw_2_1_11(zw1_3_11), .zTw_2_1_12(zw1_3_12), .zTw_2_1_13(zw1_3_13), .zTw_2_1_14(zw1_3_14),
    .zTw_2_1_21(zw1_3_21), .zTw_2_1_22(zw1_3_22), .zTw_2_1_23(zw1_3_23), .zTw_2_1_24(zw1_3_24),
    .zTw_2_1_31(zw1_3_31), .zTw_2_1_32(zw1_3_32), .zTw_2_1_33(zw1_3_33), .zTw_2_1_34(zw1_3_34),
    .zTw_2_1_41(zw1_3_41), .zTw_2_1_42(zw1_3_42), .zTw_2_1_43(zw1_3_43), .zTw_2_1_44(zw1_3_44),

    .zTw_2_2_11(zw2_3_11), .zTw_2_2_12(zw2_3_12), .zTw_2_2_13(zw2_3_13), .zTw_2_2_14(zw2_3_14),
    .zTw_2_2_21(zw2_3_21), .zTw_2_2_22(zw2_3_22), .zTw_2_2_23(zw2_3_23), .zTw_2_2_24(zw2_3_24),
    .zTw_2_2_31(zw2_3_31), .zTw_2_2_32(zw2_3_32), .zTw_2_2_33(zw2_3_33), .zTw_2_2_34(zw2_3_34),
    .zTw_2_2_41(zw2_3_41), .zTw_2_2_42(zw2_3_42), .zTw_2_2_43(zw2_3_43), .zTw_2_2_44(zw2_3_44),

    .zTw_2_3_11(zw3_3_11), .zTw_2_3_12(zw3_3_12), .zTw_2_3_13(zw3_3_13), .zTw_2_3_14(zw3_3_14),
    .zTw_2_3_21(zw3_3_21), .zTw_2_3_22(zw3_3_22), .zTw_2_3_23(zw3_3_23), .zTw_2_3_24(zw3_3_24),
    .zTw_2_3_31(zw3_3_31), .zTw_2_3_32(zw3_3_32), .zTw_2_3_33(zw3_3_33), .zTw_2_3_34(zw3_3_34),
    .zTw_2_3_41(zw3_3_41), .zTw_2_3_42(zw3_3_42), .zTw_2_3_43(zw3_3_43), .zTw_2_3_44(zw3_3_44),

    .zTw_2_4_11(zw4_3_11), .zTw_2_4_12(zw4_3_12), .zTw_2_4_13(zw4_3_13), .zTw_2_4_14(zw4_3_14),
    .zTw_2_4_21(zw4_3_21), .zTw_2_4_22(zw4_3_22), .zTw_2_4_23(zw4_3_23), .zTw_2_4_24(zw4_3_24),
    .zTw_2_4_31(zw4_3_31), .zTw_2_4_32(zw4_3_32), .zTw_2_4_33(zw4_3_33), .zTw_2_4_34(zw4_3_34),
    .zTw_2_4_41(zw4_3_41), .zTw_2_4_42(zw4_3_42), .zTw_2_4_43(zw4_3_43), .zTw_2_4_44(zw4_3_44)
);

MUL4 mul4 (
    .clk_mul(clk_mul4),
    .en_mul(en_mul4),
    
    // z
    .z1(zmul3_1), .z2(zmul3_2), .z3(zmul3_3), .z4(zmul3_4),

    // (zTw)^3
    .i1_11(zw1_3_11), .i1_12(zw1_3_12), .i1_13(zw1_3_13), .i1_14(zw1_3_14),
    .i1_21(zw1_3_21), .i1_22(zw1_3_22), .i1_23(zw1_3_23), .i1_24(zw1_3_24),
    .i1_31(zw1_3_31), .i1_32(zw1_3_32), .i1_33(zw1_3_33), .i1_34(zw1_3_34),
    .i1_41(zw1_3_41), .i1_42(zw1_3_42), .i1_43(zw1_3_43), .i1_44(zw1_3_44),

    .i2_11(zw2_3_11), .i2_12(zw2_3_12), .i2_13(zw2_3_13), .i2_14(zw2_3_14),
    .i2_21(zw2_3_21), .i2_22(zw2_3_22), .i2_23(zw2_3_23), .i2_24(zw2_3_24),
    .i2_31(zw2_3_31), .i2_32(zw2_3_32), .i2_33(zw2_3_33), .i2_34(zw2_3_34),
    .i2_41(zw2_3_41), .i2_42(zw2_3_42), .i2_43(zw2_3_43), .i2_44(zw2_3_44),

    .i3_11(zw3_3_11), .i3_12(zw3_3_12), .i3_13(zw3_3_13), .i3_14(zw3_3_14),
    .i3_21(zw3_3_21), .i3_22(zw3_3_22), .i3_23(zw3_3_23), .i3_24(zw3_3_24),
    .i3_31(zw3_3_31), .i3_32(zw3_3_32), .i3_33(zw3_3_33), .i3_34(zw3_3_34),
    .i3_41(zw3_3_41), .i3_42(zw3_3_42), .i3_43(zw3_3_43), .i3_44(zw3_3_44),

    .i4_11(zw4_3_11), .i4_12(zw4_3_12), .i4_13(zw4_3_13), .i4_14(zw4_3_14),
    .i4_21(zw4_3_21), .i4_22(zw4_3_22), .i4_23(zw4_3_23), .i4_24(zw4_3_24),
    .i4_31(zw4_3_31), .i4_32(zw4_3_32), .i4_33(zw4_3_33), .i4_34(zw4_3_34),
    .i4_41(zw4_3_41), .i4_42(zw4_3_42), .i4_43(zw4_3_43), .i4_44(zw4_3_44),

    .o11(z_zw_3_11), .o12(z_zw_3_12), .o13(z_zw_3_13), .o14(z_zw_3_14),
    .o21(z_zw_3_21), .o22(z_zw_3_22), .o23(z_zw_3_23), .o24(z_zw_3_24),
    .o31(z_zw_3_31), .o32(z_zw_3_32), .o33(z_zw_3_33), .o34(z_zw_3_34),
    .o41(z_zw_3_41), .o42(z_zw_3_42), .o43(z_zw_3_43), .o44(z_zw_3_44)
);

MUL5 mul5 (
    .clk_mul(clk_mul5),
    .en_mul(en_mul5),

    .iw11(w11_d), .iw12(w12_d), .iw13(w13_d), .iw14(w14_d),
    .iw21(w21_d), .iw22(w22_d), .iw23(w23_d), .iw24(w24_d),
    .iw31(w31_d), .iw32(w32_d), .iw33(w33_d), .iw34(w34_d),
    .iw41(w41_d), .iw42(w42_d), .iw43(w43_d), .iw44(w44_d),

    .ow11(w11_3), .ow12(w12_3), .ow13(w13_3), .ow14(w14_3),
    .ow21(w21_3), .ow22(w22_3), .ow23(w23_3), .ow24(w24_3),
    .ow31(w31_3), .ow32(w32_3), .ow33(w33_3), .ow34(w34_3),
    .ow41(w41_3), .ow42(w42_3), .ow43(w43_3), .ow44(w44_3)
);

MEAN_CALC mean_calc (
    .clk_mean(clk_mean),
    .en_mean(en_mean),

    .i11(z_zw_3_11), .i12(z_zw_3_12), .i13(z_zw_3_13), .i14(z_zw_3_14),
    .i21(z_zw_3_21), .i22(z_zw_3_22), .i23(z_zw_3_23), .i24(z_zw_3_24),
    .i31(z_zw_3_31), .i32(z_zw_3_32), .i33(z_zw_3_33), .i34(z_zw_3_34),
    .i41(z_zw_3_41), .i42(z_zw_3_42), .i43(z_zw_3_43), .i44(z_zw_3_44),

    .o11(mean11), .o12(mean12), .o13(mean13), .o14(mean14),
    .o21(mean21), .o22(mean22), .o23(mean23), .o24(mean24),
    .o31(mean31), .o32(mean32), .o33(mean33), .o34(mean34),
    .o41(mean41), .o42(mean42), .o43(mean43), .o44(mean44)
);


SUBTRACTOR subtractor (
    .clk_sub(clk_sub),
    .en_sub(en_sub),

    .i1_11(mean11), .i1_12(mean12), .i1_13(mean13), .i1_14(mean14),
    .i1_21(mean21), .i1_22(mean22), .i1_23(mean23), .i1_24(mean24),
    .i1_31(mean31), .i1_32(mean32), .i1_33(mean33), .i1_34(mean34),
    .i1_41(mean41), .i1_42(mean42), .i1_43(mean43), .i1_44(mean44),

    .i2_11(w11_3), .i2_12(w12_3), .i2_13(w13_3), .i2_14(w14_3),
    .i2_21(w21_3), .i2_22(w22_3), .i2_23(w23_3), .i2_24(w24_3),
    .i2_31(w31_3), .i2_32(w32_3), .i2_33(w33_3), .i2_34(w34_3),
    .i2_41(w41_3), .i2_42(w42_3), .i2_43(w43_3), .i2_44(w44_3),

    .w11(w11_out), .w12(w12_out), .w13(w13_out), .w14(w14_out),
    .w21(w21_out), .w22(w22_out), .w23(w23_out), .w24(w24_out),
    .w31(w31_out), .w32(w32_out), .w33(w33_out), .w34(w34_out),
    .w41(w41_out), .w42(w42_out), .w43(w43_out), .w44(w44_out)
);

endmodule
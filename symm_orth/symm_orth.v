module SYMM_ORTH (
    input clk_symm,
    input go_symm,

    input signed [25:0] b11, b12, b13, b14,
    input signed [25:0] b21, b22, b23, b24,
    input signed [25:0] b31, b32, b33, b34,
    input signed [25:0] b41, b42, b43, b44,

    output signed [25:0] w11, w12, w13, w14,
    output signed [25:0] w21, w22, w23, w24,
    output signed [25:0] w31, w32, w33, w34,
    output signed [25:0] w41, w42, w43, w44
);

wire symm_busy;
wire clk_mul1, clk_norm, clk_sqrt, clk_mul2, clk_mul3, clk_sub;
wire en_mul1, en_norm, en_sqrt, en_mul2, en_mul3, en_sub;

wire signed [25:0] b11_1, b12_1, b13_1, b14_1;
wire signed [25:0] b21_1, b22_1, b23_1, b24_1;
wire signed [25:0] b31_1, b32_1, b33_1, b34_1;
wire signed [25:0] b41_1, b42_1, b43_1, b44_1;

wire signed [25:0] b11_2, b12_2, b13_2, b14_2;
wire signed [25:0] b21_2, b22_2, b23_2, b24_2;
wire signed [25:0] b31_2, b32_2, b33_2, b34_2;
wire signed [25:0] b41_2, b42_2, b43_2, b44_2;

wire signed [25:0] norm11, norm12, norm13, norm14;
wire signed [25:0] norm21, norm22, norm23, norm24;
wire signed [25:0] norm31, norm32, norm33, norm34;
wire signed [25:0] norm41, norm42, norm43, norm44;

wire signed [25:0] sum1, sum2, sum3, sum4;

wire signed [25:0] sqrt11, sqrt12, sqrt13, sqrt14;
wire signed [25:0] sqrt21, sqrt22, sqrt23, sqrt24;
wire signed [25:0] sqrt31, sqrt32, sqrt33, sqrt34;
wire signed [25:0] sqrt41, sqrt42, sqrt43, sqrt44;

wire signed [25:0] mul2_11, mul2_12, mul2_13, mul2_14;
wire signed [25:0] mul2_21, mul2_22, mul2_23, mul2_24;
wire signed [25:0] mul2_31, mul2_32, mul2_33, mul2_34;
wire signed [25:0] mul2_41, mul2_42, mul2_43, mul2_44;

wire signed [25:0] mul3_11, mul3_12, mul3_13, mul3_14;
wire signed [25:0] mul3_21, mul3_22, mul3_23, mul3_24;
wire signed [25:0] mul3_31, mul3_32, mul3_33, mul3_34;
wire signed [25:0] mul3_41, mul3_42, mul3_43, mul3_44;

SYMM_CONTROLLER SYMM_CONTROLLER_1 (
    .clk_symm(clk_symm),
    .go_symm(go_symm),
    
    .symm_busy(symm_busy),
    .clk_mul1(clk_mul1), .clk_norm(clk_norm), .clk_sqrt(clk_sqrt),
    .clk_mul2(clk_mul2), .clk_mul3(clk_mul3), .clk_sub(clk_sub),
    .en_mul1(en_mul1), .en_norm(en_norm), .en_sqrt(en_sqrt),
    .en_mul2(en_mul2), .en_mul3(en_mul3), .en_sub(en_sub)
);

SYMM_MUL1 SYMM_MUL_1 (
    .clk_mul1(clk_mul1),
    .en_mul1(en_mul1),

    .b11(b11), .b12(b12), .b13(b13), .b14(b14),
    .b21(b21), .b22(b22), .b23(b23), .b24(b24),
    .b31(b31), .b32(b32), .b33(b33), .b34(b34),
    .b41(b41), .b42(b42), .b43(b43), .b44(b44),

    .w11(b11_1), .w12(b12_1), .w13(b13_1), .w14(b14_1),
    .w21(b21_1), .w22(b22_1), .w23(b23_1), .w24(b24_1),
    .w31(b31_1), .w32(b32_1), .w33(b33_1), .w34(b34_1),
    .w41(b41_1), .w42(b42_1), .w43(b43_1), .w44(b44_1),

    .w11_2(b11_2), .w12_2(b12_2), .w13_2(b13_2), .w14_2(b14_2),
    .w21_2(b21_2), .w22_2(b22_2), .w23_2(b23_2), .w24_2(b24_2),
    .w31_2(b31_2), .w32_2(b32_2), .w33_2(b33_2), .w34_2(b34_2),
    .w41_2(b41_2), .w42_2(b42_2), .w43_2(b43_2), .w44_2(b44_2)
);

SYMM_NORM SYMM_NORM_1 (
    .clk_norm(clk_norm),
    .en_norm(en_norm),

    .i11(b11_1), .i12(b12_1), .i13(b13_1), .i14(b14_1),
    .i21(b21_1), .i22(b22_1), .i23(b23_1), .i24(b24_1),
    .i31(b31_1), .i32(b32_1), .i33(b33_1), .i34(b34_1),
    .i41(b41_1), .i42(b42_1), .i43(b43_1), .i44(b44_1),

    .i11_2(b11_2), .i12_2(b12_2), .i13_2(b13_2), .i14_2(b14_2),
    .i21_2(b21_2), .i22_2(b22_2), .i23_2(b23_2), .i24_2(b24_2),
    .i31_2(b31_2), .i32_2(b32_2), .i33_2(b33_2), .i34_2(b34_2),
    .i41_2(b41_2), .i42_2(b42_2), .i43_2(b43_2), .i44_2(b44_2),

    .o11(norm11), .o12(norm12), .o13(norm13), .o14(norm14),
    .o21(norm21), .o22(norm22), .o23(norm23), .o24(norm24),
    .o31(norm31), .o32(norm32), .o33(norm33), .o34(norm34),
    .o41(norm41), .o42(norm42), .o43(norm43), .o44(norm44),

    .sum1(sum1), .sum2(sum2), .sum3(sum3), .sum4(sum4)
);

SYMM_SQRT SYMM_SQRT_1 (
    .clk_sqrt(clk_sqrt),
    .en_sqrt(en_sqrt),

    .i11(norm11), .i12(norm12), .i13(norm13), .i14(norm14),
    .i21(norm21), .i22(norm22), .i23(norm23), .i24(norm24),
    .i31(norm31), .i32(norm32), .i33(norm33), .i34(norm34),
    .i41(norm41), .i42(norm42), .i43(norm43), .i44(norm44),

    .sum1(sum1), .sum2(sum2), .sum3(sum3), .sum4(sum4),

    .o11(sqrt11), .o12(sqrt12), .o13(sqrt13), .o14(sqrt14),
    .o21(sqrt21), .o22(sqrt22), .o23(sqrt23), .o24(sqrt24),
    .o31(sqrt31), .o32(sqrt32), .o33(sqrt33), .o34(sqrt34),
    .o41(sqrt41), .o42(sqrt42), .o43(sqrt43), .o44(sqrt44)
);

SYMM_MUL2 SYMM_MUL_2 (
    .clk_mul2(clk_mul2),
    .en_mul2(en_mul2),

    .iw11(sqrt11), .iw12(sqrt12), .iw13(sqrt13), .iw14(sqrt14),
    .iw21(sqrt21), .iw22(sqrt22), .iw23(sqrt23), .iw24(sqrt24),
    .iw31(sqrt31), .iw32(sqrt32), .iw33(sqrt33), .iw34(sqrt34),
    .iw41(sqrt41), .iw42(sqrt42), .iw43(sqrt43), .iw44(sqrt44),

    .ow11(mul2_11), .ow12(mul2_12), .ow13(mul2_13), .ow14(mul2_14),
    .ow21(mul2_21), .ow22(mul2_22), .ow23(mul2_23), .ow24(mul2_24),
    .ow31(mul2_31), .ow32(mul2_32), .ow33(mul2_33), .ow34(mul2_34),
    .ow41(mul2_41), .ow42(mul2_42), .ow43(mul2_43), .ow44(mul2_44)
);

SYMM_MUL3 SYMM_MUL_3 (
    .clk_mul3(clk_mul3),
    .en_mul3(en_mul3),

    .i11(sqrt11), .i12(sqrt12), .i13(sqrt13), .i14(sqrt14),
    .i21(sqrt21), .i22(sqrt22), .i23(sqrt23), .i24(sqrt24),
    .i31(sqrt31), .i32(sqrt32), .i33(sqrt33), .i34(sqrt34),
    .i41(sqrt41), .i42(sqrt42), .i43(sqrt43), .i44(sqrt44),

    .o11(mul3_11), .o12(mul3_12), .o13(mul3_13), .o14(mul3_14),
    .o21(mul3_21), .o22(mul3_22), .o23(mul3_23), .o24(mul3_24),
    .o31(mul3_31), .o32(mul3_32), .o33(mul3_33), .o34(mul3_34),
    .o41(mul3_41), .o42(mul3_42), .o43(mul3_43), .o44(mul3_44)
);

SYMM_SUB SYMM_SUB_1 (
    .clk_sub(clk_sub),
    .en_sub(en_sub),

    .i1_11(mul2_11), .i1_12(mul2_12), .i1_13(mul2_13), .i1_14(mul2_14),
    .i1_21(mul2_21), .i1_22(mul2_22), .i1_23(mul2_23), .i1_24(mul2_24),
    .i1_31(mul2_31), .i1_32(mul2_32), .i1_33(mul2_33), .i1_34(mul2_34),
    .i1_41(mul2_41), .i1_42(mul2_42), .i1_43(mul2_43), .i1_44(mul2_44),

    .i2_11(mul3_11), .i2_12(mul3_12), .i2_13(mul3_13), .i2_14(mul3_14),
    .i2_21(mul3_21), .i2_22(mul3_22), .i2_23(mul3_23), .i2_24(mul3_24),
    .i2_31(mul3_31), .i2_32(mul3_32), .i2_33(mul3_33), .i2_34(mul3_34),
    .i2_41(mul3_41), .i2_42(mul3_42), .i2_43(mul3_43), .i2_44(mul3_44),

    .o11(w11), .o12(w12), .o13(w13), .o14(w14),
    .o21(w21), .o22(w22), .o23(w23), .o24(w24),
    .o31(w31), .o32(w32), .o33(w33), .o34(w34),
    .o41(w41), .o42(w42), .o43(w43), .o44(w44)
);

endmodule
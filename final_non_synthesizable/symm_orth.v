module SYMM_ORTH (
    input clk_symm,
    input go_symm,

    input signed [25:0] b11, b12, b13, b14,
    input signed [25:0] b21, b22, b23, b24,
    input signed [25:0] b31, b32, b33, b34,
    input signed [25:0] b41, b42, b43, b44,

    output symm_busy,

    output signed [25:0] w11_symm, w12_symm, w13_symm, w14_symm,
    output signed [25:0] w21_symm, w22_symm, w23_symm, w24_symm,
    output signed [25:0] w31_symm, w32_symm, w33_symm, w34_symm,
    output signed [25:0] w41_symm, w42_symm, w43_symm, w44_symm
);

wire clk_mul1, clk_norm, clk_sqrt, clk_sel, clk_mul2, clk_mul3, clk_sub, clk_mul4, clk_abs, clk_test;
wire en_mul1, en_norm, en_sqrt, en_sel, en_mul2, en_mul3, en_sub, en_mul4, en_abs, en_test;
wire select;
wire isOrth;

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

wire signed [25:0] w11, w12, w13, w14;
wire signed [25:0] w21, w22, w23, w24;
wire signed [25:0] w31, w32, w33, w34;
wire signed [25:0] w41, w42, w43, w44;

wire signed [25:0] w11_2, w12_2, w13_2, w14_2;
wire signed [25:0] w21_2, w22_2, w23_2, w24_2;
wire signed [25:0] w31_2, w32_2, w33_2, w34_2;
wire signed [25:0] w41_2, w42_2, w43_2, w44_2;

wire signed [25:0] w11_3, w12_3, w13_3, w14_3;
wire signed [25:0] w21_3, w22_3, w23_3, w24_3;
wire signed [25:0] w31_3, w32_3, w33_3, w34_3;
wire signed [25:0] w41_3, w42_3, w43_3, w44_3;

wire signed [25:0] w11_4, w12_4, w13_4, w14_4;
wire signed [25:0] w21_4, w22_4, w23_4, w24_4;
wire signed [25:0] w31_4, w32_4, w33_4, w34_4;
wire signed [25:0] w41_4, w42_4, w43_4, w44_4;

wire signed [25:0] w11_5, w12_5, w13_5, w14_5;
wire signed [25:0] w21_5, w22_5, w23_5, w24_5;
wire signed [25:0] w31_5, w32_5, w33_5, w34_5;
wire signed [25:0] w41_5, w42_5, w43_5, w44_5;

wire signed [25:0] dot11, dot12, dot13, dot14;
wire signed [25:0] dot21, dot22, dot23, dot24;
wire signed [25:0] dot31, dot32, dot33, dot34;
wire signed [25:0] dot41, dot42, dot43, dot44;

wire signed [25:0] abs11, abs12, abs13, abs14;
wire signed [25:0] abs21, abs22, abs23, abs24;
wire signed [25:0] abs31, abs32, abs33, abs34;
wire signed [25:0] abs41, abs42, abs43, abs44;

assign w11_symm = w11_5;
assign w12_symm = w12_5;
assign w13_symm = w13_5;
assign w14_symm = w14_5;
assign w21_symm = w21_5;
assign w22_symm = w22_5;
assign w23_symm = w23_5;
assign w24_symm = w24_5;
assign w31_symm = w31_5;
assign w32_symm = w32_5;
assign w33_symm = w33_5;
assign w34_symm = w34_5;
assign w41_symm = w41_5;
assign w42_symm = w42_5;
assign w43_symm = w43_5;
assign w44_symm = w44_5;

SYMM_CONTROLLER SYMM_CONTROLLER_1 (
    .clk_symm(clk_symm),
    .go_symm(go_symm),
    .isOrth(isOrth),
    
    .symm_busy(symm_busy),
    .clk_mul1(clk_mul1), .clk_norm(clk_norm), .clk_sqrt(clk_sqrt), .clk_sel(clk_sel), .clk_mul2(clk_mul2),
    .clk_mul3(clk_mul3), .clk_sub(clk_sub), .clk_mul4(clk_mul4), .clk_abs(clk_abs), .clk_test(clk_test), 
    .en_mul1(en_mul1), .en_norm(en_norm), .en_sqrt(en_sqrt), .en_sel(en_sel),.en_mul2(en_mul2),
    .en_mul3(en_mul3), .en_sub(en_sub), .en_mul4(en_mul4), .en_abs(en_abs), .en_test(en_test),
    .select(select)
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

SYMM_SELECT SYMM_SELECT_1 (
    .clk_sel(clk_sel),
    .en_sel(en_sel),
    
    .select(select),
    
    .i11(sqrt11), .i12(sqrt12), .i13(sqrt13), .i14(sqrt14),
    .i21(sqrt21), .i22(sqrt22), .i23(sqrt23), .i24(sqrt24),
    .i31(sqrt31), .i32(sqrt32), .i33(sqrt33), .i34(sqrt34),
    .i41(sqrt41), .i42(sqrt42), .i43(sqrt43), .i44(sqrt44),

    .i11_2(w11_5), .i12_2(w12_5), .i13_2(w13_5), .i14_2(w14_5),
    .i21_2(w21_5), .i22_2(w22_5), .i23_2(w23_5), .i24_2(w24_5),
    .i31_2(w31_5), .i32_2(w32_5), .i33_2(w33_5), .i34_2(w34_5),
    .i41_2(w41_5), .i42_2(w42_5), .i43_2(w43_5), .i44_2(w44_5),

    .o11(w11), .o12(w12), .o13(w13), .o14(w14),
    .o21(w21), .o22(w22), .o23(w23), .o24(w24),
    .o31(w31), .o32(w32), .o33(w33), .o34(w34),
    .o41(w41), .o42(w42), .o43(w43), .o44(w44)
);

SYMM_MUL2 SYMM_MUL_2 (
    .clk_mul2(clk_mul2),
    .en_mul2(en_mul2),

    .iw11(w11), .iw12(w12), .iw13(w13), .iw14(w14),
    .iw21(w21), .iw22(w22), .iw23(w23), .iw24(w24),
    .iw31(w31), .iw32(w32), .iw33(w33), .iw34(w34),
    .iw41(w41), .iw42(w42), .iw43(w43), .iw44(w44),

    .ow11(mul2_11), .ow12(mul2_12), .ow13(mul2_13), .ow14(mul2_14),
    .ow21(mul2_21), .ow22(mul2_22), .ow23(mul2_23), .ow24(mul2_24),
    .ow31(mul2_31), .ow32(mul2_32), .ow33(mul2_33), .ow34(mul2_34),
    .ow41(mul2_41), .ow42(mul2_42), .ow43(mul2_43), .ow44(mul2_44)
);

SYMM_MUL3 SYMM_MUL_3 (
    .clk_mul3(clk_mul3),
    .en_mul3(en_mul3),

    .i11(w11), .i12(w12), .i13(w13), .i14(w14),
    .i21(w21), .i22(w22), .i23(w23), .i24(w24),
    .i31(w31), .i32(w32), .i33(w33), .i34(w34),
    .i41(w41), .i42(w42), .i43(w43), .i44(w44),

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

    .o11(w11_2), .o12(w12_2), .o13(w13_2), .o14(w14_2),
    .o21(w21_2), .o22(w22_2), .o23(w23_2), .o24(w24_2),
    .o31(w31_2), .o32(w32_2), .o33(w33_2), .o34(w34_2),
    .o41(w41_2), .o42(w42_2), .o43(w43_2), .o44(w44_2)
);

SYMM_MUL4 SYMM_MUL_4 (
    .clk_mul4(clk_mul4),
    .en_mul4(en_mul4),

    .i11(w11_2), .i12(w12_2), .i13(w13_2), .i14(w14_2),
    .i21(w21_2), .i22(w22_2), .i23(w23_2), .i24(w24_2),
    .i31(w31_2), .i32(w32_2), .i33(w33_2), .i34(w34_2),
    .i41(w41_2), .i42(w42_2), .i43(w43_2), .i44(w44_2),

    .o11(w11_3), .o12(w12_3), .o13(w13_3), .o14(w14_3),
    .o21(w21_3), .o22(w22_3), .o23(w23_3), .o24(w24_3),
    .o31(w31_3), .o32(w32_3), .o33(w33_3), .o34(w34_3),
    .o41(w41_3), .o42(w42_3), .o43(w43_3), .o44(w44_3),

    .o11_2(dot11), .o12_2(dot12), .o13_2(dot13), .o14_2(dot14),
    .o21_2(dot21), .o22_2(dot22), .o23_2(dot23), .o24_2(dot24),
    .o31_2(dot31), .o32_2(dot32), .o33_2(dot33), .o34_2(dot34),
    .o41_2(dot41), .o42_2(dot42), .o43_2(dot43), .o44_2(dot44)
);

SYMM_ABS SYMM_ABS_1 (
    .clk_abs(clk_abs),
    .en_abs(en_abs),

    .i11(w11_3), .i12(w12_3), .i13(w13_3), .i14(w14_3),
    .i21(w21_3), .i22(w22_3), .i23(w23_3), .i24(w24_3),
    .i31(w31_3), .i32(w32_3), .i33(w33_3), .i34(w34_3),
    .i41(w41_3), .i42(w42_3), .i43(w43_3), .i44(w44_3),
    
    .i11_2(dot11), .i12_2(dot12), .i13_2(dot13), .i14_2(dot14),
    .i21_2(dot21), .i22_2(dot22), .i23_2(dot23), .i24_2(dot24),
    .i31_2(dot31), .i32_2(dot32), .i33_2(dot33), .i34_2(dot34),
    .i41_2(dot41), .i42_2(dot42), .i43_2(dot43), .i44_2(dot44),

    .o11(w11_4), .o12(w12_4), .o13(w13_4), .o14(w14_4),
    .o21(w21_4), .o22(w22_4), .o23(w23_4), .o24(w24_4),
    .o31(w31_4), .o32(w32_4), .o33(w33_4), .o34(w34_4),
    .o41(w41_4), .o42(w42_4), .o43(w43_4), .o44(w44_4),

    .o11_2(abs11), .o12_2(abs12), .o13_2(abs13), .o14_2(abs14),
    .o21_2(abs21), .o22_2(abs22), .o23_2(abs23), .o24_2(abs24),
    .o31_2(abs31), .o32_2(abs32), .o33_2(abs33), .o34_2(abs34),
    .o41_2(abs41), .o42_2(abs42), .o43_2(abs43), .o44_2(abs44)
);
    
SYMM_TEST SYMM_TEST_1 (
    .clk_test(clk_test),
    .en_test(en_test),

    .i11(w11_4), .i12(w12_4), .i13(w13_4), .i14(w14_4),
    .i21(w21_4), .i22(w22_4), .i23(w23_4), .i24(w24_4),
    .i31(w31_4), .i32(w32_4), .i33(w33_4), .i34(w34_4),
    .i41(w41_4), .i42(w42_4), .i43(w43_4), .i44(w44_4),
    
    .i11_2(abs11), .i12_2(abs12), .i13_2(abs13), .i14_2(abs14),
    .i21_2(abs21), .i22_2(abs22), .i23_2(abs23), .i24_2(abs24),
    .i31_2(abs31), .i32_2(abs32), .i33_2(abs33), .i34_2(abs34),
    .i41_2(abs41), .i42_2(abs42), .i43_2(abs43), .i44_2(abs44),
    
    .o11(w11_5), .o12(w12_5), .o13(w13_5), .o14(w14_5),
    .o21(w21_5), .o22(w22_5), .o23(w23_5), .o24(w24_5),
    .o31(w31_5), .o32(w32_5), .o33(w33_5), .o34(w34_5),
    .o41(w41_5), .o42(w42_5), .o43(w43_5), .o44(w44_5),
    
    .isOrth(isOrth)
);

endmodule
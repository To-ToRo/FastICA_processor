module ERROR_CAL(
    input clk_error,
    input en_error,

    input signed [25:0] w_new11, w_new12, w_new13, w_new14,
    input signed [25:0] w_new21, w_new22, w_new23, w_new24,
    input signed [25:0] w_new31, w_new32, w_new33, w_new34,
    input signed [25:0] w_new41, w_new42, w_new43, w_new44,

    output signed [25:0] w11, w12, w13, w14,
    output signed [25:0] w21, w22, w23, w24,
    output signed [25:0] w31, w32, w33, w34,
    output signed [25:0] w41, w42, w43, w44,
    
    output isConverge,
    output error_busy
);

wire clk_abs1, clk_abs2, clk_sub, clk_abs3, clk_out;
wire en_abs1, en_abs2, en_sub, en_abs3, en_out;

wire signed [25:0] w_ica11, w_ica12, w_ica13, w_ica14;
wire signed [25:0] w_ica21, w_ica22, w_ica23, w_ica24;
wire signed [25:0] w_ica31, w_ica32, w_ica33, w_ica34;
wire signed [25:0] w_ica41, w_ica42, w_ica43, w_ica44;

wire signed [25:0] abs_w_new11, abs_w_new12, abs_w_new13, abs_w_new14;
wire signed [25:0] abs_w_new21, abs_w_new22, abs_w_new23, abs_w_new24;
wire signed [25:0] abs_w_new31, abs_w_new32, abs_w_new33, abs_w_new34;
wire signed [25:0] abs_w_new41, abs_w_new42, abs_w_new43, abs_w_new44;

wire signed [25:0] abs_w_ica11, abs_w_ica12, abs_w_ica13, abs_w_ica14;
wire signed [25:0] abs_w_ica21, abs_w_ica22, abs_w_ica23, abs_w_ica24;
wire signed [25:0] abs_w_ica31, abs_w_ica32, abs_w_ica33, abs_w_ica34;
wire signed [25:0] abs_w_ica41, abs_w_ica42, abs_w_ica43, abs_w_ica44;

wire signed [25:0] sub11, sub12, sub13, sub14;
wire signed [25:0] sub21, sub22, sub23, sub24;
wire signed [25:0] sub31, sub32, sub33, sub34;
wire signed [25:0] sub41, sub42, sub43, sub44;

wire signed [25:0] abs_sub11, abs_sub12, abs_sub13, abs_sub14;
wire signed [25:0] abs_sub21, abs_sub22, abs_sub23, abs_sub24;
wire signed [25:0] abs_sub31, abs_sub32, abs_sub33, abs_sub34;
wire signed [25:0] abs_sub41, abs_sub42, abs_sub43, abs_sub44;

assign w11 = w_ica11;
assign w12 = w_ica12;
assign w13 = w_ica13;
assign w14 = w_ica14;
assign w21 = w_ica21;
assign w22 = w_ica22;
assign w23 = w_ica23;
assign w24 = w_ica24;
assign w31 = w_ica31;
assign w32 = w_ica32;
assign w33 = w_ica33;
assign w34 = w_ica34;
assign w41 = w_ica41;
assign w42 = w_ica42;
assign w43 = w_ica43;
assign w44 = w_ica44;

reg signed [25:0] w_new11_reg, w_new12_reg, w_new13_reg, w_new14_reg;
reg signed [25:0] w_new21_reg, w_new22_reg, w_new23_reg, w_new24_reg;
reg signed [25:0] w_new31_reg, w_new32_reg, w_new33_reg, w_new34_reg;
reg signed [25:0] w_new41_reg, w_new42_reg, w_new43_reg, w_new44_reg;

wire signed [25:0] ow_new11, ow_new12, ow_new13, ow_new14;
wire signed [25:0] ow_new21, ow_new22, ow_new23, ow_new24;
wire signed [25:0] ow_new31, ow_new32, ow_new33, ow_new34;
wire signed [25:0] ow_new41, ow_new42, ow_new43, ow_new44;

wire signed [25:0] w_new_sub_11, w_new_sub_12, w_new_sub_13, w_new_sub_14;
wire signed [25:0] w_new_sub_21, w_new_sub_22, w_new_sub_23, w_new_sub_24;
wire signed [25:0] w_new_sub_31, w_new_sub_32, w_new_sub_33, w_new_sub_34;
wire signed [25:0] w_new_sub_41, w_new_sub_42, w_new_sub_43, w_new_sub_44;

wire signed [25:0] w_new_abs_11, w_new_abs_12, w_new_abs_13, w_new_abs_14;
wire signed [25:0] w_new_abs_21, w_new_abs_22, w_new_abs_23, w_new_abs_24;
wire signed [25:0] w_new_abs_31, w_new_abs_32, w_new_abs_33, w_new_abs_34;
wire signed [25:0] w_new_abs_41, w_new_abs_42, w_new_abs_43, w_new_abs_44;


always @(posedge clk_error) begin
    w_new11_reg <= w_new11;
    w_new12_reg <= w_new12;
    w_new13_reg <= w_new13;
    w_new14_reg <= w_new14;
    w_new21_reg <= w_new21;
    w_new22_reg <= w_new22;
    w_new23_reg <= w_new23;
    w_new24_reg <= w_new24;
    w_new31_reg <= w_new31;
    w_new32_reg <= w_new32;
    w_new33_reg <= w_new33;
    w_new34_reg <= w_new34;
    w_new41_reg <= w_new41;
    w_new42_reg <= w_new42;
    w_new43_reg <= w_new43;
    w_new44_reg <= w_new44;
end

ERROR_CONTROLLER ERROR_CONTROLLER_1 (
    .clk_error(clk_error),
    .en_error(en_error),
    
    .error_busy(error_busy),
    .clk_abs1(clk_abs1), .clk_abs2(clk_abs2), .clk_sub(clk_sub), .clk_abs3(clk_abs3), .clk_out(clk_out),
    .en_abs1(en_abs1), .en_abs2(en_abs2), .en_sub(en_sub), .en_abs3(en_abs3), .en_out(en_out)
);

ERROR_ABS_DELIVERY ERROR_ABS_1 (
    .clk_abs(clk_abs1),
    .en_abs(en_abs1),

    .i11(w_new11_reg), .i12(w_new12_reg), .i13(w_new13_reg), .i14(w_new14_reg),
    .i21(w_new21_reg), .i22(w_new22_reg), .i23(w_new23_reg), .i24(w_new24_reg),
    .i31(w_new31_reg), .i32(w_new32_reg), .i33(w_new33_reg), .i34(w_new34_reg),
    .i41(w_new41_reg), .i42(w_new42_reg), .i43(w_new43_reg), .i44(w_new44_reg),

    .iw_new11(w_new11_reg), .iw_new12(w_new12_reg), .iw_new13(w_new13_reg), .iw_new14(w_new14_reg),
    .iw_new21(w_new21_reg), .iw_new22(w_new22_reg), .iw_new23(w_new23_reg), .iw_new24(w_new24_reg),
    .iw_new31(w_new31_reg), .iw_new32(w_new32_reg), .iw_new33(w_new33_reg), .iw_new34(w_new34_reg),
    .iw_new41(w_new41_reg), .iw_new42(w_new42_reg), .iw_new43(w_new43_reg), .iw_new44(w_new44_reg),

    .ow_new11(ow_new11), .ow_new12(ow_new12), .ow_new13(ow_new13), .ow_new14(ow_new14),
    .ow_new21(ow_new21), .ow_new22(ow_new22), .ow_new23(ow_new23), .ow_new24(ow_new24),
    .ow_new31(ow_new31), .ow_new32(ow_new32), .ow_new33(ow_new33), .ow_new34(ow_new34),
    .ow_new41(ow_new41), .ow_new42(ow_new42), .ow_new43(ow_new43), .ow_new44(ow_new44),
    
    .o11(abs_w_new11), .o12(abs_w_new12), .o13(abs_w_new13), .o14(abs_w_new14),
    .o21(abs_w_new21), .o22(abs_w_new22), .o23(abs_w_new23), .o24(abs_w_new24),
    .o31(abs_w_new31), .o32(abs_w_new32), .o33(abs_w_new33), .o34(abs_w_new34),
    .o41(abs_w_new41), .o42(abs_w_new42), .o43(abs_w_new43), .o44(abs_w_new44)
);

ERROR_ABS ERROR_ABS_2 (
    .clk_abs(clk_abs2),
    .en_abs(en_abs2),

    .i11(w_ica11), .i12(w_ica12), .i13(w_ica13), .i14(w_ica14),
    .i21(w_ica21), .i22(w_ica22), .i23(w_ica23), .i24(w_ica24),
    .i31(w_ica31), .i32(w_ica32), .i33(w_ica33), .i34(w_ica34),
    .i41(w_ica41), .i42(w_ica42), .i43(w_ica43), .i44(w_ica44),
    
    .o11(abs_w_ica11), .o12(abs_w_ica12), .o13(abs_w_ica13), .o14(abs_w_ica14),
    .o21(abs_w_ica21), .o22(abs_w_ica22), .o23(abs_w_ica23), .o24(abs_w_ica24),
    .o31(abs_w_ica31), .o32(abs_w_ica32), .o33(abs_w_ica33), .o34(abs_w_ica34),
    .o41(abs_w_ica41), .o42(abs_w_ica42), .o43(abs_w_ica43), .o44(abs_w_ica44)
);

ERROR_SUB ERROR_SUB_1 (   
    .clk_sub(clk_sub),
    .en_sub(en_sub),

    .i1_11(abs_w_new11), .i1_12(abs_w_new12), .i1_13(abs_w_new13), .i1_14(abs_w_new14),
    .i1_21(abs_w_new21), .i1_22(abs_w_new22), .i1_23(abs_w_new23), .i1_24(abs_w_new24),
    .i1_31(abs_w_new31), .i1_32(abs_w_new32), .i1_33(abs_w_new33), .i1_34(abs_w_new34),
    .i1_41(abs_w_new41), .i1_42(abs_w_new42), .i1_43(abs_w_new43), .i1_44(abs_w_new44),
    
    .i2_11(abs_w_ica11), .i2_12(abs_w_ica12), .i2_13(abs_w_ica13), .i2_14(abs_w_ica14),
    .i2_21(abs_w_ica21), .i2_22(abs_w_ica22), .i2_23(abs_w_ica23), .i2_24(abs_w_ica24),
    .i2_31(abs_w_ica31), .i2_32(abs_w_ica32), .i2_33(abs_w_ica33), .i2_34(abs_w_ica34),
    .i2_41(abs_w_ica41), .i2_42(abs_w_ica42), .i2_43(abs_w_ica43), .i2_44(abs_w_ica44),

    .iw_11(ow_new11), .iw_12(ow_new12), .iw_13(ow_new13), .iw_14(ow_new14),
    .iw_21(ow_new21), .iw_22(ow_new22), .iw_23(ow_new23), .iw_24(ow_new24),
    .iw_31(ow_new31), .iw_32(ow_new32), .iw_33(ow_new33), .iw_34(ow_new34),
    .iw_41(ow_new41), .iw_42(ow_new42), .iw_43(ow_new43), .iw_44(ow_new44),

    .ow_11(w_new_sub_11), .ow_12(w_new_sub_12), .ow_13(w_new_sub_13), .ow_14(w_new_sub_14),
    .ow_21(w_new_sub_21), .ow_22(w_new_sub_22), .ow_23(w_new_sub_23), .ow_24(w_new_sub_24),
    .ow_31(w_new_sub_31), .ow_32(w_new_sub_32), .ow_33(w_new_sub_33), .ow_34(w_new_sub_34),
    .ow_41(w_new_sub_41), .ow_42(w_new_sub_42), .ow_43(w_new_sub_43), .ow_44(w_new_sub_44),

    .o11(sub11), .o12(sub12), .o13(sub13), .o14(sub14),
    .o21(sub21), .o22(sub22), .o23(sub23), .o24(sub24),
    .o31(sub31), .o32(sub32), .o33(sub33), .o34(sub34),
    .o41(sub41), .o42(sub42), .o43(sub43), .o44(sub44)
);

ERROR_ABS_DELIVERY ERROR_ABS_3 (
    .clk_abs(clk_abs3),
    .en_abs(en_abs3),

    .i11(sub11), .i12(sub12), .i13(sub13), .i14(sub14),
    .i21(sub21), .i22(sub22), .i23(sub23), .i24(sub24),
    .i31(sub31), .i32(sub32), .i33(sub33), .i34(sub34),
    .i41(sub41), .i42(sub42), .i43(sub43), .i44(sub44),

    .iw_new11(w_new_sub_11), .iw_new12(w_new_sub_12), .iw_new13(w_new_sub_13), .iw_new14(w_new_sub_14),
    .iw_new21(w_new_sub_21), .iw_new22(w_new_sub_22), .iw_new23(w_new_sub_23), .iw_new24(w_new_sub_24),
    .iw_new31(w_new_sub_31), .iw_new32(w_new_sub_32), .iw_new33(w_new_sub_33), .iw_new34(w_new_sub_34),
    .iw_new41(w_new_sub_41), .iw_new42(w_new_sub_42), .iw_new43(w_new_sub_43), .iw_new44(w_new_sub_44),

    .ow_new11(w_new_abs_11), .ow_new12(w_new_abs_12), .ow_new13(w_new_abs_13), .ow_new14(w_new_abs_14),
    .ow_new21(w_new_abs_21), .ow_new22(w_new_abs_22), .ow_new23(w_new_abs_23), .ow_new24(w_new_abs_24),
    .ow_new31(w_new_abs_31), .ow_new32(w_new_abs_32), .ow_new33(w_new_abs_33), .ow_new34(w_new_abs_34),
    .ow_new41(w_new_abs_41), .ow_new42(w_new_abs_42), .ow_new43(w_new_abs_43), .ow_new44(w_new_abs_44),
    
    .o11(abs_sub11), .o12(abs_sub12), .o13(abs_sub13), .o14(abs_sub14),
    .o21(abs_sub21), .o22(abs_sub22), .o23(abs_sub23), .o24(abs_sub24),
    .o31(abs_sub31), .o32(abs_sub32), .o33(abs_sub33), .o34(abs_sub34),
    .o41(abs_sub41), .o42(abs_sub42), .o43(abs_sub43), .o44(abs_sub44)
);

ERROR_OUT ERROR_OUT_1 (
    .clk_out(clk_out),
    .en_out(en_out),

    .i1_11(w_new_abs_11), .i1_12(w_new_abs_12), .i1_13(w_new_abs_13), .i1_14(w_new_abs_14),
    .i1_21(w_new_abs_21), .i1_22(w_new_abs_22), .i1_23(w_new_abs_23), .i1_24(w_new_abs_24),
    .i1_31(w_new_abs_31), .i1_32(w_new_abs_32), .i1_33(w_new_abs_33), .i1_34(w_new_abs_34),
    .i1_41(w_new_abs_41), .i1_42(w_new_abs_42), .i1_43(w_new_abs_43), .i1_44(w_new_abs_44),
    
    .i2_11(abs_sub11), .i2_12(abs_sub12), .i2_13(abs_sub13), .i2_14(abs_sub14),
    .i2_21(abs_sub21), .i2_22(abs_sub22), .i2_23(abs_sub23), .i2_24(abs_sub24),
    .i2_31(abs_sub31), .i2_32(abs_sub32), .i2_33(abs_sub33), .i2_34(abs_sub34),
    .i2_41(abs_sub41), .i2_42(abs_sub42), .i2_43(abs_sub43), .i2_44(abs_sub44),
    
    .o11(w_ica11), .o12(w_ica12), .o13(w_ica13), .o14(w_ica14),
    .o21(w_ica21), .o22(w_ica22), .o23(w_ica23), .o24(w_ica24),
    .o31(w_ica31), .o32(w_ica32), .o33(w_ica33), .o34(w_ica34),
    .o41(w_ica41), .o42(w_ica42), .o43(w_ica43), .o44(w_ica44),
    
    .isConverge(isConverge)
);

endmodule

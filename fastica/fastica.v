module FASTICA (
    input clk_fastica,
    input go_fastica,

    input signed [25:0] z1, z2, z3, z4,

    output signed [25:0] y1, y2, y3, y4
);

wire symm_busy, fast_busy, error_busy;
wire isConverge;
wire clk_symm, clk_norm, clk_fast, clk_error, clk_mul1, clk_mem1;
wire go_symm, en_norm, go_fast, en_error, en_mul1, en_mem1;
wire [13:0] address_sel_mem1;
wire rw;

reg signed [25:0]  Z1[0:127];
reg signed [25:0]  Z2[0:127];
reg signed [25:0]  Z3[0:127];
reg signed [25:0]  Z4[0:127];

reg [7:0] z_cnt, fast_cnt, mul1_cnt;

always @(posedge clk_fastica or negedge go_fastica) begin
    if (!go_fastica) begin
        z_cnt <= 8'd0;
    end else begin
        if (z_cnt < 8'd128) begin
            Z1[z_cnt] <= z1;
            Z2[z_cnt] <= z2;
            Z3[z_cnt] <= z3;
            Z4[z_cnt] <= z4;
            z_cnt <= z_cnt + 8'd1;
        end
    end
end

always @(posedge clk_fast or negedge go_fast) begin
    if (!go_fast) begin
        fast_cnt <= 8'd0;
    end else begin
        fast_cnt <= fast_cnt + 8'd0;
    end
end

always @(posedge clk_mul1 or negedge en_mul1) begin
    if (!en_mul1) begin
        mul1_cnt <= 8'd0;
    end else begin
        mul1_cnt <= mul1_cnt + 8'd1;
    end
end

wire signed [25:0] w11_symm, w12_symm, w13_symm, w14_symm;
wire signed [25:0] w21_symm, w22_symm, w23_symm, w24_symm;
wire signed [25:0] w31_symm, w32_symm, w33_symm, w34_symm;
wire signed [25:0] w41_symm, w42_symm, w43_symm, w44_symm;

wire signed [25:0] w11_norm, w12_norm, w13_norm, w14_norm;
wire signed [25:0] w21_norm, w22_norm, w23_norm, w24_norm;
wire signed [25:0] w31_norm, w32_norm, w33_norm, w34_norm;
wire signed [25:0] w41_norm, w42_norm, w43_norm, w44_norm;

wire signed [25:0] w11_fast, w12_fast, w13_fast, w14_fast;
wire signed [25:0] w21_fast, w22_fast, w23_fast, w24_fast;
wire signed [25:0] w31_fast, w32_fast, w33_fast, w34_fast;
wire signed [25:0] w41_fast, w42_fast, w43_fast, w44_fast;

wire signed [25:0] w11_error, w12_error, w13_error, w14_error;
wire signed [25:0] w21_error, w22_error, w23_error, w24_error;
wire signed [25:0] w31_error, w32_error, w33_error, w34_error;
wire signed [25:0] w41_error, w42_error, w43_error, w44_error;

FASTICA_CONTROLLER fastica_controller (
    .clk_fastica(clk_fastica),
    .go_fastica(go_fastica),
    .symm_busy(symm_busy),
    .fast_busy(fast_busy),
    .error_busy(error_busy),

    .isConverge(isConverge),

    .fastica_busy(fastica_busy),

    .clk_symm(clk_symm),
    .clk_norm(clk_norm),
    .clk_fast(clk_fast),
    .clk_error(clk_error),
    .clk_mul1(clk_mul1),
    // .clk_mul2(),
    .clk_mem1(clk_mem1),

    .go_symm(go_symm),
    .en_norm(en_norm),
    .go_fast(go_fast),
    .en_error(en_error),
    .en_mul1(en_mul1),
    // .en_mul2(),
    .en_mem1(en_mem1),
    .address_sel_mem1(address_sel_mem1),
    .rw(rw)
);

SYMM_ORTH symm_orth (
    .clk_symm(clk_symm),
    .go_symm(go_symm),

    .symm_busy(symm_busy),

    .b11(w11_error), .b12(w12_error), .b13(w13_error), .b14(w14_error),
    .b21(w21_error), .b22(w22_error), .b23(w23_error), .b24(w24_error),
    .b31(w31_error), .b32(w32_error), .b33(w33_error), .b34(w34_error),
    .b41(w41_error), .b42(w42_error), .b43(w43_error), .b44(w44_error),

    .w11_symm(w11_symm), .w12_symm(w12_symm), .w13_symm(w13_symm), .w14_symm(w14_symm),
    .w21_symm(w21_symm), .w22_symm(w22_symm), .w23_symm(w23_symm), .w24_symm(w24_symm),
    .w31_symm(w31_symm), .w32_symm(w32_symm), .w33_symm(w33_symm), .w34_symm(w34_symm),
    .w41_symm(w41_symm), .w42_symm(w42_symm), .w43_symm(w43_symm), .w44_symm(w44_symm)
);

NORM_DIVIDER norm_divider (
    .clk_norm(clk_norm),
    .en_norm(en_norm),

    .w_in11(w11_symm), .w_in12(w12_symm), .w_in13(w13_symm), .w_in14(w14_symm),
    .w_in21(w21_symm), .w_in22(w22_symm), .w_in23(w23_symm), .w_in24(w24_symm),
    .w_in31(w31_symm), .w_in32(w32_symm), .w_in33(w33_symm), .w_in34(w34_symm),
    .w_in41(w41_symm), .w_in42(w42_symm), .w_in43(w43_symm), .w_in44(w44_symm),

    .w_out11(w11_norm), .w_out12(w12_norm), .w_out13(w13_norm), .w_out14(w14_norm),
    .w_out21(w21_norm), .w_out22(w22_norm), .w_out23(w23_norm), .w_out24(w24_norm),
    .w_out31(w31_norm), .w_out32(w32_norm), .w_out33(w33_norm), .w_out34(w34_norm),
    .w_out41(w41_norm), .w_out42(w42_norm), .w_out43(w43_norm), .w_out44(w44_norm)
);

ONE_UNIT_FASTICA one_unit_fastica(
    .clk_fast(clk_fast),
    .go_fast(go_fast),

    .z1(Z1[fast_cnt]), .z2(Z2[fast_cnt]), .z3(Z3[fast_cnt]), .z4(Z4[fast_cnt]),

    .w11_in(w11_norm), .w12_in(w12_norm), .w13_in(w13_norm), .w14_in(w14_norm),
    .w21_in(w21_norm), .w22_in(w22_norm), .w23_in(w23_norm), .w24_in(w24_norm),
    .w31_in(w31_norm), .w32_in(w32_norm), .w33_in(w33_norm), .w34_in(w34_norm),
    .w41_in(w41_norm), .w42_in(w42_norm), .w43_in(w43_norm), .w44_in(w44_norm),

    .fast_busy(fast_busy),
    // E(Z(Z^TW)^3) - 3W
    .w11_out(w11_fast), .w12_out(w12_fast), .w13_out(w13_fast), .w14_out(w14_fast),
    .w21_out(w21_fast), .w22_out(w22_fast), .w23_out(w23_fast), .w24_out(w24_fast),
    .w31_out(w31_fast), .w32_out(w32_fast), .w33_out(w33_fast), .w34_out(w34_fast),
    .w41_out(w41_fast), .w42_out(w42_fast), .w43_out(w43_fast), .w44_out(w44_fast)
);

ERROR_CAL error_cal(
    .clk_error(clk_error),
    .en_error(en_error),

    .w_new11(w11_fast), .w_new12(w12_fast), .w_new13(w13_fast), .w_new14(w14_fast),
    .w_new21(w21_fast), .w_new22(w22_fast), .w_new23(w23_fast), .w_new24(w24_fast),
    .w_new31(w31_fast), .w_new32(w32_fast), .w_new33(w33_fast), .w_new34(w34_fast),
    .w_new41(w41_fast), .w_new42(w42_fast), .w_new43(w43_fast), .w_new44(w44_fast),

    .w11(w11_error), .w12(w12_error), .w13(w13_error), .w14(w14_error),
    .w21(w21_error), .w22(w22_error), .w23(w23_error), .w24(w24_error),
    .w31(w31_error), .w32(w32_error), .w33(w33_error), .w34(w34_error),
    .w41(w41_error), .w42(w42_error), .w43(w43_error), .w44(w44_error),
    
    .isConverge(isConverge),
    .error_busy(error_busy)
);

FASTICA_MUL1 fastica_mul1(
    .clk_mul(clk_mul1),
    .en_mul(en_mul1),

    .w11(w11_error), .w12(w12_error), .w13(w13_error), .w14(w14_error),
    .w21(w21_error), .w22(w22_error), .w23(w23_error), .w24(w24_error),
    .w31(w31_error), .w32(w32_error), .w33(w33_error), .w34(w34_error),
    .w41(w41_error), .w42(w42_error), .w43(w43_error), .w44(w44_error),

    .z1(Z1[mul1_cnt]), .z2(Z2[mul1_cnt]), .z3(Z3[mul_cnt]), .z4(Z4[mul_cnt]),

    .y1(y1), .y2(y2), .y3(y3), .y4(y4)
);
    
endmodule
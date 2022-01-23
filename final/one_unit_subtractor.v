module ONE_UNIT_SUBTRACTOR (
    input clk_sub,
    input en_sub,

    // mean
    input signed [25:0] i1_11, i1_12, i1_13, i1_14,
    input signed [25:0] i1_21, i1_22, i1_23, i1_24,
    input signed [25:0] i1_31, i1_32, i1_33, i1_34,
    input signed [25:0] i1_41, i1_42, i1_43, i1_44,
    // 3w
    input signed [25:0] i2_11, i2_12, i2_13, i2_14,
    input signed [25:0] i2_21, i2_22, i2_23, i2_24,
    input signed [25:0] i2_31, i2_32, i2_33, i2_34,
    input signed [25:0] i2_41, i2_42, i2_43, i2_44,

    output reg signed [25:0] w11, w12, w13, w14,
    output reg signed [25:0] w21, w22, w23, w24,
    output reg signed [25:0] w31, w32, w33, w34,
    output reg signed [25:0] w41, w42, w43, w44
);

always @(posedge clk_sub) begin
    if (en_sub) begin
        w11 <= i1_11 - i2_11;
        w12 <= i1_12 - i2_12;
        w13 <= i1_13 - i2_13;
        w14 <= i1_14 - i2_14;
        w21 <= i1_21 - i2_21;
        w22 <= i1_22 - i2_22;
        w23 <= i1_23 - i2_23;
        w24 <= i1_24 - i2_24;
        w31 <= i1_31 - i2_31;
        w32 <= i1_32 - i2_32;
        w33 <= i1_33 - i2_33;
        w34 <= i1_34 - i2_34;
        w41 <= i1_41 - i2_41;
        w42 <= i1_42 - i2_42;
        w43 <= i1_43 - i2_43;
        w44 <= i1_44 - i2_44;
    end else begin
        w11 <= i2_11;
        w12 <= i2_12;
        w13 <= i2_13;
        w14 <= i2_14;
        w21 <= i2_21;
        w22 <= i2_22;
        w23 <= i2_23;
        w24 <= i2_24;
        w31 <= i2_31;
        w32 <= i2_32;
        w33 <= i2_33;
        w34 <= i2_34;
        w41 <= i2_41;
        w42 <= i2_42;
        w43 <= i2_43;
        w44 <= i2_44;
    end
end
    
endmodule
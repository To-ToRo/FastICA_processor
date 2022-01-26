module ERROR_SUB(
    input clk_sub,
    input en_sub,

    input signed [25:0] i1_11, i1_12, i1_13, i1_14,
    input signed [25:0] i1_21, i1_22, i1_23, i1_24,
    input signed [25:0] i1_31, i1_32, i1_33, i1_34,
    input signed [25:0] i1_41, i1_42, i1_43, i1_44,

    input signed [25:0] i2_11, i2_12, i2_13, i2_14,
    input signed [25:0] i2_21, i2_22, i2_23, i2_24,
    input signed [25:0] i2_31, i2_32, i2_33, i2_34,
    input signed [25:0] i2_41, i2_42, i2_43, i2_44,

    input signed [25:0] iw_11, iw_12, iw_13, iw_14,
    input signed [25:0] iw_21, iw_22, iw_23, iw_24,
    input signed [25:0] iw_31, iw_32, iw_33, iw_34,
    input signed [25:0] iw_41, iw_42, iw_43, iw_44,

    output reg signed [25:0] ow_11, ow_12, ow_13, ow_14,
    output reg signed [25:0] ow_21, ow_22, ow_23, ow_24,
    output reg signed [25:0] ow_31, ow_32, ow_33, ow_34,
    output reg signed [25:0] ow_41, ow_42, ow_43, ow_44,

    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44
);

always @(posedge clk_sub) begin
    if (en_sub) begin
        o11 <= i1_11 - i2_11; o12 <= i1_12 - i2_12; o13 <= i1_13 - i2_13; o14 <= i1_14 - i2_14;
        o21 <= i1_21 - i2_21; o22 <= i1_22 - i2_22; o23 <= i1_23 - i2_23; o24 <= i1_24 - i2_24;
        o31 <= i1_31 - i2_31; o32 <= i1_32 - i2_32; o33 <= i1_33 - i2_33; o34 <= i1_34 - i2_34;
        o41 <= i1_41 - i2_41; o42 <= i1_42 - i2_42; o43 <= i1_43 - i2_43; o44 <= i1_44 - i2_44;

        ow_11 <= iw_11; ow_12 <= iw_12; ow_13 <= iw_13; ow_14 <= iw_14;
        ow_21 <= iw_21; ow_22 <= iw_22; ow_23 <= iw_23; ow_24 <= iw_24;
        ow_31 <= iw_31; ow_32 <= iw_32; ow_33 <= iw_33; ow_34 <= iw_34;
        ow_41 <= iw_41; ow_42 <= iw_42; ow_43 <= iw_43; ow_44 <= iw_44;
    end else begin
        o11 <= i1_11; o12 <= i1_12; o13 <= i1_13; o14 <= i1_14;
        o21 <= i1_21; o22 <= i1_22; o23 <= i1_23; o24 <= i1_24;
        o31 <= i1_31; o32 <= i1_32; o33 <= i1_33; o34 <= i1_34;
        o41 <= i1_41; o42 <= i1_42; o43 <= i1_43; o44 <= i1_44;
    end
end

endmodule

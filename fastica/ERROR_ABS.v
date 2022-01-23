module ERROR_ABS(
    input clk_abs,
    input en_abs,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    input reg signed [25:0] iw_new11, iw_new12, iw_new13, iw_new14,
    input reg signed [25:0] iw_new21, iw_new22, iw_new23, iw_new24,
    input reg signed [25:0] iw_new31, iw_new32, iw_new33, iw_new34,
    input reg signed [25:0] iw_new41, iw_new42, iw_new43, iw_new44,

    output reg signed [25:0] ow_new11, ow_new12, ow_new13, ow_new14,
    output reg signed [25:0] ow_new21, ow_new22, ow_new23, ow_new24,
    output reg signed [25:0] ow_new31, ow_new32, ow_new33, ow_new34,
    output reg signed [25:0] ow_new41, ow_new42, ow_new43, ow_new44,

    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44
);
wire signed [51:0] pow1, pow2, pow3, pow4, pow5, pow6, pow7, pow8, pow9, pow10, pow11, pow12, pow13, pow14, pow15, pow16;
wire signed [25:0] sqrt1, sqrt2, sqrt3, sqrt4, sqrt5, sqrt6, sqrt7, sqrt8, sqrt9, sqrt10, sqrt11, sqrt12, sqrt13, sqrt14, sqrt15, sqrt16;

assign pow1 = (i11 * i11) >>> 13;
assign pow2 = (i12 * i12) >>> 13;
assign pow3 = (i13 * i13) >>> 13;
assign pow4 = (i14 * i14) >>> 13;
assign pow5 = (i21 * i21) >>> 13;
assign pow6 = (i22 * i22) >>> 13;
assign pow7 = (i23 * i23) >>> 13;
assign pow8 = (i24 * i24) >>> 13;
assign pow9 = (i31 * i31) >>> 13;
assign pow10 = (i32 * i32) >>> 13;
assign pow11 = (i33 * i33) >>> 13;
assign pow12 = (i34 * i34) >>> 13;
assign pow13 = (i41 * i41) >>> 13;
assign pow14 = (i42 * i42) >>> 13;
assign pow15 = (i43 * i43) >>> 13;
assign pow16 = (i44 * i44) >>> 13;

always @(posedge clk_abs) begin
    if (en_abs) begin
        o11 <= sqrt1; o12 <= sqrt2; o13 <= sqrt3; o14 <= sqrt4; 
        o21 <= sqrt5; o22 <= sqrt6; o23 <= sqrt7; o24 <= sqrt8; 
        o31 <= sqrt9; o32 <= sqrt10; o33 <= sqrt11; o34 <= sqrt12; 
        o41 <= sqrt13; o42 <= sqrt14; o43 <= sqrt15; o44 <= sqrt16; 

        ow_new11 <= iw_new11; ow_new12 <= iw_new11; ow_new13 <= iw_new13; ow_new14 <= iw_new_14;
        ow_new21 <= iw_new21; ow_new22 <= iw_new21; ow_new23 <= iw_new23; ow_new24 <= iw_new_24;
        ow_new31 <= iw_new31; ow_new32 <= iw_new31; ow_new33 <= iw_new33; ow_new34 <= iw_new_34;
        ow_new41 <= iw_new41; ow_new42 <= iw_new41; ow_new43 <= iw_new43; ow_new44 <= iw_new_44;
    end else begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;

        ow_new11 <= iw_new11; ow_new12 <= iw_new11; ow_new13 <= iw_new13; ow_new14 <= iw_new_14;
        ow_new21 <= iw_new21; ow_new22 <= iw_new21; ow_new23 <= iw_new23; ow_new24 <= iw_new_24;
        ow_new31 <= iw_new31; ow_new32 <= iw_new31; ow_new33 <= iw_new33; ow_new34 <= iw_new_34;
        ow_new41 <= iw_new41; ow_new42 <= iw_new41; ow_new43 <= iw_new43; ow_new44 <= iw_new_44;
    end
end

SQRT2 SQRT1 (
    .x(pow1),
    .y(sqrt1)
);

SQRT2 SQRT2 (
    .x(pow2),
    .y(sqrt2)
);

SQRT2 SQRT3 (
    .x(pow3),
    .y(sqrt3)
);

SQRT2 SQRT4 (
    .x(pow4),
    .y(sqrt4)
);

SQRT2 SQRT5 (
    .x(pow5),
    .y(sqrt5)
);

SQRT2 SQRT6 (
    .x(pow6),
    .y(sqrt6)
);

SQRT2 SQRT7 (
    .x(pow7),
    .y(sqrt7)
);

SQRT2 SQRT8 (
    .x(pow8),
    .y(sqrt8)
);

SQRT2 SQRT9 (
    .x(pow9),
    .y(sqrt9)
);

SQRT2 SQRT10 (
    .x(pow10),
    .y(sqrt10)
);

SQRT2 SQRT11 (
    .x(pow11),
    .y(sqrt11)
);

SQRT2 SQRT12 (
    .x(pow12),
    .y(sqrt12)
);

SQRT2 SQRT13 (
    .x(pow13),
    .y(sqrt13)
);

SQRT2 SQRT14 (
    .x(pow14),
    .y(sqrt14)
);

SQRT2 SQRT15 (
    .x(pow15),
    .y(sqrt15)
);

SQRT2 SQRT16 (
    .x(pow16),
    .y(sqrt16)
);
endmodule

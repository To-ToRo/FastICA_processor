module SYMM_ABS(
    input clk_abs,
    input en_abs,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,
    
    input signed [25:0] i11_2, i12_2, i13_2, i14_2,
    input signed [25:0] i21_2, i22_2, i23_2, i24_2,
    input signed [25:0] i31_2, i32_2, i33_2, i34_2,
    input signed [25:0] i41_2, i42_2, i43_2, i44_2,

    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44,
    
    output reg signed [25:0] o11_2, o12_2, o13_2, o14_2,
    output reg signed [25:0] o21_2, o22_2, o23_2, o24_2,
    output reg signed [25:0] o31_2, o32_2, o33_2, o34_2,
    output reg signed [25:0] o41_2, o42_2, o43_2, o44_2
);
wire signed [51:0] pow1, pow2, pow3, pow4, pow5, pow6, pow7, pow8, pow9, pow10, pow11, pow12, pow13, pow14, pow15, pow16;
wire signed [25:0] sqrt1, sqrt2, sqrt3, sqrt4, sqrt5, sqrt6, sqrt7, sqrt8, sqrt9, sqrt10, sqrt11, sqrt12, sqrt13, sqrt14, sqrt15, sqrt16;

assign pow1 = ((i11_2 - 26'd8192) * (i11_2 - 26'd8192)) >>> 13;
assign pow2 = (i12_2 * i12_2) >>> 13;
assign pow3 = (i13_2 * i13_2) >>> 13;
assign pow4 = (i14_2 * i14_2) >>> 13;
assign pow5 = (i21_2 * i21_2) >>> 13;
assign pow6 = ((i22_2 - 26'd8192) * (i22_2 - 26'd8192)) >>> 13;
assign pow7 = (i23_2 * i23_2) >>> 13;
assign pow8 = (i24_2 * i24_2) >>> 13;
assign pow9 = (i31_2 * i31_2) >>> 13;
assign pow10 = (i32_2 * i32_2) >>> 13;
assign pow11 = ((i33_2 - 26'd8192) * (i33_2 - 26'd8192)) >>> 13;
assign pow12 = (i34_2 * i34_2) >>> 13;
assign pow13 = (i41_2 * i41_2) >>> 13;
assign pow14 = (i42_2 * i42_2) >>> 13;
assign pow15 = (i43_2 * i43_2) >>> 13;
assign pow16 = ((i44_2 - 26'd8192) * (i44_2 - 26'd8192)) >>> 13;

always @(posedge clk_abs) begin
    if (en_abs) begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
        
        o11_2 <= sqrt1; o12_2 <= sqrt2; o13_2 <= sqrt3; o14_2 <= sqrt4; 
        o21_2 <= sqrt5; o22_2 <= sqrt6; o23_2 <= sqrt7; o24_2 <= sqrt8; 
        o31_2 <= sqrt9; o32_2 <= sqrt10; o33_2 <= sqrt11; o34_2 <= sqrt12; 
        o41_2 <= sqrt13; o42_2 <= sqrt14; o43_2 <= sqrt15; o44_2 <= sqrt16; 
    end else begin
        // o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        // o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        // o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        // o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
        
        // o11_2 <= i11; o12_2 <= i12; o13_2 <= i13; o14_2 <= i14;
        // o21_2 <= i21; o22_2 <= i22; o23_2 <= i23; o24_2 <= i24;
        // o31_2 <= i31; o32_2 <= i32; o33_2 <= i33; o34_2 <= i34;
        // o41_2 <= i41; o42_2 <= i42; o43_2 <= i43; o44_2 <= i44;
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
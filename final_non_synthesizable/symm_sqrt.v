module SYMM_SQRT (
    input clk_sqrt,
    input en_sqrt,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    input signed [25:0] sum1, sum2, sum3, sum4,

    output wire signed [25:0] o11, o12, o13, o14,
    output wire signed [25:0] o21, o22, o23, o24,
    output wire signed [25:0] o31, o32, o33, o34,
    output wire signed [25:0] o41, o42, o43, o44
);

wire signed [25:0] sqrt1, sqrt2, sqrt3, sqrt4;

reg signed [51:0] o11_reg, o12_reg, o13_reg, o14_reg;
reg signed [51:0] o21_reg, o22_reg, o23_reg, o24_reg;  
reg signed [51:0] o31_reg, o32_reg, o33_reg, o34_reg;  
reg signed [51:0] o41_reg, o42_reg, o43_reg, o44_reg;   

assign o11 = o11_reg[25:0];
assign o12 = o12_reg[25:0];
assign o13 = o13_reg[25:0];
assign o14 = o14_reg[25:0];
assign o21 = o21_reg[25:0];
assign o22 = o22_reg[25:0];
assign o23 = o23_reg[25:0];
assign o24 = o24_reg[25:0];
assign o31 = o31_reg[25:0];
assign o32 = o32_reg[25:0];
assign o33 = o33_reg[25:0];
assign o34 = o34_reg[25:0];
assign o41 = o41_reg[25:0];
assign o42 = o42_reg[25:0];
assign o43 = o43_reg[25:0];
assign o44 = o44_reg[25:0];


always @(posedge clk_sqrt) begin
    if (en_sqrt) begin
        o11_reg <= ((i11 <<< 26) / ((sqrt1 <<< 26) >>> 26)) >>> 13; o12_reg <= (((i12 <<< 26) / ((sqrt1 <<< 26) >>> 26))) >>> 13;
        o13_reg <= ((i13 <<< 26) / ((sqrt1 <<< 26) >>> 26)) >>> 13; o14_reg <= (((i14 <<< 26) / ((sqrt1 <<< 26) >>> 26))) >>> 13; 
        o21_reg <= ((i21 <<< 26) / ((sqrt2 <<< 26) >>> 26)) >>> 13; o22_reg <= (((i22 <<< 26) / ((sqrt2 <<< 26) >>> 26))) >>> 13;
        o23_reg <= ((i23 <<< 26) / ((sqrt2 <<< 26) >>> 26)) >>> 13; o24_reg <= (((i24 <<< 26) / ((sqrt2 <<< 26) >>> 26))) >>> 13; 
        o31_reg <= ((i31 <<< 26) / ((sqrt3 <<< 26) >>> 26)) >>> 13; o32_reg <= (((i32 <<< 26) / ((sqrt3 <<< 26) >>> 26))) >>> 13;
        o33_reg <= ((i33 <<< 26) / ((sqrt3 <<< 26) >>> 26)) >>> 13; o34_reg <= (((i34 <<< 26) / ((sqrt3 <<< 26) >>> 26))) >>> 13; 
        o41_reg <= ((i41 <<< 26) / ((sqrt4 <<< 26) >>> 26)) >>> 13; o42_reg <= (((i42 <<< 26) / ((sqrt4 <<< 26) >>> 26))) >>> 13;
        o43_reg <= ((i43 <<< 26) / ((sqrt4 <<< 26) >>> 26)) >>> 13; o44_reg <= (((i44 <<< 26) / ((sqrt4 <<< 26) >>> 26))) >>> 13; 
    end else begin
        // o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        // o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        // o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        // o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
    end
end

SQRT1 symm_sqrt1 (
    .x(sum1),
    .y(sqrt1)
);
SQRT1 symm_sqrt2 (
    .x(sum2),
    .y(sqrt2)
);
SQRT1 symm_sqrt3 (
    .x(sum3),
    .y(sqrt3)
);
SQRT1 symm_sqrt4 (
    .x(sum4),
    .y(sqrt4)
);

endmodule
module SYMM_SQRT (
    input clk_sqrt,
    input en_sqrt,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    input signed [25:0] sum1, sum2, sum3, sum4,

    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44
);

wire signed [25:0] sqrt1, sqrt2, sqrt3, sqrt4;

always @(posedge clk_sqrt) begin
    if (en_sqrt) begin
        o11 <= ((i11 <<< 6) / (sqrt1 >>> 6)) <<< 1; o12 <= ((i12 <<< 6) / (sqrt1 >>> 6)) <<< 1;
        o13 <= ((i13 <<< 6) / (sqrt1 >>> 6)) <<< 1; o14 <= ((i14 <<< 6) / (sqrt1 >>> 6)) <<< 1; 
        o21 <= ((i21 <<< 6) / (sqrt2 >>> 6)) <<< 1; o22 <= ((i22 <<< 6) / (sqrt2 >>> 6)) <<< 1;
        o23 <= ((i23 <<< 6) / (sqrt2 >>> 6)) <<< 1; o24 <= ((i24 <<< 6) / (sqrt2 >>> 6)) <<< 1; 
        o31 <= ((i31 <<< 6) / (sqrt3 >>> 6)) <<< 1; o32 <= ((i32 <<< 6) / (sqrt3 >>> 6)) <<< 1;
        o33 <= ((i33 <<< 6) / (sqrt3 >>> 6)) <<< 1; o34 <= ((i34 <<< 6) / (sqrt3 >>> 6)) <<< 1; 
        o41 <= ((i41 <<< 6) / (sqrt4 >>> 6)) <<< 1; o42 <= ((i42 <<< 6) / (sqrt4 >>> 6)) <<< 1;
        o43 <= ((i43 <<< 6) / (sqrt4 >>> 6)) <<< 1; o44 <= ((i44 <<< 6) / (sqrt4 >>> 6)) <<< 1; 
    end else begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
    end
end

SQRT SQRT1 (
    .x(sum1),
    .y(sqrt1)
);
SQRT SQRT2 (
    .x(sum2),
    .y(sqrt2)
);
SQRT SQRT3 (
    .x(sum3),
    .y(sqrt3)
);
SQRT SQRT4 (
    .x(sum4),
    .y(sqrt4)
);

endmodule
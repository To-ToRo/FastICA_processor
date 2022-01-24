module SYMM_MUL3 (
    input clk_mul3,
    input en_mul3,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    output signed [25:0] o11, o12, o13, o14,
    output signed [25:0] o21, o22, o23, o24,
    output signed [25:0] o31, o32, o33, o34,
    output signed [25:0] o41, o42, o43, o44
);

reg signed [51:0] wwT11, wwT12, wwT13, wwT14;
reg signed [51:0] wwT21, wwT22, wwT23, wwT24;
reg signed [51:0] wwT31, wwT32, wwT33, wwT34;
reg signed [51:0] wwT41, wwT42, wwT43, wwT44;

reg signed [51:0] wwTw11, wwTw12, wwTw13, wwTw14;
reg signed [51:0] wwTw21, wwTw22, wwTw23, wwTw24;
reg signed [51:0] wwTw31, wwTw32, wwTw33, wwTw34;
reg signed [51:0] wwTw41, wwTw42, wwTw43, wwTw44;

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

always @(*) begin
    wwT11 = ((i11 * i11) >>> 13) + ((i12 * i12) >>> 13) + ((i13 * i13) >>> 13) + ((i14 * i14) >>> 13);
    wwT12 = ((i11 * i21) >>> 13) + ((i12 * i22) >>> 13) + ((i13 * i23) >>> 13) + ((i14 * i24) >>> 13);
    wwT13 = ((i11 * i31) >>> 13) + ((i12 * i32) >>> 13) + ((i13 * i33) >>> 13) + ((i14 * i34) >>> 13);
    wwT14 = ((i11 * i41) >>> 13) + ((i12 * i42) >>> 13) + ((i13 * i43) >>> 13) + ((i14 * i44) >>> 13);
    wwT21 = ((i21 * i11) >>> 13) + ((i22 * i12) >>> 13) + ((i23 * i13) >>> 13) + ((i24 * i14) >>> 13);
    wwT22 = ((i21 * i21) >>> 13) + ((i22 * i22) >>> 13) + ((i23 * i23) >>> 13) + ((i24 * i24) >>> 13);
    wwT23 = ((i21 * i31) >>> 13) + ((i22 * i32) >>> 13) + ((i23 * i33) >>> 13) + ((i24 * i34) >>> 13);
    wwT24 = ((i21 * i41) >>> 13) + ((i22 * i42) >>> 13) + ((i23 * i43) >>> 13) + ((i24 * i44) >>> 13);
    wwT31 = ((i31 * i11) >>> 13) + ((i32 * i12) >>> 13) + ((i33 * i13) >>> 13) + ((i34 * i14) >>> 13);
    wwT32 = ((i31 * i21) >>> 13) + ((i32 * i22) >>> 13) + ((i33 * i23) >>> 13) + ((i34 * i24) >>> 13);
    wwT33 = ((i31 * i31) >>> 13) + ((i32 * i32) >>> 13) + ((i33 * i33) >>> 13) + ((i34 * i34) >>> 13);
    wwT34 = ((i31 * i41) >>> 13) + ((i32 * i42) >>> 13) + ((i33 * i43) >>> 13) + ((i34 * i44) >>> 13);
    wwT41 = ((i41 * i11) >>> 13) + ((i42 * i12) >>> 13) + ((i43 * i13) >>> 13) + ((i44 * i14) >>> 13);
    wwT42 = ((i41 * i21) >>> 13) + ((i42 * i22) >>> 13) + ((i43 * i23) >>> 13) + ((i44 * i24) >>> 13);
    wwT43 = ((i41 * i31) >>> 13) + ((i42 * i32) >>> 13) + ((i43 * i33) >>> 13) + ((i44 * i34) >>> 13);
    wwT44 = ((i41 * i41) >>> 13) + ((i42 * i42) >>> 13) + ((i43 * i43) >>> 13) + ((i44 * i44) >>> 13);

    wwTw11 = ((wwT11 * i11) >>> 13) + ((wwT12 * i21) >>> 13) + ((wwT13 * i31) >>> 13) + ((wwT14 * i41) >>> 13);
    wwTw12 = ((wwT11 * i12) >>> 13) + ((wwT12 * i22) >>> 13) + ((wwT13 * i32) >>> 13) + ((wwT14 * i42) >>> 13);
    wwTw13 = ((wwT11 * i13) >>> 13) + ((wwT12 * i23) >>> 13) + ((wwT13 * i33) >>> 13) + ((wwT14 * i43) >>> 13);
    wwTw14 = ((wwT11 * i14) >>> 13) + ((wwT12 * i24) >>> 13) + ((wwT13 * i34) >>> 13) + ((wwT14 * i44) >>> 13);
    wwTw21 = ((wwT21 * i11) >>> 13) + ((wwT22 * i21) >>> 13) + ((wwT23 * i31) >>> 13) + ((wwT24 * i41) >>> 13);
    wwTw22 = ((wwT21 * i12) >>> 13) + ((wwT22 * i22) >>> 13) + ((wwT23 * i32) >>> 13) + ((wwT24 * i42) >>> 13);
    wwTw23 = ((wwT21 * i13) >>> 13) + ((wwT22 * i23) >>> 13) + ((wwT23 * i33) >>> 13) + ((wwT24 * i43) >>> 13);
    wwTw24 = ((wwT21 * i14) >>> 13) + ((wwT22 * i24) >>> 13) + ((wwT23 * i34) >>> 13) + ((wwT24 * i44) >>> 13);
    wwTw31 = ((wwT31 * i11) >>> 13) + ((wwT32 * i21) >>> 13) + ((wwT33 * i31) >>> 13) + ((wwT34 * i41) >>> 13);
    wwTw32 = ((wwT31 * i12) >>> 13) + ((wwT32 * i22) >>> 13) + ((wwT33 * i32) >>> 13) + ((wwT34 * i42) >>> 13);
    wwTw33 = ((wwT31 * i13) >>> 13) + ((wwT32 * i23) >>> 13) + ((wwT33 * i33) >>> 13) + ((wwT34 * i43) >>> 13);
    wwTw34 = ((wwT31 * i14) >>> 13) + ((wwT32 * i24) >>> 13) + ((wwT33 * i34) >>> 13) + ((wwT34 * i44) >>> 13);
    wwTw41 = ((wwT41 * i11) >>> 13) + ((wwT42 * i21) >>> 13) + ((wwT43 * i31) >>> 13) + ((wwT44 * i41) >>> 13);
    wwTw42 = ((wwT41 * i12) >>> 13) + ((wwT42 * i22) >>> 13) + ((wwT43 * i32) >>> 13) + ((wwT44 * i42) >>> 13);
    wwTw43 = ((wwT41 * i13) >>> 13) + ((wwT42 * i23) >>> 13) + ((wwT43 * i33) >>> 13) + ((wwT44 * i43) >>> 13);
    wwTw44 = ((wwT41 * i14) >>> 13) + ((wwT42 * i24) >>> 13) + ((wwT43 * i34) >>> 13) + ((wwT44 * i44) >>> 13);
end

always @(posedge clk_mul3) begin
    if (en_mul3) begin
        o11_reg <= wwTw11 >>> 1; o12_reg <= wwTw12 >>> 1; o13_reg <= wwTw13 >>> 1; o14_reg <= wwTw14 >>> 1;
        o21_reg <= wwTw21 >>> 1; o22_reg <= wwTw22 >>> 1; o23_reg <= wwTw23 >>> 1; o24_reg <= wwTw24 >>> 1;
        o31_reg <= wwTw31 >>> 1; o32_reg <= wwTw32 >>> 1; o33_reg <= wwTw33 >>> 1; o34_reg <= wwTw34 >>> 1;
        o41_reg <= wwTw41 >>> 1; o42_reg <= wwTw42 >>> 1; o43_reg <= wwTw43 >>> 1; o44_reg <= wwTw44 >>> 1;
    end else begin
        // o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        // o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        // o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        // o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
    end
end
    
endmodule
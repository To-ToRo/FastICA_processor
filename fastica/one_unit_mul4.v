module ONE_UNIT_MUL4 (
    input clk_mul,
    input en_mul,
    
    // z
    input signed [25:0] z1, z2, z3, z4,

    // (zTw)^3
    input signed [25:0] i1_11, i1_12, i1_13, i1_14,
    input signed [25:0] i1_21, i1_22, i1_23, i1_24,
    input signed [25:0] i1_31, i1_32, i1_33, i1_34,
    input signed [25:0] i1_41, i1_42, i1_43, i1_44,
    
    input signed [25:0] i2_11, i2_12, i2_13, i2_14,
    input signed [25:0] i2_21, i2_22, i2_23, i2_24,
    input signed [25:0] i2_31, i2_32, i2_33, i2_34,
    input signed [25:0] i2_41, i2_42, i2_43, i2_44,

    input signed [25:0] i3_11, i3_12, i3_13, i3_14,
    input signed [25:0] i3_21, i3_22, i3_23, i3_24,
    input signed [25:0] i3_31, i3_32, i3_33, i3_34,
    input signed [25:0] i3_41, i3_42, i3_43, i3_44,

    input signed [25:0] i4_11, i4_12, i4_13, i4_14,
    input signed [25:0] i4_21, i4_22, i4_23, i4_24,
    input signed [25:0] i4_31, i4_32, i4_33, i4_34,
    input signed [25:0] i4_41, i4_42, i4_43, i4_44,

    output signed [25:0] o11, o12, o13, o14,
    output signed [25:0] o21, o22, o23, o24,
    output signed [25:0] o31, o32, o33, o34,
    output signed [25:0] o41, o42, o43, o44
);

reg signed [51:0] o11_52, o12_52, o13_52, o14_52;
reg signed [51:0] o21_52, o22_52, o23_52, o24_52;
reg signed [51:0] o31_52, o32_52, o33_52, o34_52;
reg signed [51:0] o41_52, o42_52, o43_52, o44_52;

assign o11 = o11_52[38:13];
assign o12 = o12_52[38:13];
assign o13 = o13_52[38:13];
assign o14 = o14_52[38:13];
assign o21 = o21_52[38:13];
assign o22 = o22_52[38:13];
assign o23 = o23_52[38:13];
assign o24 = o24_52[38:13];
assign o31 = o31_52[38:13];
assign o32 = o32_52[38:13];
assign o33 = o33_52[38:13];
assign o34 = o34_52[38:13];
assign o41 = o41_52[38:13];
assign o42 = o42_52[38:13];
assign o43 = o43_52[38:13];
assign o44 = o44_52[38:13];


always @(posedge clk_mul)
begin
    if (en_mul) begin
        // active
        o11_52 <= z1 * i1_11 + z2 * i1_21 + z3 * i1_31 + z4 * i1_41;
        o12_52 <= z1 * i1_12 + z2 * i1_22 + z3 * i1_32 + z4 * i1_42;
        o13_52 <= z1 * i1_13 + z2 * i1_23 + z3 * i1_33 + z4 * i1_43;
        o14_52 <= z1 * i1_14 + z2 * i1_24 + z3 * i1_34 + z4 * i1_44;

        o21_52 <= z1 * i2_11 + z2 * i2_21 + z3 * i2_31 + z4 * i2_41;
        o22_52 <= z1 * i2_12 + z2 * i2_22 + z3 * i2_32 + z4 * i2_42;
        o23_52 <= z1 * i2_13 + z2 * i2_23 + z3 * i2_33 + z4 * i2_43;
        o24_52 <= z1 * i2_14 + z2 * i2_24 + z3 * i2_34 + z4 * i2_44;
        
        o31_52 <= z1 * i3_11 + z2 * i3_21 + z3 * i3_31 + z4 * i3_41;
        o32_52 <= z1 * i3_12 + z2 * i3_22 + z3 * i3_32 + z4 * i3_42;
        o33_52 <= z1 * i3_13 + z2 * i3_23 + z3 * i3_33 + z4 * i3_43;
        o34_52 <= z1 * i3_14 + z2 * i3_24 + z3 * i3_34 + z4 * i3_44;
        
        o41_52 <= z1 * i4_11 + z2 * i4_21 + z3 * i4_31 + z4 * i4_41;
        o42_52 <= z1 * i4_12 + z2 * i4_22 + z3 * i4_32 + z4 * i4_42;
        o43_52 <= z1 * i4_13 + z2 * i4_23 + z3 * i4_33 + z4 * i4_43;
        o44_52 <= z1 * i4_14 + z2 * i4_24 + z3 * i4_34 + z4 * i4_44;
    end else begin
        o11_52 <= i1_11;
        o12_52 <= i1_12;
        o13_52 <= i1_13;
        o14_52 <= i1_14;

        o21_52 <= i2_11;
        o22_52 <= i2_12;
        o23_52 <= i2_13;
        o24_52 <= i2_14;
        
        o31_52 <= i3_11;
        o32_52 <= i3_12;
        o33_52 <= i3_13;
        o34_52 <= i3_14;
        
        o41_52 <= i4_11;
        o42_52 <= i4_12;
        o43_52 <= i4_13;
        o44_52 <= i4_14;
    end
end
    
endmodule
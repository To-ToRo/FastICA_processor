module SYMM_MUL4(
    input clk_mul4,
    input en_mul4,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44,
    
    output signed [25:0] o11_2, o12_2, o13_2, o14_2,
    output signed [25:0] o21_2, o22_2, o23_2, o24_2,
    output signed [25:0] o31_2, o32_2, o33_2, o34_2,
    output signed [25:0] o41_2, o42_2, o43_2, o44_2
);

reg [51:0] dot11, dot12, dot13, dot14,
           dot21, dot22, dot23, dot24,
           dot31, dot32, dot33, dot34,
           dot41, dot42, dot43, dot44;

assign o11_2 = dot11[38:13];
assign o12_2 = dot12[38:13];
assign o13_2 = dot13[38:13];
assign o14_2 = dot14[38:13];
assign o21_2 = dot21[38:13];
assign o22_2 = dot22[38:13];
assign o23_2 = dot23[38:13];
assign o24_2 = dot24[38:13];
assign o31_2 = dot31[38:13];
assign o32_2 = dot32[38:13];
assign o33_2 = dot33[38:13];
assign o34_2 = dot34[38:13];
assign o41_2 = dot41[38:13];
assign o42_2 = dot42[38:13];
assign o43_2 = dot43[38:13];
assign o44_2 = dot44[38:13];

always @(posedge clk_mul4) begin
    if (en_mul4) begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
        
        dot11 <= i11*i11 + i12*i12 + i13*i13 + i14*i14;
        dot12 <= i11*i21 + i12*i22 + i13*i23 + i14*i24;
        dot13 <= i11*i31 + i12*i32 + i13*i33 + i14*i34;
        dot14 <= i11*i41 + i12*i42 + i13*i43 + i14*i44;
        dot21 <= i21*i11 + i22*i12 + i23*i13 + i24*i14;
        dot22 <= i21*i21 + i22*i22 + i23*i23 + i24*i24;
        dot23 <= i21*i31 + i22*i32 + i23*i33 + i24*i34;
        dot24 <= i21*i41 + i22*i42 + i23*i43 + i24*i44;
        dot31 <= i31*i11 + i32*i12 + i33*i13 + i34*i14;
        dot32 <= i31*i21 + i32*i22 + i33*i23 + i34*i24;
        dot33 <= i31*i31 + i32*i32 + i33*i33 + i34*i34;
        dot34 <= i31*i41 + i32*i42 + i33*i43 + i34*i44;
        dot41 <= i41*i11 + i42*i12 + i43*i13 + i44*i14;
        dot42 <= i41*i21 + i42*i22 + i43*i23 + i44*i24;
        dot43 <= i41*i31 + i42*i32 + i43*i33 + i44*i34;
        dot44 <= i41*i41 + i42*i42 + i43*i43 + i44*i44;      
    end else begin
        // o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        // o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        // o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        // o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
        
        // dot11 <= 0; dot12 <= 0; dot13 <= 0; dot14 <= 0;
        // dot21 <= 0; dot22 <= 0; dot23 <= 0; dot24 <= 0;
        // dot31 <= 0; dot32 <= 0; dot33 <= 0; dot34 <= 0;
        // dot41 <= 0; dot42 <= 0; dot43 <= 0; dot44 <= 0;     
    end
end
    
endmodule

module SYMM_TEST (
    input clk_test,
    input en_test,

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
    
    output reg isOrth
);

wire signed [29:0] orthtest;

assign orthtest =  i11_2 + i12_2 + i13_2 + i14_2 
                 + i21_2 + i22_2 + i23_2 + i24_2
                 + i31_2 + i32_2 + i33_2 + i34_2
                 + i41_2 + i42_2 + i43_2 + i44_2;

always @(posedge clk_test) begin
    if (en_test) begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
        if(orthtest == 0) isOrth <= 1;
        else isOrth <= 0;
    end else begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
        isOrth <= 0;
    end
end
    
endmodule
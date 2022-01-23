module ERROR_OUT(
    input clk_out,
    input en_out,

    input signed [25:0] i1_11, i1_12, i1_13, i1_14,
    input signed [25:0] i1_21, i1_22, i1_23, i1_24,
    input signed [25:0] i1_31, i1_32, i1_33, i1_34,
    input signed [25:0] i1_41, i1_42, i1_43, i1_44,

    input signed [25:0] i2_11, i2_12, i2_13, i2_14,
    input signed [25:0] i2_21, i2_22, i2_23, i2_24,
    input signed [25:0] i2_31, i2_32, i2_33, i2_34,
    input signed [25:0] i2_41, i2_42, i2_43, i2_44,
    
    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44,
    
    output reg isConverge
);

wire signed [29:0] distance;
assign distance = i2_11 + i2_12 + i2_13 + i2_14 + i2_21 + i2_22 + i2_23 + i2_24 + i2_31 + i2_32 + i2_33 + i2_34 + i2_41 + i2_42 + i2_43 + i2_44;

always @(posedge clk_out) begin
    if (en_out) begin
        o11 <= i1_11; o12 <= i1_12; o13 <= i1_13; o14 <= i1_14;
        o21 <= i1_21; o22 <= i1_22; o23 <= i1_23; o24 <= i1_24;
        o31 <= i1_31; o32 <= i1_32; o33 <= i1_33; o34 <= i1_34;
        o41 <= i1_41; o42 <= i1_42; o43 <= i1_43; o44 <= i1_44;
        if (distance < 30'd2) begin
            isConverge <= 1;
        end else begin
            isConverge <= 0;
        end
    end else begin
        o11 <= i1_11; o12 <= i1_12; o13 <= i1_13; o14 <= i1_14;
        o21 <= i1_21; o22 <= i1_22; o23 <= i1_23; o24 <= i1_24;
        o31 <= i1_31; o32 <= i1_32; o33 <= i1_33; o34 <= i1_34;
        o41 <= i1_41; o42 <= i1_42; o43 <= i1_43; o44 <= i1_44;
        isConverge <= 0;
    end
end

endmodule
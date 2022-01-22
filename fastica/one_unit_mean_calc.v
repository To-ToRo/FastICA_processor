module ONE_UNIT_MEAN_CALC (
    input clk_mean,
    input en_mean,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    output signed [25:0] o11, o12, o13, o14,
    output signed [25:0] o21, o22, o23, o24,
    output signed [25:0] o31, o32, o33, o34,
    output signed [25:0] o41, o42, o43, o44
);

reg signed [25:0] mean11, mean12, mean13, mean14;
reg signed [25:0] mean21, mean22, mean23, mean24;
reg signed [25:0] mean31, mean32, mean33, mean34;
reg signed [25:0] mean41, mean42, mean43, mean44;

assign o11 = mean11;
assign o12 = mean12;
assign o13 = mean13;
assign o14 = mean14;
assign o21 = mean21;
assign o22 = mean22;
assign o23 = mean23;
assign o24 = mean24;
assign o31 = mean31;
assign o32 = mean32;
assign o33 = mean33;
assign o34 = mean34;
assign o41 = mean41;
assign o42 = mean42;
assign o43 = mean43;
assign o44 = mean44;

always @(posedge clk_mean)
begin
    if (en_mean) begin
        mean11 <= mean11 + (i11 >>> 7);
        mean12 <= mean12 + (i12 >>> 7);
        mean13 <= mean13 + (i13 >>> 7);
        mean14 <= mean14 + (i14 >>> 7);

        mean21 <= mean21 + (i21 >>> 7);
        mean22 <= mean22 + (i22 >>> 7);
        mean23 <= mean23 + (i23 >>> 7);
        mean24 <= mean24 + (i24 >>> 7);
        
        mean31 <= mean31 + (i31 >>> 7);
        mean32 <= mean32 + (i32 >>> 7);
        mean33 <= mean33 + (i33 >>> 7);
        mean34 <= mean34 + (i34 >>> 7);
        
        mean41 <= mean41 + (i41 >>> 7);
        mean42 <= mean42 + (i42 >>> 7);
        mean43 <= mean43 + (i43 >>> 7);
        mean44 <= mean44 + (i44 >>> 7);
    end else begin
        mean11 <= 0;
        mean12 <= 0;
        mean13 <= 0;
        mean14 <= 0;
        mean21 <= 0;
        mean22 <= 0;
        mean23 <= 0;
        mean24 <= 0;
        mean31 <= 0;
        mean32 <= 0;
        mean33 <= 0;
        mean34 <= 0;
        mean41 <= 0;
        mean42 <= 0;
        mean43 <= 0;
        mean44 <= 0;
    end
end
    
endmodule
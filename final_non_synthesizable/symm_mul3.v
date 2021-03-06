module SYMM_MUL3 (
    input clk_mul3,
    input en_mul3,

    input signed [25:0] i11, i12, i13, i14,
    input signed [25:0] i21, i22, i23, i24,
    input signed [25:0] i31, i32, i33, i34,
    input signed [25:0] i41, i42, i43, i44,

    output reg signed [25:0] o11, o12, o13, o14,
    output reg signed [25:0] o21, o22, o23, o24,
    output reg signed [25:0] o31, o32, o33, o34,
    output reg signed [25:0] o41, o42, o43, o44
);

reg signed [51:0] wwT11, wwT12, wwT13, wwT14;
reg signed [51:0] wwT21, wwT22, wwT23, wwT24;
reg signed [51:0] wwT31, wwT32, wwT33, wwT34;
reg signed [51:0] wwT41, wwT42, wwT43, wwT44;

reg signed [51:0] wwTw11, wwTw12, wwTw13, wwTw14;
reg signed [51:0] wwTw21, wwTw22, wwTw23, wwTw24;
reg signed [51:0] wwTw31, wwTw32, wwTw33, wwTw34;
reg signed [51:0] wwTw41, wwTw42, wwTw43, wwTw44;

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
        o11 <= wwTw11 >>> 1; o12 <= wwTw12 >>> 1; o13 <= wwTw13 >>> 1; o14 <= wwTw14 >>> 1;
        o21 <= wwTw21 >>> 1; o22 <= wwTw22 >>> 1; o23 <= wwTw23 >>> 1; o24 <= wwTw24 >>> 1;
        o31 <= wwTw31 >>> 1; o32 <= wwTw32 >>> 1; o33 <= wwTw33 >>> 1; o34 <= wwTw34 >>> 1;
        o41 <= wwTw41 >>> 1; o42 <= wwTw42 >>> 1; o43 <= wwTw43 >>> 1; o44 <= wwTw44 >>> 1;
    end else begin
        // o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        // o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        // o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        // o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
    end
end
    
endmodule
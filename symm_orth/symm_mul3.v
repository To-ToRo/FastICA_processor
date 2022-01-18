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

reg [25:0] wwT11, wwT12, wwT13, wwT14;
reg [25:0] wwT21, wwT22, wwT23, wwT24;
reg [25:0] wwT31, wwT32, wwT33, wwT34;
reg [25:0] wwT41, wwT42, wwT43, wwT44;

reg [25:0] wwTw11, wwTw12, wwTw13, wwTw14;
reg [25:0] wwTw21, wwTw22, wwTw23, wwTw24;
reg [25:0] wwTw31, wwTw32, wwTw33, wwTw34;
reg [25:0] wwTw41, wwTw42, wwTw43, wwTw44;

always @(*) begin
    wwT11 = i11 * i11 + i12 * i12 + i13 * i13 + i14 * i14;
    wwT12 = i11 * i21 + i12 * i22 + i13 * i23 + i14 * i24;
    wwT13 = i11 * i31 + i12 * i32 + i13 * i33 + i14 * i34;
    wwT14 = i11 * i41 + i12 * i42 + i13 * i43 + i14 * i44;
    wwT21 = i21 * i11 + i22 * i12 + i23 * i13 + i24 * i14;
    wwT22 = i21 * i21 + i22 * i22 + i23 * i23 + i24 * i24;
    wwT23 = i21 * i31 + i22 * i32 + i23 * i33 + i24 * i34;
    wwT24 = i21 * i41 + i22 * i42 + i23 * i43 + i24 * i44;
    wwT31 = i31 * i11 + i32 * i12 + i33 * i13 + i34 * i14;
    wwT32 = i31 * i21 + i32 * i22 + i33 * i23 + i34 * i24;
    wwT33 = i31 * i31 + i32 * i32 + i33 * i33 + i34 * i34;
    wwT34 = i31 * i41 + i32 * i42 + i33 * i43 + i34 * i44;
    wwT41 = i41 * i11 + i42 * i12 + i43 * i13 + i44 * i14;
    wwT42 = i41 * i21 + i42 * i22 + i43 * i23 + i44 * i24;
    wwT43 = i41 * i31 + i42 * i32 + i43 * i33 + i44 * i34;
    wwT44 = i41 * i41 + i42 * i42 + i43 * i43 + i44 * i44;

    wwTw11 = wwT11 * i11 + wwT12 * i21 + wwT13 * i31 + wwT14 * i41;
    wwTw12 = wwT11 * i12 + wwT12 * i22 + wwT13 * i32 + wwT14 * i42;
    wwTw13 = wwT11 * i13 + wwT12 * i23 + wwT13 * i33 + wwT14 * i43;
    wwTw14 = wwT11 * i14 + wwT12 * i24 + wwT13 * i34 + wwT14 * i44;
    wwTw21 = wwT21 * i11 + wwT22 * i21 + wwT23 * i31 + wwT24 * i41;
    wwTw22 = wwT21 * i12 + wwT22 * i22 + wwT23 * i32 + wwT24 * i42;
    wwTw23 = wwT21 * i13 + wwT22 * i23 + wwT23 * i33 + wwT24 * i43;
    wwTw24 = wwT21 * i14 + wwT22 * i24 + wwT23 * i34 + wwT24 * i44;
    wwTw31 = wwT31 * i11 + wwT32 * i21 + wwT33 * i31 + wwT34 * i41;
    wwTw32 = wwT31 * i12 + wwT32 * i22 + wwT33 * i32 + wwT34 * i42;
    wwTw33 = wwT31 * i13 + wwT32 * i23 + wwT33 * i33 + wwT34 * i43;
    wwTw34 = wwT31 * i14 + wwT32 * i24 + wwT33 * i34 + wwT34 * i44;
    wwTw41 = wwT41 * i11 + wwT42 * i21 + wwT43 * i31 + wwT44 * i41;
    wwTw42 = wwT41 * i12 + wwT42 * i22 + wwT43 * i32 + wwT44 * i42;
    wwTw43 = wwT41 * i13 + wwT42 * i23 + wwT43 * i33 + wwT44 * i43;
    wwTw44 = wwT41 * i14 + wwT42 * i24 + wwT43 * i34 + wwT44 * i44;
end

always @(posedge clk_mul3) begin
    if (en_mul3) begin
        o11 <= wwTw11 >>> 1; o12 <= wwTw12 >>> 1; o13 <= wwTw13 >>> 1; o14 <= wwTw14 >>> 1;
        o21 <= wwTw21 >>> 1; o22 <= wwTw22 >>> 1; o23 <= wwTw23 >>> 1; o24 <= wwTw24 >>> 1;
        o31 <= wwTw31 >>> 1; o32 <= wwTw32 >>> 1; o33 <= wwTw33 >>> 1; o34 <= wwTw34 >>> 1;
        o41 <= wwTw41 >>> 1; o42 <= wwTw42 >>> 1; o43 <= wwTw43 >>> 1; o44 <= wwTw44 >>> 1;
    end else begin
        o11 <= i11; o12 <= i12; o13 <= i13; o14 <= i14;
        o21 <= i21; o22 <= i22; o23 <= i23; o24 <= i24;
        o31 <= i31; o32 <= i32; o33 <= i33; o34 <= i34;
        o41 <= i41; o42 <= i42; o43 <= i43; o44 <= i44;
    end
end
    
endmodule
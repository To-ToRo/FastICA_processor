/*
 * MUL 1
 * zw1(4x4) = z(4x1)*w1(1x4) zw2, zw3, zw4
 */
module MUL1 (
    input clk_mul,
    input en_mul,
    
    input signed [25:0] z1, z2, z3, z4,

    input signed [25:0] w11, w12, w13, w14,
    input signed [25:0] w21, w22, w23, w24,
    input signed [25:0] w31, w32, w33, w34,
    input signed [25:0] w41, w42, w43, w44,

    output reg signed [25:0] zw1_11, zw1_12, zw1_13, zw1_14,
    output reg signed [25:0] zw1_21, zw1_22, zw1_23, zw1_24,
    output reg signed [25:0] zw1_31, zw1_32, zw1_33, zw1_34,
    output reg signed [25:0] zw1_41, zw1_42, zw1_43, zw1_44,

    output reg signed [25:0] zw2_11, zw2_12, zw2_13, zw2_14,
    output reg signed [25:0] zw2_21, zw2_22, zw2_23, zw2_24,
    output reg signed [25:0] zw2_31, zw2_32, zw2_33, zw2_34,
    output reg signed [25:0] zw2_41, zw2_42, zw2_43, zw2_44,

    output reg signed [25:0] zw3_11, zw3_12, zw3_13, zw3_14,
    output reg signed [25:0] zw3_21, zw3_22, zw3_23, zw3_24,
    output reg signed [25:0] zw3_31, zw3_32, zw3_33, zw3_34,
    output reg signed [25:0] zw3_41, zw3_42, zw3_43, zw3_44,
           reg               
    output reg signed [25:0] zw4_11, zw4_12, zw4_13, zw4_14,
    output reg signed [25:0] zw4_21, zw4_22, zw4_23, zw4_24,
    output reg signed [25:0] zw4_31, zw4_32, zw4_33, zw4_34,
    output reg signed [25:0] zw4_41, zw4_42, zw4_43, zw4_44
);

always @(posedge clk_mul)
begin
    if (en_mul) begin
        // active
        zw1_11 <= (z1 * w11) >>> 13;
        zw1_12 <= (z1 * w12) >>> 13;
        zw1_13 <= (z1 * w13) >>> 13;
        zw1_14 <= (z1 * w14) >>> 13;
        zw1_21 <= (z2 * w11) >>> 13;
        zw1_22 <= (z2 * w12) >>> 13;
        zw1_23 <= (z2 * w13) >>> 13;
        zw1_24 <= (z2 * w14) >>> 13;
        zw1_31 <= (z3 * w11) >>> 13;
        zw1_32 <= (z3 * w12) >>> 13;
        zw1_33 <= (z3 * w13) >>> 13;
        zw1_34 <= (z3 * w14) >>> 13;
        zw1_41 <= (z4 * w11) >>> 13;
        zw1_42 <= (z4 * w12) >>> 13;
        zw1_43 <= (z4 * w13) >>> 13;
        zw1_44 <= (z4 * w14) >>> 13;

        zw2_11 <= (z1 * w21) >>> 13;
        zw2_12 <= (z1 * w22) >>> 13;
        zw2_13 <= (z1 * w23) >>> 13;
        zw2_14 <= (z1 * w24) >>> 13;
        zw2_21 <= (z2 * w21) >>> 13;
        zw2_22 <= (z2 * w22) >>> 13;
        zw2_23 <= (z2 * w23) >>> 13;
        zw2_24 <= (z2 * w24) >>> 13;
        zw2_31 <= (z3 * w21) >>> 13;
        zw2_32 <= (z3 * w22) >>> 13;
        zw2_33 <= (z3 * w23) >>> 13;
        zw2_34 <= (z3 * w24) >>> 13;
        zw2_41 <= (z4 * w21) >>> 13;
        zw2_42 <= (z4 * w22) >>> 13;
        zw2_43 <= (z4 * w23) >>> 13;
        zw2_44 <= (z4 * w24) >>> 13;

        zw3_11 <= (z1 * w31) >>> 13;
        zw3_12 <= (z1 * w32) >>> 13;
        zw3_13 <= (z1 * w33) >>> 13;
        zw3_14 <= (z1 * w34) >>> 13;
        zw3_21 <= (z2 * w31) >>> 13;
        zw3_22 <= (z2 * w32) >>> 13;
        zw3_23 <= (z2 * w33) >>> 13;
        zw3_24 <= (z2 * w34) >>> 13;
        zw3_31 <= (z3 * w31) >>> 13;
        zw3_32 <= (z3 * w32) >>> 13;
        zw3_33 <= (z3 * w33) >>> 13;
        zw3_34 <= (z3 * w34) >>> 13;
        zw3_41 <= (z4 * w31) >>> 13;
        zw3_42 <= (z4 * w32) >>> 13;
        zw3_43 <= (z4 * w33) >>> 13;
        zw3_44 <= (z4 * w34) >>> 13;

        zw4_11 <= (z1 * w41) >>> 13;
        zw4_12 <= (z1 * w42) >>> 13;
        zw4_13 <= (z1 * w43) >>> 13;
        zw4_14 <= (z1 * w44) >>> 13;
        zw4_21 <= (z2 * w41) >>> 13;
        zw4_22 <= (z2 * w42) >>> 13;
        zw4_23 <= (z2 * w43) >>> 13;
        zw4_24 <= (z2 * w44) >>> 13;
        zw4_31 <= (z3 * w41) >>> 13;
        zw4_32 <= (z3 * w42) >>> 13;
        zw4_33 <= (z3 * w43) >>> 13;
        zw4_34 <= (z3 * w44) >>> 13;
        zw4_41 <= (z4 * w41) >>> 13;
        zw4_42 <= (z4 * w42) >>> 13;
        zw4_43 <= (z4 * w43) >>> 13;
        zw4_44 <= (z4 * w44) >>> 13;
    end else begin
        zw1_11 <= w11; zw1_12 <= w12; zw1_13 <= w13; zw1_14 <= w14;
        zw1_21 <= w21; zw1_22 <= w22; zw1_23 <= w23; zw1_24 <= w24;
        zw1_31 <= w31; zw1_32 <= w32; zw1_33 <= w33; zw1_34 <= w34;
        zw1_41 <= w41; zw1_42 <= w42; zw1_43 <= w43; zw1_44 <= w44;
        zw2_11 <= w11; zw2_12 <= w12; zw2_13 <= w13; zw2_14 <= w14;
        zw2_21 <= w21; zw2_22 <= w22; zw2_23 <= w23; zw2_24 <= w24;
        zw2_31 <= w31; zw2_32 <= w32; zw2_33 <= w33; zw2_34 <= w34;
        zw2_41 <= w41; zw2_42 <= w42; zw2_43 <= w43; zw2_44 <= w44;
        zw3_11 <= w11; zw3_12 <= w12; zw3_13 <= w13; zw3_14 <= w14;
        zw3_21 <= w21; zw3_22 <= w22; zw3_23 <= w23; zw3_24 <= w24;
        zw3_31 <= w31; zw3_32 <= w32; zw3_33 <= w33; zw3_34 <= w34;
        zw3_41 <= w41; zw3_42 <= w42; zw3_43 <= w43; zw3_44 <= w44;
        zw4_11 <= w11; zw4_12 <= w12; zw4_13 <= w13; zw4_14 <= w14;
        zw4_21 <= w21; zw4_22 <= w22; zw4_23 <= w23; zw4_24 <= w24;
        zw4_31 <= w31; zw4_32 <= w32; zw4_33 <= w33; zw4_34 <= w34;
        zw4_41 <= w41; zw4_42 <= w42; zw4_43 <= w43; zw4_44 <= w44;
    end
end
    
endmodule
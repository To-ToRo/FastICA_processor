module NORM_DIVIDER(
    input clk_norm,
    input en_norm,

    input signed [25:0] w_in11, w_in12, w_in13, w_in14,
    input signed [25:0] w_in21, w_in22, w_in23, w_in24,
    input signed [25:0] w_in31, w_in32, w_in33, w_in34,
    input signed [25:0] w_in41, w_in42, w_in43, w_in44,

    output reg signed [25:0] w_out11, w_out12, w_out13, w_out14,
    output reg signed [25:0] w_out21, w_out22, w_out23, w_out24,
    output reg signed [25:0] w_out31, w_out32, w_out33, w_out34,
    output reg signed [25:0] w_out41, w_out42, w_out43, w_out44
    );

wire signed [51:0] sum1, sum2, sum3, sum4;
wire signed [25:0] sqrt1, sqrt2, sqrt3, sqrt4;
wire signed [38:0] w11, w12, w13, w14,
                   w21, w22, w23, w24,
                   w31, w32, w33, w34,
                   w41, w42, w43, w44;


assign sum1 = (w_in11*w_in11 + w_in12*w_in12 + w_in13*w_in13 + w_in14*w_in14) >>> 13;
assign sum2 = (w_in21*w_in21 + w_in22*w_in22 + w_in23*w_in23 + w_in24*w_in24) >>> 13;
assign sum3 = (w_in31*w_in31 + w_in32*w_in32 + w_in33*w_in33 + w_in34*w_in34) >>> 13;
assign sum4 = (w_in41*w_in41 + w_in42*w_in42 + w_in43*w_in43 + w_in44*w_in44) >>> 13;

assign w11 = w_in11 <<< 13;
assign w12 = w_in12 <<< 13;
assign w13 = w_in13 <<< 13;
assign w14 = w_in14 <<< 13;
assign w21 = w_in21 <<< 13;
assign w22 = w_in22 <<< 13;
assign w23 = w_in23 <<< 13;
assign w24 = w_in24 <<< 13;
assign w31 = w_in31 <<< 13;
assign w32 = w_in32 <<< 13;
assign w33 = w_in33 <<< 13;
assign w34 = w_in34 <<< 13;
assign w41 = w_in41 <<< 13;
assign w42 = w_in42 <<< 13;
assign w43 = w_in43 <<< 13;
assign w44 = w_in44 <<< 13;

always @(posedge clk_norm) begin
    if (en_norm) begin 
        w_out11 <= w11 / sqrt1; w_out12 <= w12 / sqrt1; w_out13 <= w13 / sqrt1; w_out14 <= w14 / sqrt1;
        w_out21 <= w21 / sqrt2; w_out22 <= w22 / sqrt2; w_out23 <= w23 / sqrt2; w_out24 <= w24 / sqrt2;
        w_out31 <= w31 / sqrt3; w_out32 <= w32 / sqrt3; w_out33 <= w33 / sqrt3; w_out34 <= w34 / sqrt3;
        w_out41 <= w41 / sqrt4; w_out42 <= w42 / sqrt4; w_out43 <= w43 / sqrt4; w_out44 <= w44 / sqrt4;    
    end 
end

SQRT2 SQRT1 (
    .x(sum1),
    .y(sqrt1)
);

SQRT2 SQRT2 (
    .x(sum2),
    .y(sqrt2)
);

SQRT2 SQRT3 (
    .x(sum3),
    .y(sqrt3)
);

SQRT2 SQRT4 (
    .x(sum4),
    .y(sqrt4)
);

endmodule
module NORM_DIVIDER(
    input clk_norm,
    input en_norm,

    input signed [25:0] w_in11, w_in12, w_in13, w_in14,
    input signed [25:0] w_in21, w_in22, w_in23, w_in24,
    input signed [25:0] w_in31, w_in32, w_in33, w_in34,
    input signed [25:0] w_in41, w_in42, w_in43, w_in44,

    output signed [25:0] w_out11, w_out12, w_out13, w_out14,
    output signed [25:0] w_out21, w_out22, w_out23, w_out24,
    output signed [25:0] w_out31, w_out32, w_out33, w_out34,
    output signed [25:0] w_out41, w_out42, w_out43, w_out44
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

assign w11 = w_in11;
assign w12 = w_in12;
assign w13 = w_in13;
assign w14 = w_in14;
assign w21 = w_in21;
assign w22 = w_in22;
assign w23 = w_in23;
assign w24 = w_in24;
assign w31 = w_in31;
assign w32 = w_in32;
assign w33 = w_in33;
assign w34 = w_in34;
assign w41 = w_in41;
assign w42 = w_in42;
assign w43 = w_in43;
assign w44 = w_in44;

reg signed [38:0] w_out11_reg, w_out12_reg, w_out13_reg, w_out14_reg;
reg signed [38:0] w_out21_reg, w_out22_reg, w_out23_reg, w_out24_reg;
reg signed [38:0] w_out31_reg, w_out32_reg, w_out33_reg, w_out34_reg;
reg signed [38:0] w_out41_reg, w_out42_reg, w_out43_reg, w_out44_reg;

assign w_out11 = w_out11_reg[25:0];
assign w_out12 = w_out12_reg[25:0];
assign w_out13 = w_out13_reg[25:0];
assign w_out14 = w_out14_reg[25:0];
assign w_out21 = w_out21_reg[25:0];
assign w_out22 = w_out22_reg[25:0];
assign w_out23 = w_out23_reg[25:0];
assign w_out24 = w_out24_reg[25:0];
assign w_out31 = w_out31_reg[25:0];
assign w_out32 = w_out32_reg[25:0];
assign w_out33 = w_out33_reg[25:0];
assign w_out34 = w_out34_reg[25:0];
assign w_out41 = w_out41_reg[25:0];
assign w_out42 = w_out42_reg[25:0];
assign w_out43 = w_out43_reg[25:0];
assign w_out44 = w_out44_reg[25:0];

always @(posedge clk_norm) begin
    if (en_norm) begin 
        w_out11_reg <= (w11 <<< 13) / sqrt1; w_out12_reg <= (w12 <<< 13) / sqrt1; w_out13_reg <= (w13 <<< 13) / sqrt1; w_out14_reg <= (w14 <<< 13) / sqrt1;
        w_out21_reg <= (w21 <<< 13) / sqrt2; w_out22_reg <= (w22 <<< 13) / sqrt2; w_out23_reg <= (w23 <<< 13) / sqrt2; w_out24_reg <= (w24 <<< 13) / sqrt2;
        w_out31_reg <= (w31 <<< 13) / sqrt3; w_out32_reg <= (w32 <<< 13) / sqrt3; w_out33_reg <= (w33 <<< 13) / sqrt3; w_out34_reg <= (w34 <<< 13) / sqrt3;
        w_out41_reg <= (w41 <<< 13) / sqrt4; w_out42_reg <= (w42 <<< 13) / sqrt4; w_out43_reg <= (w43 <<< 13) / sqrt4; w_out44_reg <= (w44 <<< 13) / sqrt4;    
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
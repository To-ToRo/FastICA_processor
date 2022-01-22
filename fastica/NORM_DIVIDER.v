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

wire signed [29:0] w_sum;
wire signed [63:0] w11,w12,w13,w14,w21,w22,w23,w24,w31,w32,w33,w34,w41,w42,w43,w44; 

assign w11 = w_in11 <<< 38;
assign w12 = w_in12 <<< 38;
assign w13 = w_in13 <<< 38;
assign w14 = w_in14 <<< 38;
assign w21 = w_in21 <<< 38;
assign w22 = w_in22 <<< 38;
assign w23 = w_in23 <<< 38;
assign w24 = w_in24 <<< 38;
assign w31 = w_in31 <<< 38;
assign w32 = w_in32 <<< 38;
assign w33 = w_in33 <<< 38;
assign w34 = w_in34 <<< 38;
assign w41 = w_in41 <<< 38;
assign w42 = w_in42 <<< 38;
assign w43 = w_in43 <<< 38;
assign w44 = w_in44 <<< 38;
assign w_sum = w_in11 +  w_in12 +  w_in13 +  w_in14 
             + w_in21 +  w_in22 +  w_in23 +  w_in24 
             + w_in31 +  w_in32 +  w_in33 +  w_in34 
             + w_in41 +  w_in42 +  w_in43 +  w_in44; 

always @(posedge clk_norm) begin
    if (en_norm) begin 
        w_out11 <= (w11/w_sum) >>> 25; w_out12 <= (w12/w_sum) >>> 25; w_out13 <= (w13/w_sum) >>> 25; w_out14 <= (w14/w_sum) >>> 25;
        w_out21 <= (w21/w_sum) >>> 25; w_out22 <= (w22/w_sum) >>> 25; w_out23 <= (w23/w_sum) >>> 25; w_out24 <= (w24/w_sum) >>> 25;
        w_out31 <= (w31/w_sum) >>> 25; w_out32 <= (w32/w_sum) >>> 25; w_out33 <= (w33/w_sum) >>> 25; w_out34 <= (w34/w_sum) >>> 25;
        w_out41 <= (w41/w_sum) >>> 25; w_out42 <= (w42/w_sum) >>> 25; w_out43 <= (w43/w_sum) >>> 25; w_out44 <= (w44/w_sum) >>> 25;
    end else begin
        // w_out11 <= w_in11; w_out12 <= w_in12; w_out13 <= w_in13; w_out14 <= w_in14;
        // w_out21 <= w_in21; w_out22 <= w_in22; w_out23 <= w_in23; w_out24 <= w_in24;
        // w_out31 <= w_in31; w_out32 <= w_in32; w_out33 <= w_in33; w_out34 <= w_in34;
        // w_out41 <= w_in41; w_out42 <= w_in42; w_out43 <= w_in43; w_out44 <= w_in44;
    end
end

endmodule

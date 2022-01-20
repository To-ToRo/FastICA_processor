module FAST_CONTROLLER #(
    parameter [4:0] INIT = 5'd0, // Enable B_DECISION, MUL1, MUL2, MUL3, MUL4, MUL5, SUB. Fast_BUsy
    parameter [4:0] MEAN = 5'd1, // Enable mean_calc for 128 clocks. Fast_Busy
    parameter [4:0] SUB = 5'd2, 
    parameter [4:0] PAUSE = 5'd3 // Disable every modules.
) (
    input clk_fast,
    input go_fast,

    output fast_busy,

    output clk_b,
    output clk_sub,
    output clk_mul1,
    output clk_mul2,
    output clk_mul3,
    output clk_mul4,
    output clk_mul5,
    output clk_mean,

    output en_b,
    output en_sub,
    output en_mul1,
    output en_mul2,
    output en_mul3,
    output en_mul4,
    output en_mul5,
    output en_mean
);


reg en_b_reg;
reg en_sub_reg;
reg en_mul1_reg;
reg en_mul2_reg;
reg en_mul3_reg;
reg en_mul4_reg;
reg en_mul5_reg;
reg en_mean_reg;

assign en_b = en_b_reg;
assign en_sub = en_sub_reg;
assign en_mul1 = en_mul1_reg;
assign en_mul2 = en_mul2_reg;
assign en_mul3 = en_mul3_reg;
assign en_mul4 = en_mul4_reg;
assign en_mul5 = en_mul5_reg;
assign en_mean = en_mean_reg;

assign clk_b = clk_fast;
assign clk_sub = clk_fast;
assign clk_mul1 = clk_fast;
assign clk_mul2 = clk_fast;
assign clk_mul3 = clk_fast;
assign clk_mul4 = clk_fast;
assign clk_mul5 = clk_fast;
assign clk_mean = clk_fast;

reg fast_busy_reg;
assign fast_busy = fast_busy_reg;

reg [4:0] state, next_state;
reg [7:0] clk_cnt;

always @(posedge clk_fast or negedge go_fast) begin
    if (!go_fast) begin
        state <= INIT;
        clk_cnt <= 8'd0;
    end else begin
        if (state != next_state) begin
            clk_cnt <= 8'd0;
        end else begin
            clk_cnt <= clk_cnt + 8'd1;
        end
        state <= next_state;
    end
end

always @(*) begin
    next_state = 5'bx;
    case (state)
            INIT: begin
                en_b_reg = 1'b1;
                en_mul1_reg = 1'b1;
                en_mul2_reg = 1'b1;
                en_mul3_reg = 1'b1;
                en_mul4_reg = 1'b1;
                en_mul5_reg = 1'b1;
                en_mean_reg = 1'b0;
                en_sub_reg = 1'b0;
                fast_busy_reg = 1'b1;

                if (clk_cnt == 8'd3) begin
                    next_state = MEAN;
                end else begin
                    next_state = INIT;
                end
            end
            MEAN: begin
                en_b_reg = 1'b1;
                en_mul1_reg = 1'b1;
                en_mul2_reg = 1'b1;
                en_mul3_reg = 1'b1;
                en_mul4_reg = 1'b1;
                en_mul5_reg = 1'b1;
                en_mean_reg = 1'b1;
                en_sub_reg = 1'b0;
                fast_busy_reg = 1'b1;

                if (clk_cnt == 8'd127) begin
                    next_state = SUB;
                end else begin
                    next_state = MEAN;
                end
            end
            SUB: begin
                en_b_reg = 1'b0;
                en_mul1_reg = 1'b0;
                en_mul2_reg = 1'b0;
                en_mul3_reg = 1'b0;
                en_mul4_reg = 1'b0;
                en_mul5_reg = 1'b0;
                en_mean_reg = 1'b0;
                en_sub_reg = 1'b1;
                fast_busy_reg = 1'b1;

                next_state = PAUSE;
            end
            PAUSE: begin
                en_b_reg = 1'b0;
                en_sub_reg = 1'b0;
                en_mul1_reg = 1'b0;
                en_mul2_reg = 1'b0;
                en_mul3_reg = 1'b0;
                en_mul4_reg = 1'b0;
                en_mul5_reg = 1'b0;
                en_mean_reg = 1'b0;
                fast_busy_reg = 1'b0;

                next_state = PAUSE;
            end
            default: begin
                en_b_reg = 1'b0;
                en_sub_reg = 1'b0;
                en_mul1_reg = 1'b0;
                en_mul2_reg = 1'b0;
                en_mul3_reg = 1'b0;
                en_mul4_reg = 1'b0;
                en_mul5_reg = 1'b0;
                en_mean_reg = 1'b0;
                fast_busy_reg = 1'b0;

                next_state = PAUSE;
            end
        endcase
end

endmodule
module FAST_CONTROLLER (
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

reg [6:0] clk_cnt;

always @(posedge clk_fast or negedge go_fast) begin
    if (!go_fast) begin
        en_b_reg <= 1'b0;
        en_sub_reg <= 1'b0;
        en_mul1_reg <= 1'b0;
        en_mul2_reg <= 1'b0;
        en_mul3_reg <= 1'b0;
        en_mul4_reg <= 1'b0;
        en_mul5_reg <= 1'b0;
        en_mean_reg <= 1'b0;
        
        fast_busy_reg <= 1'b1;
        
        clk_cnt <= 0;
    end else begin
        if (!en_b_reg) begin
            en_b_reg <= 1'b1;
        end else if (!en_mul1_reg) begin
            en_mul1_reg <= 1'b1;
        end else if (!en_mul2_reg) begin
            en_mul2_reg <= 1'b1;
        end else if (!en_mul3_reg) begin
            en_mul3_reg <= 1'b1;
        end else if (!en_mul4_reg) begin
            en_mul4_reg <= 1'b1;
        end else if (!en_mean_reg) begin
            en_mean_reg <= 1'b1;
        end else if (!en_mul5_reg) begin
            if (clk_cnt == 127) begin
                en_mul5_reg <= 1'b1;
                clk_cnt <= 0;
            end else begin
                clk_cnt <= clk_cnt + 1'b1;
            end
        end else if (!en_sub_reg) begin
            en_sub_reg <= 1'b1;
        end else if (!fast_busy_reg) begin
            fast_busy_reg <= 1'b0;
        end
    end
end
    
endmodule
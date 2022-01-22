module ONE_UNIT_FAST_CONTROLLER #(
    parameter [4:0] INIT = 5'd0, // Enable B_DECISION
    parameter [4:0] MUL = 5'd2, // Enable mul
    parameter [4:0] MEAN = 5'd3, // Enable mean_calc for 128 clocks. Fast_Busy
    parameter [4:0] SUB = 5'd4, 
    parameter [4:0] PAUSE = 5'd5 // Disable every modules.
) (
    input clk_fast,
    input go_fast,

    output clk_b,
    output clk_sub,
    output clk_mul1,
    output clk_mul2,
    output clk_mul3,
    output clk_mul4,
    output clk_mul5,
    output clk_mean,

    output reg fast_busy,

    output reg en_b,
    output reg en_sub,
    output reg en_mul1,
    output reg en_mul2,
    output reg en_mul3,
    output reg en_mul4,
    output reg en_mul5,
    output reg en_mean
);

assign clk_b = clk_fast;
assign clk_sub = clk_fast;
assign clk_mul1 = clk_fast;
assign clk_mul2 = clk_fast;
assign clk_mul3 = clk_fast;
assign clk_mul4 = clk_fast;
assign clk_mul5 = clk_fast;
assign clk_mean = clk_fast;

reg [4:0] state;
reg [7:0] clk_cnt;

always @(*) begin
    en_b = 1'b1;
    case (state)
        INIT: begin
            fast_busy = 1'b0;
            // en_b = 1'b1;
            en_sub = 1'b0;
            en_mul1 = 1'b0;
            en_mul2 = 1'b0;
            en_mul3 = 1'b0;
            en_mul4 = 1'b0;
            en_mul5 = 1'b0;
            en_mean = 1'b0;
        end
        MUL: begin
            fast_busy = 1'b1;
            // en_b = 1'b1;
            en_sub = 1'b0;
            en_mul1 = 1'b1;
            en_mul2 = 1'b1;
            en_mul3 = 1'b1;
            en_mul4 = 1'b1;
            en_mul5 = 1'b1;
            en_mean = 1'b0;
        end
        MEAN: begin
            fast_busy = 1'b1;
            // en_b = 1'b1;
            en_sub = 1'b0;
            en_mul1 = 1'b1;
            en_mul2 = 1'b1;
            en_mul3 = 1'b1;
            en_mul4 = 1'b1;
            en_mul5 = 1'b1;
            en_mean = 1'b1;
        end
        SUB: begin
            fast_busy = 1'b0;
            // en_b = 1'b1;
            en_sub = 1'b1;
            en_mul1 = 1'b1;
            en_mul2 = 1'b1;
            en_mul3 = 1'b1;
            en_mul4 = 1'b1;
            en_mul5 = 1'b1;
            en_mean = 1'b1;
        end
        default: begin
            fast_busy = 1'b0;
            // en_b = 1'b1;
            en_sub = 1'b0;
            en_mul1 = 1'b0;
            en_mul2 = 1'b0;
            en_mul3 = 1'b0;
            en_mul4 = 1'b0;
            en_mul5 = 1'b0;
            en_mean = 1'b0;
        end
    endcase
end

always @(posedge clk_fast or negedge go_fast) begin
    if (~go_fast) begin
        state <= INIT;
    end else begin
        case (state)
            INIT: begin
                state <= MUL;
            end 
            MUL: begin
                if (clk_cnt == 8'd3) begin
                    state <= MEAN;
                end
            end
            MEAN: begin
                if (clk_cnt == 8'd130) begin
                    state <= SUB;
                end
            end
            SUB: begin
                state <= INIT;
            end
            
            default: begin
                state <= INIT;
            end
        endcase
    end
end

always @(posedge clk_fast or negedge go_fast) begin
    if (~go_fast) begin
        clk_cnt <= 8'd0;
    end else begin
        case (state)
            INIT, SUB: begin
                clk_cnt <= 8'd0;
            end
            MUL, MEAN: begin
                clk_cnt <= clk_cnt + 8'd1;
            end
            default: begin
                clk_cnt <= 8'd0;
            end
        endcase
    end
end

// always @(posedge clk_fast or negedge go_fast) begin
//     if (!go_fast) begin
//         state <= INIT;
//         clk_cnt <= 8'd0;
//     end else begin
//         if (state != next_state) begin
//             clk_cnt <= 8'd0;
//         end else begin
//             clk_cnt <= clk_cnt + 8'd1;
//         end
//         state <= next_state;
//     end
// end

// always @(*) begin
//     next_state = 5'bx;
//     case (state)
//             INIT: begin
//                 en_b_reg = 1'b1;
//                 en_mul1_reg = 1'b1;
//                 en_mul2_reg = 1'b1;
//                 en_mul3_reg = 1'b1;
//                 en_mul4_reg = 1'b1;
//                 en_mul5_reg = 1'b1;
//                 en_mean_reg = 1'b0;
//                 en_sub_reg = 1'b0;
//                 fast_busy_reg = 1'b1;

//                 if (clk_cnt == 8'd3) begin
//                     next_state = MEAN;
//                 end else begin
//                     next_state = INIT;
//                 end
//             end
//             MEAN: begin
//                 en_b_reg = 1'b1;
//                 en_mul1_reg = 1'b1;
//                 en_mul2_reg = 1'b1;
//                 en_mul3_reg = 1'b1;
//                 en_mul4_reg = 1'b1;
//                 en_mul5_reg = 1'b1;
//                 en_mean_reg = 1'b1;
//                 en_sub_reg = 1'b0;
//                 fast_busy_reg = 1'b1;

//                 if (clk_cnt == 8'd127) begin
//                     next_state = SUB;
//                 end else begin
//                     next_state = MEAN;
//                 end
//             end
//             SUB: begin
//                 en_b_reg = 1'b0;
//                 en_mul1_reg = 1'b0;
//                 en_mul2_reg = 1'b0;
//                 en_mul3_reg = 1'b0;
//                 en_mul4_reg = 1'b0;
//                 en_mul5_reg = 1'b0;
//                 en_mean_reg = 1'b0;
//                 en_sub_reg = 1'b1;
//                 fast_busy_reg = 1'b1;

//                 next_state = PAUSE;
//             end
//             PAUSE: begin
//                 en_b_reg = 1'b0;
//                 en_sub_reg = 1'b0;
//                 en_mul1_reg = 1'b0;
//                 en_mul2_reg = 1'b0;
//                 en_mul3_reg = 1'b0;
//                 en_mul4_reg = 1'b0;
//                 en_mul5_reg = 1'b0;
//                 en_mean_reg = 1'b0;
//                 fast_busy_reg = 1'b0;

//                 next_state = PAUSE;
//             end
//             default: begin
//                 en_b_reg = 1'b0;
//                 en_sub_reg = 1'b0;
//                 en_mul1_reg = 1'b0;
//                 en_mul2_reg = 1'b0;
//                 en_mul3_reg = 1'b0;
//                 en_mul4_reg = 1'b0;
//                 en_mul5_reg = 1'b0;
//                 en_mean_reg = 1'b0;
//                 fast_busy_reg = 1'b0;

//                 next_state = PAUSE;
//             end
//         endcase
// end

endmodule
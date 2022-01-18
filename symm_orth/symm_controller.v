module SYMM_CONTROLLER # (
    parameter GO_SYMM = 5'd0,
    parameter PAUSE = 5'd1
)(
    input clk_symm,
    input go_symm,
    
    output reg symm_busy,
    output clk_mul1, clk_norm, clk_sqrt, clk_mul2, clk_mul3, clk_sub,
    output reg en_mul1, en_norm, en_sqrt, en_mul2, en_mul3, en_sub
);

assign clk_mul1 = clk_symm;
assign clk_norm = clk_symm;
assign clk_sqrt = clk_symm;
assign clk_mul2 = clk_symm;
assign clk_mul3 = clk_symm;
assign clk_sub  = clk_symm;

// reg symm_busy_reg;
// reg en_mul1_reg, en_norm_reg, en_sqrt_reg, en_mul2_reg, en_mul3_reg, en_sub_reg;

// assign symm_busy = symm_busy_reg;
// assign en_mul1 = en_mul1_reg;
// assign en_norm = en_norm_reg;
// assign en_sqrt = en_sqrt_reg;
// assign en_mul2 = en_mul2_reg;
// assign en_mul3 = en_mul3_reg;
// assign en_sub = en_sub_reg;

reg [4:0] state, next_state;
reg [6:0] clk_cnt;

always @(posedge clk_symm or negedge go_symm) begin
    if (!go_symm) begin
        state <= GO_SYMM;
        clk_cnt <= 7'd0;
    end else begin
        state <= next_state;
        case (state)
            GO_SYMM: begin
                clk_cnt <= clk_cnt + 7'd1;
            end 
            default: begin
                clk_cnt <= 7'd0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        GO_SYMM: begin
            en_mul1   = 1'b1;
            en_norm   = 1'b1;
            en_sqrt   = 1'b1;
            en_mul2   = 1'b1;
            en_mul3   = 1'b1;
            en_sub    = 1'b1;
            symm_busy = 1'b1;

            if (clk_cnt == 7'd5) begin
                next_state = PAUSE;
            end else begin
                next_state = GO_SYMM;
            end
        end
        PAUSE: begin
            en_mul1   = 1'b0;
            en_norm   = 1'b0;
            en_sqrt   = 1'b0;
            en_mul2   = 1'b0;
            en_mul3   = 1'b0;
            en_sub    = 1'b0;
            symm_busy = 1'b0;

            next_state = PAUSE;
        end
        
        default: begin
            en_mul1   = 1'b0;
            en_norm   = 1'b0;
            en_sqrt   = 1'b0;
            en_mul2   = 1'b0;
            en_mul3   = 1'b0;
            en_sub    = 1'b0;
            symm_busy = 1'b0;

            next_state = PAUSE;
        end
    endcase
end
    
endmodule
module FASTICA_CONTROLLER #(
    parameter INIT = 5'd0,
    parameter MAKE_ORTH = 5'd1,
    parameter NORM_DIV = 5'd2,
    parameter FAST_ICA = 5'd3,
    parameter ERROR_CALC = 5'd4,
    parameter MUL1 = 5'd5,
    parameter MEM1 = 5'd6,
    parameter DELAY = 5'd7,
    parameter ERROR_DELAY = 5'd8
)(
    input clk_fastica,
    input go_fastica,
    input symm_busy,
    input fast_busy,
    input error_busy,

    input isConverge,

    output reg fastica_busy,

    output clk_symm,
    output clk_norm,
    output clk_fast,
    output clk_error,
    output clk_mul1,
    // output clk_mul2,
    output clk_mem1,

    output reg go_symm,
    output reg en_norm,
    output reg go_fast,
    output reg en_error,
    output reg en_mul1,
    // output reg en_mul2,
    output reg en_mem1,
    output reg [13:0] address_sel_mem1,
    output reg rw
);

assign clk_symm = clk_fastica;
assign clk_norm = clk_fastica;
assign clk_fast = clk_fastica;
assign clk_error = clk_fastica;
assign clk_mul1 = clk_fastica;
// assign clk_mul2 = clk_fastica;
assign clk_mem1 = clk_fastica;

reg [4:0] state;
reg [6:0] clk_cnt;

always @(*) begin
    address_sel_mem1 = 14'd0;
    rw = 1'b0;
    
    case (state)
        INIT: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b0;
        end
        DELAY: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b0;
        end
        MAKE_ORTH: begin
            go_symm  = 1'b1;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b1;
        end
        NORM_DIV: begin
            go_symm  = 1'b0;
            en_norm  = 1'b1;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b1;
        end
        FAST_ICA: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b1;
            en_error = 1'b0;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b1;
        end
        ERROR_DELAY: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b1;
            en_error = 1'b1;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b1;
        end
        ERROR_CALC: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b1;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b1;
        end
        MUL1: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b1;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b1;
        end
        // MUL2: begin
        //     go_symm  = 1'b0;
        //     en_norm  = 1'b0;
        //     go_fast  = 1'b0;
        //     en_error = 1'b0;
        //     en_mul1  = 1'b1;
        //     // en_mul2  = 1'b1;
        //     en_mem1  = 1'b0;
        //     fastica_busy = 1'b1;
        // end
        MEM1: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b1;
            // en_mul2  = 1'b1;
            en_mem1  = 1'b1;
            fastica_busy = 1'b1;
        end
        default: begin
            go_symm  = 1'b0;
            en_norm  = 1'b0;
            go_fast  = 1'b0;
            en_error = 1'b0;
            en_mul1  = 1'b0;
            // en_mul2  = 1'b0;
            en_mem1  = 1'b0;
            fastica_busy = 1'b0;
        end
    endcase
end

always @(posedge clk_fastica or negedge go_fastica) begin
    if (~go_fastica) begin
        state <= INIT;
    end else begin
        case (state)
            INIT: begin
                state <= DELAY;
            end
            DELAY: begin
                if (clk_cnt == 7'd0) begin
                    state <= MAKE_ORTH;
                end
            end
            MAKE_ORTH: begin
                if (~symm_busy && (clk_cnt == 7'd0)) begin
                    state <= NORM_DIV;
                end
            end
            NORM_DIV: begin
                state <= FAST_ICA;
            end
            FAST_ICA: begin
                if (~fast_busy && (clk_cnt == 7'd0)) begin
                    state <= ERROR_DELAY;
                end
            end
            ERROR_DELAY: begin
                state <= ERROR_CALC;
            end
            //? 몇 clk 필요한지
            ERROR_CALC: begin
                if (isConverge) begin
                    state <= MUL1;
                end else begin
                    if (~error_busy) begin
                        state <= MAKE_ORTH;
                    end
                end
            end
            MUL1: begin
                state <= MEM1;
            end
            // MUL2: begin
            //     state <= MEM1;
            // end
            MEM1: begin
                if (clk_cnt == 7'd127) begin
                    state <= INIT;
                end else begin
                    state <= MEM1;
                end
            end
            default: begin
                state <= INIT;
            end
        endcase
    end
end

always @(posedge clk_fastica or negedge go_fastica) begin
    if (~go_fastica) begin
        clk_cnt <= 7'd0;
    end else begin
        case (state)
            INIT, MAKE_ORTH, FAST_ICA, ERROR_CALC, MUL1: begin
                clk_cnt <= 7'd0;
            end 
            MEM1, DELAY, NORM_DIV: begin
                clk_cnt <= clk_cnt + 7'd1;
            end
            default: begin
                clk_cnt <= 7'd0;
            end
        endcase
    end
end
    
endmodule
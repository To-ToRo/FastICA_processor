module ERROR_CONTROLLER (
    input clk_error,
    input en_error,
    
    output reg error_busy,
    output clk_abs1, clk_abs2, clk_sub, clk_abs3, clk_out,
    output reg en_abs1, en_abs2, en_sub, en_abs3, en_out
);

assign clk_abs1 = clk_error;
assign clk_abs2 = clk_error;
assign clk_sub = clk_error;
assign clk_abs3 = clk_error;
assign clk_out = clk_error;

reg [2:0] state, next_state;

always @(posedge clk_error or negedge en_error)
    if(!en_error) state <= 0;
    else state <= next_state;
    
always @(*)
begin
    if (state == 3'd0) begin
        en_abs1 <= 0;
        en_abs2 <= 0;
        en_sub <= 0;
        en_abs3 <= 0;
        en_out  <= 0;
        error_busy <= 0;
        next_state <= 3'd1;
    end else if (state == 3'd1) begin
        en_abs1 <= 1;
        en_abs2 <= 1;
        en_sub <= 0;
        en_abs3 <= 0;
        en_out  <= 0;
        error_busy <= 1;
        next_state <= 3'd2;
    end else if (state == 3'd2) begin
        en_abs1 <= 0;
        en_abs2 <= 0;
        en_sub <= 1;
        en_abs3 <= 0;
        en_out  <= 0;
        error_busy <= 1;
        next_state <= 3'd3;
    end else if (state == 3'd3) begin
        en_abs1 <= 0;
        en_abs2 <= 0;
        en_sub <= 0;
        en_abs3 <= 1;
        en_out  <= 0;
        error_busy <= 1;
        next_state <= 3'd4;        
    end else if (state == 3'd4) begin
        en_abs1 <= 0;
        en_abs2 <= 0;
        en_sub <= 0;
        en_abs3 <= 0;
        en_out  <= 1;
        error_busy <= 1;
        next_state <= 3'd5;        
    end else begin
        en_abs1 <= 0;
        en_abs2 <= 0;
        en_sub <= 0;
        en_abs3 <= 0;
        en_out  <= 0;
        error_busy <= 0;
        next_state <= 3'd5;      
    end             
end    
endmodule
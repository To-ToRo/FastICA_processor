module SYMM_CONTROLLER (
    input clk_symm,
    input go_symm,
    input isOrth,
    
    output reg symm_busy,
    output clk_mul1, clk_norm, clk_sqrt, clk_sel, clk_mul2, clk_mul3, clk_sub, clk_mul4, clk_abs, clk_test,
    output reg en_mul1, en_norm, en_sqrt, en_sel, en_mul2, en_mul3, en_sub, en_mul4, en_abs, en_test,
    output reg select
);

assign clk_mul1 = clk_symm;
assign clk_norm = clk_symm;
assign clk_sqrt = clk_symm;
assign clk_sel  = clk_symm;
assign clk_mul2 = clk_symm;
assign clk_mul3 = clk_symm;
assign clk_sub  = clk_symm;
assign clk_mul4 = clk_symm;
assign clk_abs  = clk_symm;
assign clk_test = clk_symm;

reg [4:0] state, next_state;

always @(posedge clk_symm or negedge go_symm)
    if(!go_symm) state <= 0;
    else state <= next_state;
    
always @(*)
begin
    if (state == 5'd0) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 0;
        next_state = 5'd1;
    end else if (state == 5'd1) begin
        en_mul1    = 1;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd2;
    end else if (state == 5'd2) begin
        en_mul1    = 0;
        en_norm    = 1;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd3;
    end else if (state == 5'd3) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 1;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd4;        
    end else if (state == 5'd4) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 1;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd5;        
    end else if (state == 5'd5) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 1;
        en_mul3    = 1;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd6;   
    end else if (state == 5'd6) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 1;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd7;           
    end else if (state == 5'd7) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 1;
        en_abs     = 0;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd8;               
    end else if (state == 5'd8) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 1;
        en_test    = 0;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd9;     
    end else if (state == 5'd9) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 1;   
        select     = 0;  
        symm_busy  = 1;
        next_state = 5'd10;                                
    end else if (state == 5'd10) begin
        if (isOrth) begin
            en_mul1    = 0;
            en_norm    = 0;
            en_sqrt    = 0;
            en_sel     = 0;
            en_mul2    = 0;
            en_mul3    = 0;
            en_sub     = 0;
            en_mul4    = 0;
            en_abs     = 0;
            en_test    = 0;   
            select     = 0;  
            symm_busy  = 0;
            next_state = 5'd0;     
        end else begin
            en_mul1    = 0;
            en_norm    = 0;
            en_sqrt    = 0;
            en_sel     = 1;
            en_mul2    = 0;
            en_mul3    = 0;
            en_sub     = 0;
            en_mul4    = 0;
            en_abs     = 0;
            en_test    = 0;   
            select     = 1;  
            symm_busy  = 1;
            next_state = 5'd11;   
        end
    end else if (state == 5'd11) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 1;
        en_mul3    = 1;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 1;  
        symm_busy  = 1;
        next_state = 5'd12;             
    end else if (state == 5'd12) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 1;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 0;   
        select     = 1;  
        symm_busy  = 1;
        next_state = 5'd13;  
    end else if (state == 5'd13) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 1;
        en_abs     = 0;
        en_test    = 0;   
        select     = 1;  
        symm_busy  = 1;
        next_state = 5'd14;  
    end else if (state == 5'd14) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 1;
        en_test    = 0;   
        select     = 1;  
        symm_busy  = 1;
        next_state = 5'd15;  
    end else if (state == 5'd15) begin
        en_mul1    = 0;
        en_norm    = 0;
        en_sqrt    = 0;
        en_sel     = 0;
        en_mul2    = 0;
        en_mul3    = 0;
        en_sub     = 0;
        en_mul4    = 0;
        en_abs     = 0;
        en_test    = 1;   
        select     = 1;  
        symm_busy  = 1;
        next_state = 5'd16;  
    end else begin
        if (isOrth) begin
            en_mul1    = 0;
            en_norm    = 0;
            en_sqrt    = 0;
            en_sel     = 0;
            en_mul2    = 0;
            en_mul3    = 0;
            en_sub     = 0;
            en_mul4    = 0;
            en_abs     = 0;
            en_test    = 0;   
            select     = 0;  
            symm_busy  = 0;
            next_state = 5'd0;     
        end else begin
            en_mul1    = 0;
            en_norm    = 0;
            en_sqrt    = 0;
            en_sel     = 1;
            en_mul2    = 0;
            en_mul3    = 0;
            en_sub     = 0;
            en_mul4    = 0;
            en_abs     = 0;
            en_test    = 0;   
            select     = 1;  
            symm_busy  = 1;
            next_state = 5'd11;   
        end
    end
end    

endmodule
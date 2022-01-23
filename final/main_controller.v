module MAIN_CONTROLLER(
    input go,
    input clk,
    input whitening_busy, fastica_busy,

    output reg go_whitening, go_ram1, go_fastica,
    output clk_whitening, clk_mem1, clk_fastica,
    output reg new_one, 
    output reg rw,
    output reg [13:0] address_sel_mem1 
);

assign clk_whitening = clk;
assign clk_mem1 = clk;
assign clk_fastica = clk;

reg [4:0] state, next_state;
reg [7:0] cnt;
            
always @(posedge clk or negedge go) begin
    if(!go) begin
        cnt <= 0;
        state <= 5'd0;
    end else begin
        if(state == 5'd4) begin
            cnt <= cnt + 1;
        end
        state <= next_state;
    end
end

always @(*)
 begin
    if (state == 5'd0) begin
        go_whitening      <= 0;
        go_ram1           <= 0;
        go_fastica        <= 0;
        new_one           <= 0;
        rw                <= 0;
        address_sel_mem1  <= 0;        
        next_state        <= 5'd1;
    end else if (state == 5'd1) begin
        go_whitening      <= 1;
        go_ram1           <= 0;
        go_fastica        <= 0;
        new_one           <= 0;
        rw                <= 0;
        address_sel_mem1  <= 0;   
        next_state        <= 5'd2;   
    end else if (state == 5'd2) begin
        go_whitening      <= 1;
        go_ram1           <= 0;
        go_fastica        <= 0;
        new_one           <= 0;
        rw                <= 0;
        address_sel_mem1  <= 0;   
        next_state        <= 5'd3;           
    end else if (state == 5'd3) begin
        if(whitening_busy) begin
            go_whitening      <= 1;
            go_ram1           <= 0;
            go_fastica        <= 0;
            new_one           <= 0;
            rw                <= 0;
            address_sel_mem1  <= 0;      
        end else begin
            go_whitening      <= 1;
            go_ram1           <= 1;
            go_fastica        <= 0;
            new_one           <= 0;
            rw                <= 1;
            address_sel_mem1  <= 0;    
            next_state        <= 5'd4;
        end
    end else if (state == 5'd4) begin
        go_whitening      <= 1;
        go_ram1           <= 1;
        go_fastica        <= 1;
        new_one           <= 0;
        rw                <= 1;
        address_sel_mem1  <= 0;    
        if(cnt == 125) next_state = 5'd5;
    end else if (state == 5'd5) begin
        go_whitening      <= 0;
        go_ram1           <= 1;
        go_fastica        <= 1;
        new_one           <= 0;
        rw                <= 1;
        address_sel_mem1  <= 0;  
        next_state        = 5'd6;         
    end else if (state == 5'd6) begin
        if(fastica_busy) begin
            go_whitening      <= 0;
            go_ram1           <= 0;
            go_fastica        <= 1;
            new_one           <= 0;
            rw                <= 0;
            address_sel_mem1  <= 0;  
        end else begin
            go_whitening      <= 0;
            go_ram1           <= 0;
            go_fastica        <= 0;
            new_one           <= 0;
            rw                <= 0;
            address_sel_mem1  <= 0; 
        end          
    end
end    

endmodule
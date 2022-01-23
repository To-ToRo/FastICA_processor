`timescale 1ns / 1ps
module TB_FASTICA_PROCESSOR();

    reg go,clk;
    wire [25:0] Y1, Y2, Y3, Y4;

    FASTICA_PROCESSOR tb (
    .go(go),
    .clk(clk),
    
    .Y1(Y1),
    .Y2(Y2),
    .Y3(Y3),
    .Y4(Y4));
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        go = 0;
        
        #10 go = 1;
    end

endmodule

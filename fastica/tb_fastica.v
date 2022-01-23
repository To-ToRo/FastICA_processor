`timescale 100ps/1ps

module TB_FASTICA;

reg clk_fastica;
reg go_fastica;

reg signed [25:0] z1[0:127];
reg signed [25:0] z2[0:127];
reg signed [25:0] z3[0:127];
reg signed [25:0] z4[0:127];

reg signed [7:0] clk_cnt;

wire signed [25:0] y1, y2, y3, y4;

initial begin
    
end

FASTICA fastica (
    .clk_fastica(clk_fastica),
    .go_fastica(go_fastica),

    .z1(z1[clk_cnt]), .z2(z2[clk_cnt]), .z3(z3[clk_cnt]), .z4(z4[clk_cnt]),

    .y1(y1), .y2(y2), .y3(y3), .y4(y4)
);

   always #1 clk_fastica=~clk_fastica;

   initial begin
       clk_fastica = 1'b0;
       go_fastica = 1'b0;
       clk_cnt = 8'd0;
       $readmemh("C:/Coding/FastICA_processor/fastica/INPUT1_order.txt", z1);
        $readmemh("C:/Coding/FastICA_processor/fastica/INPUT2_order.txt", z2);
        $readmemh("C:/Coding/FastICA_processor/fastica/INPUT3_order.txt", z3);
        $readmemh("C:/Coding/FastICA_processor/fastica/INPUT4_order.txt", z4);
       #2 go_fastica = 1'b1;
   end

   always @(posedge clk_fastica) begin
       if(go_fastica == 1'b1) begin
           clk_cnt<=8'd0;
            if(clk_cnt == 127) begin
            end
            else begin
                clk_cnt <= clk_cnt + 8'd1;
            end
       end
       else clk_cnt<=8'd0;
   end
    
endmodule
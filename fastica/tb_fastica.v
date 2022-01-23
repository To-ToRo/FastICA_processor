`timescale 100ps/1ps

module TB_FASTICA;

reg clk_fastica;
reg go_fastica;

reg signed [25:0] z1[0:127];
reg signed [25:0] z2[0:127];
reg signed [25:0] z3[0:127];
reg signed [25:0] z4[0:127];

reg signed [25:0] Y1[0:127];
reg signed [25:0] Y2[0:127];
reg signed [25:0] Y3[0:127];
reg signed [25:0] Y4[0:127];

reg signed [7:0] clk_cnt, y_cnt;

wire fastica_busy;
wire signed [25:0] y1, y2, y3, y4;

FASTICA fastica (
    .clk_fastica(clk_fastica),
    .go_fastica(go_fastica),

    .z1(z1[clk_cnt]), .z2(z2[clk_cnt]), .z3(z3[clk_cnt]), .z4(z4[clk_cnt]),

    .fastica_busy(fastica_busy),
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

       #2782
        $writememh("C:/Coding/FastICA_processor/fastica/OUTPUT1_order.txt", Y1);
        $writememh("C:/Coding/FastICA_processor/fastica/OUTPUT2_order.txt", Y2);
        $writememh("C:/Coding/FastICA_processor/fastica/OUTPUT3_order.txt", Y3);
        $writememh("C:/Coding/FastICA_processor/fastica/OUTPUT4_order.txt", Y4);
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

   always @(posedge clk_fastica) begin
       if(go_fastica == 1'b1) begin
            if(y_cnt == 8'd128) begin
                y_cnt<=8'd0;
            end
            else begin
                if (y1 === 26'bx) begin
                    y_cnt<=8'd0;
                end else begin
                    Y1[y_cnt] <= y1;
                    Y2[y_cnt] <= y2;
                    Y3[y_cnt] <= y3;
                    Y4[y_cnt] <= y4;
                    y_cnt <= y_cnt + 8'd1;
                end
            end
       end
   end
    
endmodule
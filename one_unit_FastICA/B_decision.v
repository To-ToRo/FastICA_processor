module B_DECISION (
    input clk_b,
    input en_b,

    input signed [25:0] iw11, iw12, iw13, iw14,
    input signed [25:0] iw21, iw22, iw23, iw24,
    input signed [25:0] iw31, iw32, iw33, iw34,
    input signed [25:0] iw41, iw42, iw43, iw44,

    output signed [25:0] ow11, ow12, ow13, ow14,
    output signed [25:0] ow21, ow22, ow23, ow24,
    output signed [25:0] ow31, ow32, ow33, ow34,
    output signed [25:0] ow41, ow42, ow43, ow44
);

reg signed [25:0] ow11_reg, ow12_reg, ow13_reg, ow14_reg;
reg signed [25:0] ow21_reg, ow22_reg, ow23_reg, ow24_reg;
reg signed [25:0] ow31_reg, ow32_reg, ow33_reg, ow34_reg;
reg signed [25:0] ow41_reg, ow42_reg, ow43_reg, ow44_reg;

assign ow11 = ow11_reg;
assign ow12 = ow12_reg;
assign ow13 = ow13_reg;
assign ow14 = ow14_reg;
assign ow21 = ow21_reg;
assign ow22 = ow22_reg;
assign ow23 = ow23_reg;
assign ow24 = ow24_reg;
assign ow31 = ow31_reg;
assign ow32 = ow32_reg;
assign ow33 = ow33_reg;
assign ow34 = ow34_reg;
assign ow41 = ow41_reg;
assign ow42 = ow42_reg;
assign ow43 = ow43_reg;
assign ow44 = ow44_reg;

always @(posedge clk_b) begin
    if (en_b) begin
         if (iw11 === 26'bz) begin
            // ow11_reg <= 26'b1111111111111_1101100111001; //-0.1493
            // ow12_reg <= 26'b1111111111111_0110100010110; //-0.5911
            // ow13_reg <= 26'b0000000000000_0110000100100; //0.37934
            // ow14_reg <= 26'b1111111111111_1101001101001; //-0.1747
            // ow21_reg <= 26'b0000000000010_0111001011110; //2.449
            // ow22_reg <= 26'b1111111111111_0101100001101; //-0.6547
            // ow23_reg <= 26'b1111111111111_1010101101110; //-0.3303
            // ow24_reg <= 26'b1111111111111_0000101011101; //-0.9573
            // ow31_reg <= 26'b0000000000000_0111100100011; //0.473
            // ow32_reg <= 26'b1111111111110_1110101101011; //-1.0807
            // ow33_reg <= 26'b1111111111111_1000000000001; //-0.4999
            // ow34_reg <= 26'b0000000000001_0100101011100; //1.2925
            // ow41_reg <= 26'b0000000000000_0000111011110; //0.1169
            // ow42_reg <= 26'b1111111111111_1111001111001; //-0.0477
            // ow43_reg <= 26'b1111111111111_1111001111001;//-0.0359
            // ow44_reg <= 26'b0000000000000_0111000011100; //0.4409
            
            ow11_reg <= -26'd1223; //-0.1493
            ow12_reg <= -26'd4842; //-0.5911
            ow13_reg <= 26'd3108; //0.37934
            ow14_reg <= -26'd1431; //-0.1747
            ow21_reg <= 26'd20062; //2.449
            ow22_reg <= -26'd5363; //-0.6547
            ow23_reg <= -26'd2706; //-0.3303
            ow24_reg <= -26'd7846; //-0.9573
            ow31_reg <= 26'd3875; //0.473
            ow32_reg <= -26'd8853; //-1.0807
            ow33_reg <= -26'd4095; //-0.4999
            ow34_reg <= 26'd10588; //1.2925
            ow41_reg <= 26'd958; //0.1169
            ow42_reg <= -26'd391; //-0.0477
            ow43_reg <= -26'd294;//-0.0359
            ow44_reg <= 26'd3612; //0.4409
        end else begin
            ow11_reg <= iw11;
            ow12_reg <= iw12;
            ow13_reg <= iw13;
            ow14_reg <= iw14;
            ow21_reg <= iw21;
            ow22_reg <= iw22;
            ow23_reg <= iw23;
            ow24_reg <= iw24;
            ow31_reg <= iw41;
            ow32_reg <= iw42;
            ow33_reg <= iw43;
            ow34_reg <= iw44;
            ow41_reg <= iw41;
            ow42_reg <= iw42;
            ow43_reg <= iw43;
            ow44_reg <= iw44;
        end
    end
end
    
endmodule
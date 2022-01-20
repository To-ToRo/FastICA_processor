`timescale 1ps/1ps

module TB_B_DECISION;

reg clk_b;
reg en_b;
reg signed [25:0] iw11, iw12, iw13, iw14;
reg signed [25:0] iw21, iw22, iw23, iw24;
reg signed [25:0] iw31, iw32, iw33, iw34;
reg signed [25:0] iw41, iw42, iw43, iw44;
wire signed [25:0] ow11, ow12, ow13, ow14;
wire signed [25:0] ow21, ow22, ow23, ow24;
wire signed [25:0] ow31, ow32, ow33, ow34;
wire signed [25:0] ow41, ow42, ow43, ow44;

assign #10 clk_b = ~clk_b;
assign #400 en_b = ~en_b;

initial begin
    clk_b = 1'b0;
    en_b = 1'b0;
    iw11 = 26'b0; iw12 = 26'b0; iw13 = 26'b0; iw14 = 26'b0;
    iw21 = 26'b0; iw22 = 26'b0; iw23 = 26'b0; iw24 = 26'b0;
    iw31 = 26'b0; iw32 = 26'b0; iw33 = 26'b0; iw34 = 26'b0;
    iw41 = 26'b0; iw42 = 26'b0; iw43 = 26'b0; iw44 = 26'b0;
end

always @(posedge clk_b) begin
    iw11 = iw11 + 1; iw12 = iw12 + 1; iw13 = iw13 + 1; iw14 = iw14 + 1;
    iw21 = iw21 + 1; iw22 = iw22 + 1; iw23 = iw23 + 1; iw24 = iw24 + 1;
    iw31 = iw31 + 1; iw32 = iw32 + 1; iw33 = iw33 + 1; iw34 = iw34 + 1;
    iw41 = iw41 + 1; iw42 = iw42 + 1; iw43 = iw43 + 1; iw44 = iw44 + 1;
end

B_DECISION B_DECISION (
    .clk_b(clk_b),
    .en_b(en_b),
    .iw11(iw11), .iw12(iw12), .iw13(iw13), .iw14(iw14),
    .iw21(iw21), .iw22(iw22), .iw23(iw23), .iw24(iw24),
    .iw31(iw31), .iw32(iw32), .iw33(iw33), .iw34(iw34),
    .iw41(iw41), .iw42(iw42), .iw43(iw43), .iw44(iw44),
    .ow11(ow11), .ow12(ow12), .ow13(ow13), .ow14(ow14),
    .ow21(ow21), .ow22(ow22), .ow23(ow23), .ow24(ow24),
    .ow31(ow31), .ow32(ow32), .ow33(ow33), .ow34(ow34),
    .ow41(ow41), .ow42(ow42), .ow43(ow43), .ow44(ow44)
);
    
endmodule
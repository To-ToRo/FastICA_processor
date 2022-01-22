module ONE_UNIT_MUL5 (
    input clk_mul,
    input en_mul,

    input signed [25:0] iw11, iw12, iw13, iw14,
    input signed [25:0] iw21, iw22, iw23, iw24,
    input signed [25:0] iw31, iw32, iw33, iw34,
    input signed [25:0] iw41, iw42, iw43, iw44,

    output reg signed [25:0] ow11, ow12, ow13, ow14,
    output reg signed [25:0] ow21, ow22, ow23, ow24,
    output reg signed [25:0] ow31, ow32, ow33, ow34,
    output reg signed [25:0] ow41, ow42, ow43, ow44
);

always @(posedge clk_mul) begin
    if (en_mul) begin
        ow11 <= (iw11 <<< 1) + iw11;
        ow12 <= (iw12 <<< 1) + iw12;
        ow13 <= (iw13 <<< 1) + iw13;
        ow14 <= (iw14 <<< 1) + iw14;
        ow21 <= (iw21 <<< 1) + iw21;
        ow22 <= (iw22 <<< 1) + iw22;
        ow23 <= (iw23 <<< 1) + iw23;
        ow24 <= (iw24 <<< 1) + iw24;
        ow31 <= (iw31 <<< 1) + iw31;
        ow32 <= (iw32 <<< 1) + iw32;
        ow33 <= (iw33 <<< 1) + iw33;
        ow34 <= (iw34 <<< 1) + iw34;
        ow41 <= (iw41 <<< 1) + iw41;
        ow42 <= (iw42 <<< 1) + iw42;
        ow43 <= (iw43 <<< 1) + iw43;
        ow44 <= (iw44 <<< 1) + iw44;
    end else begin
        ow11 <= iw11;
        ow12 <= iw12;
        ow13 <= iw13;
        ow14 <= iw14;
        ow21 <= iw21;
        ow22 <= iw22;
        ow23 <= iw23;
        ow24 <= iw24;
        ow31 <= iw31;
        ow32 <= iw32;
        ow33 <= iw33;
        ow34 <= iw34;
        ow41 <= iw41;
        ow42 <= iw42;
        ow43 <= iw43;
        ow44 <= iw44;
    end
end
    
endmodule
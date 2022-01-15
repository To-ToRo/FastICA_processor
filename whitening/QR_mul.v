module mul(a,b,c);

input signed [63:0] a, b;
output signed [63:0] c;

wire signed [127:0] ab;
wire signed [63:0] c;

assign ab = a * b;
assign c = ab[95:32];

endmodule

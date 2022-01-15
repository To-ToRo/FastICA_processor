module divider(a,b,c);

input signed [63:0] a, b;
output signed [63:0] c;

wire signed [127:0] a1;
wire signed [127:0] c1;
wire signed [63:0] c;

assign a1 = a <<< 64;
assign c1 = a1 / b;
assign c = c1[95:32];

endmodule

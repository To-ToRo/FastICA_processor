module divider(a,b,c);

input signed [63:0] a, b;
output signed [63:0] c;

parameter k1 = 10, k2 = 30;

wire signed [k1 + k2 - 1:0] a1;
wire signed [63:0] a2;
wire signed [63:0] c1;
           
assign a1 = a[31+k1:32-k2];
assign a2 = a1 <<< (64 - k1 - k2);
assign c1 = a2 / b;
assign c = c1 <<< k1;

endmodule
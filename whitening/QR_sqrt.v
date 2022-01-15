module sqrt(x,y);

input [63:0] x;
output [63:0] y;

parameter k = 64;

wire [63 + k:0] x1;
wire [63 + k:0] y1;
wire [63:0] y;

assign x1 = x <<< k;
assign y1 = x1 ** 0.5;
assign y = y1[(k - 32)/2 + 63:(k - 32)/2];

endmodule
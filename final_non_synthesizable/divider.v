module divider(a,b,c); // make accurate & synthesizable divider 

input signed [63:0] a, b;
output wire signed [63:0] c;
/*
parameter k1 = 11, k2 = 11;

wire signed [k1 + 31:0] a1;
wire signed [63:0] a2;
           
assign a1 = a[k1 + 31:0];
assign a2 = a1 <<< (32 - k1);
assign c = a2 / (b >>> k2);
*/


// 32 - k1 + k2 >= 32   =>  "k2 >= k1" 

parameter k = 64;

wire signed [63 + k:0] a1;
wire signed [63 + k:0] c1;

assign a1 = a <<< k;
assign c1 = a1 / b;
assign c = c1[k + 31:k - 32];



// k1 >= 11
/*
parameter k = 32, k1 = 11;

wire signed [k1 + 31:0] a1;
wire signed [63 + k:0] a2;
wire signed [63 + k:0] c1;

assign a1 = a[k1 + 31:0];
assign a2 = a1 <<< k; 
assign c1 = a2 / b;
assign c = c1[k + 31:k - 32];
*/

endmodule
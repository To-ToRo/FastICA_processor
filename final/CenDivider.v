module CenDivider(
	input wire En,
	input wire clk,
	
	input wire signed [39:0] sum1,
	input wire signed [39:0] sum2,
	input wire signed [39:0] sum3,
	input wire signed [39:0] sum4,
	
	output reg signed [25:0] res1,
	output reg signed [25:0] res2,
	output reg signed [25:0] res3,
	output reg signed [25:0] res4
	
);

always @(posedge clk)
begin
	if(En) begin
		res1 <= sum1[32:7];	// division by 128
		res2 <= sum2[32:7];
		res3 <= sum3[32:7];
		res4 <= sum4[32:7];
		
	end
end
endmodule

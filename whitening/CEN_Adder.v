module Adder_unit(
	input wire En,
	input wire clk,
	
	input wire signed [15:0] x1_in,
	input wire signed [15:0] x2_in,
	input wire signed [15:0] x3_in,
	input wire signed [15:0] x4_in,
	
	output reg signed [20:0] sum1,
	output reg signed [20:0] sum2,
	output reg signed [20:0] sum3,
	output reg signed [20:0] sum4
);


always @(posedge clk)
begin
	if(!En) begin
		sum1<=0;
		sum2<=0;
		sum3<=0;
		sum4<=0;
	end
	else begin
		sum1 <=  sum1+x1_in;
		sum2 <=  sum2+x2_in;
		sum3 <=  sum3+x3_in;
		sum4 <=  sum4+x4_in;
	end
	
end
endmodule 

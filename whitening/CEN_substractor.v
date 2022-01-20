module Substractor_unit(
	input wire GO,
	input wire En,
	input wire clk,
	
	input wire unsigned [25:0] x1_in,
	input wire unsigned [25:0] x2_in,
	input wire unsigned [25:0] x3_in,
	input wire unsigned [25:0] x4_in,
	
	input wire unsigned [25:0] res1,
	input wire unsigned [25:0] res2,
	input wire unsigned [25:0] res3,
	input wire unsigned [25:0] res4,
	output reg signed [25:0] Xcen1,
	output reg signed [25:0] Xcen2,
	output reg signed [25:0] Xcen3,
	output reg signed [25:0] Xcen4
	
);

always @(posedge clk) 
begin
	if(En) begin
		Xcen1 <= x1_in-res1;
		Xcen2 <= x2_in-res2;
		Xcen3 <= x3_in-res3;
		Xcen4 <= x4_in-res4;	
	end
end
endmodule 

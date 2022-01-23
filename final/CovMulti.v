module  CovMulti(
	input wire En,
	input wire clk,
	
	input wire signed [25:0] Xcen1,
	input wire signed [25:0] Xcen2,
	input wire signed [25:0] Xcen3,
	input wire signed [25:0] Xcen4,

	output reg signed [51:0] X1X1,
	output reg signed [51:0] X1X2,
	output reg signed [51:0] X1X3,
	output reg signed [51:0] X1X4,
	//output reg signed [15:0] X2X1,
	output reg signed [51:0] X2X2,
	output reg signed [51:0] X2X3,
	output reg signed [51:0] X2X4,
	//output reg signed [15:0] X3X1,
	//output reg signed [15:0] X3X2,
	output reg signed [51:0] X3X3, 
    output reg signed [51:0] X3X4, 
	//output reg signed [15:0] X4X1,
   // output reg signed [15:0] X4X2, 
    //output reg signed [15:0] X4X3, 
    output reg signed [51:0] X4X4

); 
reg [7:0] cnt;

always @ (posedge clk) begin
	if(En) begin
		if(cnt==128) begin
			cnt<=0;
		end
		else begin 
			X1X1<= Xcen1 * Xcen1;
			X1X2<= Xcen1 * Xcen2;
			X1X3<= Xcen1 * Xcen3;
			X1X4<= Xcen1 * Xcen4;
			//X2X1<=Xcen2 * Xcen1
			X2X2<= Xcen2 * Xcen2;
			X2X3<= Xcen2 * Xcen3;
			X2X4<= Xcen2 * Xcen4;
			//X3X1<=Xcen3 * Xcen1;
			//X3X2<=Xcen3 * Xcen2
			X3X3<=Xcen3 * Xcen3;
			X3X4<=Xcen3 * Xcen4;
			//X4X1<=Xcen4 * Xcen1
			//X4X2<=Xcen4 * Xcen2
			//X4X3<=Xcen4 * Xcen3
			X4X4<=Xcen4 * Xcen4;
			cnt<=cnt+1;
		end
	end
	else begin
		cnt<=0;
	end
end
endmodule

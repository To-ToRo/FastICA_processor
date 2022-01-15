module Substractor_unit(
	input wire GO,
	input wire En,
	input wire clk,
	
	input wire signed [15:0] x1_in,
	input wire signed [15:0] x2_in,
	input wire signed [15:0] x3_in,
	input wire signed [15:0] x4_in,
	
	input wire signed [15:0] res1,
	input wire signed [15:0] res2,
	input wire signed [15:0] res3,
	input wire signed [15:0] res4,
	output reg signed [15:0] Xcen1,
	output reg signed [15:0] Xcen2,
	output reg signed [15:0] Xcen3,
	output reg signed [15:0] Xcen4
);

//일단 실행되기 위해 reg를 사용한다.

reg signed [15:0] s1[0:127];
reg signed [15:0] s2[0:127];
reg signed [15:0] s3[0:127];
reg signed [15:0] s4[0:127];
reg [6:0] cnt;
reg [6:0] cnt1;

always @(posedge clk) 
begin
	if(!GO) begin
		cnt<=0;
		cnt1<=0;
	end
	else begin
		if(En) begin
			if(cnt1 == 127) begin
				cnt1 <=0;
			end
			else begin
				Xcen1 <= s1[cnt1]-res1;
				Xcen2 <= s2[cnt1]-res2;
				Xcen3 <= s3[cnt1]-res3;
				Xcen4 <= s4[cnt1]-res4;
				cnt1<=cnt1+1;
			end
		end
		else begin
			if(cnt == 127) begin
				cnt <= 127;
			end
			else begin
				s1[cnt] <= x1_in;
				s2[cnt] <= x2_in;
				s3[cnt] <= x3_in;
				s4[cnt] <= x4_in;
				cnt <= cnt+1;
			end
		end
	end
end
endmodule 

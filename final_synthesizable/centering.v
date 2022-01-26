module Centering(
	input wire clk,
	input wire GO,
	input wire signed [25:0]x1_in,
	input wire signed [25:0]x2_in,
	input wire signed [25:0]x3_in,
	input wire signed [25:0]x4_in,
	output wire signed [25:0]x1_out,
	output wire signed [25:0]x2_out,
	output wire signed [25:0]x3_out,
	output wire signed [25:0]x4_out,
	output wire busy
);

wire  En_SUM;
wire  En_DIV;
wire  En_SUB;
wire  CLK_adder;
wire  CLK_Divider;
wire  CLK_Sub;

wire signed [39:0] sum1;
wire signed [39:0] sum2;
wire signed [39:0] sum3;
wire signed [39:0] sum4;
wire signed [25:0] res1;
wire signed [25:0] res2;
wire signed [25:0] res3;
wire signed [25:0] res4;

CenteringController CCU(
		.GO_cen(GO),
		.CLK_cen(clk),
		.CEN_Busy(busy),
		.En_SUM(En_SUM),
		.En_DIV(En_DIV),
		.En_SUB(En_SUB),
		.CLK_adder(CLK_adder),
		.CLK_Divider(CLK_Divider),
		.CLK_Sub( CLK_Sub)
		
);

CenAdder add(
	.En(En_SUM),
	.clk(CLK_adder),
	.x1_in(x1_in),
	.x2_in(x2_in),
	.x3_in(x3_in),
	.x4_in(x4_in),
	.sum1(sum1),
	.sum2(sum2),
	.sum3(sum3),
	.sum4(sum4)
);

CenDivider div(
		.En(En_DIV),
		.clk(CLK_Divider),
		.sum1(sum1),
		.sum2(sum2),
		.sum3(sum3),
		.sum4(sum4),
		.res1(res1),
		.res2(res2),
		.res3(res3),
		.res4(res4)
);

CenSubstractor sub(
		.GO(GO),
		.En(En_SUB),
		.clk(CLK_Sub),
		.x1_in(x1_in),
		.x2_in(x2_in),
		.x3_in(x3_in),
		.x4_in(x4_in),
		.res1(res1),
		.res2(res2),
		.res3(res3),
		.res4(res4),
		.Xcen1(x1_out),
		.Xcen2(x2_out),
		.Xcen3(x3_out),
		.Xcen4(x4_out)
);

endmodule



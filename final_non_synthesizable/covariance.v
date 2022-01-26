module Covariance(
	input wire GO_cov,
	input wire CLK_cov,
	input wire signed [25:0]Xcen1,	
	input wire signed [25:0]Xcen2,
	input wire signed [25:0]Xcen3,
	input wire signed [25:0]Xcen4,
	
	output wire signed [25:0] C11,
	output wire signed [25:0] C12,
	output wire signed [25:0] C13,
	output wire signed [25:0] C14,
	output wire signed [25:0] C21,
	output wire signed [25:0] C22,
	output wire signed [25:0] C23,
	output wire signed [25:0] C24,
	output wire signed [25:0] C31,
	output wire signed [25:0] C32,
	output wire signed [25:0] C33,
	output wire signed [25:0] C34,
	output wire signed [25:0] C41,
	output wire signed [25:0] C42,
	output wire signed [25:0] C43,
	output wire signed [25:0] C44,
	output wire Cov_busy
);

wire CLK_Multi;
wire CLK_add_div;
wire En_Multi;
wire En_add_div;
wire signed [51:0] X1X1;
wire signed [51:0] X1X2;
wire signed [51:0] X1X3;
wire signed [51:0] X1X4;
wire signed [51:0] X2X2;
wire signed [51:0] X2X3;
wire signed [51:0] X2X4;
wire signed [51:0] X3X3;
wire signed [51:0] X3X4; 
wire signed [51:0] X4X4;

CovController cov_controller(
	.GO(GO_cov),
	.CLK(CLK_cov),
	.COV_busy(Cov_busy),
	.CLK_Multi(CLK_Multi),
	.CLK_add_div(CLK_add_div),
	.En_Multi(En_Multi),
	.En_add_div(En_add_div)
);

CovMulti multi(
	.En(En_Multi),
	.clk(CLK_Multi),
	.Xcen1(Xcen1),
	.Xcen2(Xcen2),
	.Xcen3(Xcen3),
	.Xcen4(Xcen4),
	.X1X1(X1X1),
	.X1X2(X1X2),
	.X1X3(X1X3),
	.X1X4(X1X4),
	.X2X2(X2X2),
	.X2X3(X2X3),
	.X2X4(X2X4),
	.X3X3(X3X3), 
    .X3X4(X3X4), 
    .X4X4(X4X4)
);

CovAdderAndDivider add_div(
	.En(En_add_div),
	.clk(CLK_add_div),
	.X1X1(X1X1),
	.X1X2(X1X2),
	.X1X3(X1X3),
	.X1X4(X1X4),
	.X2X2(X2X2),
	.X2X3(X2X3),
	.X2X4(X2X4),
	.X3X3(X3X3), 
    .X3X4(X3X4), 
    .X4X4(X4X4),
	.C11(C11),
	.C12(C12),
	.C13(C13),
	.C14(C14),
	.C21(C21),
	.C22(C22),
	.C23(C23),
	.C24(C24),
	.C31(C31),
	.C32(C32),
	.C33(C33),
	.C34(C34),
	.C41(C41),
	.C42(C42),
	.C43(C43),
	.C44(C44)
);


endmodule


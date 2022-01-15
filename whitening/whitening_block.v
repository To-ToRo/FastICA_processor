module Whitening_block(
	input wire GO_whitening,
	input wire CLK_whitening,
	input wire New_one,

	output wire Whitening_busy,
	output wire signed [15:0] Z1,
	output wire signed [15:0] Z2,
	output wire signed [15:0] Z3,
	output wire signed [15:0] Z4,
	
	output wire signed [25:0] V11,
	output wire signed [25:0] V12,
	output wire signed [25:0] V13,
	output wire signed [25:0] V14,
	output wire signed [25:0] V21,
	output wire signed [25:0] V22,
	output wire signed [25:0] V23,
	output wire signed [25:0] V24,
	output wire signed [25:0] V31,
	output wire signed [25:0] V32,
	output wire signed [25:0] V33,
	output wire signed [25:0] V34,
	output wire signed [25:0] V41,
	output wire signed [25:0] V42,
	output wire signed [25:0] V43,
	output wire signed [25:0] V44,
	
	output wire signed [15:0] C11,
	output wire signed [15:0] C12,
	output wire signed [15:0] C13,
	output wire signed [15:0] C14,
	output wire signed [15:0] C21,
	output wire signed [15:0] C22,
	output wire signed [15:0] C23,
	output wire signed [15:0] C24,
	output wire signed [15:0] C31,
	output wire signed [15:0] C32,
	output wire signed [15:0] C33,
	output wire signed [15:0] C34,
	output wire signed [15:0] C41,
	output wire signed [15:0] C42,
	output wire signed [15:0] C43,
	output wire signed [15:0] C44
);

reg [13:0] addr;

wire signed [15:0]X1;
wire signed [15:0]X2;
wire signed [15:0]X3;
wire signed [15:0]X4;

wire signed [15:0]Xcen1;
wire signed [15:0]Xcen2;
wire signed [15:0]Xcen3;
wire signed [15:0]Xcen4;

wire cov_busy;
wire cen_busy;
wire qr_busy;

wire  En_mem1;
wire  GO_cen;
wire  En_mem2;
wire  En_mem3;
wire  GO_cov;
wire  GO_QR;
wire  En_multi_1;
wire  En_multi_2;

wire CLK_mem1;
wire CLK_cen;
wire CLK_mem2;
wire CLK_cov;
wire CLK_QR;
wire CLK_multi_1;
wire CLK_multi_2;
wire CLK_mem3;

WhiteningControllerUnit WCU(
	.GO_whitening(GO_whitening),
	.CLK_Whitening(CLK_whitening),
	.New_one(New_one),	
	
	
	.COV_busy(cov_busy),
	.QR_busy(qr_busy),
	.CEN_busy(cen_busy),
	.Whitening_busy(Whitening_busy),
	
	.En_mem1(En_mem1),
	.GO_cen(GO_cen),
	.En_mem2(En_mem2),
	.En_mem3(En_mem3),
	.GO_cov(GO_cov),
	.GO_QR(GO_QR),
	.En_multi_1(En_multi_1),
	.En_multi_2(En_multi_2),
	
	.CLK_mem1(CLK_mem1),
	.CLK_cen(CLK_cen),
	.CLK_mem2(CLK_mem2),
	.CLK_cov(CLK_cov),
	.CLK_QR(CLK_QR),
	.CLK_multi_1(CLK_multi_1),
	.CLK_multi_2(CLK_multi_2),
	.CLK_mem3(CLK_mem3)
);

ROM rom(
.clk(CLK_mem1),
.En(En_mem1),
.addr(addr),
.data1(X1),
.data2(X2),
.data3(X3),
.data4(X4)
);

centering_block center(
.clk(CLK_cen),
.GO(GO_cen),
.x1_in(X1),
.x2_in(X2),
.x3_in(X3),
.x4_in(X4),
.x1_out(Xcen1),
.x2_out(Xcen2),
.x3_out(Xcen3),
.x4_out(Xcen4),
.busy(cen_busy)
);

/*
RAM1 ram1(
	.clk(CLK_mem2),
	.En(En_mem2),
	.busy(mem2_busy)
);
*/

Covariance_block cov(
	.GO_cov(GO_cov),
	.CLK_cov(CLK_cov),
	.Xcen1(Xcen1),	
	.Xcen2(Xcen2),
	.Xcen3(Xcen3),
	.Xcen4(Xcen4),
	
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
	.C44(C44),
	.Cov_busy(Cov_busy)
);


QR_decomposition qr_decom(
.GO_QR(GO_QR),
.CLK_QR(CLK_QR),
.cov11(C11),
.cov12(C12),
.cov13(C13),
.cov14(C14),
.cov21(C21),
.cov22(C22),
.cov23(C23),
.cov24(C24),
.cov31(C31),
.cov32(C32),
.cov33(C33),
.cov34(C34),
.cov41(C41),
.cov42(C42),
.cov43(C43),
.cov44(C44),
.E11(E11),.E12(E12),.E13(E13),.E14(E14),
.E21(E21),.E22(E22),.E23(E23),.E24(E24),
.E31(E31),.E32(E32),.E33(E33),.E34(E34),
.E41(E41),.E42(E42),.E43(E43),.E44(E44),
.D11(D11),.D12(D12),.D13(D13),.D14(D14),
.D21(D21),.D22(D22),.D23(D23),.D24(D24),
.D31(D31),.D32(D32),.D33(D33),.D34(D34),
.D41(D41),.D42(D42),.D43(D43),.D44(D44),
.BUSY_QR(qr_busy)
);




/*

MULTI_2 multi_2(
.clk(CLK_multi_2),
.En(En_multi_2),

.busy(multi_2_busy)
);

RAM2 ram2(
.clk(CLK_mem3),
.En(En_mem3),

.busy(mem3_busy)
);
*/

endmodule


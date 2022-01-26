module WHITENING (
	input wire GO_whitening,
	input wire CLK_whitening,
	input wire New_one,

	output wire Whitening_busy,
	output wire signed [25:0] Z1,
	output wire signed [25:0] Z2,
	output wire signed [25:0] Z3,
	output wire signed [25:0] Z4,
	
	output wire signed [25:0] V11, V12, V13, V14,
	output wire signed [25:0] V21, V22, V23, V24,
	output wire signed [25:0] V31, V32, V33, V34,
	output wire signed [25:0] V41, V42, V43, V44,
	
	output wire signed [25:0] C11, C12, C13, C14,
	output wire signed [25:0] C21, C22, C23, C24,
	output wire signed [25:0] C31, C32, C33, C34,
	output wire signed [25:0] C41, C42, C43, C44
);

reg [13:0] addr;

wire signed [25:0]X1;
wire signed [25:0]X2;
wire signed [25:0]X3;
wire signed [25:0]X4;

wire signed [25:0]Xcen1;
wire signed [25:0]Xcen2;
wire signed [25:0]Xcen3;
wire signed [25:0]Xcen4;
wire signed [25:0]q1;
wire signed [25:0]q2;
wire signed [25:0]q3;
wire signed [25:0]q4;

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
wire  En_eig;

wire R_w1, R_w2;

wire CLK_mem1;
wire CLK_cen;
wire CLK_mem2;
wire CLK_cov;
wire CLK_QR;
wire CLK_multi_1;
wire CLK_multi_2;
wire CLK_mem3;
wire CLK_eig;

wire [63:0] E11,E12,E13,E14,E21,E22,E23,E24,E31,E32,E33,E34,E41,E42,E43,E44;
wire [63:0] D11,D12,D13,D14,D21,D22,D23,D24,D31,D32,D33,D34,D41,D42,D43,D44;

wire signed [63:0] D_inv_sqrt11,D_inv_sqrt12,D_inv_sqrt13,D_inv_sqrt14;
wire signed [63:0] D_inv_sqrt21,D_inv_sqrt22,D_inv_sqrt23,D_inv_sqrt24;
wire signed [63:0] D_inv_sqrt31,D_inv_sqrt32,D_inv_sqrt33,D_inv_sqrt34;
wire signed [63:0] D_inv_sqrt41,D_inv_sqrt42,D_inv_sqrt43,D_inv_sqrt44;

wire signed [63:0] E_T11,E_T12,E_T13,E_T14;
wire signed [63:0] E_T21,E_T22,E_T23,E_T24;
wire signed [63:0] E_T31,E_T32,E_T33,E_T34;
wire signed [63:0] E_T41,E_T42,E_T43,E_T44;

wire signed [25:0] Z1_in, Z2_in, Z3_in, Z4_in;

WhiteningController WCU(
	.GO_whitening(GO_whitening),
	.CLK_Whitening(CLK_whitening),
	.New_one(New_one),	
	
	
	.COV_busy(cov_busy),
	.QR_busy(qr_busy),
	// .CEN_busy(cen_busy),
	.Whitening_busy(Whitening_busy),
	
	.En_mem1(En_mem1),
	.GO_cen(GO_cen),
	.En_mem2(En_mem2),
	.En_mem3(En_mem3),
	.GO_cov(GO_cov),
	.GO_QR(GO_QR),
	.En_multi_1(En_multi_1),
	.En_multi_2(En_multi_2),
	.En_eig(En_eig),
	
	.R_w1(R_w1),
	.R_w2(R_w2),

	.CLK_mem1(CLK_mem1),
	.CLK_cen(CLK_cen),
	.CLK_mem2(CLK_mem2),
	.CLK_cov(CLK_cov),
	.CLK_QR(CLK_QR),
	.CLK_eig(CLK_eig),
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

Centering center(
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


RAM1 ram1(
	.clk (CLK_mem2),
    .En  (En_mem2),
    .R_w1(R_w1),
    .addr(addr),
    .data1(Xcen1),
    .data2(Xcen2),
    .data3(Xcen3),
    .data4(Xcen4),
    .q1(q1), 
    .q2(q2),
    .q3(q3),
    .q4(q4)
);


Covariance cov(
	.GO_cov(GO_cov),
	.CLK_cov(CLK_cov),
	.Xcen1(q1),	
	.Xcen2(q2),
	.Xcen3(q3),
	.Xcen4(q4),
	
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
	.Cov_busy(cov_busy)
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

Eigen_Conditioning_Block eigen_condition(
.En_eig(En_eig),
.CLK_eig(CLK_eig),
.E11(E11),.E12(E12),.E13(E13),.E14(E14),
.E21(E21),.E22(E22),.E23(E23),.E24(E24),
.E31(E31),.E32(E32),.E33(E33),.E34(E34),
.E41(E41),.E42(E42),.E43(E43),.E44(E44),
.D11(D11),.D12(D12),.D13(D13),.D14(D14),
.D21(D21),.D22(D22),.D23(D23),.D24(D24),
.D31(D31),.D32(D32),.D33(D33),.D34(D34),
.D41(D41),.D42(D42),.D43(D43),.D44(D44),
.E_T11(E_T11), .E_T12(E_T12), .E_T13(E_T13), .E_T14(E_T14),
.E_T21(E_T21), .E_T22(E_T22), .E_T23(E_T23), .E_T24(E_T24),
.E_T31(E_T31), .E_T32(E_T32), .E_T33(E_T33), .E_T34(E_T34),
.E_T41(E_T41), .E_T42(E_T42), .E_T43(E_T43), .E_T44(E_T44),
.D_inv_sqrt11(D_inv_sqrt11), .D_inv_sqrt12(D_inv_sqrt12), .D_inv_sqrt13(D_inv_sqrt13), .D_inv_sqrt14(D_inv_sqrt14),
.D_inv_sqrt21(D_inv_sqrt21), .D_inv_sqrt22(D_inv_sqrt22), .D_inv_sqrt23(D_inv_sqrt23), .D_inv_sqrt24(D_inv_sqrt24),
.D_inv_sqrt31(D_inv_sqrt31), .D_inv_sqrt32(D_inv_sqrt32), .D_inv_sqrt33(D_inv_sqrt33), .D_inv_sqrt34(D_inv_sqrt34),
.D_inv_sqrt41(D_inv_sqrt41), .D_inv_sqrt42(D_inv_sqrt42), .D_inv_sqrt43(D_inv_sqrt43), .D_inv_sqrt44(D_inv_sqrt44)
);

Whitening_Multiplier1 multi_1(
.En_WM1(En_multi_1),
.CLK_WM1(CLK_multi_1),
.D_inv_sqrt11(D_inv_sqrt11), .D_inv_sqrt12(D_inv_sqrt12), .D_inv_sqrt13(D_inv_sqrt13), .D_inv_sqrt14(D_inv_sqrt14),
.D_inv_sqrt21(D_inv_sqrt21), .D_inv_sqrt22(D_inv_sqrt22), .D_inv_sqrt23(D_inv_sqrt23), .D_inv_sqrt24(D_inv_sqrt24),
.D_inv_sqrt31(D_inv_sqrt31), .D_inv_sqrt32(D_inv_sqrt32), .D_inv_sqrt33(D_inv_sqrt33), .D_inv_sqrt34(D_inv_sqrt34),
.D_inv_sqrt41(D_inv_sqrt41), .D_inv_sqrt42(D_inv_sqrt42), .D_inv_sqrt43(D_inv_sqrt43), .D_inv_sqrt44(D_inv_sqrt44),
.E_T11(E_T11), .E_T12(E_T12), .E_T13(E_T13), .E_T14(E_T14),
.E_T21(E_T21), .E_T22(E_T22), .E_T23(E_T23), .E_T24(E_T24),
.E_T31(E_T31), .E_T32(E_T32), .E_T33(E_T33), .E_T34(E_T34),
.E_T41(E_T41), .E_T42(E_T42), .E_T43(E_T43), .E_T44(E_T44),
.V11(V11), .V12(V12), .V13(V13), .V14(V14),
.V21(V21), .V22(V22), .V23(V23), .V24(V24),
.V31(V31), .V32(V32), .V33(V33), .V34(V34),
.V41(V41), .V42(V42), .V43(V43), .V44(V44)
);

Whitening_Multiplier2 multi_2(
.En(En_multi_2),
.clk(CLK_multi_2),
.V11(V11), .V12(V12), .V13(V13), .V14(V14), 
.V21(V21), .V22(V22), .V23(V23), .V24(V24), 
.V31(V31), .V32(V32), .V33(V33), .V34(V34), 
.V41(V41), .V42(V42), .V43(V43), .V44(V44), 
.X1(q1), .X2(q2), .X3(q3), .X4(q4),
.Z1(Z1_in), .Z2(Z2_in), .Z3(Z3_in), .Z4(Z4_in)
);


RAM2 ram2(
    .clk(CLK_mem3),
    .En(En_mem3),
    .R_w2(R_w2),
    .addr(addr),
    .data1(Z1_in),
    .data2(Z2_in),
    .data3(Z3_in),
    .data4(Z4_in),
    .q1(Z1), 
    .q2(Z2),
    .q3(Z3),
    .q4(Z4)
);

endmodule


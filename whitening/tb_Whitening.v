`timescale 100ps/100ps

module tb_Whitening;
	reg GO_whitening;
	reg CLK_whitening;
	reg New_one;

	wire Whitening_busy;
	wire signed [15:0] Z1;
	wire signed [15:0] Z2;
	wire signed [15:0] Z3;
	wire signed [15:0] Z4;
	
	wire signed [25:0] V11;
	wire signed [25:0] V12;
	wire signed [25:0] V13;
	wire signed [25:0] V14;
	wire signed [25:0] V21;
	wire signed [25:0] V22;
	wire signed [25:0] V23;
	wire signed [25:0] V24;
	wire signed [25:0] V31;
	wire signed [25:0] V32;
	wire signed [25:0] V33;
	wire signed [25:0] V34;
	wire signed [25:0] V41;
	wire signed [25:0] V42;
	wire signed [25:0] V43;
	wire signed [25:0] V44;
	
	wire signed [15:0] C11;
	wire signed [15:0] C12;
	wire signed [15:0] C13;
	wire signed [15:0] C14;
	wire signed [15:0] C21;
	wire signed [15:0] C22;
	wire signed [15:0] C23;
	wire signed [15:0] C24;
	wire signed [15:0] C31;
	wire signed [15:0] C32;
	wire signed [15:0] C33;
	wire signed [15:0] C34;
	wire signed [15:0] C41;
	wire signed [15:0] C42;
	wire signed [15:0] C43;
	wire signed [15:0] C44;

Whitening_block white_block(
	.GO_whitening(GO_whitening),
	.CLK_whitening(CLK_whitening),
	.New_one(New_one),

	.Whitening_busy(Whitening_busy),
	.Z1(Z1),
	.Z2(Z2),
	.Z3(Z3),
	.Z4(Z4),
	
	.V11(V11),
	.V12(V12),
	.V13(V13),
	.V14(V14),
	.V21(V21),
	.V22(V22),
	.V23(V23),
	.V24(V24),
	.V31(V31),
	.V32(V32),
	.V33(V33),
	.V34(V34),
	.V41(V41),
	.V42(V42),
	.V43(V43),
	.V44(V44),
	
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
always #1 CLK_whitening=~CLK_whitening;

initial  begin
	CLK_whitening = 0;
	GO_whitening = 1'b0;
	New_one = 0;

	#1
	GO_whitening = 1'b1;
	
end


endmodule
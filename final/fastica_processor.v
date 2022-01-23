module FASTICA_PROCESSOR(
    input go,
	input clk,

	output wire signed [25:0] Y1,
	output wire signed [25:0] Y2,
	output wire signed [25:0] Y3,
	output wire signed [25:0] Y4
    );

wire whitening_busy, fastica_busy;
wire go_whitening, go_ram1, go_fastica;
wire clk_whitening, clk_mem1, clk_fastica;
wire new_one;
wire rw;
wire [13:0] address_sel_mem1;

wire signed [25:0] Z1_1, Z2_1, Z3_1, Z4_1;
wire signed [25:0] Z1_2, Z2_2, Z3_2, Z4_2;
wire signed [25:0] V11, V12, V13, V14, V21, V22, V23, V24, V31, V32, V33, V34, V41, V42, V43, V44;
wire signed [15:0] C11, C12, C13, C14, C21, C22, C23, C24, C31, C32, C33, C34, C41, C42, C43, C44;

MAIN_CONTROLLER CONTROLLER (
	.go(go),
	.clk(clk),
	.whitening_busy(whitening_busy),
	.fastica_busy(fastica_busy),
	
	.go_whitening(go_whitening),
	.go_ram1(go_ram1),
	.go_fastica(go_fastica),
    
    .clk_whitening(clk_whitening),
    .clk_mem1(clk_mem1),
    .clk_fastica(clk_fastica),
    
    .new_one(new_one),
    .rw(rw),
    .address_sel_mem1(address_sel_mem1)
);

WHITENING WHITENING_BLOCK (
	.GO_whitening(go_whitening),
	.CLK_whitening(clk_whitening),
	.New_one(new_one),
    .Whitening_busy(whitening_busy),
    
	.Z1(Z1_1),
	.Z2(Z2_1),
	.Z3(Z3_1),
	.Z4(Z4_1),

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

RAM RAM_BLOCK (
    .clk(clk),
    .GO(go),
    .RW(rw),
    .addr(address_sel_mem1),
    
    .Z1_in(Z1_1),
    .Z2_in(Z2_1),
    .Z3_in(Z3_1),
    .Z4_in(Z4_1),
    
    .Z1_out(Z1_2),
    .Z2_out(Z2_2),
    .Z3_out(Z3_2),
    .Z4_out(Z4_2)
);

FASTICA FASTICA_BLOCK (
    .clk_fastica(clk_fastica),
    .go_fastica(go_fastica),
    
    .z1(Z1_2),
    .z2(Z2_2),
    .z3(Z3_2),
    .z4(Z4_2),
    
    .fastica_busy(fastica_busy),
    .y1(Y1),
    .y2(Y2),
    .y3(Y3),
    .y4(Y4)
);

endmodule
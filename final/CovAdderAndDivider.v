module CovAdderAndDivider(
	input En,
	input clk,

	input wire signed [51:0] X1X1,
	input wire signed [51:0] X1X2,
	input wire signed [51:0] X1X3,
	input wire signed [51:0] X1X4,
	//input wire signed [15:0] X2X1,
	input wire signed [51:0] X2X2,
	input wire signed [51:0] X2X3,
	input wire signed [51:0] X2X4,
	//input wire signed [15:0] X3X1,
	//input wire signed [15:0] X3X2,
	input wire signed [51:0] X3X3, 
    input wire signed [51:0] X3X4, 
	//input wire signed [15:0] X4X1,
   // input wire signed [15:0] X4X2, 
   // input wire signed [15:0] X4X3, 
    input wire signed [51:0] X4X4,
	
	output signed [25:0] C11,
	output signed [25:0] C12,
	output signed [25:0] C13,
	output signed [25:0] C14,
	output signed [25:0] C21,
	output signed [25:0] C22,
	output signed [25:0] C23,
	output signed [25:0] C24,
	output signed [25:0] C31,
	output signed [25:0] C32,
	output signed [25:0] C33,
	output signed [25:0] C34,
	output signed [25:0] C41,
	output signed [25:0] C42,
	output signed [25:0] C43,
	output signed [25:0] C44
);


reg signed [51:0] C11_52b;
reg signed [51:0] C12_52b;
reg signed [51:0] C13_52b;
reg signed [51:0] C14_52b;
reg signed [51:0] C21_52b;
reg signed [51:0] C22_52b;
reg signed [51:0] C23_52b;
reg signed [51:0] C24_52b;
reg signed [51:0] C31_52b;
reg signed [51:0] C32_52b;
reg signed [51:0] C33_52b;
reg signed [51:0] C34_52b;
reg signed [51:0] C41_52b;
reg signed [51:0] C42_52b;
reg signed [51:0] C43_52b;
reg signed [51:0] C44_52b;

reg signed [51:0] C11_reg;
reg signed [51:0] C12_reg;
reg signed [51:0] C13_reg;
reg signed [51:0] C14_reg;
reg signed [51:0] C21_reg;
reg signed [51:0] C22_reg;
reg signed [51:0] C23_reg;
reg signed [51:0] C24_reg;
reg signed [51:0] C31_reg;
reg signed [51:0] C32_reg;
reg signed [51:0] C33_reg;
reg signed [51:0] C34_reg;
reg signed [51:0] C41_reg;
reg signed [51:0] C42_reg;
reg signed [51:0] C43_reg;
reg signed [51:0] C44_reg;

assign C11 = C11_reg[25:0];
assign C12 = C12_reg[25:0];
assign C13 = C13_reg[25:0];
assign C14 = C14_reg[25:0];
assign C21 = C21_reg[25:0];
assign C22 = C22_reg[25:0];
assign C23 = C23_reg[25:0];
assign C24 = C24_reg[25:0];
assign C31 = C31_reg[25:0];
assign C32 = C32_reg[25:0];
assign C33 = C33_reg[25:0];
assign C34 = C34_reg[25:0];
assign C41 = C41_reg[25:0];
assign C42 = C42_reg[25:0];
assign C43 = C43_reg[25:0];
assign C44 = C44_reg[25:0];

reg [7:0] cnt;

always @ (posedge clk) begin
	if(En) begin
		if(cnt == 128) begin
			 cnt<=0;
			 C11_reg <= (C11_52b >>> 13) / 127;
			 C12_reg <= (C12_52b >>> 13) / 127;
			 C13_reg <= (C13_52b >>> 13) / 127;
			 C14_reg <= (C14_52b >>> 13) / 127;
			 C21_reg <= (C21_52b >>> 13) / 127;
             C22_reg <= (C22_52b >>> 13) / 127;
             C23_reg <= (C23_52b >>> 13) / 127;
             C24_reg <= (C24_52b >>> 13) / 127;
             C31_reg <= (C31_52b >>> 13) / 127;
             C32_reg <= (C32_52b >>> 13) / 127;
             C33_reg <= (C33_52b >>> 13) / 127;
             C34_reg <= (C34_52b >>> 13) / 127;
             C41_reg <= (C41_52b >>> 13) / 127;
             C42_reg <= (C42_52b >>> 13) / 127;
             C43_reg <= (C43_52b >>> 13) / 127;
			 C44_reg <= (C44_52b >>> 13) / 127;
			 
			 C11_52b <= 0;
			 C12_52b <= 0;
			 C13_52b <= 0;
			 C14_52b <= 0;
			 C21_52b <= 0;
			 C22_52b <= 0;
			 C23_52b <= 0;
			 C24_52b <= 0;
			 C31_52b <= 0;
			 C32_52b <= 0;
			 C33_52b <= 0;
			 C34_52b <= 0;
			 C41_52b <= 0;
			 C42_52b <= 0;
			 C43_52b <= 0;
			 C44_52b <= 0;
			
		end
		else begin
			 C11_52b <=  C11_52b + X1X1;
			 C12_52b <=  C12_52b + X1X2;
			 C13_52b <=  C13_52b + X1X3;
			 C14_52b <=  C14_52b + X1X4;
			 C21_52b <=  C21_52b + X1X2;
             C22_52b <=  C22_52b + X2X2;
             C23_52b <=  C23_52b + X2X3;
             C24_52b <=  C24_52b + X2X4;
             C31_52b <=  C31_52b + X1X3;
             C32_52b <=  C32_52b + X2X3;
             C33_52b <=  C33_52b + X3X3;
             C34_52b <=  C34_52b + X3X4;
             C41_52b <=  C41_52b + X1X4;
             C42_52b <=  C42_52b + X2X4;
             C43_52b <=  C43_52b + X3X4;
			 C44_52b <=  C44_52b + X4X4;

			 cnt<=cnt+1'b1;
		end
	end
	else begin
		 cnt<=0;
		 C11_52b <= 0;
		 C12_52b <= 0;
		 C13_52b <= 0;
		 C14_52b <= 0;
		 C21_52b <= 0;
		 C22_52b <= 0;
		 C23_52b <= 0;
		 C24_52b <= 0;
		 C31_52b <= 0;
		 C32_52b <= 0;
		 C33_52b <= 0;
		 C34_52b <= 0;
		 C41_52b <= 0;
		 C42_52b <= 0;
		 C43_52b <= 0;
		 C44_52b <= 0;
	end
end
endmodule
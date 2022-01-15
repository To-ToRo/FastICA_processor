module AdderAndDivider(
	input En,
	input clk,

	input wire signed [15:0] X1X1,
	input wire signed [15:0] X1X2,
	input wire signed [15:0] X1X3,
	input wire signed [15:0] X1X4,
	//input wire signed [15:0] X2X1,
	input wire signed [15:0] X2X2,
	input wire signed [15:0] X2X3,
	input wire signed [15:0] X2X4,
	//input wire signed [15:0] X3X1,
	//input wire signed [15:0] X3X2,
	input wire signed [15:0] X3X3, 
    input wire signed [15:0] X3X4, 
	//input wire signed [15:0] X4X1,
   // input wire signed [15:0] X4X2, 
   // input wire signed [15:0] X4X3, 
    input wire signed [15:0] X4X4,
	
	output reg signed [15:0] C11,
	output reg signed [15:0] C12,
	output reg signed [15:0] C13,
	output reg signed [15:0] C14,
	output reg signed [15:0] C21,
	output reg signed [15:0] C22,
	output reg signed [15:0] C23,
	output reg signed [15:0] C24,
	output reg signed [15:0] C31,
	output reg signed [15:0] C32,
	output reg signed [15:0] C33,
	output reg signed [15:0] C34,
	output reg signed [15:0] C41,
	output reg signed [15:0] C42,
	output reg signed [15:0] C43,
	output reg signed [15:0] C44
);

reg [6:0] cnt;

always @ (posedge clk) begin
	if(En) begin
		if(cnt == 127) begin
			 cnt<=0;
			
		end
		else begin
			 C11 <=  C11 + X1X1>>>7;
			 C12 <=  C12 + X1X2>>>7;
			 C13 <=  C13 + X1X3>>>7;
			 C14 <=  C14 + X1X4>>>7;
			 
			 C21 <=  C21 + X1X2>>>7;
             C22 <=  C22 + X2X2>>>7;
             C23 <=  C23 + X2X3>>>7;
             C24 <=  C24 + X2X4>>>7;
			 
             C31 <=  C31 + X1X3>>>7;
             C32 <=  C32 + X2X3>>>7;
             C33 <=  C33 + X3X3>>>7;
             C34 <=  C34 + X3X4>>>7;
			 
             C41 <=  C41 + X1X4>>>7;
             C42 <=  C42 + X2X4>>>7;
             C43 <=  C43 + X3X4>>>7;
			 C44 <=  C44 + X4X4>>>7;
			 cnt<=cnt+1;
		end
	end
	else begin
		 cnt<=0;
		 C11 <= 0;
		 C12 <= 0;
		 C13 <= 0;
		 C14 <= 0;
		 C21 <= 0;
		 C22 <= 0;
		 C23 <= 0;
		 C24 <= 0;
		 C31 <= 0;
		 C32 <= 0;
		 C33 <= 0;
		 C34 <= 0;
		 C41 <= 0;
		 C42 <= 0;
		 C43 <= 0;
		 C44 <= 0;
	end

end
endmodule
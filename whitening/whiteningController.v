module WhiteningControllerUnit(
	input wire GO_whitening,
	input wire CLK_Whitening,
	input wire New_one,
	
	input wire 	COV_busy,
	input wire  QR_busy,
	output reg  CEN_busy,
	
	output reg  Whitening_busy,
	
	output reg	En_mem1,
	output reg	GO_cen,
	output reg	En_mem2,
	output reg	En_mem3,
	output reg	GO_cov,
	output reg	GO_QR,
	output reg	En_multi_1,
	output reg	En_multi_2,
	
	output  CLK_mem1,
	output  CLK_cen,
	output  CLK_mem2,
	output  CLK_cov,
	output  CLK_QR,
	output  CLK_multi_1,
	output  CLK_multi_2,
	output  CLK_mem3
	
);

assign CLK_mem1 = CLK_Whitening;
assign CLK_cen  = CLK_Whitening;
assign CLK_mem2 = CLK_Whitening;
assign CLK_mem3 = CLK_Whitening;
assign CLK_cov = CLK_Whitening;
assign CLK_QR = CLK_Whitening;
assign CLK_multi_1 = CLK_Whitening;
assign CLK_multi_2 = CLK_Whitening;

parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6;
reg [3:0] state;
reg [6:0] cnt;

always @(posedge CLK_Whitening or negedge GO_whitening) begin
	if(!GO_whitening) begin
		state <= S0;
		cnt<=0;
		En_mem1 <= 0;
		GO_cen <= 0;
		En_mem2<= 0;
		GO_cov<= 0;
		GO_QR<= 0;
		En_multi_1<= 0;
		En_multi_2<= 0;
		En_mem3<= 0;
	end
	else begin
		case(state) 
			S0:	//SUM
				begin
					En_mem1 <= 1;
					GO_cen <= 1;
					En_mem2<= 0;
					GO_cov<= 0;
					GO_QR<= 0;
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					if(cnt ==127) begin
						cnt<=0;
						state <= S1;
					end
					else begin
						cnt<=cnt+1;
					end
				end
			S1:	//DIV
				begin
					En_mem1 <= 0;
					GO_cen <= 1;
					En_mem2<= 0;
					GO_cov<= 0;
					GO_QR<= 0;
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					state<=S2;
				end	
			S2:	//SUB
				begin
					En_mem1 <= 1;
					GO_cen <= 1;
					//En_mem2<= 1;
					GO_cov<= 1;
					GO_QR<= 0;
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					if(cnt ==127) begin
						cnt<=0;
						state <= S3;
					end
					else begin
						cnt<=cnt+1;
					end
				end
			S3:
				begin
					En_mem1 <= 0;
					GO_cen <= 1;
					En_mem2<= 0;
					GO_cov<= 1;
					GO_QR<= 0;
					//??
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					if(QR_busy==0) begin
						state <= S4;
					end
				end
			S4:
				begin

				end
			S5:
				begin
				
				end	
			S6:
				begin
				
				end	
		endcase 
	end
end
endmodule
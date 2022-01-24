module WhiteningController(
	input wire GO_whitening,
	input wire CLK_Whitening,
	input wire New_one,
	
	input wire 	COV_busy,
	input wire  QR_busy,
	// input reg  CEN_busy,
	
	output reg  Whitening_busy,
	
	output reg	En_mem1,
	output reg	GO_cen,
	output reg	En_mem2,
	output reg	En_mem3,
	output reg	GO_cov,
	output reg	GO_QR,
	output reg	En_multi_1,
	output reg	En_multi_2,
	output reg  En_eig,

	output reg R_w1,
	output reg R_w2,

	output  CLK_mem1,
	output  CLK_cen,
	output  CLK_mem2,
	output  CLK_cov,
	output  CLK_QR,
	output  CLK_multi_1,
	output  CLK_multi_2,
	output  CLK_eig,
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
assign CLK_eig = CLK_Whitening;

parameter S0=5'd0, S1=5'd1, S2=5'd2, S3=5'd3, S4=5'd4, S5=5'd5, S6=5'd6, S7=5'd7, S8=5'd8, S9=5'd9, S10=5'd10;
reg [4:0] state;
reg [7:0] cnt;

always @(posedge CLK_Whitening or negedge GO_whitening) begin
	if(!GO_whitening) begin
		state <= S0;
		cnt<=0;
		En_mem1 <= 0;
		GO_cen <= 0;
		En_mem2<= 0;
		GO_cov<= 0;
		GO_QR<= 0;
		En_eig<=0;
		En_multi_1<= 0;
		En_multi_2<= 0;
		En_mem3<= 0;

		R_w1<=0;
		R_w2<=0;
		Whitening_busy<=0;
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
					En_eig<=0;
					En_multi_1<= 0;
					En_multi_2<= 0;	
					En_mem3<= 0;
					R_w1<=0;
					R_w2<=0;
					Whitening_busy<=1;
					if(cnt ==8'd127) begin
						cnt<=0;
						state <= S1;
					end
					else begin
						cnt<=cnt+1'b1;
					end
				end
			S1:	//DIV
				begin
					state<=S2;
					En_mem1 <= 0;
					GO_cen <= 1;
					En_mem2<= 0;
					GO_cov<= 0;
					GO_QR<= 0;
					En_eig<=0;
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					R_w1<=0;
					R_w2<=0;
				end	
			S2:	//SUB and COV
				begin
					if(cnt < 8'd2) begin
						En_mem1 <= 1;
						GO_cen <= 1;
						En_mem2<= 0;
						GO_cov<= 0;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;
						R_w1<=0;
						R_w2<=0;
						cnt<=cnt+1'b1;
					end 
					else if(cnt == 8'd128) begin
						cnt<= cnt+1'b1;
						En_mem1 <= 0;
						GO_cen <= 1;
						En_mem2<= 1;
						GO_cov<= 1;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;
						R_w1<=1;
						R_w2<=0;
					end 	//not Cen
					else if(cnt == 8'd129) begin
						cnt<=cnt+1'b1;	
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 1;
						GO_cov<= 1;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;	
						En_eig<=0;
						R_w1<=1;
						R_w2<=0;
					end 	
					else if(cnt == 8'd130) begin
						cnt<=cnt+1'b1;
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 0;
						GO_cov<= 1;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;	
						En_eig<=0;
						R_w1<=0;
						R_w2<=0;
					end
					else if(cnt ==8'd131) begin
						cnt<=0;
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 0;
						GO_cov<= 1;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;	
						En_eig<=0;
						R_w1<=0;
						R_w2<=0;
						state <= S3;
					end
					else begin
						En_mem1 <= 1;
						GO_cen <= 1;
						En_mem2<= 1;
						GO_cov<= 1;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;

						R_w1<=1;
						R_w2<=0;
						cnt<=cnt+1'b1;
					end
				end
			S3:	//23��Ʈ ����Ʈ
				begin
					state <= S4;
					En_mem1 <= 0;
					GO_cen <= 0;
					En_mem2<= 0;
					GO_cov<= 1;
					GO_QR<= 0;
					En_eig<=0;
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					R_w1<=0;
					R_w2<=0;
				end
			S4:	//QR���
				begin
					if(QR_busy==0) begin
						state <= S5;
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 0;
						GO_cov<= 0;
						GO_QR<=0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;
						R_w1<=0;
						R_w2<=0;
					end
					else begin
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 0;
						GO_cov<= 0;
						GO_QR<= 1;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;
						R_w1<=0;
						R_w2<=0;
					end
				end
			S5:	
				begin //multi���
					if(cnt==8'd3) begin
						cnt<=0;
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 1;
						GO_cov<= 0;
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<=1;
						En_multi_2<= 0;
						En_mem3<= 0;
						R_w1<=0;
						R_w2<=0;
						state<=S6;
					end
					else begin	//eig���
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 0;
						GO_cov<= 0;
						GO_QR<= 0;
						En_eig<=1;
						En_multi_1<= 0;
						En_multi_2<= 0;
						En_mem3<= 0;
						R_w1<=0;
						R_w2<=0;
						cnt<=cnt+1'b1;
					end
				end	
			S6:	//multi for V
				begin
					state<=S7;
					En_mem1 <= 0;
					GO_cen <= 0;
					En_mem2<= 1;
					GO_cov<= 0;
					GO_QR<= 0;
					En_eig<=0;
					En_multi_1<= 1;
					En_multi_2<= 1;
					En_mem3<= 0;
					R_w1<=0;
					R_w2<=0;
				end	
			S7: //multi for Z
				begin
				    Whitening_busy<=0;
					if(cnt==8'd127) begin
						cnt<=0;
						state<=S8;
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 0;
						GO_cov<= 0;		
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 1;
						En_mem3<= 1;
						R_w1<=0;
						R_w2<=1;
					end
					else begin
						En_mem1 <= 0;
						GO_cen <= 0;
						En_mem2<= 1;
						GO_cov<= 0;		
						GO_QR<= 0;
						En_eig<=0;
						En_multi_1<= 0;
						En_multi_2<= 1;
						En_mem3<= 1;
						R_w1<=0;
						R_w2<=1;
						cnt<=cnt+1'b1;
					end
				end	
			S8: //end
				begin
					En_mem1 <= 0;
					GO_cen <= 0;
					En_mem2<= 0;
					GO_cov<= 0;		
					GO_QR<= 0;
					En_eig<=0;
					En_multi_1<= 0;
					En_multi_2<= 0;
					En_mem3<= 0;
					R_w1<=0;
					R_w2<=0;
				end	
		endcase 
	end
end
endmodule
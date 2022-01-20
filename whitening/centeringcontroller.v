module CenteringController(
	input wire GO_cen,
	input wire CLK_cen,
	output reg CEN_Busy,
	output reg En_SUM,
	output reg En_DIV,
	output reg En_SUB,
	output wire CLK_adder,
	output wire CLK_Divider,
	output wire CLK_Sub
);

assign CLK_adder = CLK_cen ; //초기값 설정에 의해 이렇게 했음.
assign CLK_Divider = CLK_cen;
assign CLK_Sub = CLK_cen ; //이것도 초기값 설정

parameter S0 =0 ,  S1=1 ,  S2=2 , S3=3;
reg [1:0] state;
reg [6:0] cnt;

always @(posedge CLK_cen or negedge GO_cen) 
begin
	if(!GO_cen) begin
		state <= S0;
		cnt<=0;
		En_SUM<=0;
		En_DIV<=0;
		En_SUB<=0;
	end
	else begin
		case(state)
			S0://ADD and SUB store signals
				begin
					En_SUM<=1;
					En_DIV<=0;
					En_SUB<=0;
					//En_SUM이 작동하려는 것을 기다리기 위해 1클락을 더 카운터
					if(cnt==127) begin
						state<=S1;
						cnt<=0;
					end
					else begin
						cnt<=cnt+1;
					end
				end
			S1:	//DIV
				begin
					En_SUM<=0;
					En_DIV<=1;
					En_SUB<=0;
					state<=S2;
				end
			S2:	//SUB
				begin
					En_SUM<=0;
					En_DIV<=0;
					En_SUB<=1;
					if(cnt == 127) begin
						cnt<=0;
						state<=S3;
						CEN_Busy<=0;
						//CEN_Busy<=1?? SUB? ??? RAM??? ???????.
					end
					else begin
						cnt<=cnt+1;
					end
				end
			S3 : 
				begin
					En_SUM<=0;
					En_DIV<=0;
					En_SUB<=0;
				end
		endcase
	end
end
endmodule
